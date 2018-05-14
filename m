Received: from eggs.gnu.org ([2001:4830:134:3::10]:40549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1fI8x1-0000i9-QX
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:35:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1fI8ww-0001BO-H4
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:35:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38630
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1fI8ww-0001AA-CB
	for qemu-devel@nongnu.org; Mon, 14 May 2018 04:35:18 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4E8St68189260
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 04:35:16 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hy63stkph-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 04:35:16 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Mon, 14 May 2018 04:35:16 -0400
References: <20180508135436.30140-1-stefanha@redhat.com>
	<20180508135436.30140-3-stefanha@redhat.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Mon, 14 May 2018 16:35:00 +0800
MIME-Version: 1.0
In-Reply-To: <20180508135436.30140-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <a4f15af3-0985-46ef-125c-1e5a1f45fa6a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] blockjob: do not cancel timer in
 resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jeff Cody <jcody@redhat.com>



=E5=9C=A8 2018/5/8 21:54, Stefan Hajnoczi =E5=86=99=E9=81=93:
> Currently the timer is cancelled and the block job is entered by
> block_job_resume().  This behavior causes drain to run extra blockjob
> iterations when the job was sleeping due to the ratelimit.
>=20
> This patch leaves the job asleep when block_job_resume() is called.
> Jobs can still be forcibly woken up using block_job_enter(), which is
> used to cancel jobs.
>=20
> After this patch drain no longer runs extra blockjob iterations.  This
> is the expected behavior that qemu-iotests 185 used to rely on.  We
> temporarily changed the 185 test output to make it pass for the QEMU
> 2.12 release but now it's time to address this issue.
>=20
Verified on s390x. Thx
Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Cc: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  blockjob.c                 | 22 +++++++++++++++-------
>  tests/qemu-iotests/185     |  5 +----
>  tests/qemu-iotests/185.out | 12 +++++-------
>  3 files changed, 21 insertions(+), 18 deletions(-)
>=20

[...]
>  *** done
>=20

--=20
Regards
QingFeng Hao
