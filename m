Received: from eggs.gnu.org ([2001:4830:134:3::10]:53859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsGlr-0004cH-LP
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsGlm-0008LE-Mr
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:08:39 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:47867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsGlm-0008Kg-Gn
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 19:08:34 -0400
Received: by mail-pg0-x231.google.com with SMTP id d8so3071350pgt.4
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 16:08:34 -0700 (PDT)
References: <1505240046-11454-1-git-send-email-peter.maydell@linaro.org>
	<1505240046-11454-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <41634883-f5ad-a43a-d4d1-378176c95b67@linaro.org>
Date: Wed, 13 Sep 2017 16:08:30 -0700
MIME-Version: 1.0
In-Reply-To: <1505240046-11454-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/19] nvic: Add banked exception states
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

On 09/12/2017 11:13 AM, Peter Maydell wrote:
> For the v8M security extension, some exceptions must be banked
> between security states. Add the new vecinfo array which holds
> the state for the banked exceptions and migrate it if the
> CPU the NVIC is attached to implements the security extension.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/intc/armv7m_nvic.h | 14 +++++++++++++
>  hw/intc/armv7m_nvic.c         | 49 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 62 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
