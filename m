Received: from eggs.gnu.org ([2001:4830:134:3::10]:39437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYXho-0000Ao-30
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYXhm-0007qy-Ui
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:15:27 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44135)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYXhm-0007pm-PR
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:15:26 -0400
Received: by mail-oi0-x241.google.com with SMTP id s198-v6so1448695oih.11
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:15:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1530044492-24921-1-git-send-email-eric.auger@redhat.com>
References: <1530044492-24921-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 15:15:05 +0100
Message-ID: <CAFEAcA9v4J8v8Z35LzqfeVBFRa6Vsbp0jfddk8Tg1yzZpJSjig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/3] ARM virt: Silence dtc warnings
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

On 26 June 2018 at 21:21, Eric Auger <eric.auger@redhat.com> wrote:
> When running dtc on the guest /proc/device-tree, we get the
> following warnings: "Warning (unit_address_vs_reg): Node <name>
> has a reg or ranges property, but no unit name", with name:
> /intc, /intc/its, /intc/v2m, /memory.
>
> This series removes those warnings by adding the unit address to
> the corresponding node names.
>
> This is based on Peter's target-arm.next
>
> Best Regards
>


Applied to target-arm.next, thanks.

-- PMM
