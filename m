Received: from eggs.gnu.org ([2001:4830:134:3::10]:37913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cYdn7-0006s5-J4
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 14:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cYdn4-0000Qg-6X
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 14:08:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cYdn3-0000QX-W5
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 14:08:30 -0500
References: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
	<20170118175335-mutt-send-email-mst@kernel.org>
	<20170118181918.783cb7bd@nial.brq.redhat.com>
	<CAAibmn0OEBsZUyxuKcssk-4V-=fA94QWFCk04Lt9rbFN66OgEg@mail.gmail.com>
	<20170131165802-mutt-send-email-mst@kernel.org>
	<fe787fcc-0c92-5842-1a67-b50466b6f38f@redhat.com>
	<20170131201333-mutt-send-email-mst@kernel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b2c2b185-8443-2d0e-dbd4-f6759184d69c@redhat.com>
Date: Tue, 31 Jan 2017 20:08:25 +0100
MIME-Version: 1.0
In-Reply-To: <20170131201333-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

On 01/31/17 19:17, Michael S. Tsirkin wrote:
> On Tue, Jan 31, 2017 at 05:28:57PM +0100, Laszlo Ersek wrote:
>> The ACPI 6.1 spec says,
>>
>> - DSDT: [...] If the X_DSDT field contains a non-zero value then this
>>   field must be zero.
>> - X_DSDT: [...] If the DSDT field contains a non-zero value then this
>>   field must be zero.
> 
> But that's only 6.1. 6.0 and earlier did not say this.
> The errata they wanted to address was:
> 1393 In FADT: if X_DSDT field is non-zero, DSDT
> field should be ignored or deprecated
> 
> I would class this as a spec bug.
> 

Process-wise, that's not a bad idea; it could be the only way (or the
best way) to argue for a corresponding change in edk2's
EFI_ACPI_TABLE_PROTOCOL implementation
(MdeModulePkg/Universal/Acpi/AcpiTableDxe).

Do you want to raise this on the ASWG list? I vaguely recall that you
subscribed; if not, I think you should be able to, as a Red Hatter
<http://members.uefi.org/kmembership_info/person_signup/>.

(I'd like to avoid being the middle man.)

Hm... It seems that the "Adopter Membership" is free, which could be
appropriate for individual observers:

http://uefi.org/join
http://members.uefi.org/home/

(Should Phil consider it.)

Thanks
Laszlo
