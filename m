Received: from eggs.gnu.org ([2001:4830:134:3::10]:53558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edOSA-00066c-2f
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 17:51:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edOS5-0006CZ-7I
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 17:51:06 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:39740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edOS4-0006CJ-S9
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 17:51:01 -0500
Received: by mail-qt0-x241.google.com with SMTP id f4so16587223qtj.6
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 14:51:00 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
	<20180119141105.29095-5-marcandre.lureau@redhat.com>
	<f2ecf612-8538-f8d1-ffd8-f875aa453c42@amsat.org>
	<3c334ed0-3d9d-1ef5-27b7-aa587e5acd81@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <28fea7e2-ecc7-d68f-b6b0-22b9bec70b05@amsat.org>
Date: Sun, 21 Jan 2018 19:50:44 -0300
MIME-Version: 1.0
In-Reply-To: <3c334ed0-3d9d-1ef5-27b7-aa587e5acd81@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="aUkPHFRWysRl6vQGE6DVugbXfAuHwQYRB"
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tpm: add CRB device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Alistair Francis <alistai@xilinx.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aUkPHFRWysRl6vQGE6DVugbXfAuHwQYRB
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistai@xilinx.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <28fea7e2-ecc7-d68f-b6b0-22b9bec70b05@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] tpm: add CRB device
References: <20180119141105.29095-1-marcandre.lureau@redhat.com>
 <20180119141105.29095-5-marcandre.lureau@redhat.com>
 <f2ecf612-8538-f8d1-ffd8-f875aa453c42@amsat.org>
 <3c334ed0-3d9d-1ef5-27b7-aa587e5acd81@linux.vnet.ibm.com>
In-Reply-To: <3c334ed0-3d9d-1ef5-27b7-aa587e5acd81@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/21/2018 02:46 AM, Stefan Berger wrote:
> On 01/20/2018 07:54 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 01/19/2018 11:11 AM, Marc-Andr=C3=A9 Lureau wrote:
>>> tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB)
>>> Interface as defined in TCG PC Client Platform TPM Profile (PTP)
>>> Specification Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.03 v2=
2.
>>>
>>> The PTP allows device implementation to switch between TIS and CRB
>>> model at run time, but given that CRB is a simpler device to
>>> implement, I chose to implement it as a different device.
>>>
>>> The device doesn't implement other locality than 0 for now (my laptop=

>>> TPM doesn't either, so I assume this isn't so bad)
>>>
>>> The command/reply memory region is statically allocated after the CRB=

>>> registers address TPM_CRB_ADDR_BASE + sizeof(struct crb_regs) (I
>>> wonder if the BIOS could or should allocate it instead, or what size
>>> to use, again this seems to fit well expectations)
>>>
>>> The PTP doesn't specify a particular bus to put the device. So I adde=
d
>>> it on the system bus directly, so it could hopefully be used easily o=
n
>>> a different platform than x86. Currently, it fails to init on piix,
>>> because error_on_sysbus_device() check. The check may be changed in a=

>>> near future, see discussion on the qemu-devel ML.
>>>
>>> Tested with some success with Linux upstream and Windows 10, seabios =
&
>>> modified ovmf. The device is recognized and correctly transmit
>>> command/response with passthrough & emu. However, we are missing PPI
>>> ACPI part atm.
>>>
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>>> ---
>>> =C2=A0 qapi/tpm.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 5 +-
>>> =C2=A0 include/hw/acpi/tpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 72 ++++++++
>>> =C2=A0 include/sysemu/tpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
>>> =C2=A0 hw/i386/acpi-build.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 34 +++-
>>> =C2=A0 hw/tpm/tpm_crb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 327
>>> +++++++++++++++++++++++++++++++++++++
>>> =C2=A0 default-configs/i386-softmmu.mak=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +=

