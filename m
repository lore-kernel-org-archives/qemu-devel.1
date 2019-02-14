Received: from eggs.gnu.org ([209.51.188.92]:46048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guLmm-0001vn-A6
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guLml-00057Q-Mb
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:31:00 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:41935)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guLml-0004t6-HT
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 13:30:59 -0500
Received: by mail-ot1-x333.google.com with SMTP id u16so12160192otk.8
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 10:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20190214140714.15738-1-imammedo@redhat.com>
In-Reply-To: <20190214140714.15738-1-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 18:30:37 +0000
Message-ID: <CAFEAcA8Jh6B+aOJMEAgQWhbuun6e5HSVRZ1+k5adO9PcgGua4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC] memory: use memory_region_init_ram() instead
 of memory_region_allocate_system_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Thu, 14 Feb 2019 at 14:07, Igor Mammedov <imammedo@redhat.com> wrote:
> Also some boards (ab)use memory_region_allocate_system_memory(), calling it several
> times to allocate various fixed sized chunks of RAM and ROMs, which is problematic
> to map to a single initial RAM Machine::memdev backend and is currently broken if
> -mem-path points to a not hugepage pool.

These boards are buggy and we could fix them, if we wanted to
keep the existing API. We should in that case add assertions
that memory_region_allocate_system_memory() is called once and
only once, which would let "make check" enforce the rule.

thanks
- PMM
