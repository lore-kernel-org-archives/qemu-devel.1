Received: from eggs.gnu.org ([2001:4830:134:3::10]:38971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euL4E-0001kG-I2
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euL49-0000F6-Em
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:40:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43460 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1euL49-0000ER-6h
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:40:21 -0500
References: <20180309130918.734-1-marcandre.lureau@redhat.com>
	<20180309130918.734-6-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <15291730-3285-a554-89ac-e8c359053cc3@redhat.com>
Date: Fri, 9 Mar 2018 17:40:05 +0100
MIME-Version: 1.0
In-Reply-To: <20180309130918.734-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/7] OvmfPkg: include Tcg2Pei module
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
> This module will initialize TPM device, measure reported FVs and BIOS
> version. We keep both SHA-1 and SHA-256 for the TCG 1.2 log format
> compatibility, but the SHA-256 measurements and TCG 2 log format are
> now recommended.
>=20
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Contributed-under: TianoCore Contribution Agreement 1.0
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  OvmfPkg/OvmfPkgIa32.dsc    | 7 +++++++
>  OvmfPkg/OvmfPkgIa32.fdf    | 1 +
>  OvmfPkg/OvmfPkgIa32X64.dsc | 7 +++++++
>  OvmfPkg/OvmfPkgIa32X64.fdf | 1 +
>  OvmfPkg/OvmfPkgX64.dsc     | 7 +++++++
>  OvmfPkg/OvmfPkgX64.fdf     | 1 +
>  6 files changed, 24 insertions(+)

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
