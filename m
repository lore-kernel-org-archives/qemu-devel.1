Received: from eggs.gnu.org ([2001:4830:134:3::10]:54246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXrQJ-0000r7-93
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:06:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXrQI-0002qj-Im
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:06:35 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:34844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXrQI-0002pe-Cx
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 13:06:34 -0400
Received: by mail-ot0-x244.google.com with SMTP id a6-v6so5303847otf.2
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 10:06:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529673765-16627-1-git-send-email-eric.auger@redhat.com>
References: <1529673765-16627-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 18:06:13 +0100
Message-ID: <CAFEAcA9Pg3C+XD7WuLyNr5RfifRCvXB6t01YuLiK9Cs15v-Dpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/3] ARM virt: Silence dtc warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>

On 22 June 2018 at 14:22, Eric Auger <eric.auger@redhat.com> wrote:
> When running dtc on the guest /proc/device-tree, we get the
> following warnings: "Warning (unit_address_vs_reg): Node <name>
> has a reg or ranges property, but no unit name", with name:
> /intc, /intc/its, /intc/v2m, /memory.
>
> This series removes those warnings by adding the unit address to
> the corresponding node names.

This didn't apply to my target-arm.next tree. Once I've
applied my on-list arm pullreq to master, could you
rebase it, please?

thanks
-- PMM
