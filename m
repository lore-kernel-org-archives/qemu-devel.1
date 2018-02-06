Received: from eggs.gnu.org ([2001:4830:134:3::10]:46589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ej9zP-0007Dx-1w
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:37:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ej9zL-0006OY-Q8
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:37:15 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ej9zL-0006O4-KU
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 15:37:11 -0500
Received: by mail-wm0-f68.google.com with SMTP id r71so6243219wmd.1
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 12:37:11 -0800 (PST)
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8xGrkYY14hm6htgs3oqB1gaKHFRLktz2x0tOFageDqYQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4ce6f2ad-2287-2155-277b-977e48167687@redhat.com>
Date: Tue, 6 Feb 2018 21:37:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8xGrkYY14hm6htgs3oqB1gaKHFRLktz2x0tOFageDqYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/47] Misc patches for 2018-02-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 06/02/2018 20:18, Peter Maydell wrote:
> Hi. I'm afraid this fails to build the all-linux-static config:
> 
>   LINK    ivshmem-client
> [usual linker gripes about getpwuid &c in static binaries deleted]
> /usr/lib/gcc/x86_64-linux-gnu/5/libubsan.a(sanitizer_linux_libcdep.o):
> In function `__sanitizer::SetEnv(cha
> r const*, char const*)':
> (.text+0x41b): undefined reference to `dlsym'
> /usr/lib/gcc/x86_64-linux-gnu/5/libubsan.a(sanitizer_linux_libcdep.o):
> In function `__sanitizer::InitTlsSiz
> e()':
> (.text+0x553): undefined reference to `dlsym'
> collect2: error: ld returned 1 exit status

Uhm, what is all-linux-static?  Is it using --enable-debug?

Paolo
