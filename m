Received: from eggs.gnu.org ([2001:4830:134:3::10]:53711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceJxc-00047Q-FJ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:10:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceJxZ-0000f7-87
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:10:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ceJxY-0000f1-Uo
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 06:10:49 -0500
Date: Thu, 16 Feb 2017 12:10:45 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170216121045.6ae68c19@nial.brq.redhat.com>
In-Reply-To: <D02204A1-30A7-40E0-9ED0-9C734AD8F0B1@skyportsystems.com>
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
	<D02204A1-30A7-40E0-9ED0-9C734AD8F0B1@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Ben Warren <ben@skyportsystems.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

On Wed, 15 Feb 2017 11:19:44 -0800
Ben Warren <ben@skyportsystems.com> wrote:

> > On Feb 15, 2017, at 11:14 AM, Ben Warren <ben@skyportsystems.com> wrote:
> >  =20
> >>=20
> >> On Feb 15, 2017, at 10:24 AM, Igor Mammedov <imammedo@redhat.com <mail=
to:imammedo@redhat.com>> wrote:
> >>=20
> >> On Wed, 15 Feb 2017 20:04:40 +0200
> >> "Michael S. Tsirkin" <mst@redhat.com <mailto:mst@redhat.com>> wrote:
> >>  =20
> >>> On Wed, Feb 15, 2017 at 06:43:09PM +0100, Igor Mammedov wrote: =20
> >>>> On Wed, 15 Feb 2017 18:39:06 +0200
> >>>> "Michael S. Tsirkin" <mst@redhat.com <mailto:mst@redhat.com>> wrote:
> >>>>  =20
> >>>>> On Wed, Feb 15, 2017 at 04:56:02PM +0100, Igor Mammedov wrote:   =20
> >>>>>> On Wed, 15 Feb 2017 17:30:00 +0200
> >>>>>> "Michael S. Tsirkin" <mst@redhat.com <mailto:mst@redhat.com>> wrot=
e:
> >>>>>>  =20
> >>>>>>> On Wed, Feb 15, 2017 at 04:22:25PM +0100, Igor Mammedov wrote:   =
  =20
> >>>>>>>> On Wed, 15 Feb 2017 15:13:20 +0100
> >>>>>>>> Laszlo Ersek <lersek@redhat.com <mailto:lersek@redhat.com>> wrot=
e:
> >>>>>>>>  =20
> >>>>>>>>> Commenting under Igor's reply for simplicity
> >>>>>>>>>=20
> >>>>>>>>> On 02/15/17 11:57, Igor Mammedov wrote:       =20
> >>>>>>>>>> On Tue, 14 Feb 2017 22:15:43 -0800
> >>>>>>>>>> ben@skyportsystems.com <mailto:ben@skyportsystems.com> wrote:
> >>>>>>>>>>  =20
> >>>>>>>>>>> From: Ben Warren <ben@skyportsystems.com <mailto:ben@skyports=
ystems.com>>
> >>>>>>>>>>>=20
> >>>>>>>>>>> This is similar to the existing 'add pointer' functionality, =
but instead
> >>>>>>>>>>> of instructing the guest (BIOS or UEFI) to patch memory, it i=
nstructs
> >>>>>>>>>>> the guest to write the pointer back to QEMU via a writeable f=
w_cfg file.
> >>>>>>>>>>>=20
> >>>>>>>>>>> Signed-off-by: Ben Warren <ben@skyportsystems.com <mailto:ben=
@skyportsystems.com>>
> >>>>>>>>>>> ---
> >>>>>>>>>>> hw/acpi/bios-linker-loader.c         | 58 +++++++++++++++++++=
+++++++++++++++--
> >>>>>>>>>>> include/hw/acpi/bios-linker-loader.h |  6 ++++
> >>>>>>>>>>> 2 files changed, 61 insertions(+), 3 deletions(-)
> >>>>>>>>>>>=20
> >>>>>>>>>>> diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-link=
er-loader.c
> >>>>>>>>>>> index d963ebe..5030cf1 100644
> >>>>>>>>>>> --- a/hw/acpi/bios-linker-loader.c
> >>>>>>>>>>> +++ b/hw/acpi/bios-linker-loader.c
> >>>>>>>>>>> @@ -78,6 +78,19 @@ struct BiosLinkerLoaderEntry {
> >>>>>>>>>>>             uint32_t length;
> >>>>>>>>>>>         } cksum;
> >>>>>>>>>>>=20
> >>>>>>>>>>> +        /*
> >>>>>>>>>>> +         * COMMAND_WRITE_POINTER - write the fw_cfg file (or=
iginating from
> >>>>>>>>>>> +         * @dest_file) at @wr_pointer.offset, by adding a po=
inter to the table
> >>>>>>>>>>> +         * originating from @src_file. 1,2,4 or 8 byte unsig=
ned
> >>>>>>>>>>> +         * addition is used depending on @wr_pointer.size.
> >>>>>>>>>>> +         */         =20
> >>>>>>>>>=20
> >>>>>>>>> The words "adding" and "addition" are causing confusion here.
> >>>>>>>>>=20
> >>>>>>>>> In all of the previous discussion, *addition* was out of scope =
from
> >>>>>>>>> WRITE_POINTER. Again, the firmware is specifically not required=
 to
> >>>>>>>>> *read* any part of the fw_cfg blob identified by "dest_file".
> >>>>>>>>>=20
> >>>>>>>>> WRITE_POINTER instructs the firmware to return the allocation a=
ddress of
> >>>>>>>>> the downloaded "src_file" to QEMU. Any necessary runtime subscr=
ipting
> >>>>>>>>> within "src_file" is to be handled by QEMU code dynamically.
> >>>>>>>>>=20
> >>>>>>>>> For example, consider that "src_file" has *several* fields that=
 QEMU
> >>>>>>>>> wants to massage; in that case, indexing within QEMU code with =
field
> >>>>>>>>> offsets is simply unavoidable.       =20
> >>>>>>>> what I don't like here is that this indexing would be rather fra=
gile
> >>>>>>>> and has to be done in different parts of QEMU /device, AML/.
> >>>>>>>>=20
> >>>>>>>> I'd prefer this helper function to have the same @src_offset
> >>>>>>>> behavior as ADD_POINTER where patched address could point to
> >>>>>>>> any part of src_file i.e. not just beginning.       =20
> >>>>>>>=20
> >>>>>>>=20
> >>>>>>>=20
> >>>>>>>        /*
> >>>>>>>         * COMMAND_ADD_POINTER - patch the table (originating from
> >>>>>>>         * @dest_file) at @pointer.offset, by adding a pointer to =
the table
> >>>>>>>         * originating from @src_file. 1,2,4 or 8 byte unsigned
> >>>>>>>         * addition is used depending on @pointer.size.
> >>>>>>>         */
> >>>>>>>=20
> >>>>>>> so the way ADD works is
> >>>>>>> 	read at offset
> >>>>>>> 	add table address
> >>>>>>> 	write result at offset
> >>>>>>>=20
> >>>>>>> in other words it is always beginning of table that is added.    =
 =20
> >>>>>> more exactly it's, read at=20
> >>>>>>  src_offset =3D *(dst_blob_ptr+dst_offset)
> >>>>>>  *(dst_blob+dst_offset) =3D src_blob_ptr + src_offset
> >>>>>>  =20
> >>>>>>> Would the following be acceptable?
> >>>>>>>=20
> >>>>>>>=20
> >>>>>>>         * COMMAND_WRITE_POINTER - update the fw_cfg file (origina=
ting from
> >>>>>>>         * @dest_file) at @wr_pointer.offset, by writing a pointer=
 to the table
> >>>>>>>         * originating from @src_file. 1,2,4 or 8 byte unsigned va=
lue
> >>>>>>>         * is written depending on @wr_pointer.size.     =20
> >>>>>> it looses 'adding' part of ADD_POINTER command which handles src_o=
ffset,
> >>>>>> however implementing adding part looks a bit complicated
> >>>>>> as patched blob (dst) is not in guest memory but in QEMU and
> >>>>>> on reset *(dst_blob+dst_offset) should be reset to src_offset.
> >>>>>> Considering dst file could be device specific memory (field/blob/w=
hatever)
> >>>>>> it could be hard to track/notice proper reset behavior.
> >>>>>>=20
> >>>>>> So now I'm not sure if src_offset is worth adding.     =20
> >>>>>=20
> >>>>> Right. Let's just do this math in QEMU if we have to.   =20
> >>>> Math complicates QEMU code though and not only QMEMU but AML code as=
 well.
> >>>> Considering that we are adding a new command and don't have to keep
> >>>> any sort of compatibility we can pass src_offset as part
> >>>> of command instead of hiding it inside of dst_file.
> >>>> Something like this:
> >>>>=20
> >>>>        /*
> >>>>         * COMMAND_WRITE_POINTER - write the fw_cfg file (originating=
 from
> >>>>         * @dest_file) at @wr_pointer.offset, by writing a pointer to=
 @src_offset
> >>>>         * within the table originating from @src_file. 1,2,4 or 8 by=
te unsigned
> >>>>         * addition is used depending on @wr_pointer.size.
> >>>>         */
> >>>>        struct {
> >>>>             char dest_file[BIOS_LINKER_LOADER_FILESZ];
> >>>>             char src_file[BIOS_LINKER_LOADER_FILESZ];
> >>>> -            uint32_t offset;
> >>>> +            uint32_t dst_offset;
> >>>> +            uint32_t src_offset;
> >>>>             uint8_t size;
> >>>>        } wr_pointer;   =20
> >>>=20
> >>>=20
> >>> As long as all users pass in 0 though there's a real possibility gues=
ts
> >>> will implement this incorrectly. =20
> >> We are here to ensure that at least Seabios (I'll review it)
> >> and OVMF (Laszlo would take care of it I suppose) do it right,
> >> and if there are other firmwares, they should do it correctly
> >> as described fix their own bugs later wrt randomly written
> >> implementation.
> >>  =20
> >>> I guess we can put in the offset just
> >>> behind the zero-filled padding we have there. =20
> >> I've assumed padding was there to make commands fixed size and give
> >> a room for future extensions so hunk changing BiosLinkerLoaderEntry
> >> would look like:
> >>  =20
> > I can=E2=80=99t say I follow the logic of these extra paddings.  The si=
zes of the structs are all over the place, so adding 4 bytes doesn=E2=80=99=
t do much.  I assume you have a good reason, though.
> >  =20
> >> diff --git a/hw/acpi/bios-linker-loader.c b/hw/acpi/bios-linker-loader=
.c
> >> index d963ebe..6983713 100644
> >> --- a/hw/acpi/bios-linker-loader.c
> >> +++ b/hw/acpi/bios-linker-loader.c
> >> @@ -49,6 +49,7 @@ struct BiosLinkerLoaderEntry {
> >>             char file[BIOS_LINKER_LOADER_FILESZ];
> >>             uint32_t align;
> >>             uint8_t zone;
> >> +            uint32_t padding; =20
> > I=E2=80=99m a little wary of doing this - in a packed structure this ne=
w field will be mis-aligned. =20
> >>         } alloc;
> >>=20
> >>         /*
> >> @@ -62,6 +63,7 @@ struct BiosLinkerLoaderEntry {
> >>             char src_file[BIOS_LINKER_LOADER_FILESZ];
> >>             uint32_t offset;
> >>             uint8_t size;
> >> +            uint32_t padding;
> >>         } pointer;
> >>=20
> >>         /*
> >> @@ -76,10 +78,25 @@ struct BiosLinkerLoaderEntry {
> >>             uint32_t offset;
> >>             uint32_t start;
> >>             uint32_t length;
> >> +            uint32_t padding;
> >>         } cksum;
> >>=20
> >> +        /*
> >> +         * COMMAND_WRITE_POINTER - write the fw_cfg file (originating=
 from
> >> +         * @dest_file) at @wr_pointer.offset, by writing a pointer to=
 @src_offset
> >> +         * within the table originating from @src_file. 1,2,4 or 8 by=
te unsigned
> >> +         * addition is used depending on @wr_pointer.size.
> >> +         */
> >> +         struct {
> >> +             char dest_file[BIOS_LINKER_LOADER_FILESZ];
> >> +             char src_file[BIOS_LINKER_LOADER_FILESZ];
> >> +             uint32_t dst_offset;
> >> +             uint32_t src_offset;
> >> +             uint8_t size;
> >> +        } wr_pointer;
> >> +
> >>         /* padding */
> >> -        char pad[124];
> >> +        char pad[120]; =20
> > wr_pointer is 121 (56 + 56 + 32 + 32 + 1), so 124 still makes sense, do=
esn=E2=80=99t it? (also, 124 + 4 from command) % 8 =3D=3D 0, so it=E2=80=99=
s nicely aligned. =20
> I mean (56 + 56 + 4 + 4 + 1), of course :)
I' was wrong, as Laszlo pointed out pad is a member of union so it
as the biggest member defines total size of union/struct
as far as new command doesn't exceed 124 bytes size.



> >>     };
> >> } QEMU_PACKED;
> >> typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;
> >>=20
> >>  =20
> >>> I'm mostly concerned we are adding new features to something
> >>> that has been through 25 revisions already. =20
> >> It's ABI so it's worth extra effort,
> >> it looks like only one more revision is left and there is
> >> about a week left to post and merge it.
> >>  =20
> >>>=20
> >>>  =20
> >>>>>  =20
> >>>>>>>=20
> >>>>>>>  =20
> >>>>>>>>=20
> >>>>>>>>  =20
> >>>>>>>>> (1) So, the above looks correct, but please replace "adding" wi=
th
> >>>>>>>>> "storing", and "unsigned addition" with "store".
> >>>>>>>>>=20
> >>>>>>>>> Side point: the case for ADD_POINTER is different; there we pat=
ch
> >>>>>>>>> several individual ACPI objects. The fact that I requested expl=
icit
> >>>>>>>>> addition within the ADDR method, as opposed to pre-setting VGIA=
 to a
