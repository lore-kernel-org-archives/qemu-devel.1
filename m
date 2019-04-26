Received: from eggs.gnu.org ([209.51.188.92]:55189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJx8k-0002ec-H0
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJx5K-0005Hw-HD
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:23:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:48346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hJx5K-0005GI-9y
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:23:58 -0400
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Fri, 26 Apr 2019 09:23:35 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78060E0DC1@shsmsx102.ccr.corp.intel.com>
References: <20190426034028.4794-1-chen.zhang@intel.com>
In-Reply-To: <20190426034028.4794-1-chen.zhang@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] migration/colo.h: Remove obsolete codes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <zhangckid@gmail.com>

This patch have been integrated in this series:
http://lists.nongnu.org/archive/html/qemu-devel/2019-04/msg04520.html
Please review it at this link.

Thanks
Zhang Chen

> -----Original Message-----
> From: Zhang, Chen
> Sent: Friday, April 26, 2019 11:40 AM
> To: Laurent Vivier <laurent@vivier.eu>; Dr. David Alan Gilbert
> <dgilbert@redhat.com>; Juan Quintela <quintela@redhat.com>; zhanghailiang
> <zhang.zhanghailiang@huawei.com>; qemu-dev <qemu-devel@nongnu.org>
> Cc: Zhang Chen <zhangckid@gmail.com>; Zhang, Chen <chen.zhang@intel.com>
> Subject: [PATCH] migration/colo.h: Remove obsolete codes
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  include/migration/colo.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/include/migration/colo.h b/include/migration/colo.h index
> ddebe0ad27..f6fbe23ec9 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -22,8 +22,6 @@ enum colo_event {
>      COLO_EVENT_FAILOVER,
>  };
>=20
> -void colo_info_init(void);
> -
>  void migrate_start_colo_process(MigrationState *s);  bool
> migration_in_colo_state(void);
>=20
> --
> 2.17.GIT
