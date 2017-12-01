Received: from eggs.gnu.org ([2001:4830:134:3::10]:56133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fweimer@redhat.com>) id 1eKnx3-0000cG-Fo
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:15:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fweimer@redhat.com>) id 1eKnw7-0001rS-EX
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:14:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:7645)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <fweimer@redhat.com>) id 1eKnw7-0001ml-1x
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:13:11 -0500
References: <87po7zrq65.fsf@fifthhorseman.net>
	<f5f44f70-d274-e7a6-618e-8906f58a9073@physik.fu-berlin.de>
	<861bc28d-4009-d35e-c03b-8ae7b0ca8680@redhat.com>
	<9608bcde-6bf8-dc36-a6b7-71cb8bc5c705@physik.fu-berlin.de>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <28e8704a-e0e6-aeb2-d636-2802b34f7659@redhat.com>
Date: Fri, 1 Dec 2017 13:35:41 +0100
MIME-Version: 1.0
In-Reply-To: <9608bcde-6bf8-dc36-a6b7-71cb8bc5c705@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] /usr/bin/m4: internal error detected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Daniel Kahn Gillmor <dkg@fifthhorseman.net>, bug-m4@gnu.org
Cc: debian-superh@lists.debian.org, libc-alpha@sourceware.org, QEMU Developers <qemu-devel@nongnu.org>

On 12/01/2017 12:58 PM, John Paul Adrian Glaubitz wrote:
> The fix is already in the packaging source of Debian's glibc [1] after
> I reported the bug. But the updated package has not been uploaded
> to the FTP servers yet. I'll ask Debian's glibc maintainers to push
> it.

Okay.  Based on the other responses, all these changes do is paper over 
bugs in the execution environment (wrong semantics of CLONE_VFORK), so 
patching glibc really isn't the proper fix.

Thanks,
Florian
