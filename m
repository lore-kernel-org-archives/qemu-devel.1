Received: from eggs.gnu.org ([2001:4830:134:3::10]:35268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpSLY-0005Kp-9o
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 00:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dpSLV-0003CW-7R
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 00:53:52 -0400
References: <1504605227-5124-1-git-send-email-thuth@redhat.com>
	<871snlwev0.fsf@dusky.pond.sub.org> <20170905164835.GF2112@work-vm>
	<6e03aa82-3663-c251-c8e1-ac2e7eb0e7e7@redhat.com>
	<20170905183716.GH2112@work-vm>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7fd704ae-81c5-dc9b-33f0-fc640399dbf8@redhat.com>
Date: Wed, 6 Sep 2017 06:53:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170905183716.GH2112@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH] tests: Add a device_add/del
 HMP test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>

On 05.09.2017 20:37, Dr. David Alan Gilbert wrote:
> * Thomas Huth (thuth@redhat.com) wrote:
>> On 05.09.2017 18:48, Dr. David Alan Gilbert wrote:
>>> * Markus Armbruster (armbru@redhat.com) wrote:
>>>> Thomas Huth <thuth@redhat.com> writes:
>>>>
>>>>> People tend to forget to mark internal devices with "user_creatable = false
>>>>> or hotpluggable = false, and these devices can crash QEMU if added via the
>>>>> HMP monitor. So let's add a test to run through all devices and that tries
>>>>> to add them blindly (without arguments) to see whether this could crash the
>>>>> QEMU instance.
>>>>>
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
[...]
>>> If I'm reading the code right it's creating the device with the same
>>> name as the device;  I wonder if that always works?
>>
>> Why not? The id is just an arbitrary string, isn't it?
> 
> I didn't know how arbitrary they were allowed to be and I was
> also worried they might clash with some existing id.
> As an example, I see there's at least one device (SUNW,fdtwo) with
> a , in it's name - is that legal for an id ?

Oh, right, I didn't think of comma :-/ ... I'll try to come up with a
better solution in the next version of the patch...

 Thomas
