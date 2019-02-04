Received: from eggs.gnu.org ([209.51.188.92]:41858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqi34-0008Jc-D8
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:28:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gqi33-0005sY-7C
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:28:46 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:41174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gqi32-0005me-PD
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 12:28:45 -0500
Received: by mail-ot1-x32f.google.com with SMTP id u16so1086839otk.8
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 09:28:33 -0800 (PST)
MIME-Version: 1.0
References: <1549299863-42415-1-git-send-email-pbonzini@redhat.com>
	<154930038693.29184.3120782428001056058@ebba9967afc0>
In-Reply-To: <154930038693.29184.3120782428001056058@ebba9967afc0>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Feb 2019 17:28:20 +0000
Message-ID: <CAFEAcA8kesvFU4YOqd5VZP9cBdmMZuyRBwAq8fdwEOet22K48g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] docker: fix test-mingw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>

On Mon, 4 Feb 2019 at 17:14, <no-reply@patchew.org> wrote:
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>    335dbb5de1..773c4a6228  master     -> master
>  * [new tag]               patchew/1549299863-42415-1-git-send-email-pbonzini@redhat.com -> patchew/1549299863-42415-1-git-send-email-pbonzini@redhat.com
> Switched to a new branch 'test'
>
> === OUTPUT BEGIN ===
> checkpatch.pl: no revisions returned for revlist '1'
> === OUTPUT END ===

This is an interesting failure mode -- presumably it's what you
get if you post a patch which ends up without any content when
it's applied to master...

thanks
-- PMM
