Received: from eggs.gnu.org ([2001:4830:134:3::10]:51258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e234H-000290-00
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1e234C-0002zY-Vx
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:32:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1e234C-0002z7-Pl
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 18:32:00 -0400
Date: Tue, 10 Oct 2017 18:31:57 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <245970228.28309170.1507674717452.JavaMail.zimbra@redhat.com>
In-Reply-To: <efe8e952-d487-0cc4-2935-5234a1d88928@linux.vnet.ibm.com>
References: <20171009225623.29232-1-marcandre.lureau@redhat.com>
	<20171009225623.29232-38-marcandre.lureau@redhat.com>
	<20171010202151.GA4178@localhost.localdomain>
	<efe8e952-d487-0cc4-2935-5234a1d88928@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, amarnath valluri <amarnath.valluri@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

----- Original Message -----
> On 10/10/2017 04:21 PM, Eduardo Habkost wrote:
> > On Tue, Oct 10, 2017 at 12:56:18AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > [...]
> >> -static inline TPMVersion tpm_get_version(void)
> >> +static inline TPMIf *tpm_find(void)
> >>   {
> >> -#ifdef CONFIG_TPM
> >> -    Object *obj =3D object_resolve_path_type("", TYPE_TPM_TIS, NULL);
> >> +    Object *obj =3D object_resolve_path_type("", TYPE_TPM_IF, NULL);
> > Considering that tpm_crb_realizefn() will rely on tpm_find()
> > returning NULL if there are multiple TPM devices, I suggest
> > adding a "returns NULL unless there is exactly one TPM device"
> > comment, just like fw_cfg_find() and find_vmgenid_dev()
>=20
> I wonder whether the function couldn't have a better name.
> tpm_find_single() ?
>=20

As Eduardo said, there is precedence in QEMU codebase (fw_cfg_find() and fi=
nd_vmgenid_dev())

I don't think foo_find() is a bad name - it returns NULL if there are multi=
ple foo, which makes sense imho. I'll add the missing comment though.
