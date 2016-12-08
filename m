Received: from eggs.gnu.org ([2001:4830:134:3::10]:54688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cF0vX-00018w-EL
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:48:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vpalatin@google.com>) id 1cF0vQ-0005KK-21
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:48:03 -0500
Received: from mail-io0-f170.google.com ([209.85.223.170]:34933)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <vpalatin@google.com>) id 1cF0vP-00059N-PN
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:47:59 -0500
Received: by mail-io0-f170.google.com with SMTP id h30so6871042iod.2
	for <qemu-devel@nongnu.org>; Thu, 08 Dec 2016 07:47:38 -0800 (PST)
MIME-Version: 1.0
Sender: vpalatin@google.com
In-Reply-To: <d308380f-e6bd-10b5-d89b-3cc9e64d41ba@weilnetz.de>
References: <cover.1479381090.git.vpalatin@chromium.org>
	<f228cb95-de64-5dc3-f761-390f20675541@linux.intel.com>
	<d308380f-e6bd-10b5-d89b-3cc9e64d41ba@weilnetz.de>
From: Vincent Palatin <vpalatin@chromium.org>
Date: Thu, 8 Dec 2016 16:46:15 +0100
Message-ID: <CAP_ceTxBrKqOGJ65485puEn_56XQhfuGFebhCmuNF5hE6fZy3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Add HAX support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Yu Ning <yu.ning@linux.intel.com>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Dec 8, 2016 at 4:31 PM, Stefan Weil <sw@weilnetz.de> wrote:
>
> Am 08.12.2016 um 10:34 schrieb Yu Ning:
> > As a HAXM developer at Intel, I just want to come out and show our
> > support for Vincent's upstreaming effort. We'd love to see HAXM support
> > code land in upstream QEMU, and will do what is necessary to make that
> > happen.
> >
> > We've been working on the issues that Vincent raised and have made some
> > progress - see below.
> >
> > Regards,
> > Yu
>
> Thanks a lot - I think that HAXM integration will make fast progress then.
>
> AFAIK, there remain at least two other features which need to be addressed:
>
> * support for real mode (e. g. BIOS code)


It does support it actually, it was failing early due to a bug in the
kernel module.
Thanks to the diligent work by Yu Ning on Intel side, this part is
solved (as soon as they release the new kernel module version).


> * support for macOS

I have a patch for it, it is mainly lacking bake/test time.

-- 
Vincent
