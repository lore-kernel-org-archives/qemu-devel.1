Received: from eggs.gnu.org ([2001:4830:134:3::10]:33691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ejPAR-00019D-M2
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ejPAQ-0004tp-UL
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:49:39 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:39940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ejPAQ-0004r4-M4
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:49:38 -0500
Received: by mail-wr0-x242.google.com with SMTP id i56so892074wra.7
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 04:49:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4c81a8d5-5d88-2f31-13be-4ae12007b2b3@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8xGrkYY14hm6htgs3oqB1gaKHFRLktz2x0tOFageDqYQ@mail.gmail.com>
	<4ce6f2ad-2287-2155-277b-977e48167687@redhat.com>
	<CAFEAcA_mAK2jeX9Uu=Mtx4PUOVToXFW351OKgu6B4A0kj_79aw@mail.gmail.com>
	<4c81a8d5-5d88-2f31-13be-4ae12007b2b3@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 7 Feb 2018 13:49:36 +0100
Message-ID: <CAJ+F1C+ukUFKkTnoDXbLDay8Gu9atEEdnzkwa9G3LErKLe_H+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/47] Misc patches for 2018-02-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On Wed, Feb 7, 2018 at 1:05 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 07/02/2018 12:55, Peter Maydell wrote:
>> On 6 February 2018 at 20:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> On 06/02/2018 20:18, Peter Maydell wrote:
>>>> Hi. I'm afraid this fails to build the all-linux-static config:
>>>>
>>>>   LINK    ivshmem-client
>>>> [usual linker gripes about getpwuid &c in static binaries deleted]
>>>> /usr/lib/gcc/x86_64-linux-gnu/5/libubsan.a(sanitizer_linux_libcdep.o):
>>>> In function `__sanitizer::SetEnv(cha
>>>> r const*, char const*)':
>>>> (.text+0x41b): undefined reference to `dlsym'
>>>> /usr/lib/gcc/x86_64-linux-gnu/5/libubsan.a(sanitizer_linux_libcdep.o):
>>>> In function `__sanitizer::InitTlsSiz
>>>> e()':
>>>> (.text+0x553): undefined reference to `dlsym'
>>>> collect2: error: ld returned 1 exit status
>>>
>>> Uhm, what is all-linux-static?  Is it using --enable-debug?
>>
>> Yeah, it's a config with --enable-debug --static --disable-system
>
> Ok, I'll drop the change to enable --enable-sanitizers when you give
> --enable-debug.  It's premature.

It is a bit weird that this is not caught during configure time, that
does check static compilation (when --static) with the sanitizers.
What is the host? is there a docker check to reproduce?


--=20
Marc-Andr=C3=A9 Lureau
