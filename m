Received: from eggs.gnu.org ([2001:4830:134:3::10]:37927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZxOi-0002id-Tz
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:21:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eZxOf-0002hl-Nu
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:21:20 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eZxOf-0002hU-HJ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:21:17 -0500
Received: by mail-wm0-f45.google.com with SMTP id r78so11218019wme.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:21:17 -0800 (PST)
References: <20180104160523.22995-1-marcandre.lureau@redhat.com>
	<20180104160523.22995-16-marcandre.lureau@redhat.com>
	<8883f760-89d9-b232-a3f1-4b733bef474c@amsat.org>
	<CAJ+F1CJhQ2H5D9tpBO7oxOwhFVeFQ3sn=wUN1bjZ_o8uJWq0GQ@mail.gmail.com>
	<CAJ+F1C+ZCAcVM++VBsYSdkU5uMS=tZHfKFkZdc-ByvHNgqnXZg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8720806d-783d-049f-0675-458374ac7851@redhat.com>
Date: Fri, 12 Jan 2018 12:21:14 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+ZCAcVM++VBsYSdkU5uMS=tZHfKFkZdc-ByvHNgqnXZg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 15/18] ucontext: annotate coroutine
 stack for ASAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 12/01/2018 12:15, Marc-André Lureau wrote:
>>> You simply need to update the .travis.yml, but does that mean your
>> I think we need libgcc-6-dev.
>>
>>> previous patch "Enable ASAN/UBSan by default if the compiler supports
>>> it." isn't correct?
>> No, the problematic patch is "ucontext: annotate coroutine stack for
>> ASAN", it should probably check for asan_interface.h before using it.
>>
>> Print a warning if it's not there during configure, as ASAN
>> experience/reports will be inferior.
>>
> This should fix it:
> 
> (Paolo, would you like me to resend or will you review the diff &
> squash? thanks)

I'll integrate it, thanks.

Paolo
