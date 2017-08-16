Received: from eggs.gnu.org ([2001:4830:134:3::10]:47889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhwLI-0000BG-2n
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhwLH-0005q0-3L
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:18:31 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhwLG-0005oj-TU
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 07:18:31 -0400
Received: by mail-wr0-x22a.google.com with SMTP id y96so9300608wrc.1
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 04:18:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
References: <20170816082650.21880-1-cohuck@redhat.com>
	<223c4e3c-097f-5a91-37fa-df4bfb427d60@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 16 Aug 2017 12:18:07 +0100
Message-ID: <CAFEAcA_UfM_XNKdc5zfHsehoRE6Q+EszRZX3FByskir7c+0Lww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10] boot-serial-test: prefer tcg
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>

On 16 August 2017 at 11:51, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 16/08/2017 10:26, Cornelia Huck wrote:
>> Prefer to use the tcg accelarator if it is available: This is our only
>> real smoke test for tcg, and fast enough to use it for that.
>
> I'm not sure this is required for 2.10.  Yes, it means the coverage from
> "make check" is worse, but that's it.

Yes, I'd put it under "if we need to roll an rc4 anyway for
some more significant bug we might as well put this in too,
but it doesn't merit cutting rc4 by itself."

thanks
-- PMM
