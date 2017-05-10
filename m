Received: from eggs.gnu.org ([2001:4830:134:3::10]:43580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d8VCc-0001By-Ms
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1d8VCZ-0008HM-KO
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:15:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1d8VCZ-0008HE-E6
	for qemu-devel@nongnu.org; Wed, 10 May 2017 13:15:03 -0400
Date: Wed, 10 May 2017 22:44:54 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <70706623-df88-fec7-9402-d076abd20d29@redhat.com>
Message-ID: <alpine.LFD.2.20.1705102240430.24924@wniryva>
References: <20170510111350.18422-1-ppandit@redhat.com>
	<70706623-df88-fec7-9402-d076abd20d29@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH] scsi: megasas: check request object in
 MegasasCmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Qemu Developers <qemu-devel@nongnu.org>, Zhangyanyu <zyy4013@stu.ouc.edu.cn>

  Hello Paolo,

+-- On Wed, 10 May 2017, Paolo Bonzini wrote --+
| What version was this reported for?  It should be fixed in v2.8.0 and
| newer by commit 9e55d58806 ("megasas: clean up and fix request
| completion/cancellation", 2016-11-28).

I checked the reproducer against current upstream git, it does work. IIUC, the 
above commit appears to have introduced the issue.

Thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
