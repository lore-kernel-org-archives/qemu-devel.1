Received: from eggs.gnu.org ([2001:4830:134:3::10]:59370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cgvjH-0001F8-4a
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1cgvjE-0005Vy-0u
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:54:51 -0500
Received: from mail-it0-x242.google.com ([2607:f8b0:4001:c0b::242]:36450)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1cgvjD-0005Tr-Qg
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 10:54:47 -0500
Received: by mail-it0-x242.google.com with SMTP id w185so616842ita.3
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 07:54:46 -0800 (PST)
In-Reply-To: <20170223140944.GK2449@lianli.shorne-pla.net>
References: <mailman.51026.1486615955.22738.qemu-devel@nongnu.org>
	<8C14E9D0-F376-4CDC-BF24-A0609A329977@gmail.com>
	<20170210003916.GL32144@lianli.shorne-pla.net>
	<ec491d8c-3fb0-3ce9-5558-ac4ab1455f7f@twiddle.net>
	<4BE06A79-02EC-48A8-8081-F21CEACE396F@gmail.com>
	<20170223140944.GK2449@lianli.shorne-pla.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C90ADBA7-AAB2-4392-8C64-3BB12545AE2F@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Thu, 23 Feb 2017 10:54:43 -0500
Subject: Re: [Qemu-devel] [PATCH 00/22] target/openrisc updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>, Openrisc <openrisc@lists.librecores.org>, qemu-devel qemu-devel <qemu-devel@nongnu.org>


On Feb 23, 2017, at 9:09 AM, Stafford Horne wrote:

> On Mon, Feb 13, 2017 at 10:33:09PM -0500, Programmingkid wrote:
>>
>> On Feb 13, 2017, at 10:25 PM, Richard Henderson wrote:
>>
>>> On 02/10/2017 11:39 AM, Stafford Horne wrote:
>>>> On Thu, Feb 09, 2017 at 09:10:51AM -0500, G 3 wrote:
>>>>>
>>>>> On Feb 8, 2017, at 11:52 PM, qemu-devel-request@nongnu.org wrote:
>>>>>
>>>>>> Message: 6
>>>>>> Date: Wed,  8 Feb 2017 20:51:32 -0800
>>>>>> From: Richard Henderson <rth@twiddle.net>
>>>>>> To: qemu-devel@nongnu.org
>>>>>> Cc: shorne@gmail.com
>>>>>> Subject: [Qemu-devel] [PATCH 00/22] target/openrisc updates
>>>>>> Message-ID: <20170209045154.16868-1-rth@twiddle.net>
>>>>>>
>>>>>> The bulk of this patch set is 2-3 years old, and was mostly
>>>>>> reviewed by Bastian Koppelmann.  But it languished because
>>>>>> there were reports of it not booting kernel images, and I
>>>>>> had problems putting together a set of tools that could even
>>>>>> build a kernel.
>>>>>>
>>>>>> The OpenRISC community has picked up activity recently,
>>>>>> with Stafford Horne upstreaming some of the compiler tools.
>>>>>> He has even done some testing for me of this patch set.
>>>>>>
>>>>>>
>>>>>> r~
>>>>>
>>>>> I see you are working on OpenRISC. Would you be able to help
>>>>> me improve its wiki page?
>>>>>
>>>>> http://wiki.qemu-project.org/Documentation/Platforms/OpenRISC
>>>>>
>>>>> Right now there isn't much information on OpenRISC here. I'm
>>>>> hoping to make it a lot useful to anyone who is interesting in  
>>>>> this
>>>>> platform.
>>>>>
>>>>> Would you know of any links to software that works in OpenRISC?
>>>>>
>>>>> Pictures of the OpenRISC target running anything would be great  
>>>>> also.
>>>>>
>>>>> What is your suggested command-line for using OpenRISC?
>>>>>
>>>>> If you have any suggestions on how to improve the page place don't
>>>>> hesitate to let me know.
>>>>>
>>>>
>>>> Hi Richard, G 3,
>>>>
>>>> I am not sure if Richard has the time for this.  But I kind of  
>>>> got him
>>>> started back on the openrisc work, it would be my fault to  
>>>> burden him
>>>> with even more work :).  Also, I was helping to do some tests so  
>>>> I have
>>>> some example commands.
>>>
>>> :-)
>>>
>>>> I don't have a lot of time, but I think I can help to update the  
>>>> above.
>>>> Probably Richard and I could work together?
>>>>
>>>> I was recently working on updating the openrisc page
>>>>
>>>>  http://openrisc.io
>>>>
>>>> I think I could link between the two for toolchain compile  
>>>> guides and
>>>> software guides (i.e. debugging and linux).
>>>>
>>>> Richard what do you think?
>>>
>>> Probably the most beneficial thing that we can do is create a  
>>> kernel+initrd that boots into a busybox root shell.  Similar to  
>>> the other test images that we have at
>>>
>>>  http://wiki.qemu-project.org/Testing/System_Images
>>>
>>>
>>> r~
>>>
>>
>> We could do both the test image and a wiki page.
>
> I posted a test image to the wiki
>
>  http://wiki.qemu-project.org/Testing/System_Images
>
> However, someone on the #qemu irc room mentioned its not ideal to post
> any images on the wiki and existing images should be taken down due to
> copyright issues.  I don't quite follow, should we be concerned?

If this is a Linux test image, it should be fine. Could we add a link  
to the test image to the wiki page?

>
> Also, I did start adding some commands to the wiki, any feedback
> appreciated.
>
>   http://wiki.qemu-project.org/Documentation/Platforms/OpenRISC
>
> -Stafford

Thank you so much for all your work. The wiki page looks great. For  
the maintainer, is Jia Liu still maintaining it? I never received a  
reply from him.  Would you be interested in being a maintainer?

This line in the wiki doesn't sound right:
"To get good traces you can also add the following, this will output  
trace info the a file z"

Maybe this:
"To get good traces you can also add the following, this will output  
trace info to the file z"

If z is a file, I really suggest renaming it to something more  
descriptive.

Thank you.
