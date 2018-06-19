Received: from eggs.gnu.org ([2001:4830:134:3::10]:56197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLhX-0000vm-W4
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:50:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fVLhX-00027s-3K
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 14:50:00 -0400
References: <20180426025129.621969-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e00e94d-bd70-0c53-d0ed-33aa066e6cf3@redhat.com>
Date: Tue, 19 Jun 2018 13:49:54 -0500
MIME-Version: 1.0
In-Reply-To: <20180426025129.621969-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 0/6] minor qcow2 compression improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org, mreitz@redhat.com

ping

On 04/25/2018 09:51 PM, Eric Blake wrote:
> Even though v5 was posted earlier today, it was worth a respin:
> - 2/6: add R-b [Berto]
> - 4/6, 6/6: improve commit messages [Max]
> - 5/6: new patch, with an iotests proving that 4/6 is a bug fix [Max]
> 
> The new test is rather slow (nearly 90 seconds for me using
> tmpfs) unless it skips entirely (such as testing on ext4); ideas
> for speeding it up are welcome (translation: maybe qemu should
> optimize the search for the next available cluster to allocate,
> and/or qemu-img check should be faster at reporting leaked
> clusters)
> 
> 001/6:[----] [--] 'qcow2: Prefer byte-based calls into bs->file'
> 002/6:[----] [--] 'qcow2: Document some maximum size constraints'
> 003/6:[----] [--] 'qcow2: Reduce REFT_OFFSET_MASK'
> 004/6:[----] [--] 'qcow2: Don't allow overflow during cluster allocation'
> 005/6:[down] 'iotests: Add new test 214 for max compressed cluster offset'
> 006/6:[----] [--] 'qcow2: Avoid memory over-allocation on compressed images'
> 
> Eric Blake (6):
>    qcow2: Prefer byte-based calls into bs->file
>    qcow2: Document some maximum size constraints
>    qcow2: Reduce REFT_OFFSET_MASK
>    qcow2: Don't allow overflow during cluster allocation
>    iotests: Add new test 214 for max compressed cluster offset
>    qcow2: Avoid memory over-allocation on compressed images
> 
>   docs/interop/qcow2.txt     | 40 +++++++++++++++++--
>   block/qcow2.h              |  8 +++-
>   block/qcow2-cluster.c      | 32 +++++++++------
>   block/qcow2-refcount.c     | 27 ++++++++-----
>   block/qcow2.c              |  2 +-
>   tests/qemu-iotests/214     | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/214.out | 54 ++++++++++++++++++++++++++
>   tests/qemu-iotests/group   |  1 +
>   8 files changed, 234 insertions(+), 27 deletions(-)
>   create mode 100755 tests/qemu-iotests/214
>   create mode 100644 tests/qemu-iotests/214.out
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
