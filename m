Received: from eggs.gnu.org ([2001:4830:134:3::10]:47694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejOKd-0001cg-9R
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejOKc-0004hR-Fz
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:56:07 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37516)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejOKc-0004hD-An
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 06:56:06 -0500
Received: by mail-ot0-x244.google.com with SMTP id e64so541410ote.4
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 03:56:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4ce6f2ad-2287-2155-277b-977e48167687@redhat.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8xGrkYY14hm6htgs3oqB1gaKHFRLktz2x0tOFageDqYQ@mail.gmail.com>
	<4ce6f2ad-2287-2155-277b-977e48167687@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Feb 2018 11:55:44 +0000
Message-ID: <CAFEAcA_mAK2jeX9Uu=Mtx4PUOVToXFW351OKgu6B4A0kj_79aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 February 2018 at 20:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 06/02/2018 20:18, Peter Maydell wrote:
>> Hi. I'm afraid this fails to build the all-linux-static config:
>>
>>   LINK    ivshmem-client
>> [usual linker gripes about getpwuid &c in static binaries deleted]
>> /usr/lib/gcc/x86_64-linux-gnu/5/libubsan.a(sanitizer_linux_libcdep.o):
>> In function `__sanitizer::SetEnv(cha
>> r const*, char const*)':
>> (.text+0x41b): undefined reference to `dlsym'
>> /usr/lib/gcc/x86_64-linux-gnu/5/libubsan.a(sanitizer_linux_libcdep.o):
>> In function `__sanitizer::InitTlsSiz
>> e()':
>> (.text+0x553): undefined reference to `dlsym'
>> collect2: error: ld returned 1 exit status
>
> Uhm, what is all-linux-static?  Is it using --enable-debug?

Yeah, it's a config with --enable-debug --static --disable-system

thanks
-- PMM
