Received: from eggs.gnu.org ([2001:4830:134:3::10]:57896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceP7C-00056z-Eu
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceP7B-00010Z-JZ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:41:06 -0500
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:34445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceP7B-0000zp-Ct
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:41:05 -0500
Received: by mail-wm0-x22f.google.com with SMTP id 196so4584996wmm.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 08:41:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
References: <1486996099-15820-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Feb 2017 16:40:43 +0000
Message-ID: <CAFEAcA98V-3EMDS+o9HnAdY14JDoY4i8yYyFP=OiK8QXMSWvmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/4] cpu: Implement
 cpu_generic_new()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 13 February 2017 at 14:28, Peter Maydell <peter.maydell@linaro.org> wrote:
> This patchset adds a new function cpu_generic_new()
> which is similar to cpu_generic_init() except that it
> does not realize the created CPU object. This means that
> board code can do a "new cpu; set QOM properties; realize"
> sequence without having to do all the work of splitting
> the CPU model string and calling parse_features by hand.
>
> Patch 2 clarifies a TODO comment, hopefully correctly,
> based on an email conversation I had with Eduardo a
> little while back.
>
> Patches 3 and 4 change the ARM boards which currently
> call parse_features by hand to use the new function.
>
>
> If there's consensus that this is the right general
> direction to go in, then I think that some other
> architectures could also make cleanups to use this:
>  * cpu_s390x_create() is almost exactly this function,
>    give or take some fine detail of error handling
>  * ppc_cpu_parse_features is almost the same thing,
>    except that it doesn't actually create the CPU object,
>    it only calls parse_features
>  * hw/i386/pc.c does a manual parse_features
>
> I'm not strongly attached to this particular approach
> (though it seems like a reasonable one, especially given
> the proliferation of different arch-specific helpers
> listed above and the bugs in boards which don't call
> parse_features when they should), but I would like us to
> figure out and document what the right way for a board
> to create and configure its CPU objects is...

I know it's only been a few days, but I just wanted to
say that I'd appreciate it if we could manage relatively
quick review on this one, since I have a set of patches
pending that depend on this and which it would be nice
to get into 2.9 (softfreeze approaching rapidly).

thanks
-- PMM
