Received: from eggs.gnu.org ([2001:4830:134:3::10]:49018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1csZwJ-0005RX-0T
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1csZwF-0007sF-0R
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:04:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1csZwE-0007qE-RC
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:04:22 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 529754E024
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 19:04:20 +0000 (UTC)
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
	<4a56f716-3528-ddd4-f8c4-f3f6b23c469a@redhat.com>
	<bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <fddf5055-c458-3893-9a18-5b0701e5431a@redhat.com>
Date: Mon, 27 Mar 2017 15:04:18 -0400
MIME-Version: 1.0
In-Reply-To: <bbc2671a-42dd-aa2a-0f03-6a4a487cb8f5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org



On 03/27/2017 04:06 AM, Thomas Huth wrote:
> On 24.03.2017 23:10, John Snow wrote:
>>
>>
>> On 03/08/2017 03:26 AM, Thomas Huth wrote:
>>>
>>>  Hi everybody,
>>>
>>> what will be the next version of QEMU after 2.9? Will we go for a 2.10
>>> (as I've seen it mentioned a couple of times on the mailing list
>>> already), or do we dare to switch to 3.0 instead?
>>>
>>> I personally dislike two-digit minor version numbers like 2.10 since the
>>> non-experienced users sometimes mix it up with 2.1 ... and there have
>>> been a couple of new cool features in the past releases that would
>>> justify a 3.0 now, too, I think.
>>>
>>> But anyway, the more important thing that keeps me concerned is: Someone
>>>  once told me that we should get rid of old parameters and interfaces
>>> (like HMP commands) primarily only when we're changing to a new major
>>> version number. As you all know, QEMU has a lot of legacy options, which
>>> are likely rather confusing than helpful for the new users nowadays,
>>> e.g. things like the "-net channel" option (which is fortunately even
>>> hardly documented), but maybe also even the whole vlan/hub concept in
>>> the net code, or legacy parameters like "-usbdevice". If we switch to
>>> version 3.0, could we agree to remove at least some of them?
>>>
>>>  Thomas
>>>
>>
>> As others have stated, we need a few releases to deprecate things first.
>>
>> Maybe we should develop a serious plan to develop some of our legacy
>> interfaces first.
>>
>> Maybe 2.10 can introduce a list of things we want to deprecate,
>> 2.11 can be the transition release,
>> and then 3.0 can cut the cord and free of us our terrible burden?
>>
>> I have a list of things I want to axe...
> 
> I've started a Wiki page with such a list here:
> 
> http://wiki.qemu-project.org/Features/LegacyRemoval
> 
> Feel free to amend!
> 

Absolutely!

>  Thomas
> 

Should we make an effort to print warnings for any of these items in the
list for 2.10 that they may disappear for 3.0?

It'd be nice to turn this wiki list into something that we're actually
definitely going to do.

--js
