Received: from eggs.gnu.org ([2001:4830:134:3::10]:39070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNC7-0006EI-Fk
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:44:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNC3-0003w4-Ic
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:44:03 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:36548)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNNC3-0003vu-BU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:43:59 -0400
Received: by mail-pf0-x22e.google.com with SMTP id x63so72487411pff.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 10:43:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
	<1497974944-27050-6-git-send-email-edgar.iglesias@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c83418e2-1310-23c3-fb4f-115fb053c9db@twiddle.net>
Date: Tue, 20 Jun 2017 10:43:55 -0700
MIME-Version: 1.0
In-Reply-To: <1497974944-27050-6-git-send-email-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/7] target-microblaze: dec_barrel: Add
 BSEFI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On 06/20/2017 09:09 AM, Edgar E. Iglesias wrote:
> +    if (e) {
> +        tcg_gen_extract_i32(cpu_R[dc->rd], cpu_R[dc->ra], imm_s, imm_w);

You'll want to validate imm_s and imm_w lest you trigger the asserts in 
tcg_gen_extract_i32.


r~
