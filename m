Received: from eggs.gnu.org ([2001:4830:134:3::10]:37578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqoSB-00025Y-0N
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 18:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqoSA-0008WC-9A
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 18:42:19 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:44523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqoSA-0008Vh-38
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 18:42:18 -0400
Received: by mail-wm0-x230.google.com with SMTP id 137so13487298wmj.1
	for <qemu-devel@nongnu.org>; Sat, 09 Sep 2017 15:42:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170909203014.GG7570@localhost.localdomain>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-7-git-send-email-imammedo@redhat.com>
	<20170905213152.GG17184@localhost.localdomain>
	<CAKmqyKPWDmVYJceYao7NkD5svWqN_fYbDoUJ4uLNFdAhv+kFwg@mail.gmail.com>
	<20170905221226.GZ7570@localhost.localdomain>
	<CAKmqyKO4yRz3R0BJ+gz=UfLc0d_AoNtEAHn-SNFMzg3xo12D=Q@mail.gmail.com>
	<20170909203014.GG7570@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Sep 2017 23:41:55 +0100
Message-ID: <CAFEAcA9iTepyGg17xPB_4XOnoOK6iAPsvOdJg_XLEbdk+dggGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 6/6] arm: drop intermadiate cpu_model ->
 cpu type parsing and use cpu type directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>, Igor Mammedov <imammedo@redhat.com>, Andrew Jones <drjones@redhat.com>, Rob Herring <robh@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On 9 September 2017 at 21:30, Eduardo Habkost <ehabkost@redhat.com> wrote:
> However, I have a suggestion for Igor: making a separate patch
> that renames the existing property to "x-cpu-model", and using
> "x-cpu-type" in this series.  This way we will explicitly
> document the fact that the property is not a stable
> user/management interface.

We have lots and lots of properties on non-user-instantiated
devices that aren't intended as user level configurable
things...

thanks
-- PMM
