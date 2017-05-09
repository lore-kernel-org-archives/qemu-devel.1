Received: from eggs.gnu.org ([2001:4830:134:3::10]:58134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d89lC-0002AS-1f
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d89lB-0002Zz-4c
	for qemu-devel@nongnu.org; Tue, 09 May 2017 14:21:22 -0400
References: <20170509180946.17046-1-jsnow@redhat.com>
	<0a25ed7b-174f-1860-cef4-d141b5de3d64@redhat.com>
	<09281d7d-82f1-fdd8-5f03-669f13b2f09d@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a52155cb-bba7-96ad-9735-a952a3a25d46@redhat.com>
Date: Tue, 9 May 2017 14:21:12 -0400
MIME-Version: 1.0
In-Reply-To: <09281d7d-82f1-fdd8-5f03-669f13b2f09d@redhat.com>
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
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com



On 05/09/2017 02:19 PM, Eric Blake wrote:
> On 05/09/2017 01:17 PM, Eric Blake wrote:
>> On 05/09/2017 01:09 PM, John Snow wrote:
>>> Or, rather, force the open of a backing image if one was specified
>>> for creation. Using a similar -unsafe option as rebase, allow qemu-img
>>> to ignore the backing file validation if possible.
>>>
> 
>>> +++ b/qemu-img.c
>>> @@ -145,9 +145,11 @@ static void QEMU_NORETURN help(void)
>>>             "  'snapshot_id_or_name' is deprecated, use 'snapshot_param'\n"
>>>             "    instead\n"
>>>             "  '-c' indicates that target image must be compressed (qcow format only)\n"
>>> -           "  '-u' enables unsafe rebasing. It is assumed that old and new backing file\n"
>>> -           "       match exactly. The image doesn't need a working backing file before\n"
>>> -           "       rebasing in this case (useful for renaming the backing file)\n"
>>> +           "  '-u' allows unsafe backing chains. For rebasing, it is assumed that old and new\n"
>>> +           "       backing file match exactly. The image doesn't need a working backing file\n"
>>> +           "       before rebasing in this case (useful for renaming the backing file)\n"
> 
> Also, a '.' to end this sentence would be nice.
> 

d'oh.

I can respin if that's more convenient, as I am assuming Max or Kevin
will have something to say.

If not, either edit it if that's easier, or ask me to re-spin.

>>> +           "       For image creation, allow creating without attempting to"
>>
>> Missing \n
>>
>> With that fixed,
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
> 
