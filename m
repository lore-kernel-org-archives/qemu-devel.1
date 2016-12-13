Received: from eggs.gnu.org ([2001:4830:134:3::10]:57240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGmRB-0001Xq-Ra
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:44:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGmR7-0007G6-IH
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:44:05 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cGmR7-0007Fx-DD
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:44:01 -0500
Received: by mail-vk0-f47.google.com with SMTP id p9so59101228vkd.3
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 04:44:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481085020-2614-1-git-send-email-rth@twiddle.net>
References: <1481085020-2614-1-git-send-email-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Dec 2016 12:42:40 +0000
Message-ID: <CAFEAcA-NNVttaOdBivqsZYDhK_hkfQwOjXH-ZDM31bZO4bFkew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 0/2] target-arm aarch64 big-endian fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 7 December 2016 at 04:30, Richard Henderson <rth@twiddle.net> wrote:
> I ran Alex's risu tests on an s390x host, and ran into two
> problems not related to the s390 backend.
>
>
> r~
>
>
> Richard Henderson (2):
>   target-arm: Fix aarch64 disas_ldst_single_struct
>   target-arm: Fix aarch64 vec_reg_offset
>
>  target-arm/translate-a64.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)



Applied to target-arm.next for 2.9, thanks.

-- PMM
