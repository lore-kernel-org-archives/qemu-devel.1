Received: from eggs.gnu.org ([2001:4830:134:3::10]:35609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvNYv-0005j9-Ft
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cvNYu-0006Ol-MS
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:27:53 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cvNYu-0006OX-GN
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:27:52 -0400
Received: by mail-wr0-x231.google.com with SMTP id w43so212041402wrb.0
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 05:27:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490276212-32008-2-git-send-email-diana.craciun@nxp.com>
References: <1490276212-32008-1-git-send-email-diana.craciun@nxp.com>
	<1490276212-32008-2-git-send-email-diana.craciun@nxp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Apr 2017 13:27:29 +0100
Message-ID: <CAFEAcA8s9aR4rbJzd=9-oRashOGvUtSL4xxqbu2M1Cv2YFND7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH RFC 1/2] Increased the size of requester_id
 field from MemTxAttrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Diana Craciun <diana.craciun@nxp.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, Mihai Claudiu Caraman <mike.caraman@nxp.com>, bharat.bhushan@nxp.com, Christoffer Dall <christoffer.dall@linaro.org>, laurentiu.tudor@nxp.com

On 23 March 2017 at 13:36, Diana Craciun <diana.craciun@nxp.com> wrote:
> The PCI requester ID field is 16 bits. The requester_id field
> from MemTxAttrs is used for MSIs to specify the device ID for
> the platforms where this device ID is needed (e.g virt machine + GICv3
> ITS). However, if more entities that uses MSIs in the system are used,
> 16 bit is no longer enough to represent the device ID. Increased the size
> of this field to 24 bits in order to accomodate 256 entities.
> Also the name requester_id does no longer reflect the content, so
> the name was changed to stream_id.

This name change would be reverting the name change in
commit a05f686ff3, which says:
    MemTxAttrs.stream_id also renamed to requester_id in order to better
    reflect semantics of the field.

I don't have a strong opinion about the name myself, but flipping
backwards and forwards doesn't seem like a great plan :-)

thanks
-- PMM
