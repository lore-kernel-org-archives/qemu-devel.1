Received: from eggs.gnu.org ([2001:4830:134:3::10]:49550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e212Q-0008O4-KT
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:22:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1e212N-0006sf-6i
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:22:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1e212N-0006sM-0J
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 16:21:59 -0400
Date: Tue, 10 Oct 2017 17:21:51 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171010202151.GA4178@localhost.localdomain>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-38-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20171009225623.29232-38-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 37/42] tpm: lookup the the TPM interface
 instead of TIS device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, amarnath.valluri@intel.com, "Michael S. Tsirkin" <mst@redhat.com>, stefanb@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On Tue, Oct 10, 2017 at 12:56:18AM +0200, Marc-Andr=E9 Lureau wrote:
[...]
> -static inline TPMVersion tpm_get_version(void)
> +static inline TPMIf *tpm_find(void)
>  {
> -#ifdef CONFIG_TPM
> -    Object *obj =3D object_resolve_path_type("", TYPE_TPM_TIS, NULL);
> +    Object *obj =3D object_resolve_path_type("", TYPE_TPM_IF, NULL);

Considering that tpm_crb_realizefn() will rely on tpm_find()
returning NULL if there are multiple TPM devices, I suggest
adding a "returns NULL unless there is exactly one TPM device"
comment, just like fw_cfg_find() and find_vmgenid_dev()

> +
> +    return TPM_IF(obj);
> +}
[...]

--=20
Eduardo
