Received: from eggs.gnu.org ([2001:4830:134:3::10]:47512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d8sVz-0005sT-6N
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d8sVy-0005MR-6f
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:08:39 -0400
References: <20170511151126.20323-1-jsnow@redhat.com>
	<cf739d3c-522a-6cac-a672-752a6efecca7@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e10cb92a-4971-c216-2fc2-4267e83d92c4@redhat.com>
Date: Thu, 11 May 2017 14:08:23 -0400
MIME-Version: 1.0
In-Reply-To: <cf739d3c-522a-6cac-a672-752a6efecca7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] qemu-img: Check for backing image if
 specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com



On 05/11/2017 11:17 AM, Eric Blake wrote:
> On 05/11/2017 10:11 AM, John Snow wrote:
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
>> ---
>> v3: Rebased
>>
> 
>> +++ b/qemu-img.c
>> @@ -145,9 +145,11 @@ static void QEMU_NORETURN help(void)
>>             "  'snapshot_id_or_name' is deprecated, use 'snapshot_param'\n"
>>             "    instead\n"
>>             "  '-c' indicates that target image must be compressed (qcow format only)\n"
>> -           "  '-u' enables unsafe rebasing. It is assumed that old and new backing file\n"
>> -           "       match exactly. The image doesn't need a working backing file before\n"
>> -           "       rebasing in this case (useful for renaming the backing file)\n"
>> +           "  '-u' allows unsafe backing chains. For rebasing, it is assumed that old and new\n"
>> +           "       backing file match exactly. The image doesn't need a working backing file\n"
>> +           "       before rebasing in this case (useful for renaming the backing file)\n"
>> +           "       For image creation, allow creating without attempting to"
>> +           "       open the backing file.\n"
> 
> You forgot to fix my v2 review comments ('.', \n)
> 

%*(#$)@%

Stand by...
