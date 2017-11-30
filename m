Received: from eggs.gnu.org ([2001:4830:134:3::10]:59662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eKKxh-0002G8-Tc
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eKKxe-0002j7-NG
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:16:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eKKxe-0002ic-HF
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:16:50 -0500
Date: Thu, 30 Nov 2017 14:46:32 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20171129121609.61a03d36.cohuck@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1711301445190.2625@wniryva>
References: <20171124183446.7308-1-ppandit@redhat.com>
	<20171124183446.7308-2-ppandit@redhat.com>
	<20171127111532.GI16527@stefanha-x1.localdomain>
	<nycvar.YSQ.7.76.1711272251290.24944@wniryva>
	<20171128101154.64b49cb0.cohuck@redhat.com>
	<20171128103757.GD17146@stefanha-x1.localdomain>
	<nycvar.YSQ.7.76.1711281653440.1581@wniryva>
	<20171128130012.1466d231.cohuck@redhat.com>
	<nycvar.YSQ.7.76.1711291445390.12405@wniryva>
	<20171129121609.61a03d36.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v3 1/2] virtio: check VirtQueue Vring
 object is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

+-- On Wed, 29 Nov 2017, Cornelia Huck wrote --+
| I think the basic problem is still that you conflate two things:
| - vring.num, which cannot be flipped between 0 and !0 by the guest
| - vring.{desc,avail,used}, which can
| 
| IOW, if vring.num == 0, the guest cannot manipulate the queue; if
| vring.desc == 0, the guest can. 
| 
| Many functions have a likely/unlikely check, setup routines excepted.

Have sent a revised patch v4. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
