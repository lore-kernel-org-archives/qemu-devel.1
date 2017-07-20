Received: from eggs.gnu.org ([2001:4830:134:3::10]:59224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dY8Fr-0000G6-MH
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 06:00:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dY8Fm-0003V4-Vn
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 06:00:23 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:37242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dY8Fm-0003S9-NX
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 06:00:18 -0400
Received: by mail-wr0-x231.google.com with SMTP id 33so12045933wrz.4
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 03:00:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <aadcb5f0-410a-94a5-ddd9-0933e32bd871@redhat.com>
References: <20170628204452.41230-1-raj.khem@gmail.com>
	<CAFEAcA-N3Ve8GmX6Yq+Kbng8vExe3CzDT_2_07JML8QC2xVwDA@mail.gmail.com>
	<20170629131807.GD32167@redhat.com>
	<aadcb5f0-410a-94a5-ddd9-0933e32bd871@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 10:59:55 +0100
Message-ID: <CAFEAcA8ubNPPj+hLjxJ0EFxuB=ERhFfXMVERSOR+kpEs=DGg3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Khem Raj <raj.khem@gmail.com>, Kamil Rytarowski <kamil@netbsd.org>, Paolo Bonzini <pbonzini@redhat.com>

On 19 July 2017 at 02:06, Eric Blake <eblake@redhat.com> wrote:
> On 06/29/2017 08:18 AM, Daniel P. Berrange wrote:
>> On Thu, Jun 29, 2017 at 10:05:13AM +0100, Peter Maydell wrote:
>>> On 28 June 2017 at 21:44, Khem Raj <raj.khem@gmail.com> wrote:
>>>> The ucontext_t type had a tag struct ucontext until now
>>>> but newer glibc will drop it so we need to adjust and use
>>>> the exposed type instead
>>>
>>> If true this seems like a bug in glibc to break
>>> existing working programs, and it should be fixed there...
>>
>> The glib commit message indicates it is intentional change, in order
>> to get POSIX compliance:
>>
>>   https://sourceware.org/git/?p=glibc.git;a=commit;h=251287734e89a52da3db682a8241eb6bccc050c9
>>
>> NB, other parts of QEMU like the coroutine code are already
>> using the 'ucontext_t' typedef, so attaining consistency across
>> files is good regardless of the glibc change.
>
> I agree. And since the issue has been reposted, I support the fix,
> although Nathaniel's repost may have the better commit message.
> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06005.html
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks; applied to master with an upgraded commit message.

-- PMM
