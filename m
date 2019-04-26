Received: from eggs.gnu.org ([209.51.188.92]:55329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJx8k-0002lB-Ly
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJx5G-0005Ef-6E
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:23:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:18735)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hJx5F-0005DJ-Te
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:23:54 -0400
From: "Zhang, Chen" <chen.zhang@intel.com>
Date: Fri, 26 Apr 2019 09:23:47 +0000
Message-ID: <9CFF81C0F6B98A43A459C9EDAD400D78060E0DCF@shsmsx102.ccr.corp.intel.com>
References: <20190426034015.4696-1-chen.zhang@intel.com>
In-Reply-To: <20190426034015.4696-1-chen.zhang@intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] migration/colo.c: Remove redundant input
 parameter
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
> Subject: [PATCH] migration/colo.c: Remove redundant input parameter
>=20
> From: Zhang Chen <chen.zhang@intel.com>
>=20
> The colo_do_failover no need the input parameter.
>=20
> Signed-off-by: Zhang Chen <chen.zhang@intel.com>
> ---
>  include/migration/colo.h  | 2 +-
>  migration/colo-failover.c | 2 +-
>  migration/colo.c          | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/migration/colo.h b/include/migration/colo.h index
> 99ce17aca7..ddebe0ad27 100644
> --- a/include/migration/colo.h
> +++ b/include/migration/colo.h
> @@ -37,7 +37,7 @@ bool migration_incoming_in_colo_state(void);
>  COLOMode get_colo_mode(void);
>=20
>  /* failover */
> -void colo_do_failover(MigrationState *s);
> +void colo_do_failover(void);
>=20
>  void colo_checkpoint_notify(void *opaque);  #endif diff --git a/migratio=
n/colo-
> failover.c b/migration/colo-failover.c index 4854a96c92..e9ca0b4774 10064=
4
> --- a/migration/colo-failover.c
> +++ b/migration/colo-failover.c
> @@ -39,7 +39,7 @@ static void colo_failover_bh(void *opaque)
>          return;
>      }
>=20
> -    colo_do_failover(NULL);
> +    colo_do_failover();
>  }
>=20
>  void failover_request_active(Error **errp) diff --git a/migration/colo.c
> b/migration/colo.c index 238a6d62c7..8c1644091f 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -193,7 +193,7 @@ COLOMode get_colo_mode(void)
>      }
>  }
>=20
> -void colo_do_failover(MigrationState *s)
> +void colo_do_failover(void)
>  {
>      /* Make sure VM stopped while failover happened. */
>      if (!colo_runstate_is_stopped()) {
> --
> 2.17.GIT
