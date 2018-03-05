Received: from eggs.gnu.org ([2001:4830:134:3::10]:38760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1esuy3-0007if-LY
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1esuxy-0002xR-NZ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:36:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53534 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1esuxy-0002wc-Jh
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 13:36:06 -0500
Date: Tue, 6 Mar 2018 00:05:58 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20180227194816.17940-1-ppandit@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1803060005050.13539@wniryva>
References: <20180227194816.17940-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] multiboot: check mh_load_end_addr address
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, CERT CC <cert.cc@orange.com>, "Michael S . Tsirkin" <mst@redhat.com>

+-- On Wed, 28 Feb 2018, P J P wrote --+
| While loading kernel via multiboot-v1 image, (flags & 0x00010000)
| indicates that multiboot header contains valid addresses to load
| the kernel image. In that, end of the data segment address
| 'mh_load_end_addr' should be less than the bss segment address
| 'mh_bss_end_addr'. Add check to validate that.
| 
| +        if (mh_load_end_addr > mh_bss_end_addr) {
| +            fprintf(stderr, "invalid mh_load_end_addr address\n");
| +            exit(1);
| +        }
|  

Ping...!
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
