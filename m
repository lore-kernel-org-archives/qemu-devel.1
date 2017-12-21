Received: from eggs.gnu.org ([2001:4830:134:3::10]:32898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eS1ZQ-0002M4-EG
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:11:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eS1ZP-0001Uf-IL
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:11:36 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:47030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eS1ZP-0001Tc-At
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:11:35 -0500
Received: by mail-wm0-x241.google.com with SMTP id r78so16281578wme.5
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 06:11:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1510323112-2207-2-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1510323112-2207-2-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 21 Dec 2017 15:11:33 +0100
Message-ID: <CAJ+F1CJswqrzqJr+61TtJ8xK0KAQo8g3XgcvEYMov85vwJC1-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/13] tpm_tis: convert uint32_t to
 size_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, Amarnath Valluri <amarnath.valluri@intel.com>

On Fri, Nov 10, 2017 at 3:11 PM, Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> ---
>  hw/tpm/tpm_tis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> index dd43630..69fe531 100644
> --- a/hw/tpm/tpm_tis.c
> +++ b/hw/tpm/tpm_tis.c
> @@ -974,7 +974,7 @@ static const MemoryRegionOps tpm_tis_memory_ops =3D {
>      },
>  };
>
> -static int tpm_tis_do_startup_tpm(TPMState *s, uint32_t buffersize)
> +static int tpm_tis_do_startup_tpm(TPMState *s, size_t buffersize)
>  {
>      return tpm_backend_startup_tpm(s->be_driver, buffersize);
>  }
> --
> 2.5.5
>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>





--=20
Marc-Andr=C3=A9 Lureau
