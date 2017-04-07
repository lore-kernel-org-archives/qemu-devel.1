Received: from eggs.gnu.org ([2001:4830:134:3::10]:59497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwbVy-00019Z-VJ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 17:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwbVu-0007GL-0K
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 17:33:55 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170322204844.446-1-f4bug@amsat.org>
	<20170322204844.446-2-f4bug@amsat.org>
	<87y3vw1o94.fsf@dusky.pond.sub.org>
	<1490255007.463.11.camel@redhat.com>
	<CAJ+F1CJNy+e83EHR_8uzAHURxDk6idnNTTL_FoD-krWPue7Lww@mail.gmail.com>
	<1490262680.463.27.camel@redhat.com>
	<87tw6ktban.fsf@dusky.pond.sub.org>
	<1490277406.13302.1.camel@redhat.com>
	<878tnwm6g7.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f5610e3c-116f-ae57-1e67-1fd930a59c4c@amsat.org>
Date: Fri, 7 Apr 2017 18:33:45 -0300
MIME-Version: 1.0
In-Reply-To: <878tnwm6g7.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND 1/3] usb-ccid: make
 ccid_write_data_block() cope with null buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>

Hi Markus, Gerd.

On 03/23/2017 11:08 AM, Markus Armbruster wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
>
>> On Do, 2017-03-23 at 13:41 +0100, Markus Armbruster wrote:
>>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>>
>>>>   Hi,
>>>>
>>>>>  oops, there are hard-coded calls with NULL/0. I suppose to fix clang
>>>>> warning, it would need to check if data != null for memcpy.
>>>>
>>>> I'd check for len > 0, and in that if branch we can also assert on data
>>>> == NULL and thereby check that len and data are consistent.
>>>
>>> If len is non-zero but data is null, memcpy() will crash just fine by
>>> itself, so why bother asserting.
>>
>> To make clang happy?  But maybe clang is clever enough to figure data
>> can't be null at that point in case we call memcpy with len != 0
>> only ...
>
> If Clang needs another hint to become happy, then an assertion is a fine
> way to provide it.

Apparently Clang isn't clever enough using an assertion.

I'll resend checking len.
