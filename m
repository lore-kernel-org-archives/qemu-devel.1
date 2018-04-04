Received: from eggs.gnu.org ([2001:4830:134:3::10]:48610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3hgB-0000c0-OF
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:38:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f3hg7-0004bF-R7
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:38:19 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:54379)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f3hg7-0004aj-JB
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 08:38:15 -0400
Received: by mail-wm0-x22f.google.com with SMTP id r191so9930296wmg.4
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 05:38:15 -0700 (PDT)
References: <20180228180215.25470-1-wei@redhat.com>
	<20180228180215.25470-2-wei@redhat.com>
	<ca21f795-dae7-d6b5-44f1-ef8ba792ac04@redhat.com>
	<20180305110122.GD3131@work-vm>
	<20180305133654.7aokepvzcmxhzk4q@kamzik.brq.redhat.com>
	<20180305135244.GJ3131@work-vm>
	<868c6039-35fb-16cb-67bb-39cee11e8118@redhat.com>
	<28739cac-ad18-a46d-23b0-fef9458da75e@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <28739cac-ad18-a46d-23b0-fef9458da75e@redhat.com>
Date: Wed, 04 Apr 2018 13:38:12 +0100
Message-ID: <87fu4bcfkb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V7 1/4] rules: Move cross compilation auto
 detection functions to rules.mak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Wei Huang <wei@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Andrew Jones <drjones@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, quintela@redhat.com


Laurent Vivier <lvivier@redhat.com> writes:

> On 05/03/2018 18:59, Wei Huang wrote:
> ...
>>
>> SLO build actually is OK if we don't move the cross-compile stuff to the
>> generic rules.mak.
>>
>> So this cross-compile approach has lots of objection (unclean, broken
>> rom build etc.). A complete solution will make this patchset bloated,
>> which is diverted away from original purpose of migration-test.
>>
>> Dave & Drew: will the following be acceptable?
>>
>> 1. Still use Makefile for .s->.h compilation
>> 2. In Makefile, we don't support cross-compilation. This avoids
>> duplicating the cross-compile detection code at all. Whoever really
>> wants to re-generate .h file must be avid programmers. They can either
>> find a native machine or fix Makefile themselves.
>> 3. The cross-compile re-factoring will become a separate patchset. In
>> that patchset, both ROM and migration-test Makefiles will be changed to
>> support cross compilation.
>>
>> Thoughts?
>
> I agree with Peter: I think an improvement would be to detect/configure
> cross-compilers at the configure level, not in the Makefile.

I'm going to have a go at this now for docker and host installed
cross-compilers.

>
> thanks,
> Laurent


--
Alex Benn=C3=A9e
