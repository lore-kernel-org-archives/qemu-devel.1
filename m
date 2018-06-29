Received: from eggs.gnu.org ([2001:4830:134:3::10]:56576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYqgm-00015n-7o
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:31:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYqgj-0007PA-4S
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:31:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45568 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYqgi-0007Mg-Uz
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 06:31:37 -0400
References: <1530265890-17213-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-779p+=wkKaPa2LL4k6jAHx-K5fmXxwBhrjED5PjDnaw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc567ee3-64fa-c812-f111-d75c49244218@redhat.com>
Date: Fri, 29 Jun 2018 12:31:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-779p+=wkKaPa2LL4k6jAHx-K5fmXxwBhrjED5PjDnaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/60] Misc patches for soft freeze
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

On 29/06/2018 12:30, Peter Maydell wrote:
> 
> This still fails in the same way:
>   LINK    i386-linux-user/qemu-i386
> target/i386/cpu.o: In function `x86_cpu_realizefn':
> /home/petmay01/linaro/qemu-for-merges/target/i386/cpu.c:4815:
> undefined reference to `enable_cpu_pm
> '
> collect2: error: ld returned 1 exit status

Uhm, it worked for me.  I'll just add a stub.

Paolo
