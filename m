Received: from eggs.gnu.org ([2001:4830:134:3::10]:44081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duIZ2-0001zR-Hu
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1duIZ1-0006me-I4
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:27:48 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170919112645.8574-1-clg@kaod.org>
	<20170919112645.8574-5-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3bb3924d-a7c9-26b3-50a2-8a10ef2585e5@amsat.org>
Date: Tue, 19 Sep 2017 10:27:42 -0300
MIME-Version: 1.0
In-Reply-To: <20170919112645.8574-5-clg@kaod.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 4/5] misc: add pca9552 LED
 blinker model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>

On 09/19/2017 08:26 AM, Cédric Le Goater wrote:
> Specs are available here :
> 
>    https://www.nxp.com/docs/en/data-sheet/PCA9552.pdf
> 
> This is a simple model supporting the basic registers for led and GPIO
> mode. The device also supports two blinking rates but not the model
> yet.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   default-configs/arm-softmmu.mak |   1 +
>   hw/misc/Makefile.objs           |   1 +
>   hw/misc/pca9552.c               | 212 ++++++++++++++++++++++++++++++++++++++++
>   include/hw/misc/pca9552.h       |  32 ++++++

I'd rather move it to hw/display/

>   4 files changed, 246 insertions(+)
>   create mode 100644 hw/misc/pca9552.c
>   create mode 100644 include/hw/misc/pca9552.h
