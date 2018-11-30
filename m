Received: from eggs.gnu.org ([2001:4830:134:3::10]:33399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gSewY-0002if-0Q
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gSewT-0005vr-4J
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:18:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gSewS-0005uz-Qa
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 04:18:33 -0500
Date: Fri, 30 Nov 2018 14:48:19 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <44516b60-dafd-70e3-1638-ea38a804c8a4@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1811301446050.9903@xnncv>
References: <20181129121449.4322-1-jasowang@redhat.com>
	<44516b60-dafd-70e3-1638-ea38a804c8a4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH V2 for 3.1 0/4] Fix possible OOB during
 queuing packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, mst@redhat.com, liq3ea@gmail.com, pbonzini@redhat.com

+-- On Thu, 29 Nov 2018, Eric Blake wrote --+
| How important is this for 3.1?  We've missed -rc3.  Is this CVE quality 
| because of a guest being able to cause mayhem by intentionally getting into 
| this condition (in which case, we need it, as well as a CVE assigned)? Is it 
| pre-existing in 3.0 at which point waiting for 4.0 is no worse off than what 
| we already are?

It is a revised patch to fix 'CVE-2018-17963' issue. Earlier patch was 
included in -rc0.

$ git tag --contains 1592a9947036d60dde5404204a5d45975133caf5
v3.1.0-rc0
v3.1.0-rc1
v3.1.0-rc2
v3.1.0-rc3

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
