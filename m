Received: from eggs.gnu.org ([2001:4830:134:3::10]:54574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXlhX-0003Yi-FV
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:32:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gXlhW-0006rD-QQ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:32:15 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gXlhW-0006r3-LB
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 06:32:14 -0500
Received: by mail-ot1-x342.google.com with SMTP id 32so5029518ota.12
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 03:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20181122133507.30950-1-peter.maydell@linaro.org>
In-Reply-To: <20181122133507.30950-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Dec 2018 11:32:02 +0000
Message-ID: <CAFEAcA-xzUS4Nrf9dq26-Pp-c5TM-gdMTBBMr-fjFBSd4AZmYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-4.0 0/2] Rename
 cpu_physical_memory_write_rom() to address_space_write_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, "patches@linaro.org" <patches@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>

On Thu, 22 Nov 2018 at 13:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The API of cpu_physical_memory_write_rom() is odd, because it
> takes an AddressSpace, unlike all the other cpu_physical_memory_*
> access functions. We note this oddity as a TODO in the
> docs/devel/loads-stores.rst documentation.
>
> Rename cpu_physical_memory_write_rom() to address_space_write_rom(),
> and give it an API that matches address_space_write().
> We also adjest the cpu_physical_memory_write_rom_internal()
> function which is local to exec.c similarly.

Unless somebody would prefer a different route, I'm going
to add this series to a 'misc' pullreq I'm putting together.

thanks
-- PMM
