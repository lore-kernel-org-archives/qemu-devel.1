Received: from eggs.gnu.org ([2001:4830:134:3::10]:37906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWgZc-0001TS-7I
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWgZZ-0006Kz-4p
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:42:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cWgZY-0006JQ-Ue
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:42:29 -0500
References: <1484834995-26826-1-git-send-email-peter.maydell@linaro.org>
	<1484834995-26826-27-git-send-email-peter.maydell@linaro.org>
	<6807802b-e9d3-e4d2-f904-e34211a336e9@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9ac50d18-bd27-a32d-8e80-b92bfd975a8f@redhat.com>
Date: Thu, 26 Jan 2017 10:42:25 +0100
MIME-Version: 1.0
In-Reply-To: <6807802b-e9d3-e4d2-f904-e34211a336e9@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 26.01.2017 10:35, Paolo Bonzini wrote:
> 
> 
> On 19/01/2017 15:09, Peter Maydell wrote:
>> +        uint64_t lr = cs->ich_lr_el2[i];
>> +
>> +        if ((lr & ICH_LR_EL2_STATE_MASK) == 0 &&
>> +            ((lr & ICH_LR_EL2_HW) == 1 || (lr & ICH_LR_EL2_EOI) == 0)) {
> 
> This should be "!= 0", not == 1 (reported by Coverity).

A patch for this issue is already on the mailing list - see "arm_gicv3:
Fix broken logic in ELRSR calculation"

 Thomas
