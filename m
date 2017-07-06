Received: from eggs.gnu.org ([2001:4830:134:3::10]:47300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dSzKB-0007Q9-Br
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 01:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dSzKA-0002yg-Bw
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 01:27:35 -0400
References: <20170522211205.14265-1-hpoussin@reactos.org>
	<20170703165047.GB4936@noname.redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <fd2f738e-238b-8617-c3bb-0f753fde7788@reactos.org>
Date: Thu, 6 Jul 2017 07:27:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170703165047.GB4936@noname.redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/13] vvfat: misc fixes for read-only
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Hi,

Thanks to have taken this patch series.

However, I already have in my repository the v3 patch series, whose chang=
elog is:

Changes v2->v3:
- added patches 5, 12, 16
- fixed warning (unused variable) (patch 11)
- added #defines for constants for deleted byte following Philippe remark=
s (patch 14)
- added #define and explanations for OEM name following Philippe remarks =
(patch 15)

Changes v1->v2:
- small changes following Kevin remarks (patches 3, 5, 6)
- use g_utf8_* functions instead of ad-hock code (patches 8 and 9)
- fix a bug with filenames starting with a dot (patch 9)

Herv=E9 Poussineau (16):
   vvfat: fix qemu-img map and qemu-img convert
   vvfat: replace tabs by 8 spaces
   vvfat: fix typos
   vvfat: rename useless enumeration values
   vvfat: add constants for special values of name[0]
   vvfat: introduce offset_to_bootsector, offset_to_fat and
     offset_to_root_dir
   vvfat: fix field names in FAT12/FAT16 and FAT32 boot sectors
   vvfat: always create . and .. entries at first and in that order
   vvfat: correctly create long names for non-ASCII filenames
   vvfat: correctly create base short names for non-ASCII filenames
   vvfat: correctly generate numeric-tail of short file names
   vvfat: correctly parse non-ASCII short and long file names
   vvfat: limit number of entries in root directory in FAT12/FAT16
   vvfat: handle KANJI lead byte 0xe5
   vvfat: change OEM name to 'MSWIN4.1'
   vvfat: initialize memory after allocating it

Should I rebase on top of your branch, or should I send the v3 as is?

It fixes the last random errors I had in Win9x Scandisk (uninitialized me=
mory).

Regards,

Herv=E9

Le 03/07/2017 =E0 18:50, Kevin Wolf a =E9crit :
> Am 22.05.2017 um 23:11 hat Herv=E9 Poussineau geschrieben:
>> Hi,
>>
>> This patchset fixes some of issues I encountered when trying to use vv=
fat, and fixes
>> bug #1599539: https://bugs.launchpad.net/qemu/+bug/1599539
>>
>> Patch 1 fixes a crash when using 'qemu-img convert'.
>> Patches 2 to 6 are code cleanup. No functionnal changes.
>> Patches 7 to 13 fix problems detected by disk checking utilities in re=
ad-only mode.
>>
>> With these patches, vvfat creates valid FAT volumes and can be used wi=
th QEMU disk utilities.
>>
>> Read-write mode is still buggy after this patchset, but at least, I wa=
s not
>> able to crash QEMU anymore.
>>
>> Note that patch 2 doesn't pass checkpatch.pl, as it changes indentatio=
n only.
>
> Thanks, fixed the build error in patch 9 (yet unused variables) and
> applied to the block branch.
>
> There were a few more minor comments for this series, but it has been o=
n
> the list for long enough and I figured that they can be addressed on
> top.
>
> Kevin
>
