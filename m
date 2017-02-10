Received: from eggs.gnu.org ([2001:4830:134:3::10]:43297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccCKI-00008p-AV
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:37:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ccCKF-0002eg-6Z
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:37:30 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:36237)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ccCKE-0002e9-Vc
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 09:37:27 -0500
Received: by mail-wm0-x22b.google.com with SMTP id c85so261912114wmi.1
	for <qemu-devel@nongnu.org>; Fri, 10 Feb 2017 06:37:26 -0800 (PST)
References: <20170210014519.12413-1-bobby.prani@gmail.com>
	<871sv6xmzk.fsf@linaro.org>
	<0ec07664-fa06-8f09-33ce-ca15448c7851@redhat.com>
	<87y3xew7hn.fsf@linaro.org>
	<3f702266-1ac2-57c5-e0f8-3dec07b450d2@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <3f702266-1ac2-57c5-e0f8-3dec07b450d2@redhat.com>
Date: Fri, 10 Feb 2017 14:37:38 +0000
Message-ID: <87vasiw1ql.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: handle EXCP_ATOMIC exception properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pranith Kumar <bobby.prani@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/02/2017 13:33, Alex Bennée wrote:
>> That said for TCG system emulation EXCP_ATOMIC is currently broken with
>> respect to debugging. However for the initial guests/host combination of
>> ARMv7/8 on x86_64 we don't need the fallback with pretty much 99% of
>> deployed hosts. How about the following:
>>
>>   - drop Pranith's patch for the current MTTCG series
>>   - replace with an error/abort on EXCP_ATOMIC
>
> Don't even replace it? :)

I guess - the failure mode is only when we single step? Should we not
try to emit a warning like we do for the mismatched MOs?

>
> Paolo
>
>>   - proceed with merge as plan
>>   - tackle the BQL lock next (along with more MTTCG guest/targets enablement)


--
Alex Bennée
