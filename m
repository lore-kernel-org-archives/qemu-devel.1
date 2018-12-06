Received: from eggs.gnu.org ([2001:4830:134:3::10]:51109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gUrW8-0008Vc-1y
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gUrW3-0002Wv-Dn
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:08:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39376)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gUrW3-0002WA-6L
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:08:23 -0500
Date: Thu, 6 Dec 2018 16:38:10 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20181206105830.43eb1d05@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1812061637070.2113@xnncv>
References: <20181206084816.30485-1-ppandit@redhat.com>
	<20181206105830.43eb1d05@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] i2c: pm_smbus: check smb_index before
 block transfer write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Hanselmann <public@hansmi.ch>, "Michael S . Tsirkin" <mst@redhat.com>

+-- On Thu, 6 Dec 2018, Igor Mammedov wrote --+
| > From: Prasad J Pandit <pjp@fedoraproject.org>
| > 
| > While performing block transfer write in smb_ioport_writeb(),
| > 'smb_index' is incremented and used to index smb_data[] array.
| > Check 'smb_index' value to avoid OOB access.
| > 
| > Reported-by: Michael Hanselmann <public@hansmi.ch>
| > Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
| pls squash in:
| 
| Fixes: 38ad4fae43 i2c: pm_smbus: Add block transfer capability

Do we need patch v2, or it can be done while merging it?

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
