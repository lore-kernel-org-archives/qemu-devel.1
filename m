Received: from eggs.gnu.org ([2001:4830:134:3::10]:40522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXTGG-0005fx-Tg
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:18:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fXTGD-0004z6-OV
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:18:36 -0400
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:60186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fXTGD-0004yY-I8
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 11:18:33 -0400
Received: from player786.ha.ovh.net (unknown [10.109.108.21])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 11AAE1084F3
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 17:18:31 +0200 (CEST)
Date: Mon, 25 Jun 2018 17:18:30 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180625171830.1f4d756d@bahia.lan>
In-Reply-To: <08ebbb93dbfc29bbb727c05a16cd5ded6dec42b3.1529196703.git.keno@juliacomputing.com>
References: <cover.1529196703.git.keno@juliacomputing.com>
	<08ebbb93dbfc29bbb727c05a16cd5ded6dec42b3.1529196703.git.keno@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 05/13] 9p: darwin: Explicitly cast
 comparisons of mode_t with -1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keno Fischer <keno@juliacomputing.com>
Cc: qemu-devel@nongnu.org

On Sat, 16 Jun 2018 20:56:49 -0400
Keno Fischer <keno@juliacomputing.com> wrote:

> Comparisons of mode_t with -1 require an explicit cast, since mode_t
> is unsigned on Darwin.
> 
> Signed-off-by: Keno Fischer <keno@juliacomputing.com>
> ---

Applied to 9p-next.

>  hw/9pfs/9p-local.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index d713983..98d4073 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -310,7 +310,7 @@ update_map_file:
>      if (credp->fc_gid != -1) {
>          gid = credp->fc_gid;
>      }
> -    if (credp->fc_mode != -1) {
> +    if (credp->fc_mode != (mode_t)-1) {
>          mode = credp->fc_mode;
>      }
>      if (credp->fc_rdev != -1) {
> @@ -416,7 +416,7 @@ static int local_set_xattrat(int dirfd, const char *path, FsCred *credp)
>              return err;
>          }
>      }
> -    if (credp->fc_mode != -1) {
> +    if (credp->fc_mode != (mode_t)-1) {
>          uint32_t tmp_mode = cpu_to_le32(credp->fc_mode);
>          err = fsetxattrat_nofollow(dirfd, path, "user.virtfs.mode", &tmp_mode,
>                                     sizeof(mode_t), 0);
