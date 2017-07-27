Received: from eggs.gnu.org ([2001:4830:134:3::10]:42723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dakn7-0004eD-7n
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:33:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dakmx-00019D-O8
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:33:33 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:37203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dakmx-00015e-5k
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 11:33:23 -0400
Received: by mail-wm0-x230.google.com with SMTP id c184so110397730wmd.0
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 08:33:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170727152137.GW2555@redhat.com>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<20170725131931.GC23343@stefanha-x1.localdomain>
	<CAFEAcA_pmFYZ_y9E5D0c70G2oA62vb+KBXnxbp_Sg39kuNeREA@mail.gmail.com>
	<20170726112633.GE18489@stefanha-x1.localdomain>
	<CAFEAcA_pXX6ZCsBwAQnzQbTSbxzAh=nFpPeEzZoRBhBDt2r+vA@mail.gmail.com>
	<20170727104302.GI2555@redhat.com>
	<CAFEAcA8oyHi+7NVCE8YWHY+v0UXLbt2tWHGE4AP_V8TtDBc89g@mail.gmail.com>
	<20170727152137.GW2555@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2017 16:33:01 +0100
Message-ID: <CAFEAcA-eH7J+fFXYgFo6Wx58zgD8=kqhrGE5BqR+NrhHjipsFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>, QEMU Developers <qemu-devel@nongnu.org>

On 27 July 2017 at 16:21, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Thu, Jul 27, 2017 at 11:54:29AM +0100, Peter Maydell wrote:
>> That said, yes, I was going to ask if we could do this via
>> leveraging the tracepoint infrastructure and whatever scripting
>> facilities it provides. Are there any good worked examples of
>> this sort of thing? Can you do it as an ordinary non-root user?
>
> Do you have a particular thing you'd like to see an example of ?
>
> To dynamically probe a function which doesn't have a tracepoint
> defined you can do:
>
> probe process("/usr/bin/qemu-x86_64").function("helper_syscall") {
>   printf("syscall stasrt\n")
> }
>
> but getting access to the function args is not as easy as with
> pre-defined tracepoints.

How do I go about actually running that script? What I
have in mind by "worked example" is something like a blog
post that says "ok, here's a problem, we want to find out
what QEMU is doing in situation X, here's how you do this
with $TRACING_THINGY" and generally steps you through how
it works assuming you know nothing at all about whatever
the tracing facility you're using is.

> You can't typically run this as root,

Do you mean "non-root" ?

> however, I don't think that's a
> huge issue, because most QEMU deployments are not running as your own
> user account anyway, so you can't directly interact with them no
> matter what.

It is important, because almost all uses of TCG QEMU are
running it from the command line as non-root normal users,
especially if they're trying to debug what's going on with a
guest binary. So any tracing solution for this kind of usecase
must work without requiring root access, I think.

I think the users for this are pretty much completely
distinct from anybody who would use the term "deployment"
for their usage of QEMU :-)

thanks
-- PMM
