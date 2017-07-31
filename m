Received: from eggs.gnu.org ([2001:4830:134:3::10]:60764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dcFoq-0006FP-KF
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dcFol-00020J-Pl
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:53:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54050)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1dcFol-0001zy-GG
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 14:53:27 -0400
References: <374E3394-46D9-4459-AE2E-059F8EEC7406@gmail.com>
	<c76ef5de-81a5-a98e-d598-161694248788@redhat.com>
	<776EE91A-4857-4484-AAC1-3C5D67BA77F7@gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <61a8c718-d211-cc92-f1ef-fc3cfe6d2c70@redhat.com>
Date: Mon, 31 Jul 2017 14:53:25 -0400
MIME-Version: 1.0
In-Reply-To: <776EE91A-4857-4484-AAC1-3C5D67BA77F7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Call for testers for various versions of Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>



On 07/31/2017 02:05 PM, Programmingkid wrote:
> 
>> On Jul 31, 2017, at 2:03 PM, John Snow <jsnow@redhat.com> wrote:
>>
>>
>>
>> On 07/28/2017 03:45 PM, Programmingkid wrote:
>>> I have made a page that keeps track of anyone who wishes to be a tester for a particular version of Windows. Here is the page: http://wiki.qemu.org/Testing/Windows
>>>
>>
>> I think for this to be successful, you'd have to define exactly what the
>> required testing *is*.
>>
>> Are these simple installation smoketests? Installation and boot? How big
>> is the test matrix? What is considered a pass and what is not? Across
>> which machine types and which architectures?
>>
>> etc.
>>
>>> If there is a version of Window you would like to help test in QEMU, please contact me with the email address you wish to use and the version of Windows you wish to support. Your information will be added to this list. With this list someone who makes a patch may need your help ensuring the patch is compatible with your supported version of Windows. 
>>>
>>> Here are all the versions of Windows I have up so far:
>>>
>>> Windows 3.1
>>> Windows NT 3.1
>>> Windows NT 3.5
>>> Windows 95
>>> Windows NT 4.0
>>> Windows 98
>>> Windows ME
>>> Windows 2000
>>> Windows XP
>>> Windows Vista
>>> Windows 7
>>> Windows 8
>>> Windows 10
>>> ReactOS
>>>
>>
>> There's probably people willing to at least do boot tests for some of
>> these, but I doubt there's much interest in doing anything more rigorous
>> than that.
> 
> Ok. I could add something like this:
> 
> Testing could include these categories:
> - Booting
> - Networking
> - USB
> - IDE/ATA
> - Video
> - Sound
> - Input Devices
> 

These are areas of testing, but they are not themselves tests. You ought
to define fairly rigidly what counts as a test, and what is required to
pass. This way, when someone volunteers to "Test Windows 3.1," we'll
know exactly what it means if it is "passing".

"Installation Test" should be fairly obvious, but should probably
include a reference configuration that we expect the given OS to boot on
(e.g., Q35 not working for Windows 3.11 is not a problem.) Expecting
people to test a large number of configurations is likely a non-starter.

For simple installation/smoke tests, the architectures involved probably
do not matter terribly much; but we should probably say that the target
binary to test here is either i386 or x86_64 or both, and the host
machine should be any x86 machine.

"Boot Test" should also be fairly simple; boot an existing image and
confirm that process works, but we should take care to define the same
criteria as above (which binaries? which boards? which devices? ETC)

"Networking" starts to need to get into more specifics. Which network
device will we test for each OS? We only expect certain ones to work, of
course. Some OSes may not have networking applications readily
available. (Windows 3.11?)

"USB" should test what, exactly? And there may not be USB drivers
readily available for many of the pre-XP OSes here.

"Video" -- I assume this can be confirmed by the installation test.

IDE/ATA: Probably covered by installation for at least the earlier
Windows OSes, but that may not cover all of the interesting/unusual
cases that can arise. If corner cases are known they should be specified.

Etc etc etc...

> 
> Thank you for the input.
> 
