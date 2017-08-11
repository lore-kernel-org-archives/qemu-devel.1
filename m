Received: from eggs.gnu.org ([2001:4830:134:3::10]:50926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dgD8k-0006Q1-SR
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dgD8j-0006KK-QB
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:50:26 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37598)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dgD8j-0006Jg-Hy
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 12:50:25 -0400
Received: by mail-wm0-x22c.google.com with SMTP id i66so52063152wmg.0
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 09:50:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AM3PR04MB0616F921434F49926CA6213DFF890@AM3PR04MB0616.eurprd04.prod.outlook.com>
References: <1495537965-4187-1-git-send-email-diana.craciun@nxp.com>
	<1495537965-4187-2-git-send-email-diana.craciun@nxp.com>
	<17ae81be-a86e-d0ab-de93-046846e0b7d2@redhat.com>
	<AM3PR04MB0616F921434F49926CA6213DFF890@AM3PR04MB0616.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2017 17:50:02 +0100
Message-ID: <CAFEAcA-Qmtc6qM25192u8_YLP9h+Xne0b+zXLfngEE7djx2xXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 1/2] Increased the size of
 requester_id field from MemTxAttrs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Diana Madalina Craciun <diana.craciun@nxp.com>
Cc: Auger Eric <eric.auger@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, Mike Caraman <mike.caraman@nxp.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "marcel@redhat.com" <marcel@redhat.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, "christoffer.dall@linaro.org" <christoffer.dall@linaro.org>, Laurentiu Tudor <laurentiu.tudor@nxp.com>

On 11 August 2017 at 15:32, Diana Madalina Craciun
<diana.craciun@nxp.com> wrote:
> On 07/26/2017 03:23 PM, Auger Eric wrote:
>> With respect to the renaming, stream_id really is ARM specific and
>> corresponds to the ID space before the SMMU while you mostly address
>> device id problematics here (ie. space id input to the interrupt
>> controller). Maybe a more generic terminology such as originator id
>> could be used or source id (I think this is Intel terminology though).
>
> I agree, originator id sounds good and so far it doesn't seem to overlap
> to other specific terminology.

That reminds me that the other thing I'd like to use this field
for is the "identify which CPU of a cluster made this memory
transaction" thing (which you can get on ARM AXI etc buses).
So that's another thing that would need to have some part
of the ID space...

thanks
-- PMM
