Received: from eggs.gnu.org ([2001:4830:134:3::10]:45484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRmMD-0003Ig-9w
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:56:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRmMA-00046E-89
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:56:57 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:33148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eRmMA-00045e-1U
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:56:54 -0500
Received: by mail-wm0-x241.google.com with SMTP id g130so17583869wme.0
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 13:56:53 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8J53A93+SQz01W13gRCX-ecw0v+8JTaRqwmrUeFjqaJA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <51174e3a-12d3-f3e0-2d76-b776e0fe62b6@redhat.com>
Date: Wed, 20 Dec 2017 22:56:49 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8J53A93+SQz01W13gRCX-ecw0v+8JTaRqwmrUeFjqaJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 00/46] First batch of misc patches for QEMU
 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>

On 20/12/2017 20:20, Peter Maydell wrote:
> On the x86/sanitizer build, new runtime errors:
>   GTESTER check-qtest-m68k
> /home/petmay01/linaro/qemu-for-merges/target/m68k/translate.c:230:12:
> runtime error: index -1 out of bounds for type 'const uint8_t [11]'
>
> ...and similar fails on one or two boards on most of the other
> guest architectures.

These are preexisting bugs, now exposed by the boot-serial-test.
Thomas, can you identify the architectures that have a problem and
notify the maintainers?  In the meanwhile I'll keep the boot-serial-test
enhancements queued locally, and remove them from the pull request.

Paolo
