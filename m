Received: from eggs.gnu.org ([2001:4830:134:3::10]:56595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIxt-0004oa-LM
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUIxq-00019R-Ii
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:38:01 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:33122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dUIxq-00019M-Bb
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 16:37:58 -0400
Received: by mail-pg0-f47.google.com with SMTP id k14so39436878pgr.0
	for <qemu-devel@nongnu.org>; Sun, 09 Jul 2017 13:37:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-16-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <daa51509-2cdf-783d-e508-ef981f252db7@twiddle.net>
Date: Sun, 9 Jul 2017 10:36:53 -1000
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-16-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/22] gen-icount: fold exitreq_label into
 TCGContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org

On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> Before we make TCGContext thread-local.
> 
> Signed-off-by: Emilio G. Cota<cota@braap.org>
> ---
>   include/exec/gen-icount.h | 7 +++----
>   tcg/tcg.h                 | 2 ++
>   2 files changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
