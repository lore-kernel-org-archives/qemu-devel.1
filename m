Received: from eggs.gnu.org ([2001:4830:134:3::10]:59880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTnkz-0001FL-NG
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTnky-0001gw-Qp
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:23:09 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTnky-0001gY-Ml
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:23:08 -0400
Received: by mail-oi0-x242.google.com with SMTP id h79-v6so8605312oig.13
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 05:23:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1528554193-27270-1-git-send-email-eric.auger@redhat.com>
References: <1528554193-27270-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 13:22:47 +0100
Message-ID: <CAFEAcA-PJe+hwmL+vtLKNoCCb+2c5e8tx6kWnE0AuOiB_3HR+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] ARM virt: Silence dtc warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 9 June 2018 at 15:23, Eric Auger <eric.auger@redhat.com> wrote:
> When running dtc on the guest /proc/device-tree, we get the
> following warnings: "Warning (unit_address_vs_reg): Node <name>
> has a reg or ranges property, but no unit name", with name:
> /intc, /intc/its, /intc/v2m, /memory.
>
> This series removes those warnings by adding the unit address to
> the corresponding node names.

Thanks for this patchset -- Marc Z reported this ages ago
but I never got round to looking at it.

Patch 1 looks fine, but patch 2 changing the "/memory" node
handling I'm less happy with. Currently we're consistent: we
assume that the memory node must always be called "/memory",
and we look for an existing node that way and create our own
with that name. If in fact memory nodes might not be named
"/memory" then we need to look for any preexisting "/memory@*" node,
not just "/memory", don't we?

thanks
-- PMM
