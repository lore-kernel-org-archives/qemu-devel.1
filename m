Received: from eggs.gnu.org ([208.118.235.92]:33173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fz6W9-0000qk-Ib
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 16:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fz6Po-0008Ka-Gk
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 16:34:44 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:43809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fz6Po-0008JW-A9
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 16:34:40 -0400
Received: by mail-wr1-x434.google.com with SMTP id k5-v6so19743555wre.10
	for <qemu-devel@nongnu.org>; Sun, 09 Sep 2018 13:34:40 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180824093343.11346-1-peter.maydell@linaro.org>
	<20180824093343.11346-22-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <141d1a23-9559-25ed-d1ea-eae14e3f7daf@redhat.com>
Date: Sun, 9 Sep 2018 22:34:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180824093343.11346-22-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 21/52] hw/timer/cmsdk-apb-dualtimer:
 Implement CMSDK dual timer module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 24/08/2018 11:33, Peter Maydell wrote:
> ze);
> +
> + if (offset >= A_TIMERITCR) {
> + switch (offset) {
> + case A_TIMERITCR:
> + s->timeritcr = value & R_TIMERITCR_VALID_MASK;
> + cmsdk_apb_dualtimer_update(s);
> + case A_TIMERITOP:
> + s->timeritop = value & R_TIMERITOP_VALID_MASK;
> + cmsdk_apb_dualtimer_update(s);
> + default:

Two missing "break"s here (Coverity CID 1395626 and 1395633).

Paolo
