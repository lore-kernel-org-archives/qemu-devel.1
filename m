Received: from eggs.gnu.org ([2001:4830:134:3::10]:43436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chDoU-0000Ad-Kg
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:13:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1chDoP-0007nh-L0
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:13:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1chDoP-0007mq-Ez
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 06:13:21 -0500
References: <20170220141943.8426-1-cornelia.huck@de.ibm.com>
	<20170220141943.8426-2-cornelia.huck@de.ibm.com>
	<967f7397-9995-0d24-bf35-682da2c732ff@redhat.com>
	<48b23a4f-ebd3-2306-ea0f-75b713817440@de.ibm.com>
	<aade1638-9dd8-98e7-bf40-f12ab9322da6@redhat.com>
	<3c9ae0ce-c4b8-6061-c68d-4aa72a56bccd@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <da29b247-d13c-4de4-d458-1c3b15ff420e@redhat.com>
Date: Fri, 24 Feb 2017 12:13:17 +0100
MIME-Version: 1.0
In-Reply-To: <3c9ae0ce-c4b8-6061-c68d-4aa72a56bccd@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] elf-loader: Allow late loading of elf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>

On 24.02.2017 12:09, Christian Borntraeger wrote:
> On 02/24/2017 11:44 AM, Thomas Huth wrote:
>> On 21.02.2017 11:23, Christian Borntraeger wrote:
>>> On 02/20/2017 04:33 PM, Thomas Huth wrote:
>>>> On 20.02.2017 15:19, Cornelia Huck wrote:
>>>>> From: Farhan Ali <alifm@linux.vnet.ibm.com>
>>>>>
>>>>> The current QEMU ROM infrastructure rejects late loading of ROMs.
>>>>> And ELFs are currently loaded as ROM, this prevents delayed loading
>>>>> of ELFs. So when loading ELF, allow the user to specify if ELF should
>>>>> be loaded as ROM or not.
>>>>>
>>>>> If an ELF is not loaded as ROM, then they are not restored on a
>>>>> guest reboot/reset and so its upto the user to handle the reloading.
>>>>
>>>> Could you maybe also explain here why you need such a delayed ELF
>>>> loading? Why can't you load the s390-netboot.img at the same time as
>>>> s390-ccw.img?
>>>
>>> Please read the cover letter for some details how to build such a netrom.
>>
>> Sure, understood, but I still did not see an explanation why this can't
>> be loaded as "ROM", too / why it needs to be loaded "delayed"? Does the
>> image data need to be writable in memory? Or is the information not
>> available yet at that point in time, whether the user wants to do a
>> network boot or not? Don't get me wrong, I'm basically fine with this
>> patch, I'm just missing some explanation *why* you have to do it this way.
> 
> As I already wrote, the rom will be big. kernel + ramdisk will take easily
> 10-30Mbytes. This is loaded twice (in the rom as data and into the guest)
> So this will waste lets say 60Mbyte per guest for nothing.

OK, now that's a proper explanation, thanks! ... it would maybe be
helpful for future reviewers to include such a proper statement in the
patch description (or cover letter), too.

 Thomas
