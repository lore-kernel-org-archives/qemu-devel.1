Received: from eggs.gnu.org ([2001:4830:134:3::10]:56996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g8PBI-0003zl-2e
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:26:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1g8P66-0008Mm-CA
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:20:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1g8P66-0008MM-4l
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 08:20:46 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <1538734535-7483-1-git-send-email-thuth@redhat.com>
	<7381a5a1-07f5-f79a-177d-cd39bce5a52e@redhat.com>
	<a90da631-1b38-7cc3-8200-521128199264@redhat.com>
Message-ID: <bdadc236-5ec3-8d9f-68a3-9f7cee846ad9@redhat.com>
Date: Fri, 5 Oct 2018 14:20:34 +0200
MIME-Version: 1.0
In-Reply-To: <a90da631-1b38-7cc3-8200-521128199264@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/core/generic-loader: Compile only once,
 not for each target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Alistair Francis <alistair@alistair23.me>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <rth@twiddle.net>

On 10/05/18 14:17, Laszlo Ersek wrote:

> Not that it isn't valid, necessarily. "hw/virtio/virtio.c" still
> features an embedded declaration of this function. Just above
> virtio_default_endian(), which calls it. [...]
> 
> (Either way, the embedded declaration of the function should go.)

(which is what the patch already does, of course!)
Laszlo
