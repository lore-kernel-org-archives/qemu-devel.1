Received: from eggs.gnu.org ([2001:4830:134:3::10]:33365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ce6pb-0001FU-GJ
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 16:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ce6pY-0007WK-8O
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 16:09:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ce6pX-0007Vz-QY
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 16:09:40 -0500
Date: Wed, 15 Feb 2017 23:09:37 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170215230616-mutt-send-email-mst@kernel.org>
References: <20170215162225.74d48058@nial.brq.redhat.com>
	<20170215172515-mutt-send-email-mst@kernel.org>
	<20170215165602.72e96c28@nial.brq.redhat.com>
	<20170215183736-mutt-send-email-mst@kernel.org>
	<20170215184309.521aa90f@nial.brq.redhat.com>
	<5216BB96-2CB8-4E83-8950-40E44EE5264D@skyportsystems.com>
	<20170215200506-mutt-send-email-mst@kernel.org>
	<5E496DF7-107A-49E2-95AE-66DC32F6225B@skyportsystems.com>
	<20170215193520.1d436ea3@nial.brq.redhat.com>
	<B70CA5CF-AFE7-4CB1-BF51-5AEFB9B89BEB@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B70CA5CF-AFE7-4CB1-BF51-5AEFB9B89BEB@skyportsystems.com>
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
Cc: Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org

On Wed, Feb 15, 2017 at 10:44:05AM -0800, Ben Warren wrote:
>=20
>     On Feb 15, 2017, at 10:35 AM, Igor Mammedov <imammedo@redhat.com> w=
rote:
>=20
>     On Wed, 15 Feb 2017 10:14:55 -0800
>     Ben Warren <ben@skyportsystems.com> wrote:
>=20
>=20
>             On Feb 15, 2017, at 10:06 AM, Michael S. Tsirkin <mst@redha=
t.com>
>             wrote:
>=20
>             On Wed, Feb 15, 2017 at 09:54:08AM -0800, Ben Warren wrote:=
 =20
>=20
>=20
>                   On Feb 15, 2017, at 9:43 AM, Igor Mammedov <
>                 imammedo@redhat.com> wrote:
>=20
>                   On Wed, 15 Feb 2017 18:39:06 +0200
>                   "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
>=20
>                       On Wed, Feb 15, 2017 at 04:56:02PM +0100, Igor Ma=
mmedov
>                 wrote:
>=20
>                           On Wed, 15 Feb 2017 17:30:00 +0200
>                           "Michael S. Tsirkin" <mst@redhat.com> wrote:
>=20
>=20
>                               On Wed, Feb 15, 2017 at 04:22:25PM +0100,=
 Igor
>                 Mammedov wrote:
>=20
>=20
>                                   On Wed, 15 Feb 2017 15:13:20 +0100
>                                   Laszlo Ersek <lersek@redhat.com> wrot=
e:
>=20
>=20
>                                       Commenting under Igor's reply for
>                 simplicity
>=20
>                                       On 02/15/17 11:57, Igor Mammedov =
wrote:
>                   =20
>=20
>                                           On Tue, 14 Feb 2017 22:15:43 =
-0800
>                                           ben@skyportsystems.com wrote:
>=20
>=20
>                                               From: Ben Warren <
>                 ben@skyportsystems.com>
>=20
>                                               This is similar to the ex=
isting
>                 'add pointer'
>                                               functionality, but instea=
d
>                                               of instructing the guest =
(BIOS or
>                 UEFI) to
>                                               patch memory, it instruct=
s
>                                               the guest to write the po=
inter
>                 back to QEMU via
>                                               a writeable fw_cfg file.
>=20
>                                               Signed-off-by: Ben Warren=
 < =20
>                                               ben@skyportsystems.com> =20
>                                               ---
>                                               hw/acpi/bios-linker-loade=
r.c
>                         | 58
>                                               +++++++++++++++++++++++++=
+++++++++--
>                                               include/hw/acpi/
>                 bios-linker-loader.h |  6 ++++
>                                               2 files changed, 61 inser=
tions
>                 (+), 3 deletions
>                                               (-)
>=20
>                                               diff --git a/hw/acpi/
>                 bios-linker-loader.c b/hw/
>                                               acpi/bios-linker-loader.c
>                                               index d963ebe..5030cf1 10=
0644
>                                               --- a/hw/acpi/
>                 bios-linker-loader.c
>                                               +++ b/hw/acpi/
>                 bios-linker-loader.c
>                                               @@ -78,6 +78,19 @@ struct
>                 BiosLinkerLoaderEntry
>                                               {
>                                                           uint32_t leng=
th;
>                                                       } cksum;
>=20
>                                               +        /*
>                                               +         * COMMAND_WRITE=
_POINTER
>                 - write the
>                                               fw_cfg file (originating =
from
>                                               +         * @dest_file) a=
t
>                 @wr_pointer.offset,
>                                               by adding a pointer to th=
e table
>                                               +         * originating f=
rom
>                 @src_file. 1,2,4
>                                               or 8 byte unsigned
>                                               +         * addition is u=
sed
>                 depending on
>                                               @wr_pointer.size.
>                                               +         */     =20
>=20
>=20
>                                       The words "adding" and "addition"=
 are
>                 causing confusion
>                                       here.
>=20
>                                       In all of the previous discussion=
,
>                 *addition* was out
>                                       of scope from
>                                       WRITE_POINTER. Again, the firmwar=
e is
>                 specifically not
>                                       required to
>                                       *read* any part of the fw_cfg blo=
b
>                 identified by
>                                       "dest_file".
>=20
>                                       WRITE_POINTER instructs the firmw=
are to
>                 return the
>                                       allocation address of
>                                       the downloaded "src_file" to QEMU=
. Any
>                 necessary
>                                       runtime subscripting
>                                       within "src_file" is to be handle=
d by
>                 QEMU code
>                                       dynamically.
>=20
>                                       For example, consider that "src_f=
ile" has
>                 *several*
>                                       fields that QEMU
>                                       wants to massage; in that case, i=
ndexing
>                 within QEMU
>                                       code with field
>                                       offsets is simply unavoidable.   =
=20
>=20
>                                   what I don't like here is that this i=
ndexing
>                 would be
>                                   rather fragile
>                                   and has to be done in different parts=
 of QEMU
>                 /device, AML
>                                   /.
>=20
>                                   I'd prefer this helper function to ha=
ve the
>                 same
>                                   @src_offset
>                                   behavior as ADD_POINTER where patched=
 address
>                 could point
>                                   to
>                                   any part of src_file i.e. not just be=
ginning.
>                   =20
>=20
>=20
>=20
>=20
>                                      /*
>                                       * COMMAND_ADD_POINTER - patch the=
 table
>                 (originating
>                               from
>                                       * @dest_file) at @pointer.offset,=
 by
>                 adding a pointer
>                               to the table
>                                       * originating from @src_file. 1,2=
,4 or 8
>                 byte unsigned
>                                       * addition is used depending on
>                 @pointer.size.
>                                       */
>=20
>                               so the way ADD works is
>                               read at offset
>                               add table address
>                               write result at offset
>=20
>                               in other words it is always beginning of =
table
>                 that is added. =20
>=20
>                           more exactly it's, read at=20
>                            src_offset =3D *(dst_blob_ptr+dst_offset)
>                            *(dst_blob+dst_offset) =3D src_blob_ptr + sr=
c_offset
>=20
>=20
>                               Would the following be acceptable?
>=20
>=20
>                                       * COMMAND_WRITE_POINTER - update =
the
>                 fw_cfg file
>                               (originating from
>                                       * @dest_file) at @wr_pointer.offs=
et, by
>                 writing a
>                               pointer to the table
>                                       * originating from @src_file. 1,2=
,4 or 8
>                 byte unsigned
>                               value
>                                       * is written depending on
>                 @wr_pointer.size. =20
>=20
>                           it looses 'adding' part of ADD_POINTER comman=
d which
>                 handles
>                           src_offset,
>                           however implementing adding part looks a bit
>                 complicated
>                           as patched blob (dst) is not in guest memory =
but in
>                 QEMU and
>                           on reset *(dst_blob+dst_offset) should be res=
et to
>                 src_offset.
>                           Considering dst file could be device specific=
 memory
>                 (field/blob/
>                           whatever)
>                           it could be hard to track/notice proper reset
>                 behavior.
>=20
>                           So now I'm not sure if src_offset is worth ad=
ding. =20
>=20
>=20
>                       Right. Let's just do this math in QEMU if we have=
 to.
>=20
>                   Math complicates QEMU code though and not only QMEMU =
but AML
>                 code as well.
>                   Considering that we are adding a new command and don'=
t have
>                 to keep
>                   any sort of compatibility we can pass src_offset as p=
art
>                   of command instead of hiding it inside of dst_file.
>                   Something like this:
>=20
>                          /*
>                           * COMMAND_WRITE_POINTER - write the fw_cfg fi=
le
>                 (originating from
>                           * @dest_file) at @wr_pointer.offset, by writi=
ng a
>                 pointer to
>                   @src_offset
>                           * within the table originating from @src_file=
. 1,2,4
>                 or 8 byte
>                   unsigned
>                           * addition is used depending on @wr_pointer.s=
ize.
>                           */
>                          struct {
>                               char dest_file[BIOS_LINKER_LOADER_FILESZ]=
;
>                               char src_file[BIOS_LINKER_LOADER_FILESZ];
>                   -            uint32_t offset;
>                   +            uint32_t dst_offset;
>                   +            uint32_t src_offset;
>                               uint8_t size;
>                          } wr_pointer;
>=20
>=20
>                 OK, this is easy enough to do and maybe we=E2=80=99ll h=
ave a use case
>                 in the future.
>                 I=E2=80=99ll make this change in v7 =20
>=20
>=20
>=20
>             So if you do, you want to set it to VMGENID_GUID_OFFSET.
>=20
>=20
>         Oh, I was going to set it to 0 since that doesn=E2=80=99t requi=
re any other
>         changes (other than to SeaBIOS)

This is equivalent to not adding this field at all.
If we do add it we better have at least some users
set it to something non-zero otherwise we do not
really know whether it works.



>     it should be changed in following places:
>=20
>        bios_linker_loader_write_pointer(linker,
>            VMGENID_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
>     -        VMGENID_GUID_FW_CFG_FILE);
>     +        VMGENID_GUID_FW_CFG_FILE, VMGENID_GUID_OFFSET);
>=20
>     ...
>     -            cpu_physical_memory_write(vmgenid_addr + VMGENID_GUID_=
OFFSET,
>     +            cpu_physical_memory_write(vmgenid_addr,
>                                          guid_le.data, sizeof(guid_le.d=
ata));
>=20
>=20
> OK, the more places I can get rid of this goofy offset the better.  Jus=
t to be
> clear, the address that gets patched into AML (via the add_pointer() ca=
ll)
> remains at the beginning of /etc/vmgenid_guid, right?

It's up to you really but OVMF wants the beginning I think.

>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>=20
>                                       (1) So, the above looks correct, =
but
>                 please replace
>                                       "adding" with
>                                       "storing", and "unsigned addition=
" with
>                 "store".
>=20
>                                       Side point: the case for ADD_POIN=
TER is
>                 different;
>                                       there we patch
>                                       several individual ACPI objects. =
The fact
>                 that I
>                                       requested explicit
>                                       addition within the ADDR method, =
as
>                 opposed to
>                                       pre-setting VGIA to a
>                                       nonzero offset, is an *incidental=
*
>                 limitation (coming
>                                       from the OVMF ACPI
>                                       SDT header probe suppressor), and=
 we'll
>                 likely fix that
>                                       up later, with
>                                       ALLOCATE command hints or somethi=
ng like
>                 that. However,
>                                       in
>                                       WRITE_POINTER, asking for the exa=
ct
>                 allocation address
>                                       of "src_file" is
>                                       an *inherent* characteristic.
>=20
>                                       For reference, this is the comman=
d's
>                 description from
>                                       the (not as yet
>                                       posted) OVMF series:
>=20
>                                       // QemuLoaderCmdWritePointer: the=
 bytes
>                 at
>                                       //
>                 [PointerOffset..PointerOffset+PointerSize) in the
>                                       writeable fw_cfg
>                                       // file PointerFile are to receiv=
e the
>                 absolute address
>                                       of PointeeFile,
>                                       // as allocated and downloaded by=
 the
>                 firmware. Store
>                                       the base address
>                                       // of where PointeeFile's content=
s have
>                 been placed
>                                       (when
>                                       // QemuLoaderCmdAllocate has been
>                 executed for
>                                       PointeeFile) to this
>                                       // portion of PointerFile.
>                                       //
>                                       // This command is similar to
>                 QemuLoaderCmdAddPointer;
>                                       the difference is
>                                       // that the "pointer to patch" do=
es not
>                 exist in
>                                       guest-physical address
>                                       // space, only in "fw_cfg file sp=
ace". In
>                 addition, the
>                                       "pointer to
>                                       // patch" is not initialized by Q=
EMU with
>                 a possibly
>                                       nonzero offset
>                                       // value: the base address of the=
 memory
>                 allocated for
>                                       downloading
>                                       // PointeeFile shall not incremen=
t the
>                 pointer, but
>                                       overwrite it.
>=20
>                                       In the last SeaBIOS patch series,=
 namely
>=20
>                                       [SeaBIOS] [PATCH v3 2/2] QEMU fw_=
cfg: Add
>                 command to
>                                       write back address
>                                                               of file
>=20
>                                       function romfile_loader_write_poi=
nter()
>                 implemented
>                                       just that plain
>                                       store (not an addition), and that=
 was
>                 exactly right.
>=20
>                                       Continuing:
>=20
>=20
>                                               +        struct {
>                                               +            char dest_fi=
le
>                                               [BIOS_LINKER_LOADER_FILES=
Z];
>                                               +            char src_fil=
e
>                                               [BIOS_LINKER_LOADER_FILES=
Z];
>                                               +            uint32_t off=
set;
>                                               +            uint8_t size=
;
>                                               +        } wr_pointer;
>                                               +
>                                                       /* padding */
>                                                       char pad[124];
>                                                   };
>                                               @@ -85,9 +98,10 @@ struct
>                 BiosLinkerLoaderEntry
>                                               {
>                                               typedef struct
>                 BiosLinkerLoaderEntry
>                                               BiosLinkerLoaderEntry;
>=20
>                                               enum {
>                                               -
>                    BIOS_LINKER_LOADER_COMMAND_ALLOCATE     =3D
>                                               0x1,
>                                               -
>                    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER  =3D
>                                               0x2,
>                                               -
>                    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM =3D
>                                               0x3,
>                                               +
>                    BIOS_LINKER_LOADER_COMMAND_ALLOCATE
>                                                        =3D 0x1,
>                                               +
>                    BIOS_LINKER_LOADER_COMMAND_ADD_POINTER
>                                                     =3D 0x2,
>                                               +
>                    BIOS_LINKER_LOADER_COMMAND_ADD_CHECKSUM
>                                                    =3D 0x3,
>                                               +
>                    BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER
>                                                   =3D 0x4,
>                                               };
>=20
>                                               enum {
>                                               @@ -278,3 +292,41 @@ void
>                                               bios_linker_loader_add_po=
inter
>                 (BIOSLinker
>                                               *linker,
>=20
>                                                   g_array_append_vals(l=
inker->
>                 cmd_blob, &
>                                               entry, sizeof entry);
>                                               }
>                                               +
>                                               +/*
>                                               + *
>                 bios_linker_loader_write_pointer: ask guest
>                                               to write a pointer to the
>                                               + * source file into the
>                 destination file, and
>                                               write it back to QEMU via
>                                               + * fw_cfg DMA.
>                                               + *
>                                               + * @linker: linker objec=
t
>                 instance
>                                               + * @dest_file: destinati=
on file
>                 that must be
>                                               written
>                                               + * @dst_patched_offset: =
location
>                 within
>                                               destination file blob to =
be
>                 patched
>                                               + *                      =
with the
>                 pointer to
>                                               @src_file, in bytes
>                                               + * @dst_patched_offset_s=
ize:
>                 size of the
>                                               pointer to be patched
>                                               + *                      =
at
>                 @dst_patched_offset
>                                               in @dest_file blob, in by=
tes
>                                               + * @src_file: source fil=
e who's
>                 address must
>                                               be taken
>                                               + */
>                                               +void
>                 bios_linker_loader_write_pointer
>                                               (BIOSLinker *linker,
>                                               +
>                                                    const char
>                                               *dest_file,
>                                               +
>                                                    uint32_t
>                                               dst_patched_offset,
>                                               +
>                                                    uint8_t
>                                               dst_patched_size,
>                                               +
>                                                    const char
>                                               *src_file)     =20
>=20
>                                           API is missing "src_offset" e=
ven
>                 though it's not
>                                           used in this series,
>                                           a patch on top to fix it up i=
s ok for
>                 me as far as
>                                           Seabios/OVMF
>                                           counterpart can handle src_of=
fset
>                 correctly from
>                                           starters.     =20
>=20
>=20
>                                       According to the above, it is the=
 right
>                 thing not to
>                                       add "src_offset"
>                                       here. The documentation on the co=
mmand is
>                 slightly
>                                       incorrect (and causes
>                                       confusion), but the helper functi=
on's
>                 signature and
>                                       comments are okay.
>=20
>=20
>=20
>=20
>                                               +{
>                                               +    BiosLinkerLoaderEntr=
y entry;
>                                               +    const BiosLinkerFile=
Entry
>                 *source_file =3D
>                                               +        bios_linker_find=
_file
>                 (linker,
>                                               src_file);
>                                               +
>                                               +    assert(source_file);=
     =20
>=20
>=20
>                                       I wish we kept the following asse=
rts from
>                                       bios_linker_loader_add_pointer():
>=20
>                                          assert(dst_patched_offset < ds=
t_file->
>                 blob->len);
>                                          assert(dst_patched_offset +
>                 dst_patched_size <=3D
>                                       dst_file->blob->len);
>=20
>                                       Namely, just because the dst_file=
 is
>                 never supposed to
>                                       be downloaded by
>                                       the firmware, it still remains a
>                 requirement that the
>                                       "dst file offset
>                                       range" that is to be rewritten *d=
o fall*
>                 within the dst
>                                       file.
>=20
>                                       Nonetheless, this is not critical=
. (OVMF
>                 at least
>                                       verifies it anyway.)
>=20
>                                       Summary (from my side anyway): I =
feel
>                 that the
>                                       documentation of the new
>                                       command is very important. Please=
 fix it
>                 up as
>                                       suggested under (1), in
>                                       v7. Regarding the asserts, I'll l=
et you
>                 decide.
>=20
>                                       With the documentation fixed up:
>=20
>                                       Reviewed-by: Laszlo Ersek <
>                 lersek@redhat.com>
>=20
>                                       (If you don't wish to post a v7, =
I'm also
>                 completely
>                                       fine if Michael or
>                                       someone else fixes up the docs as
>                 proposed in (1),
>                                       before committing the
>                                       patch.)
>=20
>                                       Thanks!
>                                       Laszlo
>=20
>=20
>                                               +    memset(&entry, 0, si=
zeof
>                 entry);
>                                               +    strncpy
>                 (entry.wr_pointer.dest_file,
>                                               dest_file,
>                                               +            sizeof
>                 entry.wr_pointer.dest_file
>                                               - 1);
>                                               +    strncpy
>                 (entry.wr_pointer.src_file,
>                                               src_file,
>                                               +            sizeof
>                 entry.wr_pointer.src_file -
>                                               1);
>                                               +    entry.command =3D cp=
u_to_le32
>                                              =20
>                 (BIOS_LINKER_LOADER_COMMAND_WRITE_POINTER);
>                                               +    entry.wr_pointer.off=
set =3D
>                 cpu_to_le32
>                                               (dst_patched_offset);
>                                               +    entry.wr_pointer.siz=
e =3D
>                 dst_patched_size;
>                                               +    assert(dst_patched_s=
ize =3D=3D 1
>                 ||
>                                               dst_patched_size =3D=3D 2=
 ||
>                                               +           dst_patched_s=
ize =3D=3D 4
>                 ||
>                                               dst_patched_size =3D=3D 8=
);
>                                               +
>                                               +    g_array_append_vals(=
linker->
>                 cmd_blob, &
>                                               entry, sizeof entry);
>                                               +}
>                                               diff --git a/include/hw/a=
cpi/
>                                               bios-linker-loader.h b/in=
clude/hw
>                 /acpi/
>                                               bios-linker-loader.h
>                                               index fa1e5d1..f9ba5d6 10=
0644
>                                               --- a/include/hw/acpi/
>                 bios-linker-loader.h
>                                               +++ b/include/hw/acpi/
>                 bios-linker-loader.h
>                                               @@ -26,5 +26,11 @@ void
>                                               bios_linker_loader_add_po=
inter
>                 (BIOSLinker
>                                               *linker,
>                                                                        =
           const
>                 char
>                                               *src_file,
>                                                                        =
           uint32_t
>                                               src_offset);
>=20
>                                               +void
>                 bios_linker_loader_write_pointer
>                                               (BIOSLinker *linker,
>                                               +
>                                                      const
>                                               char *dest_file,
>                                               +
>                                                      uint32_t
>                                               dst_patched_offset,
>                                               +
>                                                      uint8_t
>                                               dst_patched_size,
>                                               +
>                                                      const
>                                               char *src_file);
>                                               +
>                                               void bios_linker_loader_c=
leanup
>                 (BIOSLinker
>                                               *linker);
>                                               #endif       =20
>=20
>=20
