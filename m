Received: from eggs.gnu.org ([2001:4830:134:3::10]:39465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebRUk-0005yN-KJ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ebRUh-0007so-Bt
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:41:42 -0500
Received: from mail-wr0-f174.google.com ([209.85.128.174]:45682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ebRUh-0007kI-5i
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:41:39 -0500
Received: by mail-wr0-f174.google.com with SMTP id 16so15199479wry.12
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 05:41:27 -0800 (PST)
References: <1516059302-7169-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-wnvhRfOAQySLXWqvwtPXwj+r+wn_sRGM5ti6wWe_c-Q@mail.gmail.com>
	<CAJ+F1CLzuv4CevvT+gM_ZOnC67_=-3EpRiQBoQXqNYDiFLBw+A@mail.gmail.com>
	<CAFEAcA9dsWKLitCfxy+HV66rBMruxX67Aq-n4Bpmx5b2QzC2YA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <26d847ad-b3ba-bdab-a79b-79ad486ae80a@redhat.com>
Date: Tue, 16 Jan 2018 14:41:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9dsWKLitCfxy+HV66rBMruxX67Aq-n4Bpmx5b2QzC2YA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v3 00/53] Misc changes for 2017-01-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16/01/2018 13:06, Peter Maydell wrote:
>> ASAN is enabled by default if available when --enable-debug. We could
>> add more flags if that helps.
> Configure switches should work like this:
>  * default: use feature if present, but don't complain if not present
>    or not usable
>  * --enable-foo: use feature. if feature not present, complain and
>    fail configure
>  * --disable-foo: don't test for or use feature
> 

However, --enable-debug has never worked like this (the "default" part)...

Paolo
