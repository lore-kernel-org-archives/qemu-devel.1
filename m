Received: from eggs.gnu.org ([2001:4830:134:3::10]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhGBj-00006w-GK
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:17:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhGBd-0005ZO-Do
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:17:51 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:35903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhGBd-0005Yl-6q
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 10:17:45 -0400
Received: by mail-wm0-x229.google.com with SMTP id t201so38541671wmt.1
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 07:17:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170811142954.GN4859@toto>
References: <1502438052-5117-1-git-send-email-frederic.konrad@adacore.com>
	<20170811142954.GN4859@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Aug 2017 15:17:23 +0100
Message-ID: <CAFEAcA_dufY8y2vmHQKR40=MSkkYawH1gV1Swrf2P77K_QV10w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V2 for-2.10] xlnx-qspi: add a property for
 mmio-execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: KONRAD Frederic <frederic.konrad@adacore.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On 11 August 2017 at 15:29, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> On Fri, Aug 11, 2017 at 09:54:12AM +0200, KONRAD Frederic wrote:
>> This adds mmio-exec property to workaround the migration bug.
>> When enabled the migration is blocked and will return an error.
>>
>> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
>
> Thanks Fred!
>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>

Thanks; v2 applied to master.

-- PMM
