Received: from eggs.gnu.org ([209.51.188.92]:57922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw755-0000My-PA
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gw754-0007Iq-Bq
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:13:11 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gw753-0007Hh-Uh
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:13:10 -0500
Received: by mail-ot1-x342.google.com with SMTP id 98so34795696oty.1
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 07:13:09 -0800 (PST)
MIME-Version: 1.0
References: <20190219144621.450-1-aaron@os.amperecomputing.com>
In-Reply-To: <20190219144621.450-1-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Feb 2019 15:12:55 +0000
Message-ID: <CAFEAcA98f=vibRvCNuq2qp_Hbj83LeZZPOMd-qLxxXYrPMOcEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Stop unintentional sign
 extension in pmu_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay OS <aaron@os.amperecomputing.com>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, 19 Feb 2019 at 14:46, Aaron Lindsay OS
<aaron@os.amperecomputing.com> wrote:
>
> This was introduced by
>     commit bf8d09694ccc07487cd73d7562081fdaec3370c8
>     target/arm: Don't clear supported PMU events when initializing PMCEID1
> and identified by Coverity (CID 1398645).
>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>



Applied to target-arm.next, thanks.

-- PMM
