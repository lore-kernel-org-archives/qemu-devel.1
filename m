Received: from eggs.gnu.org ([2001:4830:134:3::10]:42935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNNTu-0004ZB-6Z
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dNNTr-0002JC-59
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:02:26 -0400
Received: from mail-lf0-x22d.google.com ([2a00:1450:4010:c07::22d]:35751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
	id 1dNNTq-0002Iz-Ts
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:02:23 -0400
Received: by mail-lf0-x22d.google.com with SMTP id p189so80133465lfe.2
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 11:02:22 -0700 (PDT)
Date: Tue, 20 Jun 2017 20:02:19 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170620180219.GH4859@toto>
References: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
	<1497974944-27050-7-git-send-email-edgar.iglesias@gmail.com>
	<bc8476c4-8070-c253-637f-9ce35e0d68ee@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc8476c4-8070-c253-637f-9ce35e0d68ee@twiddle.net>
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
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, alistai@xilinx.com, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

On Tue, Jun 20, 2017 at 10:48:22AM -0700, Richard Henderson wrote:
> On 06/20/2017 09:09 AM, Edgar E. Iglesias wrote:
> >+        int width = imm_w - imm_s + 1;
> >+
> >+        if (width == 0 || imm_w <= imm_s) {
> 
> The width == 0 check is redundant; the imm_w <= imm_s check is wrong.  It
> should be <.
> 
> If imm_w >= imm_s, as per the proper check, then width must be >= 1.

Right, will fix for v2.

Thanks!
Edgar
