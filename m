Received: from eggs.gnu.org ([2001:4830:134:3::10]:53374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfuBQ-00036A-1a
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 16:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1dfuBO-0005Th-5W
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 16:35:56 -0400
From: Programmingkid <programmingkidx@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Message-Id: <D8BB14D4-9DEF-4FAA-9C48-91E01D7B2EF9@gmail.com>
Date: Thu, 10 Aug 2017 16:35:44 -0400
Subject: [Qemu-devel] Block warning messages displayed while compiling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Host info:
Operating system: Mac OS 10.12.5
Compiler: Apple LLVM version 8.1.0 (clang-802.0.42)
Command to reproduce: ./configure --target-list=3Dppc-softmmu,i386-softmmu=
 && make -j 4

When compiling QEMU I see these warning messages:


  CC      block/vdi.o
block/qcow.c:138:19: warning: taking address of packed member 'magic' of =
class or
      structure 'QCowHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    be32_to_cpus(&header.magic);
                  ^~~~~~~~~~~~
block/qcow.c:139:19: warning: taking address of packed member 'version' =
of class or
      structure 'QCowHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    be32_to_cpus(&header.version);
                  ^~~~~~~~~~~~~~
block/qcow.c:140:19: warning: taking address of packed member =
'backing_file_offset' of
      class or structure 'QCowHeader' may result in an unaligned pointer =
value
      [-Waddress-of-packed-member]
    be64_to_cpus(&header.backing_file_offset);
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
block/qcow.c:141:19: warning: taking address of packed member =
'backing_file_size' of
      class or structure 'QCowHeader' may result in an unaligned pointer =
value
      [-Waddress-of-packed-member]
    be32_to_cpus(&header.backing_file_size);
                  ^~~~~~~~~~~~~~~~~~~~~~~~
block/qcow.c:142:19: warning: taking address of packed member 'mtime' of =
class or
      structure 'QCowHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    be32_to_cpus(&header.mtime);
                  ^~~~~~~~~~~~
block/qcow.c:143:19: warning: taking address of packed member 'size' of =
class or
      structure 'QCowHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    be64_to_cpus(&header.size);
                  ^~~~~~~~~~~
block/qcow.c:144:19: warning: taking address of packed member =
'crypt_method' of class or
      structure 'QCowHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    be32_to_cpus(&header.crypt_method);
                  ^~~~~~~~~~~~~~~~~~~
block/qcow.c:145:19: warning: taking address of packed member =
'l1_table_offset' of class
      or structure 'QCowHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    be64_to_cpus(&header.l1_table_offset);
                  ^~~~~~~~~~~~~~~~~~~~~~
block/vdi.c:182:19: warning: taking address of packed member 'signature' =
of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->signature);
                  ^~~~~~~~~~~~~~~~~
block/vdi.c:183:19: warning: taking address of packed member 'version' =
of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->version);
                  ^~~~~~~~~~~~~~~
block/vdi.c:184:19: warning: taking address of packed member =
'header_size' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->header_size);
                  ^~~~~~~~~~~~~~~~~~~
block/vdi.c:185:19: warning: taking address of packed member =
'image_type' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->image_type);
                  ^~~~~~~~~~~~~~~~~~
block/vdi.c:186:19: warning: taking address of packed member =
'image_flags' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->image_flags);
                  ^~~~~~~~~~~~~~~~~~~
block/vdi.c:187:19: warning: taking address of packed member =
'offset_bmap' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->offset_bmap);
                  ^~~~~~~~~~~~~~~~~~~
block/vdi.c:188:19: warning: taking address of packed member =
'offset_data' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->offset_data);
                  ^~~~~~~~~~~~~~~~~~~
block/vdi.c:189:19: warning: taking address of packed member 'cylinders' =
of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->cylinders);
                  ^~~~~~~~~~~~~~~~~
block/vdi.c:190:19: warning: taking address of packed member 'heads' of =
class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->heads);
                  ^~~~~~~~~~~~~
block/vdi.c:191:19: warning: taking address of packed member 'sectors' =
of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->sectors);
                  ^~~~~~~~~~~~~~~
block/vdi.c:192:19: warning: taking address of packed member =
'sector_size' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->sector_size);
                  ^~~~~~~~~~~~~~~~~~~
block/vdi.c:193:19: warning: taking address of packed member 'disk_size' =
of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le64_to_cpus(&header->disk_size);
                  ^~~~~~~~~~~~~~~~~
block/vdi.c:194:19: warning: taking address of packed member =
'block_size' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->block_size);
                  ^~~~~~~~~~~~~~~~~~
block/vdi.c:195:19: warning: taking address of packed member =
'block_extra' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->block_extra);
                  ^~~~~~~~~~~~~~~~~~~
block/vdi.c:196:19: warning: taking address of packed member =
'blocks_in_image' of class
      or structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->blocks_in_image);
                  ^~~~~~~~~~~~~~~~~~~~~~~
block/vdi.c:197:19: warning: taking address of packed member =
'blocks_allocated' of class
      or structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    le32_to_cpus(&header->blocks_allocated);
                  ^~~~~~~~~~~~~~~~~~~~~~~~
