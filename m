Received: from eggs.gnu.org ([2001:4830:134:3::10]:36503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWgSp-00040m-8M
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:35:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cWgSk-0002gS-B5
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:35:31 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cWgSk-0002g5-4G
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:35:26 -0500
Received: by mail-wm0-x244.google.com with SMTP id r126so49045183wmr.3
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 01:35:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
	<1484834995-26826-27-git-send-email-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6807802b-e9d3-e4d2-f904-e34211a336e9@redhat.com>
Date: Thu, 26 Jan 2017 10:35:23 +0100
MIME-Version: 1.0
In-Reply-To: <1484834995-26826-27-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 26/36] hw/intc/arm_gicv3: Add accessors for
 ICH_ system registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org



On 19/01/2017 15:09, Peter Maydell wrote:
> +        uint64_t lr = cs->ich_lr_el2[i];
> +
> +        if ((lr & ICH_LR_EL2_STATE_MASK) == 0 &&
> +            ((lr & ICH_LR_EL2_HW) == 1 || (lr & ICH_LR_EL2_EOI) == 0)) {

This should be "!= 0", not == 1 (reported by Coverity).

Paolo

> +            value |= (1 << i);
> +        }
