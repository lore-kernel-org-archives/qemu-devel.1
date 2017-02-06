Received: from eggs.gnu.org ([2001:4830:134:3::10]:33441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1camPh-0008Ui-1r
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:45:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1camPg-0002bd-7f
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:45:13 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1camPg-0002bN-1Y
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 11:45:12 -0500
Received: by mail-oi0-x242.google.com with SMTP id u143so6867061oif.3
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 08:45:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b2c2b185-8443-2d0e-dbd4-f6759184d69c@redhat.com>
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
	<20170118181918.783cb7bd@nial.brq.redhat.com>
	<CAAibmn0OEBsZUyxuKcssk-4V-=fA94QWFCk04Lt9rbFN66OgEg@mail.gmail.com>
	<20170131165802-mutt-send-email-mst@kernel.org>
	<fe787fcc-0c92-5842-1a67-b50466b6f38f@redhat.com>
	<20170131201333-mutt-send-email-mst@kernel.org>
	<b2c2b185-8443-2d0e-dbd4-f6759184d69c@redhat.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 6 Feb 2017 17:44:50 +0100
Message-ID: <CAAibmn0-W_3gCfW=32b8q_3fsCX2HMANZ7FG3qM6yxPuZevq3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 31 January 2017 at 20:08, Laszlo Ersek <lersek@redhat.com> wrote:
> On 01/31/17 19:17, Michael S. Tsirkin wrote:
>> On Tue, Jan 31, 2017 at 05:28:57PM +0100, Laszlo Ersek wrote:
>>> The ACPI 6.1 spec says,
>>>
>>> - DSDT: [...] If the X_DSDT field contains a non-zero value then this
>>>   field must be zero.
>>> - X_DSDT: [...] If the DSDT field contains a non-zero value then this
>>>   field must be zero.
>>
>> But that's only 6.1. 6.0 and earlier did not say this.
>> The errata they wanted to address was:
>> 1393 In FADT: if X_DSDT field is non-zero, DSDT
>> field should be ignored or deprecated
>>
>> I would class this as a spec bug.
>>
>
> Process-wise, that's not a bad idea; it could be the only way (or the
> best way) to argue for a corresponding change in edk2's
> EFI_ACPI_TABLE_PROTOCOL implementation
> (MdeModulePkg/Universal/Acpi/AcpiTableDxe).
>
> Do you want to raise this on the ASWG list? I vaguely recall that you
> subscribed; if not, I think you should be able to, as a Red Hatter
> <http://members.uefi.org/kmembership_info/person_signup/>.
>
> (I'd like to avoid being the middle man.)
>
> Hm... It seems that the "Adopter Membership" is free, which could be
> appropriate for individual observers:
>
> http://uefi.org/join
> http://members.uefi.org/home/
>
> (Should Phil consider it.)

To be honest, I have no idea - does the revelation of 5.1b's
introduction of the mutual exclusivity, and the fact that you've
written up an edk2 patch change anything? If my signing up for
membership will help with resolving the problem, I'm happy to do it,
I'm just lacking the context to know if this is the case - please let
me know.

Thanks,
Phil