block/vdi.c:198:22: warning: taking address of packed member =
'uuid_image' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    qemu_uuid_bswap(&header->uuid_image);
                     ^~~~~~~~~~~~~~~~~~
block/vdi.c:199:22: warning: taking address of packed member =
'uuid_last_snap' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    qemu_uuid_bswap(&header->uuid_last_snap);
                     ^~~~~~~~~~~~~~~~~~~~~~
block/vdi.c:200:22: warning: taking address of packed member 'uuid_link' =
of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    qemu_uuid_bswap(&header->uuid_link);
                     ^~~~~~~~~~~~~~~~~
block/vdi.c:201:22: warning: taking address of packed member =
'uuid_parent' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    qemu_uuid_bswap(&header->uuid_parent);
                     ^~~~~~~~~~~~~~~~~~~
block/vdi.c:206:19: warning: taking address of packed member 'signature' =
of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->signature);
                  ^~~~~~~~~~~~~~~~~
block/vdi.c:207:19: warning: taking address of packed member 'version' =
of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->version);
                  ^~~~~~~~~~~~~~~
block/vdi.c:208:19: warning: taking address of packed member =
'header_size' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->header_size);
                  ^~~~~~~~~~~~~~~~~~~
block/vdi.c:209:19: warning: taking address of packed member =
'image_type' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->image_type);
                  ^~~~~~~~~~~~~~~~~~
block/vdi.c:210:19: warning: taking address of packed member =
'image_flags' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->image_flags);
                  ^~~~~~~~~~~~~~~~~~~
block/vdi.c:211:19: warning: taking address of packed member =
'offset_bmap' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->offset_bmap);
                  ^~~~~~~~~~~~~~~~~~~
block/vdi.c:212:19: warning: taking address of packed member =
'offset_data' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->offset_data);
                  ^~~~~~~~~~~~~~~~~~~
block/vdi.c:213:19: warning: taking address of packed member 'cylinders' =
of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->cylinders);
                  ^~~~~~~~~~~~~~~~~
block/vdi.c:214:19: warning: taking address of packed member 'heads' of =
class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->heads);
                  ^~~~~~~~~~~~~
block/vdi.c:215:19: warning: taking address of packed member 'sectors' =
of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->sectors);
                  ^~~~~~~~~~~~~~~
block/vdi.c:216:19: warning: taking address of packed member =
'sector_size' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->sector_size);
                  ^~~~~~~~~~~~~~~~~~~
block/vdi.c:217:19: warning: taking address of packed member 'disk_size' =
of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le64s(&header->disk_size);
                  ^~~~~~~~~~~~~~~~~
block/vdi.c:218:19: warning: taking address of packed member =
'block_size' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->block_size);
                  ^~~~~~~~~~~~~~~~~~
block/vdi.c:219:19: warning: taking address of packed member =
'block_extra' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->block_extra);
                  ^~~~~~~~~~~~~~~~~~~
block/vdi.c:220:19: warning: taking address of packed member =
'blocks_in_image' of class
      or structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->blocks_in_image);
                  ^~~~~~~~~~~~~~~~~~~~~~~
block/vdi.c:221:19: warning: taking address of packed member =
'blocks_allocated' of class
      or structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    cpu_to_le32s(&header->blocks_allocated);
                  ^~~~~~~~~~~~~~~~~~~~~~~~
block/vdi.c:222:22: warning: taking address of packed member =
'uuid_image' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    qemu_uuid_bswap(&header->uuid_image);
                     ^~~~~~~~~~~~~~~~~~
block/vdi.c:223:22: warning: taking address of packed member =
'uuid_last_snap' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    qemu_uuid_bswap(&header->uuid_last_snap);
                     ^~~~~~~~~~~~~~~~~~~~~~
block/vdi.c:224:22: warning: taking address of packed member 'uuid_link' =
of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    qemu_uuid_bswap(&header->uuid_link);
                     ^~~~~~~~~~~~~~~~~
block/vdi.c:225:22: warning: taking address of packed member =
'uuid_parent' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    qemu_uuid_bswap(&header->uuid_parent);
                     ^~~~~~~~~~~~~~~~~~~
block/vdi.c:440:36: warning: taking address of packed member 'uuid_link' =
of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    } else if (!qemu_uuid_is_null(&header.uuid_link)) {
                                   ^~~~~~~~~~~~~~~~
block/vdi.c:444:36: warning: taking address of packed member =
'uuid_parent' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    } else if (!qemu_uuid_is_null(&header.uuid_parent)) {
                                   ^~~~~~~~~~~~~~~~~~
block/vdi.c:798:25: warning: taking address of packed member =
'uuid_image' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    qemu_uuid_generate(&header.uuid_image);
                        ^~~~~~~~~~~~~~~~~
block/vdi.c:799:25: warning: taking address of packed member =
'uuid_last_snap' of class or
      structure 'VdiHeader' may result in an unaligned pointer value
      [-Waddress-of-packed-member]
    qemu_uuid_generate(&header.uuid_last_snap);
