Received: from eggs.gnu.org ([2001:4830:134:3::10]:57318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ck93n-0001SO-OO
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:45:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ck93i-00074s-TR
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:45:19 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ck93i-00074k-NV
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 07:45:14 -0500
Received: by mail-wr0-x230.google.com with SMTP id u108so89269758wrb.3
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 04:45:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <148858561902.285.12747236824169770569@0e2666bad730>
References: <1488556233-31246-1-git-send-email-peter.maydell@linaro.org>
	<148858561902.285.12747236824169770569@0e2666bad730>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Mar 2017 12:44:52 +0000
Message-ID: <CAFEAcA-D37hty_DmU-VtudwnrEMeS=93HB5pe4HHL9GThRbQxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.9 0/6] disas: Fix various coverity
 nits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "patches@linaro.org" <patches@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On 4 March 2017 at 00:00,  <no-reply@patchew.org> wrote:
> Hi,
>
> This series failed build test on s390x host. Please find the details below.

> === TEST BEGIN ===
> Using CC: /home/fam/bin/cc
> rm: cannot remove '/var/tmp/patchew-qemu-build/aarch64-softmmu': Directory not empty
> === OUTPUT END ===

Fam, can we drop the s390x test from patchew until it gets fixed,
please? Right now it's just spamming the list and means that
actually interesting patchew emails are likely to get ignored...

thanks
-- PMM
