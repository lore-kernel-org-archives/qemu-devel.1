Received: from eggs.gnu.org ([2001:4830:134:3::10]:48260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXMuq-0005OX-99
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:32:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXMup-00069V-Go
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:32:04 -0400
From: Thomas Huth <thuth@redhat.com>
References: <1529056145-6404-1-git-send-email-thuth@redhat.com>
Message-ID: <93f1dae5-e071-41f2-a1b7-1fbfdbe7917a@redhat.com>
Date: Mon, 25 Jun 2018 10:31:52 +0200
MIME-Version: 1.0
In-Reply-To: <1529056145-6404-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] loader: Check access size when calling
 rom_ptr() to avoid crashes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>Paolo Bonzini <pbonzini@redhat.com>

On 15.06.2018 11:49, Thomas Huth wrote:
> The rom_ptr() function allows direct access to the ROM blobs that we
> load during startup. However, there are currently no checks for the
> size of the accesses, so it's currently possible to crash QEMU for
> example with:
> 
> $ echo "Insane in the mainframe" > /tmp/test.txt
> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -append xyz
> Segmentation fault (core dumped)
> $ s390x-softmmu/qemu-system-s390x -kernel /tmp/test.txt -initrd /tmp/test.txt
> Segmentation fault (core dumped)
> $ echo -n HdrS > /tmp/hdr.txt
> $ sparc64-softmmu/qemu-system-sparc64 -kernel /tmp/hdr.txt -initrd /tmp/hdr.txt
> Segmentation fault (core dumped)
> 
> We need a possibility to check the size of the ROM area that we want
> to access, thus let's add a size parameter to the rom_ptr() function
> to avoid these problems.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Ping!

Could anybody please pick this patch up? Qemu-trivial seems to be pretty
dormant these days (?), so maybe Paolo via misc? Or either the s390x or
Sparc tree, since it fixes a crash on these machines?

 Thanks,
  Thomas
