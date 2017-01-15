Received: from eggs.gnu.org ([2001:4830:134:3::10]:59150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cSa7f-0003UR-PH
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 21:00:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cSa7c-0007VI-Cl
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 21:00:43 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:46588 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cSa7b-0007UZ-Tz
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 21:00:40 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148434048970.31446.17153056211582691244.stgit@frigg.lan>
	<148434050231.31446.10929552655201551997.stgit@frigg.lan>
	<597a44c3-2518-2d24-598c-4867f57dfa7b@twiddle.net>
Date: Sun, 15 Jan 2017 03:00:31 +0100
In-Reply-To: <597a44c3-2518-2d24-598c-4867f57dfa7b@twiddle.net> (Richard
	Henderson's message of "Fri, 13 Jan 2017 19:30:37 -0800")
Message-ID: <87d1fp13r4.fsf@ac.upc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 2/7] trace: Make
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

> On 01/13/2017 12:48 PM, Llu=C3=ADs Vilanova wrote:
>> uring and controlling the state of tracing events.
>> *
>> - * Copyright (C) 2011-2016 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> + * Copyright (C) 2011-2017 Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> *
>> * This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
>> * See the COPYING file in the top-level directory.
>> @@ -237,7 +237,7 @@ char *trace_opt_parse(const char *optarg);
>> *
>> * Return the number of known vcpu-specific events
>> */
>> -uint32_t trace_get_vcpu_event_count(void);
>> +static uint32_t trace_get_vcpu_event_count(void);
>>=20

> Why is this declaration still here?  It's redundant with the inline.

I can remove it if you feel strongly against it, but I kept it to maintain
consistency with the rest of the file. As I said in the previous series, th=
is is
the style used in the header. All "public" functions (inlined or not) are
declared there with their documentation.

Being inlined is an implementation detail (inlines are defined on a separate
header), but given C's design it leaks through the static declaration.


Cheers,
  Lluis
