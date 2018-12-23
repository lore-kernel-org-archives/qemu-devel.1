Received: from eggs.gnu.org ([2001:4830:134:3::10]:39673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gatqU-0002Ab-K1
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 21:50:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gatqP-0004gq-Mu
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 21:50:26 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gatqP-0004fd-Es
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 21:50:21 -0500
Received: by mail-pf1-x443.google.com with SMTP id w73so4385565pfk.10
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 18:50:21 -0800 (PST)
References: <20181220163123.9233-1-mark.cave-ayland@ilande.co.uk>
	<20181220163123.9233-9-mark.cave-ayland@ilande.co.uk>
	<06d2cdee-30f6-2ad7-ba56-3a0ca161fb72@linaro.org>
	<3f013e89-1f99-49b9-9db9-d39ee086aafb@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa069b0a-9059-9440-bbc2-75f128e3a649@linaro.org>
Date: Sat, 22 Dec 2018 18:50:17 -0800
MIME-Version: 1.0
In-Reply-To: <3f013e89-1f99-49b9-9db9-d39ee086aafb@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 8/9] target/ppc: move FP and VMX
 registers into aligned vsr register array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 12/22/18 10:09 AM, Mark Cave-Ayland wrote:
> Do you want these helpers used just within
> linux-user/ppc/signal.c or also within the other files touched by this patch e.g.
> arch_dump.c, gdbstub.c etc.?

Everywhere.  Thanks!


r~
