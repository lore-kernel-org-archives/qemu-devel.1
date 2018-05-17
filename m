Received: from eggs.gnu.org ([2001:4830:134:3::10]:35227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fJK9J-0007g6-Tj
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fJK9F-00064H-2l
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:44:57 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fJK9E-000647-Tc
	for qemu-devel@nongnu.org; Thu, 17 May 2018 10:44:52 -0400
Received: by mail-it0-f68.google.com with SMTP id 144-v6so9063461iti.5
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 07:44:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa1fac3a-6662-6516-5d65-827b9d36d6b0@redhat.com>
References: <20180515123007.10164-1-marcandre.lureau@redhat.com>
	<fa1fac3a-6662-6516-5d65-827b9d36d6b0@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 17 May 2018 16:44:51 +0200
Message-ID: <CAMxuvax6O55+mcJFb83B6iEzCyxHU0GhEz=dC_HWtFmEMAC0pQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: edk2-devel@lists.01.org, qemu-devel <qemu-devel@nongnu.org>, javierm@redhat.com, pjones@redhat.com, jiewen.yao@intel.com

Hi

On Thu, May 17, 2018 at 9:54 AM, Laszlo Ersek <lersek@redhat.com> wrote:
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
>
> Is -DSECURE_BOOT_ENABLE necessary for *building* with -DTPM2_ENABLE? If
> that's the case, we should update the DSC files; users building OVMF
> from source shouldn't have to care about "-D" inter-dependencies, if we
> can manage that somehow.

No, that's only my build setup, because it is likely both will be used
together. TPM usage/tests seem to be fine without it.

>
> If -DSECURE_BOOT_ENABLE is only there because otherwise a guest OS
> doesn't really make use of -DTPM2_ENABLE either, that's different. In
> that case, it's fine to allow building OVMF with TPM2 support but
> without SB support.
>
> Thanks!
> Laszlo
