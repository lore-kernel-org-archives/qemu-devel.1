Received: from eggs.gnu.org ([209.51.188.92]:54499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj1KX-0004Hp-Sb
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:27:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj1KW-0004WU-IE
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:27:01 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gj1KW-0004Vr-Bk
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:27:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so22567355wrt.13
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 04:26:59 -0800 (PST)
References: <20181213162727.17438-1-lvivier@redhat.com>
	<62bd556c-93e2-d5d0-117c-7e3b8a28ea1c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <246ba1a4-a6a3-128d-c535-75674c6f2911@redhat.com>
Date: Mon, 14 Jan 2019 13:26:57 +0100
MIME-Version: 1.0
In-Reply-To: <62bd556c-93e2-d5d0-117c-7e3b8a28ea1c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] block: Convert from DPRINTF() macro
 to trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Richard W.M. Jones" <rjones@redhat.com>, Liu Yuan <namei.unix@gmail.com>

On 1/14/19 1:14 PM, Max Reitz wrote:
> On 13.12.18 17:27, Laurent Vivier wrote:
>> Convert all the remaining uses of DPRINTF() in the directory block.
>>
>> Compiled for all target but only tested with "make check"
>>
>> v2: replace "sd_" prefix by "sheepdog_"
>>     remove the dot at the end of the text strings
>>     use %zu with size_t
>>     change an uint64_t to int64_t to match % PRIi64
>>
>> Laurent Vivier (4):
>>   block/ssh: Convert from DPRINTF() macro to trace events
>>   block/curl: Convert from DPRINTF() macro to trace events
>>   block/file-posix: Convert from DPRINTF() macro to trace events
>>   block/sheepdog: Convert from DPRINTF() macro to trace events
> 
> Applied to my block branch, with three fixes (Philippe asked me to do
> one, so what are two more O:-)):
> - Patch 1: Fixed ssh_{read,write}_return's @ret sign
> - Patch 3: Moved the pointer asterisk in file_xfs_discard from type to name
> - Patch 4: Fixed sheepdog_snapshot_create_inode's format string to use
> PRIx32 instead of %x for uint32_ts

Thank you Max!

> 
> (https://git.xanclic.moe/XanClic/qemu/commits/branch/block)
> 
> Thanks!
> 
> Max
> 
