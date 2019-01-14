Received: from eggs.gnu.org ([209.51.188.92]:46252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj0oB-0005DF-43
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:53:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj0o4-0003bg-Uv
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:53:32 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:44928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gj0nz-0003Wv-0v
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 06:53:26 -0500
Received: by mail-oi1-x234.google.com with SMTP id m6so17580234oig.11
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 03:53:20 -0800 (PST)
MIME-Version: 1.0
References: <20190108163008.7006-1-peter.maydell@linaro.org>
	<20190108163008.7006-4-peter.maydell@linaro.org>
	<CAL1e-=gtbka64eAhVdbPyLa4+HP-OSQRg7u6+SC-8MCRgoZ9Qw@mail.gmail.com>
In-Reply-To: <CAL1e-=gtbka64eAhVdbPyLa4+HP-OSQRg7u6+SC-8MCRgoZ9Qw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 11:53:06 +0000
Message-ID: <CAFEAcA-3CDZg8A3tB-TSQ_M+RVanqBNQh1EmPpqx0ftoqqDD8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 3/4] accel/tcg: Add cluster number to TCG
 TB hash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>, "Emilio G . Cota" <cota@braap.org>, "patches@linaro.org" <patches@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 14 Jan 2019 at 01:08, Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
> I do understand the definition of cluster_index in the sense
> of this series. However, it looks to me that the term
> "cluster" is generally overused in areas where we work.
> This may lead to some confusion for future developers, and
> let me suggest some other name, like "tcg_cluster_index" or
> "tcg_group_id", or "translation_group_id".

Note also that the cluster index is not purely a TCG
concept -- it also (in master at the moment) affects
the gdbstub interface. Different clusters appear as
separate processes in gdb, whereas different CPUs in
the same cluster are different threads in the same CPU.
(And by default only the first cluster's CPUs will
appear, unless you explicitly attach to the second cluster:
this is a limitation of how gdb's UI handles multiple
processes.)

thanks
-- PMM