>>> =C2=A0 default-configs/x86_64-softmmu.mak |=C2=A0=C2=A0 1 +
>>> =C2=A0 hw/tpm/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0 8 files changed, 434 insertions(+), 10 deletions(-)
>>> =C2=A0 create mode 100644 hw/tpm/tpm_crb.c
>>>
>>> diff --git a/qapi/tpm.json b/qapi/tpm.json
>>> index 7093f268fb..d50deef5e9 100644
>>> --- a/qapi/tpm.json
>>> +++ b/qapi/tpm.json
>>> @@ -11,10 +11,11 @@
>>> =C2=A0 # An enumeration of TPM models
>>> =C2=A0 #
>>> =C2=A0 # @tpm-tis: TPM TIS model
>>> +# @tpm-crb: TPM CRB model (since 2.12)
>>> =C2=A0 #
>>> =C2=A0 # Since: 1.5
>>> =C2=A0 ##
>>> -{ 'enum': 'TpmModel', 'data': [ 'tpm-tis' ] }
>>> +{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb' ] }
>>> =C2=A0 =C2=A0 ##
>>> =C2=A0 # @query-tpm-models:
>>> @@ -28,7 +29,7 @@
>>> =C2=A0 # Example:
>>> =C2=A0 #
>>> =C2=A0 # -> { "execute": "query-tpm-models" }
>>> -# <- { "return": [ "tpm-tis" ] }
>>> +# <- { "return": [ "tpm-tis", "tpm-crb" ] }
>>> =C2=A0 #
>>> =C2=A0 ##
>>> =C2=A0 { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
>>> diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
>>> index 6d516c6a7f..b0048515fa 100644
>>> --- a/include/hw/acpi/tpm.h
>>> +++ b/include/hw/acpi/tpm.h
>>> @@ -16,11 +16,82 @@
>>> =C2=A0 #ifndef HW_ACPI_TPM_H
>>> =C2=A0 #define HW_ACPI_TPM_H
>>> =C2=A0 +#include "qemu/osdep.h"
>>> +
>>> =C2=A0 #define TPM_TIS_ADDR_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0xFED40000
>>> =C2=A0 #define TPM_TIS_ADDR_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 0x5000
>>> =C2=A0 =C2=A0 #define TPM_TIS_IRQ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5
>>> =C2=A0 +struct crb_regs {
>>> +=C2=A0=C2=A0=C2=A0 union {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t reg;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned tpm_established:1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned loc_assigned:1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned active_locality:3;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned reserved:2;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned tpm_reg_valid_sts:1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } bits;
>> I suppose this is little-endian layout, so this won't work on big-endi=
an
>> hosts.
>>
>> Can you add a qtest?
>>
>>> +=C2=A0=C2=A0=C2=A0 } loc_state;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t reserved1;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t loc_ctrl;
>>> +=C2=A0=C2=A0=C2=A0 union {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t reg;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned granted:1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned been_seized:1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } bits;
>>
>> This is unclear where you expect those bits (right/left aligned).
>>
>> Can you add an unnamed field to be more explicit?
>>
>> i.e. without using struct if left alignment expected:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uns=
igned granted:1, been_seized:1, :30;
>=20
>=20
> I got rid of all the bitfields and this patch here makes it work on a
> ppc64 big endian and also x86_64 host:
>=20
> https://github.com/stefanberger/qemu-tpm/commit/28fc07f0d9314168986190e=
ffd6d72d9fd3972dd

Thanks!

Looking at your tree, I recommend you to have a look at the
"hw/registerfields.h" API, you might find it simpler when it
comes to add bitfields #defines and checks, moreover when you
have specs available in a parsable form, since you can easily
script and auto-generate.

Alistair, thinking about it I'm not sure you already have a such
template available, but if you do we might add it in the
scripts/modules/ directory, then I can add doc and examples.

>=20
>=20
> Regards,
> =C2=A0=C2=A0=C2=A0 Stefan
>=20
>=20
>>
>>> +=C2=A0=C2=A0=C2=A0 } loc_sts;
>>> +=C2=A0=C2=A0=C2=A0 uint8_t reserved2[32];
>>> +=C2=A0=C2=A0=C2=A0 union {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t reg;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned type:4;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned version:4;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned cap_locality:1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned cap_crb_idle_bypass:1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned reserved1:1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned cap_data_xfer_size_support:2;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned cap_fifo:1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned cap_crb:1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned cap_if_res:2;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned if_selector:2;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned if_selector_lock:1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned reserved2:4;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned rid:8;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned vid:16;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned did:16;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } bits;
>>> +=C2=A0=C2=A0=C2=A0 } intf_id;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t ctrl_ext;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 uint32_t ctrl_req;
>>> +=C2=A0=C2=A0=C2=A0 union {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t reg;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned tpm_sts:1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned tpm_idle:1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u=
nsigned reserved:30;
>> Oh here you use 'reserved' to left align.
>>
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } bits;
>>> +=C2=A0=C2=A0=C2=A0 } ctrl_sts;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t ctrl_cancel;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t ctrl_start;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t ctrl_int_enable;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t ctrl_int_sts;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t ctrl_cmd_size;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t ctrl_cmd_pa_low;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t ctrl_cmd_pa_high;
>>> +=C2=A0=C2=A0=C2=A0 uint32_t ctrl_rsp_size;
>>> +=C2=A0=C2=A0=C2=A0 uint64_t ctrl_rsp_pa;
>>> +=C2=A0=C2=A0=C2=A0 uint8_t reserved3[0x10];
>>> +} QEMU_PACKED;
>>> +
>>> +#define TPM_CRB_ADDR_BASE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0xFED40000
>>> +#define TPM_CRB_ADDR_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 0x1000
>>> +#define TPM_CRB_ADDR_CTRL \
>>> +=C2=A0=C2=A0=C2=A0 (TPM_CRB_ADDR_BASE + offsetof(struct crb_regs, ct=
rl_req))
>>> +
>>> =C2=A0 #define TPM_LOG_AREA_MINIMUM_SIZE=C2=A0=C2=A0 (64 * 1024)
>>> =C2=A0 =C2=A0 #define TPM_TCPA_ACPI_CLASS_CLIENT=C2=A0 0
>>> @@ -30,5 +101,6 @@
>>> =C2=A0 #define TPM2_ACPI_CLASS_SERVER=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=

