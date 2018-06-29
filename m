Received: from eggs.gnu.org ([2001:4830:134:3::10]:33224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYrAq-0001ec-U6
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:02:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYrAq-0001yI-4D
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:02:44 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:36856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYrAp-0001wg-MI
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:02:44 -0400
Received: by mail-oi0-x243.google.com with SMTP id r16-v6so7564359oie.3
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 04:02:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fc567ee3-64fa-c812-f111-d75c49244218@redhat.com>
References: <1530265890-17213-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-779p+=wkKaPa2LL4k6jAHx-K5fmXxwBhrjED5PjDnaw@mail.gmail.com>
	<fc567ee3-64fa-c812-f111-d75c49244218@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Jun 2018 12:02:21 +0100
Message-ID: <CAFEAcA8uN_PeciAiQmDhdUPVEO837+rwSxO5fBUAHyGCw1pWLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/60] Misc patches for soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 29 June 2018 at 11:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 29/06/2018 12:30, Peter Maydell wrote:
>>
>> This still fails in the same way:
>>   LINK    i386-linux-user/qemu-i386
>> target/i386/cpu.o: In function `x86_cpu_realizefn':
>> /home/petmay01/linaro/qemu-for-merges/target/i386/cpu.c:4815:
>> undefined reference to `enable_cpu_pm
>> '
>> collect2: error: ld returned 1 exit status
>
> Uhm, it worked for me.  I'll just add a stub.

Maybe you forgot to push something? I can't see anything
in commit 6f131f13e68d648a8e4 in that merge branch which
looks like it's trying to work around the undefined reference.

thanks
-- PMM
