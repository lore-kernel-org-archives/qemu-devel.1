Received: from eggs.gnu.org ([2001:4830:134:3::10]:47839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eFHGr-0004qH-3H
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:19:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1eFHGn-00075T-2Q
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:19:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1eFHGm-000748-T6
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:19:41 -0500
Date: Thu, 16 Nov 2017 15:49:16 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <658ecab6-1f09-0c94-c89e-55f71c37309a@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1711161547370.26400@wniryva>
References: <20171116075155.22378-1-ppandit@redhat.com>
	<658ecab6-1f09-0c94-c89e-55f71c37309a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v1] ps2: check PS2Queue pointers in
 post_load routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Cyrille Chatras <cyrille.chatras@orange.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

+-- On Thu, 16 Nov 2017, Paolo Bonzini wrote --+
| you don't need to change the invalid values to sane ones.  Instead, make
| ps2_common_post_load return an int (just like the .post_load member of
| VMStateDescription).  You can then detect out of range count/rptr/wptr
| and return -1 for bad indices.
| 
| In the callers,
| 
| 	ps2_common_post_load(ps2);
| 
| 	return 0;
| 
| can then become simply
| 
| 	return ps2_common_post_load(ps2);

  Okay; Sent a revised patch v2.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
