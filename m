Received: from eggs.gnu.org ([2001:4830:134:3::10]:53472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eJe3J-0004fG-7g
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:27:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eJe3F-0006uc-Al
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:27:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44714)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eJe3F-0006uE-54
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:27:45 -0500
Date: Tue, 28 Nov 2017 16:57:34 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20171128103757.GD17146@stefanha-x1.localdomain>
Message-ID: <nycvar.YSQ.7.76.1711281653440.1581@wniryva>
References: <20171124183446.7308-1-ppandit@redhat.com>
	<20171124183446.7308-2-ppandit@redhat.com>
	<20171127111532.GI16527@stefanha-x1.localdomain>
	<nycvar.YSQ.7.76.1711272251290.24944@wniryva>
	<20171128101154.64b49cb0.cohuck@redhat.com>
	<20171128103757.GD17146@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

+-- On Tue, 28 Nov 2017, Stefan Hajnoczi wrote --+
| > This is conflating different things:
| > - vq does not exist (num == 0)
| > - vq is not setup by the guest (desc == 0)
| > - vq has no valid alignment (which is only relevant for legacy)
| 
| I agree.

Either case, vq would be unfit for use, no?

--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
