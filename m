Received: from eggs.gnu.org ([2001:4830:134:3::10]:54499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f35NH-0005i3-Fl
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 15:44:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f35NG-0000cD-FN
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 15:44:15 -0400
References: <1521178795-21894-1-git-send-email-thuth@redhat.com>
	<30a96f63-4cdf-23e6-c4d2-b4de59411a11@redhat.com>
	<2d69038f-f859-eb42-afb6-acde2e0c5182@redhat.com>
	<316190e9-552f-23c8-e9e6-2b24f708ae7c@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cb2451b1-fa49-cc6c-4398-5cf7e8963924@redhat.com>
Date: Mon, 2 Apr 2018 21:43:52 +0200
MIME-Version: 1.0
In-Reply-To: <316190e9-552f-23c8-e9e6-2b24f708ae7c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Add new CD-ROM related qtests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Victor Kaplansky <victork@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-s390x@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 02.04.2018 21:34, John Snow wrote:
> 
> 
> On 04/02/2018 02:39 PM, Thomas Huth wrote:
>> On 29.03.2018 20:28, John Snow wrote:
>>>
>>>
>>> On 03/16/2018 01:39 AM, Thomas Huth wrote:
>>>> With one of my clean-up patches (see commit 1454509726719e0933c800), I
>>>> recently accidentially broke the "-cdrom" parameter (more precisely
>>>> "-drive if=scsi") on a couple of boards, since there was no error
>>>> detected during the "make check" regression testing. This is clearly an
>>>> indication that we are lacking tests in this area.
>>>> So this small patch series now introduces some tests for CD-ROM drives:
>>>> The first two patches introduce the possibility to check that booting
>>>> from CD-ROM drives still works fine for x86 and s390x, and the third
>>>> patch adds a test that certain machines can at least still be started
>>>> with the "-cdrom" parameter (i.e. that test would have catched the
>>>> mistake that I did with my SCSI cleanup patch).
>>>>
>>>> v2:
>>>>  - Use g_spawn_sync() instead of execlp() to run genisoimage
>>>>  - The "-cdrom" parameter test is now run on all architectures (with
>>>>    machine "none" for the machines that are not explicitly checked)
>>>>  - Some rewordings and improved comments here and there
>>>>
>>>> Thomas Huth (3):
>>>>   tests/boot-sector: Add magic bytes to s390x boot code header
>>>>   tests/cdrom-test: Test booting from CD-ROM ISO image file
>>>>   tests/cdrom-test: Test that -cdrom parameter is working
>>>>
>>>>  tests/Makefile.include |   2 +
>>>>  tests/boot-sector.c    |   9 +-
>>>>  tests/cdrom-test.c     | 222 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  3 files changed, 230 insertions(+), 3 deletions(-)
>>>>  create mode 100644 tests/cdrom-test.c
>>>>
>>>
>>> New file, but no edit to MAINTAINERS.
>>
>> Which section do you suggest? It tests IDE CD-ROMs, SCSI CD-ROMs, and
>> even virtio-block (on s390x) ... so I have a hard time to decide where
>> this should belong to...
>>
>>  Thomas
>>
> 
> I was hoping you'd figure it out, but fine :D
> 
> You can stick it under my section if you want, but I'll probably defer
> to you if the s390x parts break.

Ok, thanks. But in the long run, we might even need a generic "QTESTS"
section in the MAINTAINERS file, since most of the qtests are currently
not listed there.
And while we're at it, we should maybe also move the qtests to a
separate folder tests/qtests/ or so, so that it is clearer which of the
tests is a qtest and which are something different.
I'll try to come up with some patches once the hard freeze is over...

 Thomas
