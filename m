Received: from eggs.gnu.org ([2001:4830:134:3::10]:34930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dvITJ-0002j4-S2
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dvITI-0001Su-W9
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 03:34:01 -0400
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-9-andrew.smirnov@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <10a9c31a-5bd1-5915-4b82-1c3cf9cd8bbd@redhat.com>
Date: Fri, 22 Sep 2017 15:33:47 +0800
MIME-Version: 1.0
In-Reply-To: <20170918195100.17593-9-andrew.smirnov@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 08/17] imx_fec: Add support for multiple Tx
 DMA rings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, yurovsky@gmail.com



On 2017=E5=B9=B409=E6=9C=8819=E6=97=A5 03:50, Andrey Smirnov wrote:
> More recent version of the IP block support more than one Tx DMA ring,
> so add the code implementing that feature.
>
> Cc: Peter Maydell<peter.maydell@linaro.org>
> Cc: Jason Wang<jasowang@redhat.com>
> Cc:qemu-devel@nongnu.org
> Cc:qemu-arm@nongnu.org
> Cc:yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov<andrew.smirnov@gmail.com>
> ---
>   hw/net/imx_fec.c         | 97 +++++++++++++++++++++++++++++++++++++++=
---------
>   include/hw/net/imx_fec.h | 23 +++++++++++-
>   2 files changed, 101 insertions(+), 19 deletions(-)

Is there a register for driver to know about the version? (Looks like I=20
didn't find it).

Thanks
