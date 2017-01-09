Received: from eggs.gnu.org ([2001:4830:134:3::10]:34354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cQaJ1-0001dO-A5
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:48:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cQaIw-0004E1-Ba
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:48:11 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1483194856-14079-1-git-send-email-hpoussin@reactos.org>
	<8737gsl7o7.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4b140d8b-0745-6d7f-101f-25c3ca5f28c2@redhat.com>
Date: Mon, 9 Jan 2017 14:48:03 +0100
MIME-Version: 1.0
In-Reply-To: <8737gsl7o7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vl: disable default cdrom when using
 explicitely scsi-hd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>



On 09/01/2017 13:49, Markus Armbruster wrote:
> Hervé Poussineau <hpoussin@reactos.org> writes:
> 
>> 'ide-hd', 'ide-cd' and 'scsi-cd' devices already disable default cdrom.
>> Make it the same for 'scsi-hd'.
>>
>> That way, we can add/replace the device on lun=2 without using -nodefaults.
> 
> Yes, but it might upset existing usage that relies on the default
> CD-ROM.  In my opinion, making your needs explicit is better than
> relying on defaults, but that doesn't mean we can change the defaults
> unthinkingly.  Definitely not qemu-trivial.
> 
> Opinions on the change?

The original rationale for the change was "ide-hd has to suppress the
default CD-ROM, or else you can't put one on secondary master without
-nodefaults" but the same applies for scsi-hd vs. lun=1.

So I'm not sure, but I lean towards accepting the patch.

Paolo

>> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
>> ---
>>  vl.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/vl.c b/vl.c
>> index d77dd86..da97fe2 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -223,6 +223,7 @@ static struct {
>>      { .driver = "ide-hd",               .flag = &default_cdrom     },
>>      { .driver = "ide-drive",            .flag = &default_cdrom     },
>>      { .driver = "scsi-cd",              .flag = &default_cdrom     },
>> +    { .driver = "scsi-hd",              .flag = &default_cdrom     },
>>      { .driver = "virtio-serial-pci",    .flag = &default_virtcon   },
>>      { .driver = "virtio-serial",        .flag = &default_virtcon   },
>>      { .driver = "VGA",                  .flag = &default_vga       },
> 
> 
