Received: from eggs.gnu.org ([2001:4830:134:3::10]:37616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euKzD-0005lx-VA
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:35:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euKz7-00068l-Qp
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:35:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33832 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1euKz7-00067T-Lf
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:35:09 -0500
References: <20180309130918.734-1-marcandre.lureau@redhat.com>
	<20180309130918.734-5-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b86fcb79-aa59-5a43-41d4-ed80174ffc25@redhat.com>
Date: Fri, 9 Mar 2018 17:35:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180309130918.734-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/7] OvmfPkg: add customized
 Tcg2ConfigPei clone
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: pjones@redhat.com, jiewen.yao@intel.com, stefanb@linux.vnet.ibm.com, qemu-devel@nongnu.org, javierm@redhat.com

On 03/09/18 14:09, marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> The Tcg2ConfigPei module informs the firmware globally about the TPM
> device type, by setting the PcdTpmInstanceGuid PCD to the appropriate
> GUID value. The original module under SecurityPkg can perform device
> detection, or read a cached value from a non-volatile UEFI variable.
>=20
> OvmfPkg's clone of the module only performs the TPM2 hardware detection=
.
>=20
> This is what the module does:
>=20
> - Check the QEMU hardware for TPM2 availability only
>=20
> - If found, set the dynamic PCD "PcdTpmInstanceGuid" to
>   &gEfiTpmDeviceInstanceTpm20DtpmGuid. This is what informs the rest of
>   the firmware about the TPM type.
>=20
> - Install the gEfiTpmDeviceSelectedGuid PPI. This action permits the
>   PEI_CORE to dispatch the Tcg2Pei module, which consumes the above PCD=
.
>   In effect, the gEfiTpmDeviceSelectedGuid PPI serializes the setting
>   and the consumption of the "TPM type" PCD.
>=20
> - If no TPM2 was found, install gPeiTpmInitializationDonePpiGuid.
>   (Normally this is performed by Tcg2Pei, but Tcg2Pei doesn't do it if
>   no TPM2 is available. So in that case our Tcg2ConfigPei must do it.)
>=20
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Contributed-under: TianoCore Contribution Agreement 1.0
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  OvmfPkg/OvmfPkgIa32.dsc                  | 17 +++++
>  OvmfPkg/OvmfPkgIa32.fdf                  |  4 ++
>  OvmfPkg/OvmfPkgIa32X64.dsc               | 17 +++++
>  OvmfPkg/OvmfPkgIa32X64.fdf               |  4 ++
>  OvmfPkg/OvmfPkgX64.dsc                   | 17 +++++
>  OvmfPkg/OvmfPkgX64.fdf                   |  4 ++
>  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf | 53 +++++++++++++++
>  OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c  | 84 ++++++++++++++++++++++++
>  8 files changed, 200 insertions(+)
>  create mode 100644 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPei.inf
>  create mode 100644 OvmfPkg/Tcg/Tcg2Config/Tcg2ConfigPeim.c

Nice!

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
