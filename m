Received: from eggs.gnu.org ([2001:4830:134:3::10]:59765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1edouJ-0008Ts-UM
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1edouJ-0003ts-2T
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 22:05:55 -0500
References: <20180122072102.4141-1-lma@suse.com>
	<17afc198-ba65-e0b8-f568-34f5899e7477@redhat.com>
From: Lin Ma <lma@suse.com>
Message-ID: <afc7a0eb-d9ea-569d-804a-0c61f375089a@suse.com>
Date: Tue, 23 Jan 2018 11:05:07 +0800
MIME-Version: 1.0
In-Reply-To: <17afc198-ba65-e0b8-f568-34f5899e7477@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] raw: Disable probing if image format is
 given by driver-specific options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com


On 01/23/2018 12:45 AM, Max Reitz wrote:
> On 2018-01-22 08:21, Lin Ma wrote:
>> If the user specifies image format through driver-specific options, The
>> format probing should be prohibited and the warning message should not
>> be printed.
>>
>> e.g.:
>> $ qemu-system-x86_64 ... -drive file.file.filename=disk0.raw,file.driver=raw ...
>> WARNING: Image format was not specified for 'disk0.raw' and probing guessed raw.
>>           Automatically detecting the format is dangerous for raw images, ...
>>
>> Signed-off-by: Lin Ma <lma@suse.com>
>> ---
>>   blockdev.c | 2 ++
>>   1 file changed, 2 insertions(+)
> But what has been proped is the driver for the root BDS, so the warning
> is actually correct.
>
> (That command line is creating a chain of three BDS:
> raw (probed) -> raw (explicitly specified) -> file (default protocol))
>
> Max
>
OK, Thanks
Lin
