Received: from eggs.gnu.org ([2001:4830:134:3::10]:59536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHDUA-0008Ou-KZ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:41:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHDU9-0004Na-J7
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:41:30 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHDU9-0004NN-Da
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 13:41:29 -0500
Received: by mail-ot0-x244.google.com with SMTP id s4so11397902ote.4
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 10:41:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510140763-18256-2-git-send-email-frederic.konrad@adacore.com>
References: <1510140763-18256-1-git-send-email-frederic.konrad@adacore.com>
	<1510140763-18256-2-git-send-email-frederic.konrad@adacore.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 18:41:08 +0000
Message-ID: <CAFEAcA87vxBQsh4HH-3saV1jN=xJOJ7MAbjhCVxD6ry7gNvAAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/2] cadence_ttc: extract
 CadenceTTCState to a new header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 8 November 2017 at 11:32, KONRAD Frederic
<frederic.konrad@adacore.com> wrote:
> We want to add this model to the xlnx-zynqmp board so let's make
> CadenceTTCState available in an header file.
>
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  hw/timer/cadence_ttc.c         | 35 +-----------------------
>  include/hw/timer/cadence_ttc.h | 61 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 34 deletions(-)
>  create mode 100644 include/hw/timer/cadence_ttc.h
>
> diff --git a/hw/timer/cadence_ttc.c b/hw/timer/cadence_ttc.c
> index 03f5b9c..bb4a5ef 100644
> --- a/hw/timer/cadence_ttc.c
> +++ b/hw/timer/cadence_ttc.c
> @@ -16,9 +16,7 @@
>   * with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>
> -#include "qemu/osdep.h"
> -#include "hw/sysbus.h"
> -#include "qemu/timer.h"
> +#include "hw/timer/cadence_ttc.h"

Something's gone wrong here. osdep.h should always be the first
header in any .c file, and it should never be included by any
other .h file.

thanks
-- PMM
