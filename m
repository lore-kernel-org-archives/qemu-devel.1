Received: from eggs.gnu.org ([2001:4830:134:3::10]:38506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnMhG-0007ja-3N
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dnMhF-0002kk-7L
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:27:38 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:34527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dnMhE-0002jr-W1
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 06:27:37 -0400
Received: by mail-wr0-x233.google.com with SMTP id z91so916124wrc.1
	for <qemu-devel@nongnu.org>; Thu, 31 Aug 2017 03:27:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87bmmwi6r6.fsf@dusky.pond.sub.org>
References: <87r2w6eq5n.fsf@gmail.com> <87h8x1yox3.fsf@dusky.pond.sub.org>
	<20170830170941.GB24565@stefanha-x1.localdomain>
	<87bmmwi6r6.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2017 11:27:15 +0100
Message-ID: <CAFEAcA8r-EqOjZDvP=0mYG7QQ83MU-54RL9Bu8Eb_wPzQo1M7Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, David Michael <fedora.dm0@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 31 August 2017 at 07:35, Markus Armbruster <armbru@redhat.com> wrote:
> So, first we'll invest in work-arounds to make both 2 and 3 work.  Once
> 2 is gone, we can invest some more to clean them up.  Which probably
> won't happen, so we'll continue to carry work-arounds that no longer
> make sense.
>
> I maintain roughly one fourth of all Python code in qemu, and I'm not
> looking forward to this hoop-jumping at all.
>
> Are we really, really sure we want to go this way?  What exactly are we
> hoping to accomplish by it?

My take is that we have the following goals we want to achieve:

(1) We need to continue to build and run on older (long-term-support)
distros that still ship only Python 2.x (alas even back to 2.6)
(2) We need to be able to build and run on newer distros that
have dropped Python 2 altogether in favour of Python 3
(I don't know if there are any such today, but presumably by
2020 there will be)

Unless we can confidently say that either (1) or (2) is the
empty set, we need to handle both 2 and 3 in the same codebase.
This is a pain, but unfortunately Python upstream have forced
us into it by breaking source code compatibility.

I think (1) is pretty clearly not (yet) an empty set, so the
only alternative I see to "support 2 and 3 now" is "keep supporting
only 2 for the moment and hope that no distro drops 2 support
before all the LTS 2-only distro versions vanish into history".

thanks
-- PMM
