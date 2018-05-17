Received: from eggs.gnu.org ([2001:4830:134:3::10]:52355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJEFH-0002tk-Ko
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fJEFE-0000ST-Dk
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:26:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fJEFE-0000SL-9r
	for qemu-devel@nongnu.org; Thu, 17 May 2018 04:26:40 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <20180515123007.10164-1-marcandre.lureau@redhat.com>
	<fa1fac3a-6662-6516-5d65-827b9d36d6b0@redhat.com>
Message-ID: <af7d9bbf-1a5b-1937-4b19-02442c95a6a1@redhat.com>
Date: Thu, 17 May 2018 10:26:33 +0200
MIME-Version: 1.0
In-Reply-To: <fa1fac3a-6662-6516-5d65-827b9d36d6b0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH 0/4] RFC: ovmf: Add support for TPM
 Physical Presence interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@redhat.com, edk2-devel@lists.01.org
Cc: qemu-devel@nongnu.org, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

On 05/17/18 09:54, Laszlo Ersek wrote:
> On 05/15/18 14:30, marcandre.lureau@redhat.com wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> Hi,
>>
>> The following series adds basic TPM PPI 1.3 support for OVMF-on-QEMU
>> with TPM2 (I haven't tested TPM1, for lack of interest).
>>
>> PPI test runs successfully with Windows 10 WHLK, despite the limited
>> number of supported funcions (tpm2_ppi_funcs table, in particular, no
>> function allows to manipulate Tcg2PhysicalPresenceFlags)
>>
>> The way it works is relatively simple: a memory region is allocated by
>> QEMU to save PPI related variables. An ACPI interface is exposed by
>> QEMU to let the guest manipulate those. At boot, ovmf processes and
>> updates the PPI qemu region and request variables.
>>
>> I build edk2 with:
>>
>> $ build -DTPM2_ENABLE -DSECURE_BOOT_ENABLE
>=20
> Is -DSECURE_BOOT_ENABLE necessary for *building* with -DTPM2_ENABLE? If
> that's the case, we should update the DSC files; users building OVMF
> from source shouldn't have to care about "-D" inter-dependencies, if we
> can manage that somehow.
>=20
> If -DSECURE_BOOT_ENABLE is only there because otherwise a guest OS
> doesn't really make use of -DTPM2_ENABLE either, that's different. In
> that case, it's fine to allow building OVMF with TPM2 support but
> without SB support.

Oops, almost missed another important omission: in every commit message,
please insert the following line just above your S-o-b:

Contributed-under: TianoCore Contribution Agreement 1.1

We cannot take patches without that line. You can read about it in the
"Contributions.txt" file, in the project root directory.

Thanks!
Laszlo
