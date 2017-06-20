Received: from eggs.gnu.org ([2001:4830:134:3::10]:40351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNGQ-000153-Co
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNGM-0005dB-Ag
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:48:30 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:34039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNNGM-0005ba-4F
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:48:26 -0400
Received: by mail-pf0-x236.google.com with SMTP id s66so72592596pfs.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 10:48:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
	<1497974944-27050-7-git-send-email-edgar.iglesias@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bc8476c4-8070-c253-637f-9ce35e0d68ee@twiddle.net>
Date: Tue, 20 Jun 2017 10:48:22 -0700
MIME-Version: 1.0
In-Reply-To: <1497974944-27050-7-git-send-email-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 6/7] target-microblaze: dec_barrel: Add
 BSIFI
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
> +        int width = imm_w - imm_s + 1;
> +
> +        if (width == 0 || imm_w <= imm_s) {

The width == 0 check is redundant; the imm_w <= imm_s check is wrong.  It 
should be <.

If imm_w >= imm_s, as per the proper check, then width must be >= 1.


r~
