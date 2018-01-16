Received: from eggs.gnu.org ([2001:4830:134:3::10]:41505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebRaq-0002qB-PN
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:48:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebRap-0003Le-TL
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:48:00 -0500
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:42718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebRal-0003Hf-15
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 08:47:59 -0500
Received: by mail-oi0-x232.google.com with SMTP id o64so10628812oia.9
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 05:47:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <26d847ad-b3ba-bdab-a79b-79ad486ae80a@redhat.com>
References: <1516059302-7169-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-wnvhRfOAQySLXWqvwtPXwj+r+wn_sRGM5ti6wWe_c-Q@mail.gmail.com>
	<CAJ+F1CLzuv4CevvT+gM_ZOnC67_=-3EpRiQBoQXqNYDiFLBw+A@mail.gmail.com>
	<CAFEAcA9dsWKLitCfxy+HV66rBMruxX67Aq-n4Bpmx5b2QzC2YA@mail.gmail.com>
	<26d847ad-b3ba-bdab-a79b-79ad486ae80a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 13:47:33 +0000
Message-ID: <CAFEAcA87VxcTz710LKTLCkre+DoBhqgRtShObU-CYp1XU9TgWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 00/53] Misc changes for 2017-01-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On 16 January 2018 at 13:41, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 16/01/2018 13:06, Peter Maydell wrote:
>>> ASAN is enabled by default if available when --enable-debug. We could
>>> add more flags if that helps.
>> Configure switches should work like this:
>>  * default: use feature if present, but don't complain if not present
>>    or not usable
>>  * --enable-foo: use feature. if feature not present, complain and
>>    fail configure
>>  * --disable-foo: don't test for or use feature
>>
>
> However, --enable-debug has never worked like this (the "default" part)...

True, but -g, no optimization isn't really something we want to
default to :-) I think the general principle that unless the user
specifically said they cared about the address sanitizer we shouldn't
complain if it happens not to work on this host is still a good one.

thanks
-- PMM
