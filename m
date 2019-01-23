Received: from eggs.gnu.org ([209.51.188.92]:51884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmSCX-0007DK-Ae
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:44:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gmSCW-00020j-ME
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:44:57 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gmSCW-0001zm-FR
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 18:44:56 -0500
Received: by mail-pf1-x441.google.com with SMTP id c73so1967929pfe.13
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 15:44:56 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <33750f3b-3515-5271-986b-126e8986da59@linaro.org>
Date: Wed, 23 Jan 2019 15:44:52 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/23] armv7m: Make cpu object a child of
 the armv7m container
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

On 1/21/19 10:50 AM, Peter Maydell wrote:
> Rather than just creating the CPUs with object_new, make them child
> objects of the armv7m container. This will allow the cluster code to
> find the CPUs if an armv7m object is made a child of a cluster object.
> object_new_with_props() will do the parenting for us.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/armv7m.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
