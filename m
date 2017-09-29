Received: from eggs.gnu.org ([2001:4830:134:3::10]:37617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dxuDQ-0007rf-5M
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:16:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dxuDP-0008I0-AC
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:16:24 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:38561)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dxuDP-0008Ho-3s
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 08:16:23 -0400
Received: by mail-oi0-x241.google.com with SMTP id s145so588380oie.5
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 05:16:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506683421-27004-10-git-send-email-amarnath.valluri@intel.com>
References: <1506683421-27004-1-git-send-email-amarnath.valluri@intel.com>
	<1506683421-27004-10-git-send-email-amarnath.valluri@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 29 Sep 2017 14:16:21 +0200
Message-ID: <CAJ+F1CLN+=W5DcB+P5XAqU7EfHv5ojP831LYPj4+BpasnGk3DQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 9/9] tpm: Move tpm_cleanup() to right
 place
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Amarnath Valluri <amarnath.valluri@intel.com>
Cc: QEMU <qemu-devel@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
List-ID: <qemu-devel.nongnu.org>

On Fri, Sep 29, 2017 at 1:10 PM, Amarnath Valluri
<amarnath.valluri@intel.com> wrote:
> As Emulator TPM backend uses chardev, tpm cleanup should happen before ch=
ardev
> similar to other vhost-users.
>
> Signed-off-by: Amarnath Valluri <amarnath.valluri@intel.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  tpm.c | 1 -
>  vl.c  | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tpm.c b/tpm.c
> index 3b8c7ed..3122227 100644
> --- a/tpm.c
> +++ b/tpm.c
> @@ -172,7 +172,6 @@ int tpm_init(void)
>          return -1;
>      }
>
> -    atexit(tpm_cleanup);
>      return 0;
>  }
>
> diff --git a/vl.c b/vl.c
> index 9bb5058..ed86209 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -4893,6 +4893,7 @@ int main(int argc, char **argv, char **envp)
>      res_free();
>
>      /* vhost-user must be cleaned up before chardevs.  */
> +    tpm_cleanup();
>      net_cleanup();
>      audio_cleanup();
>      monitor_cleanup();
> --
> 2.7.4
>



--=20
Marc-Andr=C3=A9 Lureau
