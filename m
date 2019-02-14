Received: from eggs.gnu.org ([209.51.188.92]:45960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1guCkW-0001Om-UA
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1guCkW-0003cV-05
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:52:04 -0500
Date: Thu, 14 Feb 2019 16:51:33 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190214085133.GA20720@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190212052224.GA4839@richard>
	<20190212003414-mutt-send-email-mst@kernel.org>
	<4d6f639b-fe11-7048-3975-ee1c1875b8d3@vivier.eu>
	<3d700eed-5637-b05a-63c2-9f73a465bcb5@redhat.com>
	<af33ffd7-a134-4d61-40ee-b128f5104153@vivier.eu>
	<20190214000317.GA19899@richard>
	<3dd545f2-5346-2b01-8725-5f35cbaa0ae5@vivier.eu>
	<d69dd1c9-aa58-4b03-6b9c-1cde7bed83cb@vivier.eu>
	<20190214081828.GA19789@richard>
	<33fc1da2-144b-22b5-bcb1-f85fab64b623@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33fc1da2-144b-22b5-bcb1-f85fab64b623@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Trivial cleanup in hw/acpi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Wei Yang <richardw.yang@linux.intel.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, imammedo@redhat.com

On Thu, Feb 14, 2019 at 09:23:39AM +0100, Laurent Vivier wrote:
>On 14/02/2019 09:18, Wei Yang wrote:
>> On Thu, Feb 14, 2019 at 09:10:14AM +0100, Laurent Vivier wrote:
>>> On 14/02/2019 08:57, Laurent Vivier wrote:
>>>> On 14/02/2019 01:03, Wei Yang wrote:
>>>>> On Wed, Feb 13, 2019 at 02:45:01PM +0100, Laurent Vivier wrote:
>>>>>> On 13/02/2019 09:56, Philippe Mathieu-Daudé wrote:
>>>>>>> Hi Laurent,
>>>>>>>
>>>>>>> On 2/13/19 9:49 AM, Laurent Vivier wrote:
>>>>>>>> On 12/02/2019 06:34, Michael S. Tsirkin wrote:
>>>>>>>>> On Tue, Feb 12, 2019 at 01:22:24PM +0800, Wei Yang wrote:
>>>>>>>>>> On Wed, Jan 30, 2019 at 08:06:50AM +0800, Wei Yang wrote:
>>>>>>>>>>> There are several functions/variable which are not used anymore.
>>>>>>>>>>>
>>>>>>>>>>> This serials just remove those without functional change.
>>>>>>>>>>>
>>>>>>>>>>> v3: add ack and repost in a new thread
>>>>>>>>>>> v2: change commit log from "is now used in no place" to "in not used anymore"
>>>>>>>>>>
>>>>>>>>>> Michael,
>>>>>>>>>>
>>>>>>>>>> Looks this serials is not merged yet.
>>>>>>>>>>
>>>>>>>>>> Is there any problem I need to fix?
>>>>>>>>>
>>>>>>>>> Yes pls repost with fixed reviewed-by tags.
>>>>>>>>
>>>>>>>> Or I can take the series through the trivial branch and update manually
>>>>>>>> Philippe's lastname?
>>>>>>>
>>>>>>> I appreciate the help with manual update, however Wei is not the only
>>>>>>> one having this problem (other developpers has non-ASCII in their name,
>>>>>>> and use such tags).
>>>>>>> I'd rather prefer we find a proper configuration setup to help the
>>>>>>> community.
>>>>>>
>>>>>> I'm wondering if it can be a problem with cut'n'paste rather than with
>>>>>> git-sendemail.
>>>>>>
>>>>>> I think the following tags should cover Latin and Chinese characters:
>>>>>>
>>>>>> Content-Type: text/plain; charset=UTF-8
>>>>>> Content-Transfer-Encoding: 8bit
>>>>>>
>>>>>
>>>>> Looks not work.
>>>>>
>>>>> I have tried this and also with 
>>>>>
>>>>> Content-Language: en-US
>>>>
>>>> Could  you send me a gzipped version of the 0001-XXX.patch in attachment
>>>> so I could see the real content before git-send-email?
>>>
>>> OK, I've got it.
>>>
>>> What I see is it is already corrupted, thus the problem is not with
>>> git-send-email.
>>>
>>> So either it is corrupted by git-format-patch (which is very unlikely,
>>> we could see that if you push it to a public git repo) or it has been
>>> corrupted when you have added it to the commit message.
>>>
>> 
>> Hmm... maybe you are right.
>> 
>> But I found confused how to fix this.
>> 
>> When I use git commit --amend to fix it, the character looks good in my
>> editor. I use vim as my git editor.
>> 
>> But when I use git show, it display an unknown character.
>> 
>> And if I use git format-patch, the patch file looks good in my vim editor. But
>> corrupted if I use another editor.
>> 
>> Do you have any idea on this?
>
>What is the result of command "locale" in your terminal?
>How do you copy the characters to vim?
>

Hi, Laurent

I tried to copied the character directly from Philippe's mail.

This time looks good from my mutt client. Hope it works for you.

Thanks!

>Thanks,
>Laurent

-- 
Wei Yang
Help you, Help me
