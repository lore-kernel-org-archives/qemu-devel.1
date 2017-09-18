Received: from eggs.gnu.org ([2001:4830:134:3::10]:48058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dttLz-0000VV-7f
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:32:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dttLv-0002b5-8v
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:32:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dttLv-0002Z4-1P
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:32:35 -0400
Message-ID: <1505730751.10119.8.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 18 Sep 2017 12:32:31 +0200
In-Reply-To: <dc748e15f36db808f90b4f2393bc29ba7556a9f6.1505485574.git.alifm@linux.vnet.ibm.com>
References: <cover.1505485574.git.alifm@linux.vnet.ibm.com>
	<dc748e15f36db808f90b4f2393bc29ba7556a9f6.1505485574.git.alifm@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] virtio-gpu: Handle endian conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com

On Fri, 2017-09-15 at 10:40 -0400, Farhan Ali wrote:
> Virtio GPU code currently only supports litte endian format,
> and so using the Virtio GPU device on a big endian machine
> does not work.
> 
> Let's fix it by supporting the correct host cpu byte order.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
