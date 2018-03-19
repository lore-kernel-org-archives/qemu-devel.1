Received: from eggs.gnu.org ([2001:4830:134:3::10]:44199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1exxVB-0000C4-Vo
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1exxVA-0002G4-Ug
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:19:13 -0400
References: <20180119224735.12169-1-jsnow@redhat.com>
	<086ccaa6-eefb-47e4-a865-78075ddd827d@redhat.com>
	<56b7204f-a0d8-3a4e-6e48-6913b1f52a5f@redhat.com>
	<20180319152932.GD30864@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <b37d73f9-04c0-08d0-8a9a-bc5d034f6cc5@redhat.com>
Date: Mon, 19 Mar 2018 12:18:55 -0400
MIME-Version: 1.0
In-Reply-To: <20180319152932.GD30864@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] file-posix: specify expected filetypes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org



On 03/19/2018 11:29 AM, Kevin Wolf wrote:
> Am 13.03.2018 um 18:20 hat John Snow geschrieben:
>>
>>
>> On 01/19/2018 06:03 PM, Eric Blake wrote:
>>> On 01/19/2018 04:47 PM, John Snow wrote:
>>>> Adjust each caller of raw_open_common to specify if they are expecting
>>>> host and character devices or not. Tighten expectations of file types upon
>>>> open in the common code and refuse types that are not expected.
>>>>
>>>> This has two effects:
>>>>
>>>> (1) Character and block devices are now considered deprecated for the
>>>>     'file' driver, which expects only S_IFREG, and
>>>> (2) no file-posix driver (file, host_cdrom, or host_device) can open
>>>>     directories now.
>>>>
>>>> I don't think there's a legitimate reason to open directories as if
>>>> they were files. This prevents QEMU from opening and attempting to probe
>>>> a directory inode, which can break in exciting ways. One of those ways
>>>> is lseek on ext4/xfs, which will return 0x7fffffffffffffff as the file
>>>> size instead of EISDIR. This can coax QEMU into responding with a
>>>> confusing "file too big" instead of "Hey, that's not a file".
>>>>
>>>> See: https://bugs.launchpad.net/qemu/+bug/1739304/
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Whoops, I let this one rot. It could still be considered a bugfix for
>> next week.
> 
> Yes, we should take this as a bugfix. Needs a rebase, though.
> 
> Kevin
> 

You got it.

--js