>>> =C2=A0 =C2=A0 #define TPM2_START_METHOD_MMIO=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 6
>>> +#define TPM2_START_METHOD_CRB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 7
>>> =C2=A0 =C2=A0 #endif /* HW_ACPI_TPM_H */
>>> diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
>>> index ac04a9d4a2..233b1a3fc3 100644
>>> --- a/include/sysemu/tpm.h
>>> +++ b/include/sysemu/tpm.h
>>> @@ -46,9 +46,12 @@ typedef struct TPMIfClass {
>>> =C2=A0 } TPMIfClass;
>>> =C2=A0 =C2=A0 #define TYPE_TPM_TIS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm-tis"
>>> +#define TYPE_TPM_CRB=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm-crb"
>>> =C2=A0 =C2=A0 #define TPM_IS_TIS(chr)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_dynamic_cast(OBJECT(chr), TYPE_=
TPM_TIS)
>>> +#define TPM_IS_CRB(chr)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0 object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
>>> =C2=A0 =C2=A0 /* returns NULL unless there is exactly one TPM device =
*/
>>> =C2=A0 static inline TPMIf *tpm_find(void)
>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>>> index dc4b2b9ffe..ed78c4ed9f 100644
>>> --- a/hw/i386/acpi-build.c
>>> +++ b/hw/i386/acpi-build.c
>>> @@ -2224,6 +2224,22 @@ build_dsdt(GArray *table_data, BIOSLinker
>>> *linker,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 aml_append(sb_scope, scope);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (TPM_IS_CRB(tpm_find())) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D aml_device("TPM")=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_=
decl("_HID", aml_string("MSFT0101")));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 crs =3D aml_resource_temp=
late();
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(crs, aml_memor=
y32_fixed(TPM_CRB_ADDR_BASE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPM_CRB_ADDR_SIZE,
>>> AML_READ_WRITE));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, aml_name_=
decl("_CRS", crs));
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 method =3D aml_method("_S=
TA", 0, AML_NOTSERIALIZED);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(method, aml_re=
turn(aml_int(0x0f)));
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dev, method);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(sb_scope, dev)=
;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aml_append(dsdt, sb_scope);
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* copy AML table into ACPI tab=
les blob and patch header
>>> there */
>>> @@ -2285,18 +2301,20 @@ build_tpm2(GArray *table_data, BIOSLinker
>>> *linker, GArray *tcpalog)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (TPM_IS_TIS(tpm_find())) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm2_ptr->cont=
rol_area_address =3D cpu_to_le64(0);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm2_ptr->star=
t_method =3D cpu_to_le32(TPM2_START_METHOD_MMIO);
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm2_ptr->log_area_minimu=
m_length =3D
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
pu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
>>> -
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* log area start address=
 to be filled by Guest linker */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bios_linker_loader_add_po=
