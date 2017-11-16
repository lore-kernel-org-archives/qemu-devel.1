Received: from eggs.gnu.org ([2001:4830:134:3::10]:37895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eFEzR-0005lK-W5
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:53:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eFEzP-0007EY-UF
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:53:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eFEzP-0007Dw-Ou
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 02:53:35 -0500
Date: Thu, 16 Nov 2017 13:23:16 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <20171115133034.GB4418@work-vm>
Message-ID: <nycvar.YSQ.7.76.1711161322260.21870@wniryva>
References: <20171115124602.12501-1-ppandit@redhat.com>
	<20171115125151.GG20349@redhat.com>
	<f569ccce-4aa5-423a-25b2-baf69e8e6b43@redhat.com>
	<20171115133034.GB4418@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] ps2: fix PS2Queue counter field type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Cyrille Chatras <cyrille.chatras@orange.com>, Gerd Hoffmann <kraxel@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

+-- On Wed, 15 Nov 2017, Dr. David Alan Gilbert wrote --+
| * Paolo Bonzini (pbonzini@redhat.com) wrote:
| > However, PJP's patch breaks migration by changing a 4-byte field to
| > 1-byte.  The correct fix is to range-check the fields in
| > ps2_common_post_load.
| 
| Agreed.

Sent revised patch v1. Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
