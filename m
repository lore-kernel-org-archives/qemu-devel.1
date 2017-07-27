Received: from eggs.gnu.org ([2001:4830:134:3::10]:58854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dakFr-00081M-5D
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:59:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dakFo-0000yS-0g
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:59:11 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:48065)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dakFn-0000sH-LZ
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 10:59:07 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<20170726112633.GE18489@stefanha-x1.localdomain>
	<CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	<20170727104302.GI2555@redhat.com>
	<CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
Date: Thu, 27 Jul 2017 17:58:51 +0300
In-Reply-To: <CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	(Peter Maydell's message of "Thu, 27 Jul 2017 11:54:29 +0100")
Message-ID: <87lgnavsd0.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 00/13] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell writes:

> On 27 July 2017 at 11:43, Daniel P. Berrange <berrange@redhat.com> wrote:
>> Maybe I'm missing something, but aren't all these things
>> already possible via either the statically defined tracepoints
>> QEMU exposes, or by placing dynamic tracepoints on arbitrary
>> code locations using dtrace/systemtap/lttng-ust.

> Last time I looked we didn't have tracepoints on most of
> the events you'd be interested in.

> That said, yes, I was going to ask if we could do this via
> leveraging the tracepoint infrastructure and whatever scripting
> facilities it provides. Are there any good worked examples of
> this sort of thing? Can you do it as an ordinary non-root user?

The hypertrace series I just sent contains an example that uses dtrace to
trigger changes on the tracing state of events based on information from other
events [1].

AFAIK it requires root privileges, and it's much less efficient than loading the
instrumentation library proposed in this series (see that there's also an API to
control event tracing).

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg08458.html


Cheers,
  Lluis
