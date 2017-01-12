Received: from eggs.gnu.org ([2001:4830:134:3::10]:46011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cRjtL-0006Rf-BT
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cRjtG-0007QG-MM
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:14:26 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:59387 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cRjtG-0007Q6-8T
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:14:22 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148295045448.19871.9819696634619157347.stgit@fimbulvetr.bsc.es>
	<148295046527.19871.6610919709371885230.stgit@fimbulvetr.bsc.es>
	<6c1d8806-bb65-8be6-fb95-faf2f0633e21@twiddle.net>
Date: Thu, 12 Jan 2017 19:14:19 +0100
In-Reply-To: <6c1d8806-bb65-8be6-fb95-faf2f0633e21@twiddle.net> (Richard
	Henderson's message of "Tue, 10 Jan 2017 12:08:33 -0800")
Message-ID: <87fukoywlg.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 2/7] trace: Make
 trace_get_vcpu_event_count() inlinable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Richard Henderson writes:

> On 12/28/2016 10:41 AM, Llu=C3=ADs Vilanova wrote:
>> @@ -82,6 +83,10 @@ static inline bool trace_event_get_vcpu_state_dynamic=
(CPUState *vcpu,
>> return trace_event_get_vcpu_state_dynamic_by_vcpu_id(vcpu, vcpu_id);
>> }
>>=20
>> +static inline uint32_t trace_get_vcpu_event_count(void)
>> +{
>> +    return trace_next_vcpu_id;
>> +}
> ...
>> @@ -237,7 +237,7 @@ char *trace_opt_parse(const char *optarg);
>> *
>> * Return the number of known vcpu-specific events
>> */
>> -uint32_t trace_get_vcpu_event_count(void);
>> +static uint32_t trace_get_vcpu_event_count(void);

> This second declaration should be removed.

I don't think so. "trace/control.h" contains declarations and documentation,
while "trace/control-internal.h" contains inlined implementations (something
followed by many other functions there).


Thanks,
  Lluis