inter(linker,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A=
CPI_BUILD_TABLE_FILE, log_addr_offset, log_addr_size,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A=
CPI_BUILD_TPMLOG_FILE, 0);
>>> +=C2=A0=C2=A0=C2=A0 } else if (TPM_IS_CRB(tpm_find())) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm2_ptr->control_area_ad=
dress =3D
>>> cpu_to_le64(TPM_CRB_ADDR_CTRL);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm2_ptr->start_method =3D=
 cpu_to_le32(TPM2_START_METHOD_CRB);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_warn_if_reac=
hed();
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 tpm2_ptr->log_area_minimum_length =3D
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu_to_le32(TPM_LOG_AREA_=
MINIMUM_SIZE);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* log area start address to be filled by Guest l=
inker */
>>> +=C2=A0=C2=A0=C2=A0 bios_linker_loader_add_pointer(linker, ACPI_BUILD=
_TABLE_FILE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 log_addr_off=
set, log_addr_size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ACPI_BUILD_T=
PMLOG_FILE, 0);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 build_header(linker, table_data,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void *)tpm2_ptr, "TPM2", sizeof(=
*tpm2_ptr), 4,
>>> NULL, NULL);
>>> =C2=A0 }
>>> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
>>> new file mode 100644
>>> index 0000000000..908ca18d92
>>> --- /dev/null
>>> +++ b/hw/tpm/tpm_crb.c
>>> @@ -0,0 +1,327 @@
>>> +/*
>>> + * tpm_crb.c - QEMU's TPM CRB interface emulator
>>> + *
>>> + * Copyright (c) 2017 Red Hat, Inc.
>>> + *
>>> + * Authors:
>>> + *=C2=A0=C2=A0 Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2
>>> or later.
>>> + * See the COPYING file in the top-level directory.
>>> + *
>>> + * tpm_crb is a device for TPM 2.0 Command Response Buffer (CRB)
>>> Interface
>>> + * as defined in TCG PC Client Platform TPM Profile (PTP) Specificat=
ion
>>> + * Family =E2=80=9C2.0=E2=80=9D Level 00 Revision 01.03 v22
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +
>>> +#include "qemu-common.h"
>>> +#include "qapi/error.h"
>>> +#include "hw/sysbus.h"
>>> +#include "exec/address-spaces.h"
>>> +
>>> +#include "hw/pci/pci_ids.h"
>>> +#include "hw/acpi/tpm.h"
>>> +#include "sysemu/tpm_backend.h"
>>> +#include "tpm_int.h"
>>> +#include "tpm_util.h"
>>> +
>>> +typedef struct CRBState {
>>> +=C2=A0=C2=A0=C2=A0 SysBusDevice parent_obj;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 TPMBackend *tpmbe;
>>> +=C2=A0=C2=A0=C2=A0 TPMBackendCmd cmd;
>>> +=C2=A0=C2=A0=C2=A0 struct crb_regs regs;
>>> +=C2=A0=C2=A0=C2=A0 MemoryRegion mmio;
>>> +=C2=A0=C2=A0=C2=A0 MemoryRegion cmdmem;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 size_t be_buffer_size;
>>> +} CRBState;
>>> +
>>> +#define CRB(obj) OBJECT_CHECK(CRBState, (obj), TYPE_TPM_CRB)
>>> +
>>> +#define DEBUG_CRB 0
>>> +
>>> +#define DPRINTF(fmt, ...) do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (DEBUG_CRB) {=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p=
rintf(fmt, ## __VA_ARGS__);=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0 } while (0)
>>> +
>>> +#define CRB_ADDR_LOC_STATE offsetof(struct crb_regs, loc_state)
>>> +#define CRB_ADDR_LOC_CTRL offsetof(struct crb_regs, loc_ctrl)
>>> +#define CRB_ADDR_CTRL_REQ offsetof(struct crb_regs, ctrl_req)
>>> +#define CRB_ADDR_CTRL_CANCEL offsetof(struct crb_regs, ctrl_cancel)
>>> +#define CRB_ADDR_CTRL_START offsetof(struct crb_regs, ctrl_start)
>>> +
>>> +#define CRB_INTF_TYPE_CRB_ACTIVE 0b1
>>> +#define CRB_INTF_VERSION_CRB 0b1
>>> +#define CRB_INTF_CAP_LOCALITY_0_ONLY 0b0
>>> +#define CRB_INTF_CAP_IDLE_FAST 0b0
>>> +#define CRB_INTF_CAP_XFER_SIZE_64 0b11
>>> +#define CRB_INTF_CAP_FIFO_NOT_SUPPORTED 0b0
>>> +#define CRB_INTF_CAP_CRB_SUPPORTED 0b1
>>> +#define CRB_INTF_IF_SELECTOR_CRB 0b1
>>> +#define CRB_INTF_IF_SELECTOR_UNLOCKED 0b0
>>> +
>>> +#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - sizeof(struct crb_reg=
s))
>>> +
>>> +enum crb_loc_ctrl {
>>> +=C2=A0=C2=A0=C2=A0 CRB_LOC_CTRL_REQUEST_ACCESS =3D BIT(0),
>>> +=C2=A0=C2=A0=C2=A0 CRB_LOC_CTRL_RELINQUISH =3D BIT(1),
>>> +=C2=A0=C2=A0=C2=A0 CRB_LOC_CTRL_SEIZE =3D BIT(2),
>>> +=C2=A0=C2=A0=C2=A0 CRB_LOC_CTRL_RESET_ESTABLISHMENT_BIT =3D BIT(3),
>>> +};
>>> +
>>> +enum crb_ctrl_req {
>>> +=C2=A0=C2=A0=C2=A0 CRB_CTRL_REQ_CMD_READY =3D BIT(0),
>>> +=C2=A0=C2=A0=C2=A0 CRB_CTRL_REQ_GO_IDLE =3D BIT(1),
>>> +};
>>> +
>>> +enum crb_start {
>>> +=C2=A0=C2=A0=C2=A0 CRB_START_INVOKE =3D BIT(0),
>>> +};
>>> +
>>> +enum crb_cancel {
>>> +=C2=A0=C2=A0=C2=A0 CRB_CANCEL_INVOKE =3D BIT(0),
>>> +};
>>> +
>>> +static const char *addr_desc(unsigned off)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct crb_regs crb;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 switch (off) {
>>> +#define CASE(field)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0 case offsetof(struct crb_regs, field) ...=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offsetof(struct crb_regs,=
 field) + sizeof(crb.field) - 1:=C2=A0=C2=A0 \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return G_STRINGIFY(field)=
;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(loc_state);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(reserved1);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(loc_ctrl);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(loc_sts);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(reserved2);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(intf_id);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(ctrl_ext);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(ctrl_req);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(ctrl_sts);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(ctrl_cancel);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(ctrl_start);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(ctrl_int_enable);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(ctrl_int_sts);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(ctrl_cmd_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(ctrl_cmd_pa_low);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(ctrl_cmd_pa_high);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(ctrl_rsp_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CASE(ctrl_rsp_pa);
>>> +#undef CASE
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 return NULL;
>>> +}
>>> +
>>> +static uint64_t tpm_crb_mmio_read(void *opaque, hwaddr addr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 CRBState *s =3D CRB(opaque);
>>> +=C2=A0=C2=A0=C2=A0 DPRINTF("CRB read 0x%lx:%s len:%u\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
ddr, addr_desc(addr), size);
>>> +=C2=A0=C2=A0=C2=A0 void *regs =3D (void *)&s->regs + addr;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 switch (size) {
>>> +=C2=A0=C2=A0=C2=A0 case 1:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return *(uint8_t *)regs;
>>> +=C2=A0=C2=A0=C2=A0 case 2:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return *(uint16_t *)regs;=

>>> +=C2=A0=C2=A0=C2=A0 case 4:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return *(uint32_t *)regs;=

>>> +=C2=A0=C2=A0=C2=A0 default:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_return_val_if_reached(-=
1);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t val, unsigned size)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 CRBState *s =3D CRB(opaque);
>>> +=C2=A0=C2=A0=C2=A0 DPRINTF("CRB write 0x%lx:%s len:%u val:%lu\n",
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a=
ddr, addr_desc(addr), size, val);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 switch (addr) {
>>> +=C2=A0=C2=A0=C2=A0 case CRB_ADDR_CTRL_REQ:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (val) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CRB_CTRL_REQ_CMD_REA=
DY:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
->regs.ctrl_sts.bits.tpm_idle =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CRB_CTRL_REQ_GO_IDLE=
:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
->regs.ctrl_sts.bits.tpm_idle =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case CRB_ADDR_CTRL_CANCEL:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val =3D=3D CRB_CANCEL=
_INVOKE && s->regs.ctrl_start &
>>> CRB_START_INVOKE) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
pm_backend_cancel_cmd(s->tpmbe);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case CRB_ADDR_CTRL_START:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val =3D=3D CRB_START_=
INVOKE &&
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !=
(s->regs.ctrl_start & CRB_START_INVOKE)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=
oid *mem =3D memory_region_get_ram_ptr(&s->cmdmem);
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
->regs.ctrl_start |=3D CRB_START_INVOKE;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
->cmd =3D (TPMBackendCmd) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .in =3D mem,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .in_len =3D MIN(tpm_cmd_get_size(mem),
>>> s->be_buffer_size),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .out =3D mem,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .out_len =3D s->be_buffer_size,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }=
;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 t=
pm_backend_deliver_request(s->tpmbe, &s->cmd);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 case CRB_ADDR_LOC_CTRL:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (val) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CRB_LOC_CTRL_RESET_E=
STABLISHMENT_BIT:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /=
* not loc 3 or 4 */
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CRB_LOC_CTRL_RELINQU=
ISH:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case CRB_LOC_CTRL_REQUEST=
_ACCESS:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
->regs.loc_sts.bits.granted =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
->regs.loc_sts.bits.been_seized =3D 0;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
->regs.loc_state.bits.loc_assigned =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
->regs.loc_state.bits.tpm_reg_valid_sts =3D 1;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +static const MemoryRegionOps tpm_crb_memory_ops =3D {
>>> +=C2=A0=C2=A0=C2=A0 .read =3D tpm_crb_mmio_read,
>>> +=C2=A0=C2=A0=C2=A0 .write =3D tpm_crb_mmio_write,
>>> +=C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
>>> +=C2=A0=C2=A0=C2=A0 .valid =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .min_access_size =3D 1,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .max_access_size =3D 4,
>>> +=C2=A0=C2=A0=C2=A0 },
>>> +};
>>> +
>>> +static void tpm_crb_reset(DeviceState *dev)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 CRBState *s =3D CRB(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 tpm_backend_reset(s->tpmbe);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 s->be_buffer_size =3D MIN(tpm_backend_get_buffer_=
size(s->tpmbe),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 CRB_CTRL_CMD_SIZE);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 s->regs =3D (struct crb_regs) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .intf_id.bits =3D {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
type =3D CRB_INTF_TYPE_CRB_ACTIVE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
version =3D CRB_INTF_VERSION_CRB,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
cap_locality =3D CRB_INTF_CAP_LOCALITY_0_ONLY,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
cap_crb_idle_bypass =3D CRB_INTF_CAP_IDLE_FAST,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
cap_data_xfer_size_support =3D CRB_INTF_CAP_XFER_SIZE_64,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
cap_fifo =3D CRB_INTF_CAP_FIFO_NOT_SUPPORTED,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
cap_crb =3D CRB_INTF_CAP_CRB_SUPPORTED,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
cap_if_res =3D 0b0,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
if_selector =3D CRB_INTF_IF_SELECTOR_CRB,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
if_selector_lock =3D CRB_INTF_IF_SELECTOR_UNLOCKED,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
rid =3D 0b0001,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
vid =3D PCI_VENDOR_ID_IBM,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .=
did =3D 0b0001,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ctrl_cmd_size =3D CRB_CT=
RL_CMD_SIZE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ctrl_cmd_pa_low =3D TPM_=
CRB_ADDR_BASE + sizeof(struct crb_regs),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ctrl_rsp_size =3D CRB_CT=
RL_CMD_SIZE,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .ctrl_rsp_pa =3D TPM_CRB_=
ADDR_BASE + sizeof(struct crb_regs),
>>> +=C2=A0=C2=A0=C2=A0 };
>>> +
>>> +=C2=A0=C2=A0=C2=A0 tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_si=
ze);
>>> +}
>>> +
>>> +static void tpm_crb_request_completed(TPMIf *ti, int ret)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 CRBState *s =3D CRB(ti);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 s->regs.ctrl_start &=3D ~CRB_START_INVOKE;
>>> +=C2=A0=C2=A0=C2=A0 if (ret !=3D 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->regs.ctrl_sts.bits.tpm=
_sts =3D 1; /* fatal error */
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +}
>>> +
>>> +static enum TPMVersion tpm_crb_get_version(TPMIf *ti)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 CRBState *s =3D CRB(ti);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return tpm_backend_get_tpm_version(s->tpmbe);
>>> +}
>>> +
>>> +static const VMStateDescription vmstate_tpm_crb =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D "tpm-crb",
>>> +=C2=A0=C2=A0=C2=A0 .unmigratable =3D 1,
>>> +};
>>> +
>>> +static Property tpm_crb_properties[] =3D {
>>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
>>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_END_OF_LIST(),
>>> +};
>>> +
>>> +static void tpm_crb_realizefn(DeviceState *dev, Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 CRBState *s =3D CRB(dev);
>>> +=C2=A0=C2=A0=C2=A0 SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (!tpm_find()) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "at most=
 one TPM device is permitted");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (!s->tpmbe) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "'tpmdev=
' property is required");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->mmio, OBJECT(s), &tpm_c=
rb_memory_ops, s,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm-crb-mmio", sizeof(st=
ruct crb_regs));
>>> +=C2=A0=C2=A0=C2=A0 memory_region_init_ram(&s->cmdmem, OBJECT(s),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm-crb-cmd", CRB_CTRL_C=
MD_SIZE, errp);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 sysbus_init_mmio(sbd, &s->mmio);
>>> +=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(sbd, 0, TPM_CRB_ADDR_BASE);
>>> +=C2=A0=C2=A0=C2=A0 /* allocate ram in bios instead? */
>>> +=C2=A0=C2=A0=C2=A0 memory_region_add_subregion(get_system_memory(),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TPM_CRB_ADDR_BASE + sizeo=
f(struct crb_regs), &s->cmdmem);
>>> +}
>>> +
>>> +static void tpm_crb_class_init(ObjectClass *klass, void *data)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DeviceClass *dc =3D DEVICE_CLASS(klass);
>>> +=C2=A0=C2=A0=C2=A0 TPMIfClass *tc =3D TPM_IF_CLASS(klass);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dc->realize =3D tpm_crb_realizefn;
>>> +=C2=A0=C2=A0=C2=A0 dc->props =3D tpm_crb_properties;
>>> +=C2=A0=C2=A0=C2=A0 dc->reset =3D tpm_crb_reset;
>>> +=C2=A0=C2=A0=C2=A0 dc->vmsd=C2=A0 =3D &vmstate_tpm_crb;
>>> +=C2=A0=C2=A0=C2=A0 dc->user_creatable =3D true;
>>> +=C2=A0=C2=A0=C2=A0 tc->model =3D TPM_MODEL_TPM_CRB;
>>> +=C2=A0=C2=A0=C2=A0 tc->get_version =3D tpm_crb_get_version;
>>> +=C2=A0=C2=A0=C2=A0 tc->request_completed =3D tpm_crb_request_complet=
ed;
>>> +}
>>> +
>>> +static const TypeInfo tpm_crb_info =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D TYPE_TPM_CRB,
>>> +=C2=A0=C2=A0=C2=A0 .parent =3D TYPE_SYS_BUS_DEVICE,
>>> +=C2=A0=C2=A0=C2=A0 .instance_size =3D sizeof(CRBState),
>>> +=C2=A0=C2=A0=C2=A0 .class_init=C2=A0 =3D tpm_crb_class_init,
>>> +=C2=A0=C2=A0=C2=A0 .interfaces =3D (InterfaceInfo[]) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { TYPE_TPM_IF },
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { }
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +};
>>> +
>>> +static void tpm_crb_register(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 type_register_static(&tpm_crb_info);
>>> +}
>>> +
>>> +type_init(tpm_crb_register)
>>> diff --git a/default-configs/i386-softmmu.mak
>>> b/default-configs/i386-softmmu.mak
>>> index 95ac4b464a..ac27700e79 100644
>>> --- a/default-configs/i386-softmmu.mak
>>> +++ b/default-configs/i386-softmmu.mak
>>> @@ -37,6 +37,7 @@ CONFIG_APPLESMC=3Dy
>>> =C2=A0 CONFIG_I8259=3Dy
>>> =C2=A0 CONFIG_PFLASH_CFI01=3Dy
>>> =C2=A0 CONFIG_TPM_TIS=3D$(CONFIG_TPM)
>>> +CONFIG_TPM_CRB=3D$(CONFIG_TPM)
>>> =C2=A0 CONFIG_MC146818RTC=3Dy
>>> =C2=A0 CONFIG_PCI_PIIX=3Dy
>>> =C2=A0 CONFIG_WDT_IB700=3Dy
>>> diff --git a/default-configs/x86_64-softmmu.mak
>>> b/default-configs/x86_64-softmmu.mak
>>> index 0221236825..b2104ade19 100644
>>> --- a/default-configs/x86_64-softmmu.mak
>>> +++ b/default-configs/x86_64-softmmu.mak
>>> @@ -37,6 +37,7 @@ CONFIG_APPLESMC=3Dy
>>> =C2=A0 CONFIG_I8259=3Dy
>>> =C2=A0 CONFIG_PFLASH_CFI01=3Dy
>>> =C2=A0 CONFIG_TPM_TIS=3D$(CONFIG_TPM)
>>> +CONFIG_TPM_CRB=3D$(CONFIG_TPM)
>>> =C2=A0 CONFIG_MC146818RTC=3Dy
>>> =C2=A0 CONFIG_PCI_PIIX=3Dy
>>> =C2=A0 CONFIG_WDT_IB700=3Dy
>>> diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
>>> index 7a93b24636..1dc9f8bf2c 100644
>>> --- a/hw/tpm/Makefile.objs
>>> +++ b/hw/tpm/Makefile.objs
>>> @@ -1,4 +1,5 @@
>>> =C2=A0 common-obj-y +=3D tpm_util.o
>>> =C2=A0 common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
>>> +common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
>>> =C2=A0 common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
>>> =C2=A0 common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o
>>>
>=20


