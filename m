Received: from eggs.gnu.org ([2001:4830:134:3::10]:50291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQBgk-0007hL-Vg
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fQBgj-00080m-RL
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:07:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fQBgj-00080U-Mq
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 09:07:49 -0400
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<152819516132.30857.1700667353240369481.stgit@pasha-ThinkPad-T60>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aac4626c-c379-13b6-f505-e6ea12fea1a1@redhat.com>
Date: Tue, 5 Jun 2018 15:07:45 +0200
MIME-Version: 1.0
In-Reply-To: <152819516132.30857.1700667353240369481.stgit@pasha-ThinkPad-T60>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/7] tcg: add headers for non-target
 helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, pbonzini@redhat.com, vilanova@ac.upc.edu

On 05.06.2018 12:39, Pavel Dovgalyuk wrote:
> From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
> 
> This patch adds functions and headers for adding the helpers from
> the modules other than the target translators.
> 
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  include/exec/helper-register.h |   53 ++++++++++++++++++++++++++++++++++++++++
>  tcg/tcg.c                      |   12 +++++++++
>  tcg/tcg.h                      |    3 ++
>  3 files changed, 68 insertions(+)
>  create mode 100644 include/exec/helper-register.h
> 
> diff --git a/include/exec/helper-register.h b/include/exec/helper-register.h
> new file mode 100644
> index 0000000..aeface9
> --- /dev/null
> +++ b/include/exec/helper-register.h
> @@ -0,0 +1,53 @@
> +#ifndef HELPER_REGISTER_H
> +#define HELPER_REGISTER_H
> +
> +#include "exec/helper-head.h"
> +
> +/* Need one more level of indirection before stringification
> +   to get all the macros expanded first.  */
> +#define str(s) #s

Could you use tostring() from include/qemu/compiler.h instead?

 Thomas
