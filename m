Received: from eggs.gnu.org ([209.51.188.92]:52550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gozPU-0005R2-5W
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <muriloo@linux.ibm.com>) id 1gozPT-000796-Bn
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:36:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40734
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <muriloo@linux.ibm.com>)
	id 1gozPT-00078A-5p
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:36:47 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0UNZveP123904
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 18:36:46 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qbjqp7b93-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 18:36:45 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <muriloo@linux.ibm.com>;
	Wed, 30 Jan 2019 23:36:45 -0000
From: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
Date: Wed, 30 Jan 2019 21:36:03 -0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20190130233605.22163-1-muriloo@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 0/2] mmap-alloc: fix hugetlbfs misaligned
 length in ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Cao jin <caoj.fnst@cn.fujitsu.com>, David Gibson <david@gibson.dropbear.id.au>, Fabiano Rosas <farosas@linux.ibm.com>, Greg Kurz <groug@kaod.org>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, mopsfelder@gmail.com

The first patch unfolds parts of qemu_ram_mmap() to make it clearer.
No changes in the function behaviour.

The second one fixes the alignment of the length given to munmap().

I am pretty sure there is room for improvement, so I would love to
hear your feedback.

Thank you!

Murilo Opsfelder Araujo (2):
  mmap-alloc: unfold qemu_ram_mmap()
  mmap-alloc: fix hugetlbfs misaligned length in ppc64

 exec.c                    |  4 +--
 include/qemu/mmap-alloc.h |  2 +-
 util/mmap-alloc.c         | 73 ++++++++++++++++++++++++++-------------
 util/oslib-posix.c        |  2 +-
 4 files changed, 53 insertions(+), 28 deletions(-)

--
2.20.1
