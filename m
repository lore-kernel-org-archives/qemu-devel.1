Received: from eggs.gnu.org ([2001:4830:134:3::10]:50580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1crE2H-0003W5-0U
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1crE2C-0001ly-4u
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:29:01 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36411)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1crE2B-0001lm-V0
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 21:28:56 -0400
Received: by mail-pf0-x242.google.com with SMTP id r137so117494pfr.3
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 18:28:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<CAFEAcA-2mcGih5bscnMsevTNTy71g9kE7OjTy3hYJKeGoGQw-g@mail.gmail.com>
	<87k27hxyni.fsf@linaro.org>
	<CAFEAcA-oLDW2F=L3NCdSvrLp_eh3tu9mfKR0mTfZ=3O3dpdKbQ@mail.gmail.com>
	<1a35985f-ad4b-c017-b355-51d47aaffa11@redhat.com>
	<CAFEAcA9oBDYqmRpwU5B2o2X-viYrccf1V3zASYGpuaQBL866ig@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0036c9a7-717b-356a-e184-69270386431c@twiddle.net>
Date: Fri, 24 Mar 2017 11:28:48 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9oBDYqmRpwU5B2o2X-viYrccf1V3zASYGpuaQBL866ig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Proposal for deprecating unsupported host OSes &
 architecutures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 03/23/2017 09:02 PM, Peter Maydell wrote:
> On 23 March 2017 at 10:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> I own a MIPS Creator ci20 board (donated by Imagination Technologies).
>> I cannot give it a public IP address, but I can try and use it to do
>> builds every now and then.
>
> I think our best bet is probably to fix our test suite's
> overreliance on /tmp/. Then the gcc cfarm box will probably do.
>
> I've also had a kind offer of access to a SPARC box, which
> I'm following up on.

I also have access to a sparc box.

(At the moment I'm trying to update it from 2013 era system libraries, and to 
enable the 64-bit userland, before I do any testing of current mainline.)


r~
