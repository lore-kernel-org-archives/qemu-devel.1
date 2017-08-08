Received: from eggs.gnu.org ([2001:4830:134:3::10]:38712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1df3rk-0002H9-Mq
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:44:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1df3rj-00012u-Ke
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:44:08 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:33344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1df3rj-00012V-C9
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 08:44:07 -0400
Received: by mail-wr0-x236.google.com with SMTP id v105so12589798wrb.0
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 05:44:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170808020249.GQ14780@lemon>
References: <20170808020249.GQ14780@lemon>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Aug 2017 13:43:45 +0100
Message-ID: <CAFEAcA9AgqUDCOR_9Se9A4KONXAenk36M+GK6wVx3JdQoSk1gw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Howto: instructing patchew about patch dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 August 2017 at 03:02, Fam Zheng <famz@redhat.com> wrote:
> Hi, QEMU patch submitters,
>
> I've patched patchew so that if you add a line:
>
> Based-on: $MESSAGE_ID
>
> in your cover letter body, or in a reply to it (or reply to reply), patchew will
> try to apply your series on top of the one $MESSAGE_ID refers to, assuming the
> base series _was_ successfully applied by patchew earlier.
>
> In the single patch case, you can put the line under the "---" mark in the
> commit message (no need to let it enter git history).
>
> For human readability, around the "Based-on:" line it may be better if the
> subject is noted. E.g.:
>
> Based-on: 20170804140942.19342-1-famz@redhat.com

Does the parser accept message-ids with their angle-brackets <>
around them, or does it insist they be stripped out?

thanks
-- PMM
