Received: from eggs.gnu.org ([209.51.188.92]:41560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmcPK-0000Mj-OP
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:38:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmcPJ-0003VG-UI
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:38:50 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmcPJ-0003TV-MY
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:38:49 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so2484249wmt.0
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 02:38:49 -0800 (PST)
References: <20190124013625.27239-1-philmd@redhat.com>
	<777d8a79-39b8-d287-f09d-d0e2e1769536@comstyle.com>
	<CAFEAcA8P5eo-VEfvQ+hJTUqWVDhqV4rH91seJUM3RBOHQfj32A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c15d5762-89c7-c3d1-2d1d-a1acfd52f9ea@redhat.com>
Date: Thu, 24 Jan 2019 11:38:46 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8P5eo-VEfvQ+hJTUqWVDhqV4rH91seJUM3RBOHQfj32A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] ui/egl: Silent '__HAIKU__ undefined'
 warnings on OpenBSD 6.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Brad Smith <brad@comstyle.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

On 1/24/19 11:11 AM, Peter Maydell wrote:
> On Thu, 24 Jan 2019 at 02:03, Brad Smith <brad@comstyle.com> wrote:
>>
>> https://cgit.freedesktop.org/mesa/mesa/commit/include/EGL/eglplatform.h?id=f744c6c1e28fe363474550b94af42a8b7fc1c755
>>
>> Unfortunately that issue has only been fixed very recently.
>>
>> There is a possibility of us updating from Mesa 17.3.9 to 18.3.x which
>> would bring in this header fix, but I don't know how long that will be
>> and it's currently held up on us switching i386 from bfd ld to lld.
>>
>> So this header exists as is from 6.0 to the latest, most likely next release
>> (6.5) too.
>>
>> Honestly I think it would be better to just ignore this particular
>> issue. It's
>> an issue with a header outside of QEMU and it will go away in time when
>> Mesa is eventually updated.

Yeah, fine by me.

> 
> Yes; I have been ignoring this warning for a while now
> in my scripts that handle looking for warnings in build logs:
> 
> https://git.linaro.org/people/peter.maydell/misc-scripts.git/commit/greplogs?id=951983351baa2f27da4f4fe432fb55bf911d17e5

Thanks, useful tip.

I liked:

+      grep -v 'is almost always misused' | \
+      grep -v 'is often misused' | \
+      grep -v 'is dangerous; do not use it' | \

:)

> 
> thanks
> -- PMM
> 
