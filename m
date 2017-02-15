Received: from eggs.gnu.org ([2001:4830:134:3::10]:60112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ce57H-0006zw-39
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1ce57D-0002yE-NK
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:19:51 -0500
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:34227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1ce57D-0002xF-4i
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 14:19:47 -0500
Received: by mail-pg0-x22d.google.com with SMTP id z67so7249064pgb.1
	for <qemu-devel@nongnu.org>; Wed, 15 Feb 2017 11:19:47 -0800 (PST)
From: Ben Warren <ben@skyportsystems.com>
Message-Id: <D02204A1-30A7-40E0-9ED0-9C734AD8F0B1@skyportsystems.com>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_5FB6EFA2-5A4F-49C1-B004-C216229D7699";
	protocol="application/pkcs7-signature"; micalg=sha1
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Date: Wed, 15 Feb 2017 11:19:44 -0800
In-Reply-To: <670EAA2E-4A15-475E-99B2-8F3B80A33B7F@skyportsystems.com>
References: <cover.1487139038.git.ben@skyportsystems.com>
	<9dffe31a245cf6a717eef8227fe80ca666b168b5.1487139038.git.ben@skyportsystems.com>
	<20170215115723.77e4d9d7@nial.brq.redhat.com>
	<1f4a6eb2-0838-2218-88e3-4f65498a41d6@redhat.com>
	<20170215162225.74d48058@nial.brq.redhat.com>
	<20170215172515-mutt-send-email-mst@kernel.org>
	<20170215165602.72e96c28@nial.brq.redhat.com>
	<20170215183736-mutt-send-email-mst@kernel.org>
	<20170215184309.521aa90f@nial.brq.redhat.com>
	<20170215194647-mutt-send-email-mst@kernel.org>
	<20170215192436.2695b9f6@nial.brq.redhat.com>
	<670EAA2E-4A15-475E-99B2-8F3B80A33B7F@skyportsystems.com>
Subject: Re: [Qemu-devel] [PATCH v6 1/7] linker-loader: Add new 'write
 pointer' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org


--Apple-Mail=_5FB6EFA2-5A4F-49C1-B004-C216229D7699
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On Feb 15, 2017, at 11:14 AM, Ben Warren <ben@skyportsystems.com> =
wrote:
>=20
>>=20
>> On Feb 15, 2017, at 10:24 AM, Igor Mammedov <imammedo@redhat.com =
<mailto:imammedo@redhat.com>> wrote:
>>=20
>> On Wed, 15 Feb 2017 20:04:40 +0200
>> "Michael S. Tsirkin" <mst@redhat.com <mailto:mst@redhat.com>> wrote:
>>=20
>>> On Wed, Feb 15, 2017 at 06:43:09PM +0100, Igor Mammedov wrote:
>>>> On Wed, 15 Feb 2017 18:39:06 +0200
>>>> "Michael S. Tsirkin" <mst@redhat.com <mailto:mst@redhat.com>> =
wrote:
>>>>=20
>>>>> On Wed, Feb 15, 2017 at 04:56:02PM +0100, Igor Mammedov wrote: =20
>>>>>> On Wed, 15 Feb 2017 17:30:00 +0200
>>>>>> "Michael S. Tsirkin" <mst@redhat.com <mailto:mst@redhat.com>> =
wrote:
>>>>>>=20
>>>>>>> On Wed, Feb 15, 2017 at 04:22:25PM +0100, Igor Mammedov wrote:   =
=20
>>>>>>>> On Wed, 15 Feb 2017 15:13:20 +0100
>>>>>>>> Laszlo Ersek <lersek@redhat.com <mailto:lersek@redhat.com>> =
wrote:
>>>>>>>>=20
>>>>>>>>> Commenting under Igor's reply for simplicity
>>>>>>>>>=20
>>>>>>>>> On 02/15/17 11:57, Igor Mammedov wrote:     =20
>>>>>>>>>> On Tue, 14 Feb 2017 22:15:43 -0800
>>>>>>>>>> ben@skyportsystems.com <mailto:ben@skyportsystems.com> wrote:
>>>>>>>>>>=20
>>>>>>>>>>> From: Ben Warren <ben@skyportsystems.com =
<mailto:ben@skyportsystems.com>>
>>>>>>>>>>>=20
>>>>>>>>>>> This is similar to the existing 'add pointer' functionality, =
but instead
>>>>>>>>>>> of instructing the guest (BIOS or UEFI) to patch memory, it =
instructs
>>>>>>>>>>> the guest to write the pointer back to QEMU via a writeable =
fw_cfg file.
>>>>>>>>>>>=20
>>>>>>>>>>> Signed-off-by: Ben Warren <ben@skyportsystems.com =
<mailto:ben@skyportsystems.com>>
>>>>>>>>>>> ---
>>>>>>>>>>> hw/acpi/bios-linker-loader.c         | 58 =
++++++++++++++++++++++++++++++++++--
>>>>>>>>>>> include/hw/acpi/bios-linker-loader.h |  6 ++++
>>>>>>>>>>> 2 files changed, 61 insertions(+), 3 deletions(-)
>>>>>>>>>>>=20
>>>>>>>>>>> diff --git a/hw/acpi/bios-linker-loader.c =
b/hw/acpi/bios-linker-loader.c
>>>>>>>>>>> index d963ebe..5030cf1 100644
>>>>>>>>>>> --- a/hw/acpi/bios-linker-loader.c
>>>>>>>>>>> +++ b/hw/acpi/bios-linker-loader.c
>>>>>>>>>>> @@ -78,6 +78,19 @@ struct BiosLinkerLoaderEntry {
>>>>>>>>>>>             uint32_t length;
>>>>>>>>>>>         } cksum;
>>>>>>>>>>>=20
>>>>>>>>>>> +        /*
>>>>>>>>>>> +         * COMMAND_WRITE_POINTER - write the fw_cfg file =
(originating from
>>>>>>>>>>> +         * @dest_file) at @wr_pointer.offset, by adding a =
pointer to the table
>>>>>>>>>>> +         * originating from @src_file. 1,2,4 or 8 byte =
unsigned
>>>>>>>>>>> +         * addition is used depending on @wr_pointer.size.
>>>>>>>>>>> +         */       =20
>>>>>>>>>=20
>>>>>>>>> The words "adding" and "addition" are causing confusion here.
>>>>>>>>>=20
>>>>>>>>> In all of the previous discussion, *addition* was out of scope =
from
>>>>>>>>> WRITE_POINTER. Again, the firmware is specifically not =
required to
>>>>>>>>> *read* any part of the fw_cfg blob identified by "dest_file".
>>>>>>>>>=20
>>>>>>>>> WRITE_POINTER instructs the firmware to return the allocation =
address of
>>>>>>>>> the downloaded "src_file" to QEMU. Any necessary runtime =
subscripting
>>>>>>>>> within "src_file" is to be handled by QEMU code dynamically.
>>>>>>>>>=20
>>>>>>>>> For example, consider that "src_file" has *several* fields =
that QEMU
>>>>>>>>> wants to massage; in that case, indexing within QEMU code with =
field
>>>>>>>>> offsets is simply unavoidable.     =20
>>>>>>>> what I don't like here is that this indexing would be rather =
fragile
>>>>>>>> and has to be done in different parts of QEMU /device, AML/.
>>>>>>>>=20
>>>>>>>> I'd prefer this helper function to have the same @src_offset
>>>>>>>> behavior as ADD_POINTER where patched address could point to
>>>>>>>> any part of src_file i.e. not just beginning.     =20
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>        /*
>>>>>>>         * COMMAND_ADD_POINTER - patch the table (originating =
from
>>>>>>>         * @dest_file) at @pointer.offset, by adding a pointer to =
the table
>>>>>>>         * originating from @src_file. 1,2,4 or 8 byte unsigned
>>>>>>>         * addition is used depending on @pointer.size.
>>>>>>>         */
>>>>>>>=20
>>>>>>> so the way ADD works is
>>>>>>> 	read at offset
>>>>>>> 	add table address
>>>>>>> 	write result at offset
>>>>>>>=20
>>>>>>> in other words it is always beginning of table that is added.   =20=

>>>>>> more exactly it's, read at=20
>>>>>>  src_offset =3D *(dst_blob_ptr+dst_offset)
>>>>>>  *(dst_blob+dst_offset) =3D src_blob_ptr + src_offset
>>>>>>=20
>>>>>>> Would the following be acceptable?
>>>>>>>=20
>>>>>>>=20
>>>>>>>         * COMMAND_WRITE_POINTER - update the fw_cfg file =
(originating from
>>>>>>>         * @dest_file) at @wr_pointer.offset, by writing a =
pointer to the table
>>>>>>>         * originating from @src_file. 1,2,4 or 8 byte unsigned =
value
>>>>>>>         * is written depending on @wr_pointer.size.   =20
>>>>>> it looses 'adding' part of ADD_POINTER command which handles =
src_offset,
>>>>>> however implementing adding part looks a bit complicated
>>>>>> as patched blob (dst) is not in guest memory but in QEMU and
>>>>>> on reset *(dst_blob+dst_offset) should be reset to src_offset.
>>>>>> Considering dst file could be device specific memory =
(field/blob/whatever)
>>>>>> it could be hard to track/notice proper reset behavior.
>>>>>>=20
>>>>>> So now I'm not sure if src_offset is worth adding.   =20
>>>>>=20
>>>>> Right. Let's just do this math in QEMU if we have to. =20
>>>> Math complicates QEMU code though and not only QMEMU but AML code =
as well.
>>>> Considering that we are adding a new command and don't have to keep
>>>> any sort of compatibility we can pass src_offset as part
>>>> of command instead of hiding it inside of dst_file.
>>>> Something like this:
>>>>=20
>>>>        /*
>>>>         * COMMAND_WRITE_POINTER - write the fw_cfg file =
(originating from
>>>>         * @dest_file) at @wr_pointer.offset, by writing a pointer =
to @src_offset
>>>>         * within the table originating from @src_file. 1,2,4 or 8 =
byte unsigned
>>>>         * addition is used depending on @wr_pointer.size.
>>>>         */
>>>>        struct {
>>>>             char dest_file[BIOS_LINKER_LOADER_FILESZ];
>>>>             char src_file[BIOS_LINKER_LOADER_FILESZ];
>>>> -            uint32_t offset;
>>>> +            uint32_t dst_offset;
>>>> +            uint32_t src_offset;
>>>>             uint8_t size;
>>>>        } wr_pointer; =20
>>>=20
>>>=20
>>> As long as all users pass in 0 though there's a real possibility =
guests
>>> will implement this incorrectly.
>> We are here to ensure that at least Seabios (I'll review it)
>> and OVMF (Laszlo would take care of it I suppose) do it right,
>> and if there are other firmwares, they should do it correctly
>> as described fix their own bugs later wrt randomly written
>> implementation.
>>=20
>>> I guess we can put in the offset just
>>> behind the zero-filled padding we have there.
>> I've assumed padding was there to make commands fixed size and give
>> a room for future extensions so hunk changing BiosLinkerLoaderEntry
>> would look like:
>>=20
> I can=E2=80=99t say I follow the logic of these extra paddings.  The =
sizes of the structs are all over the place, so adding 4 bytes doesn=E2=80=
=99t do much.  I assume you have a good reason, though.
>=20
>> diff --git a/hw/acpi/bios-linker-loader.c =
b/hw/acpi/bios-linker-loader.c
>> index d963ebe..6983713 100644
>> --- a/hw/acpi/bios-linker-loader.c
>> +++ b/hw/acpi/bios-linker-loader.c
>> @@ -49,6 +49,7 @@ struct BiosLinkerLoaderEntry {
>>             char file[BIOS_LINKER_LOADER_FILESZ];
>>             uint32_t align;
>>             uint8_t zone;
>> +            uint32_t padding;
> I=E2=80=99m a little wary of doing this - in a packed structure this =
new field will be mis-aligned.
>>         } alloc;
>>=20
>>         /*
>> @@ -62,6 +63,7 @@ struct BiosLinkerLoaderEntry {
>>             char src_file[BIOS_LINKER_LOADER_FILESZ];
>>             uint32_t offset;
>>             uint8_t size;
>> +            uint32_t padding;
>>         } pointer;
>>=20
>>         /*
>> @@ -76,10 +78,25 @@ struct BiosLinkerLoaderEntry {
>>             uint32_t offset;
>>             uint32_t start;
>>             uint32_t length;
>> +            uint32_t padding;
>>         } cksum;
>>=20
>> +        /*
>> +         * COMMAND_WRITE_POINTER - write the fw_cfg file =
(originating from
>> +         * @dest_file) at @wr_pointer.offset, by writing a pointer =
to @src_offset
>> +         * within the table originating from @src_file. 1,2,4 or 8 =
byte unsigned
>> +         * addition is used depending on @wr_pointer.size.
>> +         */
>> +         struct {
>> +             char dest_file[BIOS_LINKER_LOADER_FILESZ];
>> +             char src_file[BIOS_LINKER_LOADER_FILESZ];
>> +             uint32_t dst_offset;
>> +             uint32_t src_offset;
>> +             uint8_t size;
>> +        } wr_pointer;
>> +
>>         /* padding */
>> -        char pad[124];
>> +        char pad[120];
> wr_pointer is 121 (56 + 56 + 32 + 32 + 1), so 124 still makes sense, =
doesn=E2=80=99t it? (also, 124 + 4 from command) % 8 =3D=3D 0, so it=E2=80=
=99s nicely aligned.
I mean (56 + 56 + 4 + 4 + 1), of course :)
>>     };
>> } QEMU_PACKED;
>> typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;
>>=20
>>=20
>>> I'm mostly concerned we are adding new features to something
>>> that has been through 25 revisions already.
>> It's ABI so it's worth extra effort,
>> it looks like only one more revision is left and there is
>> about a week left to post and merge it.
>>=20
>>>=20
>>>=20
>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>> (1) So, the above looks correct, but please replace "adding" =
with
>>>>>>>>> "storing", and "unsigned addition" with "store".
>>>>>>>>>=20
>>>>>>>>> Side point: the case for ADD_POINTER is different; there we =
patch
>>>>>>>>> several individual ACPI objects. The fact that I requested =
explicit
>>>>>>>>> addition within the ADDR method, as opposed to pre-setting =
VGIA to a
>>>>>>>>> nonzero offset, is an *incidental* limitation (coming from the =
OVMF ACPI
>>>>>>>>> SDT header probe suppressor), and we'll likely fix that up =
later, with
>>>>>>>>> ALLOCATE command hints or something like that. However, in
>>>>>>>>> WRITE_POINTER, asking for the exact allocation address of =
"src_file" is
>>>>>>>>> an *inherent* characteristic.
>>>>>>>>>=20
>>>>>>>>> For reference, this is the command's description from the (not =
as yet
>>>>>>>>> posted) OVMF series:
>>>>>>>>>=20
>>>>>>>>> // QemuLoaderCmdWritePointer: the bytes at
>>>>>>>>> // [PointerOffset..PointerOffset+PointerSize) in the writeable =
fw_cfg
>>>>>>>>> // file PointerFile are to receive the absolute address of =
PointeeFile,
>>>>>>>>> // as allocated and downloaded by the firmware. Store the base =
address
>>>>>>>>> // of where PointeeFile's contents have been placed (when
>>>>>>>>> // QemuLoaderCmdAllocate has been executed for PointeeFile) to =
this
>>>>>>>>> // portion of PointerFile.
>>>>>>>>> //
>>>>>>>>> // This command is similar to QemuLoaderCmdAddPointer; the =
difference is
>>>>>>>>> // that the "pointer to patch" does not exist in =
guest-physical address
>>>>>>>>> // space, only in "fw_cfg file space". In addition, the =
"pointer to
>>>>>>>>> // patch" is not initialized by QEMU with a possibly nonzero =
offset
>>>>>>>>> // value: the base address of the memory allocated for =
downloading
>>>>>>>>> // PointeeFile shall not increment the pointer, but overwrite =
it.
>>>>>>>>>=20
>>>>>>>>> In the last SeaBIOS patch series, namely
>>>>>>>>>=20
>>>>>>>>> [SeaBIOS] [PATCH v3 2/2] QEMU fw_cfg: Add command to write =
back address
>>>>>>>>>                         of file
>>>>>>>>>=20
>>>>>>>>> function romfile_loader_write_pointer() implemented just that =
plain
>>>>>>>>> store (not an addition), and that was exactly right.
>>>>>>>>>=20
>>>>>>>>> Continuing:
>>>>>>>>>=20
>>>>>>>>>>> +        struct {
>>>>>>>>>>> +            char dest_file[BIOS_LINKER_LOADER_FILESZ];
>>>>>>>>>>> +            char src_file[BIOS_LINKER_LOADER_FILESZ];
>>>>>>>>>>> +            uint32_t offset;
>>>>>>>>>>> +            uint8_t size;
>>>>>>>>>>> +        } wr_pointer;
>>>>>>>>>>> +
>>>>>>>>>>>         /* padding */
>>>>>>>>>>>         char pad[124];
>>>>>>>>>>>     };
>>>>>>>>>>> @@ -85,9 +98,10 @@ struct BiosLinkerLoaderEntry {
>>>>>>>>>>> typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;
>>>>>>>>>>>=20
>>>>>>>>>>> enum {
>>>>>>>>>>> -    BIOS_LINKER_LOADER_COMMAND_ALLOCATE     =3D 0x1,
>>>>>>>>>>> -    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER  =3D 0x2,
>>>>>>>>>>> -    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM =3D 0x3,
>>>>>>>>>>> +    BIOS_LINKER_LOADER_COMMAND_ALLOCATE          =3D 0x1,
>>>>>>>>>>> +    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER       =3D 0x2,
>>>>>>>>>>> +    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM      =3D 0x3,
>>>>>>>>>>> +    BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER     =3D 0x4,
>>>>>>>>>>> };
>>>>>>>>>>>=20
>>>>>>>>>>> enum {
>>>>>>>>>>> @@ -278,3 +292,41 @@ void =
bios_linker_loader_add_pointer(BIOSLinker *linker,
>>>>>>>>>>>=20
>>>>>>>>>>>     g_array_append_vals(linker->cmd_blob, &entry, sizeof =
entry);
>>>>>>>>>>> }
>>>>>>>>>>> +
>>>>>>>>>>> +/*
>>>>>>>>>>> + * bios_linker_loader_write_pointer: ask guest to write a =
pointer to the
>>>>>>>>>>> + * source file into the destination file, and write it back =
to QEMU via
>>>>>>>>>>> + * fw_cfg DMA.
>>>>>>>>>>> + *
>>>>>>>>>>> + * @linker: linker object instance
>>>>>>>>>>> + * @dest_file: destination file that must be written
>>>>>>>>>>> + * @dst_patched_offset: location within destination file =
blob to be patched
>>>>>>>>>>> + *                      with the pointer to @src_file, in =
bytes
>>>>>>>>>>> + * @dst_patched_offset_size: size of the pointer to be =
patched
>>>>>>>>>>> + *                      at @dst_patched_offset in =
@dest_file blob, in bytes
>>>>>>>>>>> + * @src_file: source file who's address must be taken
>>>>>>>>>>> + */
>>>>>>>>>>> +void bios_linker_loader_write_pointer(BIOSLinker *linker,
>>>>>>>>>>> +                                    const char *dest_file,
>>>>>>>>>>> +                                    uint32_t =
dst_patched_offset,
>>>>>>>>>>> +                                    uint8_t =
dst_patched_size,
>>>>>>>>>>> +                                    const char *src_file)   =
    =20
>>>>>>>>>> API is missing "src_offset" even though it's not used in this =
series,
>>>>>>>>>> a patch on top to fix it up is ok for me as far as =
Seabios/OVMF
>>>>>>>>>> counterpart can handle src_offset correctly from starters.    =
   =20
>>>>>>>>>=20
>>>>>>>>> According to the above, it is the right thing not to add =
"src_offset"
>>>>>>>>> here. The documentation on the command is slightly incorrect =
(and causes
>>>>>>>>> confusion), but the helper function's signature and comments =
are okay.
>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>>> +{
>>>>>>>>>>> +    BiosLinkerLoaderEntry entry;
>>>>>>>>>>> +    const BiosLinkerFileEntry *source_file =3D
>>>>>>>>>>> +        bios_linker_find_file(linker, src_file);
>>>>>>>>>>> +
>>>>>>>>>>> +    assert(source_file);       =20
>>>>>>>>>=20
>>>>>>>>> I wish we kept the following asserts from =
bios_linker_loader_add_pointer():
>>>>>>>>>=20
>>>>>>>>>    assert(dst_patched_offset < dst_file->blob->len);
>>>>>>>>>    assert(dst_patched_offset + dst_patched_size <=3D =
dst_file->blob->len);
>>>>>>>>>=20
>>>>>>>>> Namely, just because the dst_file is never supposed to be =
downloaded by
>>>>>>>>> the firmware, it still remains a requirement that the "dst =
file offset
>>>>>>>>> range" that is to be rewritten *do fall* within the dst file.
>>>>>>>>>=20
>>>>>>>>> Nonetheless, this is not critical. (OVMF at least verifies it =
anyway.)
>>>>>>>>>=20
>>>>>>>>> Summary (from my side anyway): I feel that the documentation =
of the new
>>>>>>>>> command is very important. Please fix it up as suggested under =
(1), in
>>>>>>>>> v7. Regarding the asserts, I'll let you decide.
>>>>>>>>>=20
>>>>>>>>> With the documentation fixed up:
>>>>>>>>>=20
>>>>>>>>> Reviewed-by: Laszlo Ersek <lersek@redhat.com =
<mailto:lersek@redhat.com>>
>>>>>>>>>=20
>>>>>>>>> (If you don't wish to post a v7, I'm also completely fine if =
Michael or
>>>>>>>>> someone else fixes up the docs as proposed in (1), before =
committing the
>>>>>>>>> patch.)
>>>>>>>>>=20
>>>>>>>>> Thanks!
>>>>>>>>> Laszlo
>>>>>>>>>=20
>>>>>>>>>>> +    memset(&entry, 0, sizeof entry);
>>>>>>>>>>> +    strncpy(entry.wr_pointer.dest_file, dest_file,
>>>>>>>>>>> +            sizeof entry.wr_pointer.dest_file - 1);
>>>>>>>>>>> +    strncpy(entry.wr_pointer.src_file, src_file,
>>>>>>>>>>> +            sizeof entry.wr_pointer.src_file - 1);
>>>>>>>>>>> +    entry.command =3D =
cpu_to_le32(BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER);
>>>>>>>>>>> +    entry.wr_pointer.offset =3D =
cpu_to_le32(dst_patched_offset);
>>>>>>>>>>> +    entry.wr_pointer.size =3D dst_patched_size;
>>>>>>>>>>> +    assert(dst_patched_size =3D=3D 1 || dst_patched_size =3D=3D=
 2 ||
>>>>>>>>>>> +           dst_patched_size =3D=3D 4 || dst_patched_size =3D=3D=
 8);
>>>>>>>>>>> +
>>>>>>>>>>> +    g_array_append_vals(linker->cmd_blob, &entry, sizeof =
entry);
>>>>>>>>>>> +}
>>>>>>>>>>> diff --git a/include/hw/acpi/bios-linker-loader.h =
b/include/hw/acpi/bios-linker-loader.h
>>>>>>>>>>> index fa1e5d1..f9ba5d6 100644
>>>>>>>>>>> --- a/include/hw/acpi/bios-linker-loader.h
>>>>>>>>>>> +++ b/include/hw/acpi/bios-linker-loader.h
>>>>>>>>>>> @@ -26,5 +26,11 @@ void =
bios_linker_loader_add_pointer(BIOSLinker *linker,
>>>>>>>>>>>                                     const char *src_file,
>>>>>>>>>>>                                     uint32_t src_offset);
>>>>>>>>>>>=20
>>>>>>>>>>> +void bios_linker_loader_write_pointer(BIOSLinker *linker,
>>>>>>>>>>> +                                      const char =
*dest_file,
>>>>>>>>>>> +                                      uint32_t =
dst_patched_offset,
>>>>>>>>>>> +                                      uint8_t =
dst_patched_size,
>>>>>>>>>>> +                                      const char =
*src_file);
>>>>>>>>>>> +
>>>>>>>>>>> void bios_linker_loader_cleanup(BIOSLinker *linker);
>>>>>>>>>>> #endif       =20


--Apple-Mail=_5FB6EFA2-5A4F-49C1-B004-C216229D7699
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJ+zCCBK8w
ggOXoAMCAQICEQDgI8sVEoNTia1hbnpUZ2shMA0GCSqGSIb3DQEBCwUAMG8xCzAJBgNVBAYTAlNF
MRQwEgYDVQQKEwtBZGRUcnVzdCBBQjEmMCQGA1UECxMdQWRkVHJ1c3QgRXh0ZXJuYWwgVFRQIE5l
dHdvcmsxIjAgBgNVBAMTGUFkZFRydXN0IEV4dGVybmFsIENBIFJvb3QwHhcNMTQxMjIyMDAwMDAw
WhcNMjAwNTMwMTA0ODM4WjCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hl
c3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/BgNV
BAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWls
IENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAibEN2npTGU5wUh28VqYGJre4SeCW
51Gr8fBaE0kVo7SMG2C8elFCp3mMpCLfF2FOkdV2IwoU00oCf7YdCYBupQQ92bq7Fv6hh6kuQ1JD
FnyvMlDIpk9a6QjYz5MlnHuI6DBk5qT4VoD9KiQUMxeZrETlaYujRgZLwjPU6UCfBrCxrJNAubUI
kzqcKlOjENs9IGE8VQOO2U52JQIhKfqjfHF2T+7hX4Hp+1SA28N7NVK3hN4iPSwwLTF/Wb1SN7Az
aS1D6/rWpfGXd2dRjNnuJ+u8pQc4doykqTj/34z1A6xJvsr3c5k6DzKrnJU6Ez0ORjpXdGFQvsZA
P8vk4p+iIQIDAQABo4IBFzCCARMwHwYDVR0jBBgwFoAUrb2YejS0Jvf6xCZU7wO94CTLVBowHQYD
VR0OBBYEFJJha4LhoqCqT+xn8cKj97SAAMHsMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAG
AQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDARBgNVHSAECjAIMAYGBFUdIAAw
RAYDVR0fBD0wOzA5oDegNYYzaHR0cDovL2NybC51c2VydHJ1c3QuY29tL0FkZFRydXN0RXh0ZXJu
YWxDQVJvb3QuY3JsMDUGCCsGAQUFBwEBBCkwJzAlBggrBgEFBQcwAYYZaHR0cDovL29jc3AudXNl
cnRydXN0LmNvbTANBgkqhkiG9w0BAQsFAAOCAQEAGypurFXBOquIxdjtzVXzqmthK8AJECOZD8Vm
am+x9bS1d14PAmEA330F/hKzpICAAPz7HVtqcgIKQbwFusFY1SbC6tVNhPv+gpjPWBvjImOcUvi7
BTarfVil3qs7Y+Xa1XPv7OD7e+Kj//BCI5zKto1NPuRLGAOyqC3U2LtCS5BphRDbpjc06HvgARCl
nMo6x59PiDRuimXQGoq7qdzKyjbR9PzCZCk1r9axp3ER0gNDsY8+muyeMlP0dpLKhjQHuSzK5hxK
2JkNwYbikJL7WkJqIyEQ6WXH9dW7fuqMhSACYurROgcsWcWZM/I4ieW26RZ6H3kU9koQGib6fIr7
mzCCBUQwggQsoAMCAQICEQCWOeMVlifzA+PvGfHjMeybMA0GCSqGSIb3DQEBCwUAMIGbMQswCQYD
VQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRow
GAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDFBMD8GA1UEAxM4Q09NT0RPIFNIQS0yNTYgQ2xpZW50
IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTYwNTE5MDAwMDAwWhcNMTcw
NTE5MjM1OTU5WjAnMSUwIwYJKoZIhvcNAQkBFhZiZW5Ac2t5cG9ydHN5c3RlbXMuY29tMIIBIjAN
BgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAryjnKj/3VRzbNXiWAp7RAZSzUCOzDG6WJ2ybuDWP
A7uDl48iX2v3ulbcZq8G0sL1nwGvBdSrmd5X3Qzirx0ti0Qe0mlAd22PEOL/xR5ChLDhNI6i43cM
R1qM1JNtuC5Dz8h2TfYbF/VuKkA1YVuXNguSP8Z1DQXptE1m3yS0gk9LLdDkqq7Vi/zfSmD1NYHN
gEGvtux/3lMp8pHgQiZo8PxKH2Y4zem0AiWtZ9fKZqYWRIhECJ+etvpGvh4dNIj8vdo/ig3uSwLv
ePX7rFz3C5WHOyKjl4VGHNOA5IRZjabp4bdAEIiMPU7lfWt0o4nCRtM/G/6FvFinR6PIHSma1wID
AQABo4IB9DCCAfAwHwYDVR0jBBgwFoAUkmFrguGioKpP7GfxwqP3tIAAwewwHQYDVR0OBBYEFJv6
uT+NCtbUQ0MHZLryEY65oKgbMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZ
MBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7
BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9D
UFMwXQYDVR0fBFYwVDBSoFCgToZMaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPU0hBMjU2
Q2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBkAYIKwYBBQUHAQEEgYMw
gYAwWAYIKwYBBQUHMAKGTGh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1NIQTI1NkNsaWVu
dEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9v
Y3NwLmNvbW9kb2NhLmNvbTAhBgNVHREEGjAYgRZiZW5Ac2t5cG9ydHN5c3RlbXMuY29tMA0GCSqG
SIb3DQEBCwUAA4IBAQAwVeCMNqTr20+cqsHnSK2AtzxKZyVG9y51wB88lPnRGHe2m+qKGdPgAh/7
iDzEEXsy4sDwHVHVq4kLHW9lX7CvRTxCtmOAtsty5ePhJjh3CX+nsK2HKpi043E6azad6L64DNVN
dMZFwUrUu8dYjOp48TPpIhW13Sbu2t/SOZK4G8EZAaZPX8Dg34tyHRUvM/B/eaJuUgdM5qY2IU+F
7U2K4hBHkhJMJgQ7TyVe8GhdBMaztY4GHqhWP5cCgZBdC9QII8E5jqX7//FbBRB0zVHRVeBZO32H
TvapSOG8ZYd0n5l5j3rBQnLfHWsnQ07rL2+w8W9BBPSZBbciPuwOe3ksMYIDxjCCA8ICAQEwgbEw
gZsxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1Nh
bGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1
NiBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z
8eMx7JswCQYFKw4DAhoFAKCCAekwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMTcwMjE1MTkxOTQ0WjAjBgkqhkiG9w0BCQQxFgQU/aTkI291wvHNauderPhVBUI7wvow
gcIGCSsGAQQBgjcQBDGBtDCBsTCBmzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFu
Y2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxQTA/
BgNVBAMTOENPTU9ETyBTSEEtMjU2IENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVt
YWlsIENBAhEAljnjFZYn8wPj7xnx4zHsmzCBxAYLKoZIhvcNAQkQAgsxgbSggbEwgZsxCzAJBgNV
BAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAY
BgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMUEwPwYDVQQDEzhDT01PRE8gU0hBLTI1NiBDbGllbnQg
QXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAJY54xWWJ/MD4+8Z8eMx7JswDQYJ
KoZIhvcNAQEBBQAEggEALiTeHWTw6S/3hwMCLCTnpGgnqCQgPT8/uXc7vI963jT8+VihfeNM5Nl3
Y1WYn/PKpIfBVN7txhr5g8x+azRv8bZhi0e6IAOjRzXce0m58gSGVbu60HqyS2E233MWo5dCKijr
8WSfnc0pblqJkxw/oIeFzt/im5K/EwI9YtEX/2xd29ym3l9nOcDlRnxJnoxzgF1SOLCmYREZzMYX
RriI7DgCJDkF+4b25jUTrVDQct5GY4/l8xeDShe3idrozJiCNsxLRMynP+DSBj13o5YaYAvp4QF+
5Qrs/+0kYs5NHQ/HmuyJwnPiKZK5ePU8QLS6EZ2J+Y/vdeuZJwjkVCfvdwAAAAAAAA==
--Apple-Mail=_5FB6EFA2-5A4F-49C1-B004-C216229D7699--
