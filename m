Received: from eggs.gnu.org ([2001:4830:134:3::10]:33447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcpP7-00035U-PX
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fcpP4-0003cS-MQ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:57:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fcpP4-0003cM-H3
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:57:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BF11400138A
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 09:57:49 +0000 (UTC)
Date: Tue, 10 Jul 2018 10:57:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180710095743.GC2656@work-vm>
References: <20180710094424.30754-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180710094424.30754-1-peterx@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0] migration: reorder
 MIG_CMD_POSTCOPY_RESUME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, ldoktor@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> It was accidently added before MIG_CMD_PACKAGED so it might break
> command compatibility when we run postcopy migration between old/new
> QEMUs.  Fix that up quickly before the QEMU 3.0 release.
>=20
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  migration/savevm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index c2f34ffc7c..0d2c4a0739 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -81,8 +81,8 @@ enum qemu_vm_cmd {
>      MIG_CMD_POSTCOPY_RAM_DISCARD,  /* A list of pages to discard that
>                                        were previously sent during
>                                        precopy but are dirty. */
> -    MIG_CMD_POSTCOPY_RESUME,       /* resume postcopy on dest */
>      MIG_CMD_PACKAGED,          /* Send a wrapped stream within this st=
ream */
> +    MIG_CMD_POSTCOPY_RESUME,   /* resume postcopy on dest */
>      MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
>      MIG_CMD_MAX
>  };
> --=20
> 2.17.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
