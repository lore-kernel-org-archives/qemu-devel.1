Received: from eggs.gnu.org ([2001:4830:134:3::10]:60462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXjkt-00030Z-PZ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXjks-0006fj-Tl
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:55:19 -0400
References: <1529056145-6404-1-git-send-email-thuth@redhat.com>
	<20180626104001.617d4ea9.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <79c0775f-49b5-1d79-a4f9-234941854e4f@redhat.com>
Date: Tue, 26 Jun 2018 10:55:09 +0200
MIME-Version: 1.0
In-Reply-To: <20180626104001.617d4ea9.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3] loader: Check access size
 when calling rom_ptr() to avoid crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On 26.06.2018 10:40, Cornelia Huck wrote:
> On Fri, 15 Jun 2018 11:49:05 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> The rom_ptr() function allows direct access to the ROM blobs that we
>> load during startup. However, there are currently no checks for the
>> size of the accesses, so it's currently possible to crash QEMU for
>> example with:
>>
>> $ echo "Insane in the mainframe" > /tmp/test.txt
>> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -append xyz
>> Segmentation fault (core dumped)
>> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -initrd /tmp/test.txt
>> Segmentation fault (core dumped)
>> $ echo -n HdrS > /tmp/hdr.txt
>> $ sparc64-softmmu/qemu-system-sparc64 -kernel /tmp/hdr.txt -initrd /tmp/hdr.txt
>> Segmentation fault (core dumped)
>>
>> We need a possibility to check the size of the ROM area that we want
>> to access, thus let's add a size parameter to the rom_ptr() function
>> to avoid these problems.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Grmpf, this conflicts with "s390/ipl: fix ipl with -no-reboot" in
> s390-next... do you want to rebase it?

Really? Where is the conflict? I can rebase my patch to your s390-next
branch, but the patch looks identical after that rebase. As far as I can
see, the patches only change different parts of the ipl.c file.

 Thomas
