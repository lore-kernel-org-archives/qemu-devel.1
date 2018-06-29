Received: from eggs.gnu.org ([2001:4830:134:3::10]:46862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYpxC-0008W1-Vt
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYpx8-0006Y0-4j
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:44:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34812 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYpx7-0006XP-VE
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 05:44:30 -0400
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA9i=tEQuOpuUksRDapLAuONJ6sSDiJY20pujOYo7GPeJA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9f47df9d-37a7-ed14-095a-6575f39c1528@redhat.com>
Date: Fri, 29 Jun 2018 11:44:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9i=tEQuOpuUksRDapLAuONJ6sSDiJY20pujOYo7GPeJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/60] Misc patches for soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29/06/2018 11:25, Peter Maydell wrote:
> Hi; this fails to link the i386 linux-user binaries
> (x86-64 Linux host, debug build):
> 
>   LINK    i386-linux-user/qemu-i386
> target/i386/cpu.o: In function `x86_cpu_realizefn':
> /home/petmay01/linaro/qemu-for-merges/target/i386/cpu.c:4814:
> undefined reference to `enable_cpu_pm'
> 
> because enable_cpu_pm is defined in vl.c but used
> in code in target/i386 which isn't softmmu-specific.

That breaks depending on the optimization level.  I'll fix that and resend.

Paolo
