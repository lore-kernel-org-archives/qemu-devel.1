Received: from eggs.gnu.org ([2001:4830:134:3::10]:60465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cYhpT-000488-9c
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:27:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cYhpS-0001dx-6m
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 18:27:15 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
References: <1485879287-12548-1-git-send-email-peter.maydell@linaro.org>
	<20170131165557.GE20303@redhat.com>
	<CAFEAcA9Jbv398L=yjPmq7MfV+bpma4TiBX9LbBBHZ_qo5DvuGg@mail.gmail.com>
Message-ID: <d7b3be0a-aa29-eb65-aa60-c872fd2b2613@redhat.com>
Date: Tue, 31 Jan 2017 18:27:01 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Jbv398L=yjPmq7MfV+bpma4TiBX9LbBBHZ_qo5DvuGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Drop QEMU_GNUC_PREREQ() checks for gcc
 older than 4.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, "patches@linaro.org" <patches@linaro.org>



On 31/01/2017 11:58, Peter Maydell wrote:
> On 31 January 2017 at 16:55, Daniel P. Berrange <berrange@redhat.com> wrote:
>> On Tue, Jan 31, 2017 at 04:14:47PM +0000, Peter Maydell wrote:
>>> We already require gcc 4.1 or newer (for the atomic
>>> support), so the fallback codepaths for older gcc
>>> versions than that are now dead code and we can
>>> just delete them.
>>
>> Do we have any explicit check alreadu for 4.1, or do we
>> just let the build fail on the atomic code ?
>>
>> IOW, is there any use in having..
>>
>> #if !QEMU_GNUC_PREREQ(4, 1)
>> # error "QEMU requires GCC >= 4.1 or CLang"
>> #endif
> 
> I guess we just barf in the atomics. An explicit check might
> not be a bad idea I guess, though it depends a bit on how
> many releases we've been implicitly requiring 4.1 for. I
> suppose it would act as documentation of our current
> minimum req.

We have:

- first occurrence on Linux hosts: 0.13.0 (for vhost)

- first occurrence on non-Linux hosts: 0.15.0 (simpletrace backend),
then backed out in 1.0

- next occurrence on all hosts, but only in tests: 1.4.0

- finally, first occurrence on all hosts with simple ./configure &&
make: 2.0.0

Paolo
