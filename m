Received: from eggs.gnu.org ([2001:4830:134:3::10]:60728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLVN-00073I-9R
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLVH-0007Ag-LI
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:34:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBLVH-0007AT-GT
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:34:39 -0400
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-3-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d8c8d779-7735-028e-4bbc-75c9a64c0bcb@redhat.com>
Date: Wed, 25 Apr 2018 16:34:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/13] hw/arm/fsl-imx*: Don't create "null"
 chardevs for serial devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org

On 20.04.2018 16:52, Peter Maydell wrote:
> Following commit 12051d82f004024, UART devices should handle
> being passed a NULL pointer chardev, so we don't need to
> create "null" backends in board code. Remove the code that
> does this and updates serial_hds[].
> 
> (fsl-imx7.c was already written this way.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/fsl-imx25.c | 12 +-----------
>  hw/arm/fsl-imx31.c | 12 +-----------
>  hw/arm/fsl-imx6.c  | 13 +------------
>  3 files changed, 3 insertions(+), 34 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
