Received: from eggs.gnu.org ([2001:4830:134:3::10]:37346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb4CH-0008MO-SR
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:49:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb4CH-00040f-3O
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:49:05 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:32791)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb4CG-00040Q-Ud
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 07:49:05 -0500
Received: by mail-oi0-x22c.google.com with SMTP id y141so8203361oia.0
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 04:49:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511879725-9576-1-git-send-email-peter.maydell@linaro.org>
References: <1511879725-9576-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 12:48:43 +0000
Message-ID: <CAFEAcA90dgSX9kYC5TbPBV2UHgQjz3HWT3eyE4RUC6x9P=7_QQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] linux-user: Fix race between threads
 in page_unprotect()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Richard Henderson <rth@twiddle.net>, Laurent Vivier <laurent@vivier.eu>, "patches@linaro.org" <patches@linaro.org>

On 28 November 2017 at 14:35, Peter Maydell <peter.maydell@linaro.org> wrote:
> If multiple guest threads in user-mode emulation write to a
> page which QEMU has marked read-only because of cached TCG
> translations, the threads can race in page_unprotect:

> Peter Maydell (2):
>   linux-user: Propagate siginfo_t through to handle_cpu_signal()
>   page_unprotect(): handle calls to pages that are PAGE_WRITE

Ping! Linux-user maintainers, any chance this could get into
a pull-request sometime soon? (I have another cleanup I'm
thinking of that will touch the same code so I'd rather this
went into master before I look at that.)

(I have a bunch of other pending linux-user patchsets which
I shan't bother to ping individually unless you want me to.)

thanks
-- PMM