> >>>>>>>>> nonzero offset, is an *incidental* limitation (coming from the =
OVMF ACPI
> >>>>>>>>> SDT header probe suppressor), and we'll likely fix that up late=
r, with
> >>>>>>>>> ALLOCATE command hints or something like that. However, in
> >>>>>>>>> WRITE_POINTER, asking for the exact allocation address of "src_=
file" is
> >>>>>>>>> an *inherent* characteristic.
> >>>>>>>>>=20
> >>>>>>>>> For reference, this is the command's description from the (not =
as yet
> >>>>>>>>> posted) OVMF series:
> >>>>>>>>>=20
> >>>>>>>>> // QemuLoaderCmdWritePointer: the bytes at
> >>>>>>>>> // [PointerOffset..PointerOffset+PointerSize) in the writeable =
fw_cfg
> >>>>>>>>> // file PointerFile are to receive the absolute address of Poin=
teeFile,
> >>>>>>>>> // as allocated and downloaded by the firmware. Store the base =
address
> >>>>>>>>> // of where PointeeFile's contents have been placed (when
> >>>>>>>>> // QemuLoaderCmdAllocate has been executed for PointeeFile) to =
this
> >>>>>>>>> // portion of PointerFile.
> >>>>>>>>> //
> >>>>>>>>> // This command is similar to QemuLoaderCmdAddPointer; the diff=
erence is
> >>>>>>>>> // that the "pointer to patch" does not exist in guest-physical=
 address
