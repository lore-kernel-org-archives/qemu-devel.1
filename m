Received: from eggs.gnu.org ([2001:4830:134:3::10]:40141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS6BB-0001Rc-IU
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cS6Av-0002SL-Bp
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:02:21 -0500
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:34461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cS6Av-0002Ro-5T
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 13:02:05 -0500
Received: by mail-yw0-x243.google.com with SMTP id a10so4262388ywa.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 10:02:04 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1484311923-28637-1-git-send-email-laurent@vivier.eu>
	<1484311923-28637-6-git-send-email-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <847e2353-9e6d-5b0a-bd74-ff742c23d460@twiddle.net>
Date: Fri, 13 Jan 2017 10:02:01 -0800
MIME-Version: 1.0
In-Reply-To: <1484311923-28637-6-git-send-email-laurent@vivier.eu>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] target-m68k: increment/decrement
 with SP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>

On 01/13/2017 04:52 AM, Laurent Vivier wrote:
> +            if (reg0 == 7 && opsize == OS_BYTE &&
> +                m68k_feature(s->env, M68K_FEATURE_M68000)) {
> +                tcg_gen_subi_i32(tmp, reg, 2);
> +            } else {
> +                tcg_gen_addi_i32(tmp, reg, opsize_bytes(opsize));
> +            }

post-increment add.


r~
