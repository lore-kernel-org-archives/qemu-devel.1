Received: from eggs.gnu.org ([2001:4830:134:3::10]:38969)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZkj-0006s1-6Y
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:47:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZki-0004W3-Ec
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:47:41 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:38061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkZki-0004VE-9e
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 13:47:40 -0400
Received: by mail-it0-x244.google.com with SMTP id a71so126282itd.5
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 10:47:38 -0700 (PDT)
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <20170823162004.27337-13-marcandre.lureau@redhat.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-13-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 23 Aug 2017 14:47:37 -0300
Message-ID: <CAAdtpL5xChckCU9wEojRqe0b6T4xrnnRLrhS+YszBERB+wYnwg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/27] vhost-user-scsi: use NULL pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, changpeng.liu@intel.com, felipe@nutanix.com

On Wed, Aug 23, 2017 at 1:19 PM, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

> ---
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-us=
er-scsi/vhost-user-scsi.c
> index 624efc24ca..596c1effa1 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -686,7 +686,7 @@ static int vdev_scsi_run(vhost_scsi_dev_t *vdev_scsi)
>      assert(vdev_scsi->server_sock >=3D 0);
>      assert(vdev_scsi->loop);
>
> -    cli_sock =3D accept(vdev_scsi->server_sock, (void *)0, (void *)0);
> +    cli_sock =3D accept(vdev_scsi->server_sock, NULL, NULL);
>      if (cli_sock < 0) {
>          perror("accept");
>          return -1;
> --
> 2.14.1.146.gd35faa819
>
>
