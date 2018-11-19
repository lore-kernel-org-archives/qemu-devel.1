Received: from eggs.gnu.org ([2001:4830:134:3::10]:60479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gOifA-00023f-D4
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gOif9-0001tk-Na
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:28:24 -0500
Date: Mon, 19 Nov 2018 13:27:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181119132740.2e948b4a.cohuck@redhat.com>
In-Reply-To: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
References: <20181119120820.29878-1-maozhongyi@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/22] QOM'ify SysBusDeviceClass->init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
Cc: qemu-devel@nongnu.org, alistair.francis@wdc.com, anthony.perard@citrix.com, armbru@redhat.com, borntraeger@de.ibm.com, chouteau@adacore.com, david@gibson.dropbear.id.au, david@redhat.com, edgar.iglesias@gmail.com, ehabkost@redhat.com, f4bug@amsat.org, gxt@mprc.pku.edu.cn, jan.kiszka@web.de, kraxel@redhat.com, kwolf@redhat.com, marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com, michael@walle.cc, mreitz@redhat.com, mst@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, richard.henderson@linaro.org, rth@twiddle.net, sstabellini@kernel.org, thuth@redhat.com, xen-devel@lists.xenproject.org

On Mon, 19 Nov 2018 20:07:58 +0800
Mao Zhongyi <maozhongyi@cmss.chinamobile.com> wrote:

> The SysBusDeviceClass::init() interface is considered
> as a legacy interface and there are currently some
> efforts going on to get rid of it. Thus convert 
> SysBusDeviceClass::init to DeviceClass::realize.

In case my comment to the s390 change comes off as negative: I like
getting rid of the legacy interface :)
