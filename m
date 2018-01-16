Received: from eggs.gnu.org ([2001:4830:134:3::10]:51841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebTSB-0007DA-Ea
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebTSA-00010z-O8
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:47:11 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:43047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebTSA-00010Z-Ii
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:47:10 -0500
Received: by mail-ot0-x22a.google.com with SMTP id p36so5933247otd.10
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 07:47:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e0132595-a110-fa09-aa7c-378caf0f885c@redhat.com>
References: <1516059302-7169-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-wnvhRfOAQySLXWqvwtPXwj+r+wn_sRGM5ti6wWe_c-Q@mail.gmail.com>
	<CAJ+F1CLzuv4CevvT+gM_ZOnC67_=-3EpRiQBoQXqNYDiFLBw+A@mail.gmail.com>
	<CAFEAcA9dsWKLitCfxy+HV66rBMruxX67Aq-n4Bpmx5b2QzC2YA@mail.gmail.com>
	<26d847ad-b3ba-bdab-a79b-79ad486ae80a@redhat.com>
	<CAFEAcA87VxcTz710LKTLCkre+DoBhqgRtShObU-CYp1XU9TgWg@mail.gmail.com>
	<5edb00c6-382e-5a36-a61b-47d3fc5b8408@redhat.com>
	<CAJ+F1CKKdHYBgWWf6zucKB25gD0zG9Lrvbh51FCir2MvTRkJbQ@mail.gmail.com>
	<e0132595-a110-fa09-aa7c-378caf0f885c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 15:46:49 +0000
Message-ID: <CAFEAcA8w5vhXB4wqyQy7Za4OSJ7GKKD2yHx=BidAZijk=ujxhw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On 16 January 2018 at 14:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 16/01/2018 15:22, Marc-Andr=C3=A9 Lureau wrote:
>>> * if not, and assuming --enable-debug tries to enable ASAN, should
>>> --enable-debug complain if fiber support is not required?  Should
>>> --enable-debug enable ASAN if fiber support is not available?
>>
>> I propose to simply print a warning during configure
>
> Yes, it could do the same as --enable-asan.

The thing you want to avoid here is having one of my standard
build configs produce new text saying 'warning' or 'error',
because that will flag up to me as a build failure and I'll
bounce the pullreq...

thanks
-- PMM
