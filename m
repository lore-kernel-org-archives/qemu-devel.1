Received: from eggs.gnu.org ([2001:4830:134:3::10]:33857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJeWp-0000a6-IF
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJeWo-0002FZ-Ng
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:58:19 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:44440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJeWo-0002FF-Iq
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:58:18 -0500
Received: by mail-oi0-x22c.google.com with SMTP id y71so46609oia.11
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 03:58:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2323fa20-ea6e-7895-3a68-1dacf32dcab8@redhat.com>
References: <20171128113204.22912-1-pbonzini@redhat.com>
	<CAJ+F1CLzoyrtwG=iiB0_ocMGELrYY9-v_pm4AGaShFw3_CzHhQ@mail.gmail.com>
	<2323fa20-ea6e-7895-3a68-1dacf32dcab8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 11:57:57 +0000
Message-ID: <CAFEAcA9=bjzkoidD=Rpymw4kwkG2_umOEd2GenwL87skj7jbUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memfd: fix configure test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, fweimer@redhat.com, QEMU <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>

On 28 November 2017 at 11:49, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 28/11/2017 12:42, Marc-Andr=C3=A9 Lureau wrote:
>> It is introduced by this commit, right?
>> https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D59d2cbb1fe4b860=
1d5cbd359c3806973eab6c62d
>>
>> (I added Florian Weimer in cc)
>>
>> So it's not part of glibc release yet.
>>
>> Couldn't the declarations be put in sys/memfd.h like the man claimed
>> it would be for > 1y?
>
> Yeah, that would have been better---certainly other software than QEMU
> is likely to have a static memfd_create declaration, and polluting
> sys/mman.h is going to trigger the same error.  However, at least
> systemd seems to have changed the test to sys/mman.h
> (https://github.com/systemd/systemd/pull/7468), so I think we should
> follow their lead now

I don't see why systemd should control anything. If the documentation
has been around for ages and there hasn't been a released glibc with
the incorrect placement then the implementation in glibc should follow
the documentation.

thanks
-- PMM