--aUkPHFRWysRl6vQGE6DVugbXfAuHwQYRB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlplGUkACgkQ4+MsLN6t
wN4eyA/9Ex79tcNHKvi2XvV9OpS2m8PmpqSRkQUJRsJ9j9nAbRdMQtPzRGJdbLcB
eGgq0/7ZteN1cyxAKSysIamcQpmMXckwU8ofOG3B5a0pAtKElnk6O37T5BtvvfIj
XK0zcDnR0kObileAtYEZOOyoG+CK7GXjDnwVmUtBQRwMt+3aGhZhxOdP8tqEPNbX
1eoTJLtf1w8xcvxkavQd2jP1lQP+1l/R5CKs+Y2S4ecjWICtLvwhg6Tr1rYTcWQM
/fr9iPRyjdgBSsgHmW830g3vIXRru8dK4IF+7+S0LsShSVeFiwKRRbiC1M3aaQGF
uCavpWOPagIOoMDI0DXFb8irKrmb4jBIYCheRUDDybkiReuCjBuQeukw2orWCo3x
sz3dO2Yp77PFTKxdm2vJvvTRkyKeMqyztp8fULq8hqv8kFwFZtkLCJHbZjp5l4Nr
ye/ntG5lwDuHNMlEOJwaDz85Ts8fFkIUQZLoTcyRQIhpp8OtFTgd7Sb/cQiKftBs
Dwe78ZwuHb/JwOuVPeFl3iSEcEA79d1o+5FOcPE0P8Dx2hwWDJT2Bq+I5lFg+Upg
DNh3qIAyZ50swLxCjpmxQNZJJUzBAB5ygWLrPNacj7fLqjnn4TF0UOwxfHDz7ceH
ZOWQB/1LSO7w+F2qvL/shGwAddlj9D359JlurY/SwxeWMeQ/pjk=
=Pt9M
-----END PGP SIGNATURE-----

--aUkPHFRWysRl6vQGE6DVugbXfAuHwQYRB--
