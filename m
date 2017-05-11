Received: from eggs.gnu.org ([2001:4830:134:3::10]:46356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d8pQr-0001Db-DT
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:51:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d8pQq-00017R-Hp
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:51:09 -0400
References: <20170509180946.17046-1-jsnow@redhat.com>
	<20170511093739.GB4235@noname.str.redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cf68e3b7-85aa-5ee7-118a-c885d3de4115@redhat.com>
Date: Thu, 11 May 2017 10:51:00 -0400
MIME-Version: 1.0
In-Reply-To: <20170511093739.GB4235@noname.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: Check for backing image if
 specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com



On 05/11/2017 05:37 AM, Kevin Wolf wrote:
> Am 09.05.2017 um 20:09 hat John Snow geschrieben:
>> Or, rather, force the open of a backing image if one was specified
>> for creation. Using a similar -unsafe option as rebase, allow qemu-img
>> to ignore the backing file validation if possible.
>>
>> It may not always be possible, as in the existing case when a filesize
>> for the new image was not specified.
>>
>> This is accomplished by shifting around the conditionals in
>> bdrv_img_create, such that a backing file is always opened unless we
>> provide BDRV_O_NO_BACKING. qemu-img is adjusted to pass this new flag
>> when -u is provided to create.
>>
>> Sorry for the heinous looking diffstat, but it's mostly whitespace.
>>
>> Inspired by: https://bugzilla.redhat.com/show_bug.cgi?id=1213786
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> The idea makes sense to me, but the patch needs a rebase.
> 
> Kevin
> 

Already, again? Alright, coming up.
