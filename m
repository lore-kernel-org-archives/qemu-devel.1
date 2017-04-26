Received: from eggs.gnu.org ([2001:4830:134:3::10]:43664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsprakash.linux@gmail.com>) id 1d3LJr-0004zU-WD
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsprakash.linux@gmail.com>) id 1d3LJr-00076E-8R
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 07:41:16 -0400
MIME-Version: 1.0
In-Reply-To: <1492173995-14140-5-git-send-email-eric.auger@redhat.com>
References: <1492173995-14140-1-git-send-email-eric.auger@redhat.com>
	<1492173995-14140-5-git-send-email-eric.auger@redhat.com>
From: Prakash B <bjsprakash.linux@gmail.com>
Date: Wed, 26 Apr 2017 17:11:11 +0530
Message-ID: <CACJhume5bvQ4tF8RCPZ8W6rEy_jfpMF2BJPYFEYu8GkajUbQkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [RFC v5 4/4] hw/intc/arm_gicv3_its: Allow
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, drjones@redhat.com, Vijay Kilari <vijay.kilari@gmail.com>, quintela@redhat.com, dgilbert@redhat.com, Vijaya.Kumar@cavium.com, Christoffer Dall <christoffer.dall@linaro.org>

On Fri, Apr 14, 2017 at 6:16 PM, Eric Auger <eric.auger@redhat.com> wrote:
> We change the restoration priority of both the GICv3 and ITS. The
> GICv3 must be restored before the ITS and the ITS needs to be restored
> before PCIe devices since it translates their MSI transactions.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
Tested-by: Prakash, Brahmajyosyula <Brahmajyosyula.Prakash@cavium.com>
