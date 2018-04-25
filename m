Received: from eggs.gnu.org ([2001:4830:134:3::10]:33129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLXG-0000Kr-HO
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLXE-0007vz-Fw
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:36:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBLXE-0007vu-Bn
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:36:40 -0400
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-3-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <63483ae4-5a07-d1fa-af76-bd1566563833@redhat.com>
Date: Wed, 25 Apr 2018 16:36:33 +0200
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

... maybe drop the "updates serial_hds" in this patch description since
serial_hds is not updated here?

 Thomas
