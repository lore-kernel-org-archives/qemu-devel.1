Received: from eggs.gnu.org ([2001:4830:134:3::10]:51927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0oaQ-0007xG-4G
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 08:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1e0oaL-0003h0-8Y
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 08:52:10 -0400
Received: from 14.mo4.mail-out.ovh.net ([46.105.40.29]:35205)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1e0oaL-0003eq-2U
	for qemu-devel@nongnu.org; Sat, 07 Oct 2017 08:52:05 -0400
Received: from player772.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id E98A4D1885
	for <qemu-devel@nongnu.org>; Sat,  7 Oct 2017 14:52:02 +0200 (CEST)
Date: Sat, 7 Oct 2017 14:51:53 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171007145153.3cc83ff8@bahia.lan>
In-Reply-To: <20171006235023.11952-70-f4bug@amsat.org>
References: <20171006235023.11952-1-f4bug@amsat.org>
	<20171006235023.11952-70-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 69/88] virtio-9p: use g_new() family of
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Aneesh
	Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu trival <qemu-trivial@nongnu.org>

On Fri,  6 Oct 2017 20:50:04 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [PMD: added 2 more uses in hw/9pfs/9p-synth.c]
> ---

Acked-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p-handle.c | 2 +-
>  hw/9pfs/9p-proxy.c  | 2 +-
>  hw/9pfs/9p-synth.c  | 8 ++++----
>  hw/9pfs/9p.c        | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/9pfs/9p-handle.c b/hw/9pfs/9p-handle.c
> index 9875f1894c..357ced3079 100644
> --- a/hw/9pfs/9p-handle.c
> +++ b/hw/9pfs/9p-handle.c
> @@ -609,7 +609,7 @@ static int handle_init(FsContext *ctx)
>      int ret, mnt_id;
>      struct statfs stbuf;
>      struct file_handle fh;
> -    struct handle_data *data =3D g_malloc(sizeof(struct handle_data));
> +    struct handle_data *data =3D g_new(struct handle_data, 1);
> =20
>      data->mountfd =3D open(ctx->fs_root, O_DIRECTORY);
>      if (data->mountfd < 0) {
> diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> index 28b20a7c3d..2de303d713 100644
> --- a/hw/9pfs/9p-proxy.c
> +++ b/hw/9pfs/9p-proxy.c
> @@ -1136,7 +1136,7 @@ static int proxy_parse_opts(QemuOpts *opts, struct =
FsDriverEntry *fs)
> =20
>  static int proxy_init(FsContext *ctx)
>  {
> -    V9fsProxy *proxy =3D g_malloc(sizeof(V9fsProxy));
> +    V9fsProxy *proxy =3D g_new(V9fsProxy, 1);
>      int sock_id;
> =20
>      if (ctx->export_flags & V9FS_PROXY_SOCK_NAME) {
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index df0a8de08a..3aa69cf465 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -43,7 +43,7 @@ static V9fsSynthNode *v9fs_add_dir_node(V9fsSynthNode *=
parent, int mode,
> =20
>      /* Add directory type and remove write bits */
>      mode =3D ((mode & 0777) | S_IFDIR) & ~(S_IWUSR | S_IWGRP | S_IWOTH);
> -    node =3D g_malloc0(sizeof(V9fsSynthNode));
> +    node =3D g_new0(V9fsSynthNode, 1);
>      if (attr) {
>          /* We are adding .. or . entries */
>          node->attr =3D attr;
> @@ -124,7 +124,7 @@ int qemu_v9fs_synth_add_file(V9fsSynthNode *parent, i=
nt mode,
>      }
>      /* Add file type and remove write bits */
>      mode =3D ((mode & 0777) | S_IFREG);
> -    node =3D g_malloc0(sizeof(V9fsSynthNode));
> +    node =3D g_new0(V9fsSynthNode, 1);
>      node->attr         =3D &node->actual_attr;
>      node->attr->inode  =3D synth_node_count++;
>      node->attr->nlink  =3D 1;
> @@ -180,7 +180,7 @@ static int synth_opendir(FsContext *ctx,
>      V9fsSynthOpenState *synth_open;
>      V9fsSynthNode *node =3D *(V9fsSynthNode **)fs_path->data;
> =20
> -    synth_open =3D g_malloc(sizeof(*synth_open));
> +    synth_open =3D g_new(V9fsSynthOpenState, 1);
>      synth_open->node =3D node;
>      node->open_count++;
>      fs->private =3D synth_open;
> @@ -264,7 +264,7 @@ static int synth_open(FsContext *ctx, V9fsPath *fs_pa=
th,
>      V9fsSynthOpenState *synth_open;
>      V9fsSynthNode *node =3D *(V9fsSynthNode **)fs_path->data;
> =20
> -    synth_open =3D g_malloc(sizeof(*synth_open));
> +    synth_open =3D g_new(V9fsSynthOpenState, 1);
>      synth_open->node =3D node;
>      node->open_count++;
>      fs->private =3D synth_open;
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 23ac7bb532..510867b4dc 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -298,7 +298,7 @@ static V9fsFidState *alloc_fid(V9fsState *s, int32_t =
fid)
>              return NULL;
>          }
>      }
> -    f =3D g_malloc0(sizeof(V9fsFidState));
> +    f =3D g_new0(V9fsFidState, 1);
>      f->fid =3D fid;
>      f->fid_type =3D P9_FID_NONE;
>      f->ref =3D 1;
