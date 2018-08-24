Received: from eggs.gnu.org ([2001:4830:134:3::10]:49934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ft4Hj-0000Ut-O7
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 01:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ft4Hg-0000b5-Gl
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 01:05:23 -0400
References: <1528867465-26696-1-git-send-email-thuth@redhat.com>
	<5f7eaa02-8dc6-9d61-0a30-62d632f6cda3@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5ead6e54-cbe5-7b4a-473d-2d3c49df0e89@redhat.com>
Date: Fri, 24 Aug 2018 07:05:15 +0200
MIME-Version: 1.0
In-Reply-To: <5f7eaa02-8dc6-9d61-0a30-62d632f6cda3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] trivial: Make bios files and source files
 non-executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

On 2018-06-13 12:34, David Hildenbrand wrote:
> On 13.06.2018 07:24, Thomas Huth wrote:
>> These files can not be executed on the host, so they should not be
>> marked as executable.
> 
> Or can not be executed at all :)
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>
> 
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  block/blkreplay.c                  |   0
>>  pc-bios/hppa-firmware.img          | Bin
>>  pc-bios/palcode-clipper            | Bin
>>  pc-bios/u-boot-sam460-20100605.bin | Bin
>>  pc-bios/u-boot.e500                | Bin
>>  replay/replay-char.c               |   0
>>  6 files changed, 0 insertions(+), 0 deletions(-)
>>  mode change 100755 => 100644 block/blkreplay.c
>>  mode change 100755 => 100644 pc-bios/hppa-firmware.img
>>  mode change 100755 => 100644 pc-bios/palcode-clipper
>>  mode change 100755 => 100644 pc-bios/u-boot-sam460-20100605.bin
>>  mode change 100755 => 100644 pc-bios/u-boot.e500
>>  mode change 100755 => 100644 replay/replay-char.c
>>
>> diff --git a/block/blkreplay.c b/block/blkreplay.c
>> old mode 100755
>> new mode 100644
>> diff --git a/pc-bios/hppa-firmware.img b/pc-bios/hppa-firmware.img
>> old mode 100755
>> new mode 100644
>> diff --git a/pc-bios/palcode-clipper b/pc-bios/palcode-clipper
>> old mode 100755
>> new mode 100644
>> diff --git a/pc-bios/u-boot-sam460-20100605.bin b/pc-bios/u-boot-sam460-20100605.bin
>> old mode 100755
>> new mode 100644
>> diff --git a/pc-bios/u-boot.e500 b/pc-bios/u-boot.e500
>> old mode 100755
>> new mode 100644
>> diff --git a/replay/replay-char.c b/replay/replay-char.c
>> old mode 100755
>> new mode 100644

Ping?

 Thomas
