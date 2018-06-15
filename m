Received: from eggs.gnu.org ([2001:4830:134:3::10]:59971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTnlg-0001fm-Sa
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTnlg-0002BT-4M
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:23:52 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTnlf-0002B9-Vy
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 08:23:52 -0400
Received: by mail-oi0-x242.google.com with SMTP id 14-v6so8626839oie.3
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 05:23:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1528554193-27270-2-git-send-email-eric.auger@redhat.com>
References: <1528554193-27270-1-git-send-email-eric.auger@redhat.com>
	<1528554193-27270-2-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 13:23:31 +0100
Message-ID: <CAFEAcA9GKDdsQmfvmvS=yGnE72GqNMQuJW3AwqTdsey0iVW8SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/arm/virt: Silence dtc /intc warnings
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
> When running dtc on the guest /proc/device-tree we get the
> following warnings: "Warning (unit_address_vs_reg): Node <name>
> has a reg or ranges property, but no unit name", with name:
> /intc, /intc/its, /intc/v2m.
>
> Nodes should have a name in the form <name>[@<unit-address>] where
> unit-address is the primary address used to access the device, listed
> in the node's reg property. This fix seems to make dtc happy.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

I don't understand why this requirement is in the dt spec, but
whatever...

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
