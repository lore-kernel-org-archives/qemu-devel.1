Received: from eggs.gnu.org ([2001:4830:134:3::10]:52801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dRwC8-0001iH-G2
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:55:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dRwC2-0000DQ-EA
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:54:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47653
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dRwC1-0000CY-En
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 03:54:49 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v637raP6175891
	for <qemu-devel@nongnu.org>; Mon, 3 Jul 2017 03:54:48 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bf29c2eur-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 03:54:48 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Mon, 3 Jul 2017 03:54:47 -0400
References: <1499049848-18012-1-git-send-email-peterx@redhat.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Mon, 3 Jul 2017 15:54:38 +0800
MIME-Version: 1.0
In-Reply-To: <1499049848-18012-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <7d11960f-168b-dce1-aa29-34cee7e7b043@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] migration: fix iotest 055,
 only-migratable break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

I tested the 2 patches and they can make iotest 055 passed on both x86=20
and s390x.

thanks


=E5=9C=A8 2017/7/3 10:44, Peter Xu =E5=86=99=E9=81=93:
> Two breakage introduced during the migration objectify series: one for
> --only-migratable, another one for iotest 055.
>
> First two patches fixes the breakages. Latter two are documentation
> updates suggested by Eduardo. Please review. Thanks.
>
> Peter Xu (4):
>    migration: fix handling for --only-migratable
>    vl: move global property, migrate init earlier
>    doc: add item for "-M enforce-config-section"
>    doc: update TYPE_MIGRATION documents
>
>   include/migration/misc.h |  1 -
>   migration/migration.c    | 20 +++++++++-----------
>   qemu-options.hx          |  8 ++++++++
>   vl.c                     | 26 +++++++++++++-------------
>   4 files changed, 30 insertions(+), 25 deletions(-)
>

--=20
Regards
QingFeng Hao
