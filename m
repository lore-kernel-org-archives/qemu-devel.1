Received: from eggs.gnu.org ([2001:4830:134:3::10]:44449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwsXC-0005Zd-Bu
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:17:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <carenas@gmail.com>) id 1dwsW8-000220-70
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:16:34 -0400
MIME-Version: 1.0
In-Reply-To: <20170926151421.14557-1-eblake@redhat.com>
References: <20170926151421.14557-1-eblake@redhat.com>
From: Carlo Arenas <carenas@gmail.com>
Date: Tue, 26 Sep 2017 09:15:23 -0700
Message-ID: <CAPUEspivA58rgYWwNB8mi1esu-kfn7-j7m-6EAfg91e2PzxTnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scsi: Ignore executable for in-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, pbonzini@redhat.com

Reviewed-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

On Tue, Sep 26, 2017 at 8:14 AM, Eric Blake <eblake@redhat.com> wrote:

> The new qemu-pr-helper (commit b855f8d17) should not be checked in,
> even when doing in-tree builds.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.gitignore b/.gitignore
> index 40acfcb9e2..3a7e01dc6a 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -49,6 +49,7 @@
>  /qemu-version.h
>  /qemu-version.h.tmp
>  /module_block.h
> +/scsi/qemu-pr-helper
>  /vscclient
>  /vhost-user-scsi
>  /fsdev/virtfs-proxy-helper
> --
> 2.13.5
>
>
>
