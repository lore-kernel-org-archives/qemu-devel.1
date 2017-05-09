Received: from eggs.gnu.org ([2001:4830:134:3::10]:51470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d87yE-0000iH-Ny
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:26:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1d87yD-00055C-Sd
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:26:42 -0400
Date: Tue, 9 May 2017 12:26:32 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170509162632.GD16494@localhost.localdomain>
References: <20170508141310.8674-1-pbonzini@redhat.com>
	<20170508141310.8674-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170508141310.8674-3-pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/11] blockjob: remove iostatus_reset
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, stefanha@redhat.com

On Mon, May 08, 2017 at 04:13:01PM +0200, Paolo Bonzini wrote:
> This is unused since commit 66a0fae ("blockjob: Don't touch BDS iostatu=
s",
> 2016-05-19).
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c                   | 3 ---
>  include/block/blockjob_int.h | 3 ---
>  2 files changed, 6 deletions(-)
>=20
> diff --git a/blockjob.c b/blockjob.c
> index 23022b3331..71187d0c9e 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -555,9 +555,6 @@ bool block_job_is_cancelled(BlockJob *job)
>  void block_job_iostatus_reset(BlockJob *job)
>  {
>      job->iostatus =3D BLOCK_DEVICE_IO_STATUS_OK;
> -    if (job->driver->iostatus_reset) {
> -        job->driver->iostatus_reset(job);
> -    }
>  }
> =20
>  static int block_job_finish_sync(BlockJob *job,
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.=
h
> index 3f86cc5acc..bfcc5d1241 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -44,9 +44,6 @@ struct BlockJobDriver {
>      /** Optional callback for job types that support setting a speed l=
imit */
>      void (*set_speed)(BlockJob *job, int64_t speed, Error **errp);
> =20
> -    /** Optional callback for job types that need to forward I/O statu=
s reset */
> -    void (*iostatus_reset)(BlockJob *job);
> -
>      /** Mandatory: Entrypoint for the Coroutine. */
>      CoroutineEntry *start;
> =20
> --=20
> 2.12.2
>=20
>
Reviewed-by: Jeff Cody <jcody@redhat.com>