> >>>>>>>>> // space, only in "fw_cfg file space". In addition, the "pointe=
r to
> >>>>>>>>> // patch" is not initialized by QEMU with a possibly nonzero of=
fset
> >>>>>>>>> // value: the base address of the memory allocated for download=
ing
> >>>>>>>>> // PointeeFile shall not increment the pointer, but overwrite i=
t.
> >>>>>>>>>=20
> >>>>>>>>> In the last SeaBIOS patch series, namely
> >>>>>>>>>=20
> >>>>>>>>> [SeaBIOS] [PATCH v3 2/2] QEMU fw_cfg: Add command to write back=
 address
> >>>>>>>>>                         of file
> >>>>>>>>>=20
> >>>>>>>>> function romfile_loader_write_pointer() implemented just that p=
lain
> >>>>>>>>> store (not an addition), and that was exactly right.
> >>>>>>>>>=20
> >>>>>>>>> Continuing:
> >>>>>>>>>  =20
> >>>>>>>>>>> +        struct {
> >>>>>>>>>>> +            char dest_file[BIOS_LINKER_LOADER_FILESZ];
> >>>>>>>>>>> +            char src_file[BIOS_LINKER_LOADER_FILESZ];
> >>>>>>>>>>> +            uint32_t offset;
> >>>>>>>>>>> +            uint8_t size;
> >>>>>>>>>>> +        } wr_pointer;
> >>>>>>>>>>> +
> >>>>>>>>>>>         /* padding */
> >>>>>>>>>>>         char pad[124];
> >>>>>>>>>>>     };
> >>>>>>>>>>> @@ -85,9 +98,10 @@ struct BiosLinkerLoaderEntry {
> >>>>>>>>>>> typedef struct BiosLinkerLoaderEntry BiosLinkerLoaderEntry;
> >>>>>>>>>>>=20
> >>>>>>>>>>> enum {
> >>>>>>>>>>> -    BIOS_LINKER_LOADER_COMMAND_ALLOCATE     =3D 0x1,
> >>>>>>>>>>> -    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER  =3D 0x2,
> >>>>>>>>>>> -    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM =3D 0x3,
> >>>>>>>>>>> +    BIOS_LINKER_LOADER_COMMAND_ALLOCATE          =3D 0x1,
> >>>>>>>>>>> +    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER       =3D 0x2,
> >>>>>>>>>>> +    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM      =3D 0x3,
> >>>>>>>>>>> +    BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER     =3D 0x4,
> >>>>>>>>>>> };
> >>>>>>>>>>>=20
> >>>>>>>>>>> enum {
> >>>>>>>>>>> @@ -278,3 +292,41 @@ void bios_linker_loader_add_pointer(BIOS=
Linker *linker,
> >>>>>>>>>>>=20
> >>>>>>>>>>>     g_array_append_vals(linker->cmd_blob, &entry, sizeof entr=
y);
> >>>>>>>>>>> }
> >>>>>>>>>>> +
> >>>>>>>>>>> +/*
> >>>>>>>>>>> + * bios_linker_loader_write_pointer: ask guest to write a po=
inter to the
> >>>>>>>>>>> + * source file into the destination file, and write it back =
to QEMU via
> >>>>>>>>>>> + * fw_cfg DMA.
> >>>>>>>>>>> + *
> >>>>>>>>>>> + * @linker: linker object instance
> >>>>>>>>>>> + * @dest_file: destination file that must be written
> >>>>>>>>>>> + * @dst_patched_offset: location within destination file blo=
b to be patched
> >>>>>>>>>>> + *                      with the pointer to @src_file, in by=
tes
> >>>>>>>>>>> + * @dst_patched_offset_size: size of the pointer to be patch=
ed
> >>>>>>>>>>> + *                      at @dst_patched_offset in @dest_file=
 blob, in bytes
> >>>>>>>>>>> + * @src_file: source file who's address must be taken
> >>>>>>>>>>> + */
> >>>>>>>>>>> +void bios_linker_loader_write_pointer(BIOSLinker *linker,
> >>>>>>>>>>> +                                    const char *dest_file,
> >>>>>>>>>>> +                                    uint32_t dst_patched_off=
set,
> >>>>>>>>>>> +                                    uint8_t dst_patched_size,
> >>>>>>>>>>> +                                    const char *src_file)   =
      =20
> >>>>>>>>>> API is missing "src_offset" even though it's not used in this =
series,
> >>>>>>>>>> a patch on top to fix it up is ok for me as far as Seabios/OVMF
> >>>>>>>>>> counterpart can handle src_offset correctly from starters.    =
     =20
> >>>>>>>>>=20
> >>>>>>>>> According to the above, it is the right thing not to add "src_o=
ffset"
> >>>>>>>>> here. The documentation on the command is slightly incorrect (a=
nd causes
> >>>>>>>>> confusion), but the helper function's signature and comments ar=
e okay.
> >>>>>>>>>  =20
> >>>>>>>>>>  =20
> >>>>>>>>>>> +{
> >>>>>>>>>>> +    BiosLinkerLoaderEntry entry;
> >>>>>>>>>>> +    const BiosLinkerFileEntry *source_file =3D
> >>>>>>>>>>> +        bios_linker_find_file(linker, src_file);
> >>>>>>>>>>> +
> >>>>>>>>>>> +    assert(source_file);         =20
> >>>>>>>>>=20
> >>>>>>>>> I wish we kept the following asserts from bios_linker_loader_ad=
d_pointer():
> >>>>>>>>>=20
> >>>>>>>>>    assert(dst_patched_offset < dst_file->blob->len);
> >>>>>>>>>    assert(dst_patched_offset + dst_patched_size <=3D dst_file->=
blob->len);
> >>>>>>>>>=20
> >>>>>>>>> Namely, just because the dst_file is never supposed to be downl=
oaded by
> >>>>>>>>> the firmware, it still remains a requirement that the "dst file=
 offset
> >>>>>>>>> range" that is to be rewritten *do fall* within the dst file.
> >>>>>>>>>=20
> >>>>>>>>> Nonetheless, this is not critical. (OVMF at least verifies it a=
nyway.)
> >>>>>>>>>=20
> >>>>>>>>> Summary (from my side anyway): I feel that the documentation of=
 the new
> >>>>>>>>> command is very important. Please fix it up as suggested under =
(1), in
> >>>>>>>>> v7. Regarding the asserts, I'll let you decide.
> >>>>>>>>>=20
> >>>>>>>>> With the documentation fixed up:
> >>>>>>>>>=20
> >>>>>>>>> Reviewed-by: Laszlo Ersek <lersek@redhat.com <mailto:lersek@red=
hat.com>>
> >>>>>>>>>=20
> >>>>>>>>> (If you don't wish to post a v7, I'm also completely fine if Mi=
chael or
> >>>>>>>>> someone else fixes up the docs as proposed in (1), before commi=
tting the
> >>>>>>>>> patch.)
> >>>>>>>>>=20
> >>>>>>>>> Thanks!
> >>>>>>>>> Laszlo
> >>>>>>>>>  =20
> >>>>>>>>>>> +    memset(&entry, 0, sizeof entry);
> >>>>>>>>>>> +    strncpy(entry.wr_pointer.dest_file, dest_file,
> >>>>>>>>>>> +            sizeof entry.wr_pointer.dest_file - 1);
> >>>>>>>>>>> +    strncpy(entry.wr_pointer.src_file, src_file,
> >>>>>>>>>>> +            sizeof entry.wr_pointer.src_file - 1);
> >>>>>>>>>>> +    entry.command =3D cpu_to_le32(BIOS_LINKER_LOADER_COMMAND=
_WRITE_POINTER);
> >>>>>>>>>>> +    entry.wr_pointer.offset =3D cpu_to_le32(dst_patched_offs=
et);
> >>>>>>>>>>> +    entry.wr_pointer.size =3D dst_patched_size;
> >>>>>>>>>>> +    assert(dst_patched_size =3D=3D 1 || dst_patched_size =3D=
=3D 2 ||
> >>>>>>>>>>> +           dst_patched_size =3D=3D 4 || dst_patched_size =3D=
=3D 8);
> >>>>>>>>>>> +
> >>>>>>>>>>> +    g_array_append_vals(linker->cmd_blob, &entry, sizeof ent=
ry);
> >>>>>>>>>>> +}
> >>>>>>>>>>> diff --git a/include/hw/acpi/bios-linker-loader.h b/include/h=
w/acpi/bios-linker-loader.h
> >>>>>>>>>>> index fa1e5d1..f9ba5d6 100644
> >>>>>>>>>>> --- a/include/hw/acpi/bios-linker-loader.h
> >>>>>>>>>>> +++ b/include/hw/acpi/bios-linker-loader.h
> >>>>>>>>>>> @@ -26,5 +26,11 @@ void bios_linker_loader_add_pointer(BIOSLi=
nker *linker,
> >>>>>>>>>>>                                     const char *src_file,
> >>>>>>>>>>>                                     uint32_t src_offset);
> >>>>>>>>>>>=20
> >>>>>>>>>>> +void bios_linker_loader_write_pointer(BIOSLinker *linker,
> >>>>>>>>>>> +                                      const char *dest_file,
> >>>>>>>>>>> +                                      uint32_t dst_patched_o=
ffset,
> >>>>>>>>>>> +                                      uint8_t dst_patched_si=
ze,
> >>>>>>>>>>> +                                      const char *src_file);
> >>>>>>>>>>> +
> >>>>>>>>>>> void bios_linker_loader_cleanup(BIOSLinker *linker);
> >>>>>>>>>>> #endif         =20
>=20
