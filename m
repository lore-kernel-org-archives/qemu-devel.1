Received: from eggs.gnu.org ([2001:4830:134:3::10]:39247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duMtC-0000oq-E8
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duMt8-0002eh-OF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:04:54 -0400
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:53015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duMt8-0002ct-K6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 14:04:50 -0400
Received: by mail-io0-x22f.google.com with SMTP id i197so1026989ioe.9
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 11:04:50 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-7-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <32166eca-14d9-63b3-cfc7-d7b63066cdc7@linaro.org>
Date: Tue, 19 Sep 2017 13:04:46 -0500
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-7-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/19] nvic: Make ICSR.RETTOBASE handle
 banked exceptions
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

On 09/12/2017 01:13 PM, Peter Maydell wrote:
> Update the code in nvic_rettobase() so that it checks the
> sec_vectors[] array as well as the vectors[] array if needed.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
