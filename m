Received: from eggs.gnu.org ([2001:4830:134:3::10]:53111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1enowA-0003U0-Mh
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:09:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1enow7-0003vn-BW
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:09:10 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:44059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1enow7-0003vS-4o
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 12:09:07 -0500
Received: by mail-pl0-x242.google.com with SMTP id w21so5928127plp.11
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 09:09:07 -0800 (PST)
References: <1518824446-20235-1-git-send-email-cota@braap.org>
	<1518824446-20235-2-git-send-email-cota@braap.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4aa94d2a-a548-76b0-79a3-2cbaf8306596@linaro.org>
Date: Mon, 19 Feb 2018 09:09:02 -0800
MIME-Version: 1.0
In-Reply-To: <1518824446-20235-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] target/s390x: convert to DisasJumpType
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>

On 02/16/2018 03:40 PM, Emilio G. Cota wrote:
> The only non-trivial modification is the use of DISAS_TOO_MANY
> in the same way is used by the generic translation loop.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/s390x/translate.c | 1267 +++++++++++++++++++++++-----------------------
>  1 file changed, 632 insertions(+), 635 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
