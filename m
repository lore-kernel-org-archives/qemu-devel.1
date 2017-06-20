Received: from eggs.gnu.org ([2001:4830:134:3::10]:39365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNDY-000789-S2
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNDU-0004RK-UB
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:45:32 -0400
Received: from mail-pg0-x22a.google.com ([2607:f8b0:400e:c05::22a]:34797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNNDU-0004R8-OU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 13:45:28 -0400
Received: by mail-pg0-x22a.google.com with SMTP id e187so13325852pgc.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 10:45:28 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497974944-27050-1-git-send-email-edgar.iglesias@gmail.com>
	<1497974944-27050-3-git-send-email-edgar.iglesias@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7cb7cca7-654e-bca6-0d5f-210c8c8977b9@twiddle.net>
Date: Tue, 20 Jun 2017 10:45:25 -0700
MIME-Version: 1.0
In-Reply-To: <1497974944-27050-3-git-send-email-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/7] target-microblaze: dec_barrel: Use
 extract32
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

On 06/20/2017 09:08 AM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias"<edgar.iglesias@xilinx.com>
> 
> Use extract32 instead of opencoding the shifting and masking.
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias<edgar.iglesias@xilinx.com>
> ---
>   target/microblaze/translate.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
