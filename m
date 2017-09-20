Received: from eggs.gnu.org ([2001:4830:134:3::10]:56033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dujrz-00084S-Qf
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:37:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dujrw-0008SO-NU
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:37:11 -0400
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:51589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dujrw-0008Ql-Fz
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 14:37:08 -0400
Received: by mail-io0-x231.google.com with SMTP id l15so5650435iol.8
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 11:37:08 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-19-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <362cf79b-6d11-53b0-a396-f010e47a337f@linaro.org>
Date: Wed, 20 Sep 2017 13:37:03 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-19-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/19] nvic: Make SHCSR banked for v8M
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 09/12/2017 01:14 PM, Peter Maydell wrote:
> Handle banking of SHCSR: some register bits are banked between
> Secure and Non-Secure, and some are only accessible to Secure.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 221 ++++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 169 insertions(+), 52 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
