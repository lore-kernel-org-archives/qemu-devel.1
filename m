Received: from eggs.gnu.org ([2001:4830:134:3::10]:41553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eI8tj-0003fG-6O
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:59:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eI8te-00010i-3P
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:59:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eI8td-00010H-Tb
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:59:38 -0500
Date: Fri, 24 Nov 2017 13:29:28 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <adb78e77-491a-c899-8454-d628b845cd29@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1711241326170.17028@wniryva>
References: <20171123190131.5138-1-ppandit@redhat.com>
	<20171123190131.5138-2-ppandit@redhat.com>
	<adb78e77-491a-c899-8454-d628b845cd29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio: check VirtQueue Vring object
 is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, zhangboxian <zhangboxian@huawei.com>, Stefan Hajnoczi <stefanha@redhat.com>

+-- On Fri, 24 Nov 2017, Paolo Bonzini wrote --+
| Why not check vring->num in virtio_queue_update_rings too?

Yes, sent a revised patch v1. These checks seem to repeat through sequence of 
functions. I guess it'll help to do them in one place.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
