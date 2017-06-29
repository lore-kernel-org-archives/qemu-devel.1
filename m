Received: from eggs.gnu.org ([2001:4830:134:3::10]:50032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQVOK-0004of-MV
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQVOJ-0007L8-SQ
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:05:36 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQVOJ-0007Kv-Kn
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:05:35 -0400
Received: by mail-wr0-x22e.google.com with SMTP id 77so186106124wrb.1
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 02:05:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170628204452.41230-1-raj.khem@gmail.com>
References: <20170628204452.41230-1-raj.khem@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 10:05:13 +0100
Message-ID: <CAFEAcA-N3Ve8GmX6Yq+Kbng8vExe3CzDT_2_07JML8QC2xVwDA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] replace struct ucontext with ucontext_t
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Khem Raj <raj.khem@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 28 June 2017 at 21:44, Khem Raj <raj.khem@gmail.com> wrote:
> The ucontext_t type had a tag struct ucontext until now
> but newer glibc will drop it so we need to adjust and use
> the exposed type instead

If true this seems like a bug in glibc to break
existing working programs, and it should be fixed there...

thanks
-- PMM
