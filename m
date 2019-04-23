Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2620C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:04:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE5E621738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5E621738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51749 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hItE6-0001DN-UI
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 07:04:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1hItAI-0007GU-Ku
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1hIt90-0007q9-Ed
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:59:23 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:43476
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chouteau@adacore.com>)
	id 1hIt8z-0007oP-6e
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:59:21 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 3BE4F81396;
	Tue, 23 Apr 2019 12:59:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
	by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LT0lat-wJQQK; Tue, 23 Apr 2019 12:59:19 +0200 (CEST)
Received: from [192.168.42.81] (unknown [37.175.125.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.eu.adacore.com (Postfix) with ESMTPSA id D07CA81386;
	Tue, 23 Apr 2019 12:59:18 +0200 (CEST)
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
References: <1555669092-10351-1-git-send-email-frederic.konrad@adacore.com>
	<1555669092-10351-3-git-send-email-frederic.konrad@adacore.com>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <dac838c9-171c-d14e-c0ec-0d3f16d2b7ed@adacore.com>
Date: Tue, 23 Apr 2019 12:59:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1555669092-10351-3-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 194.98.77.210
Subject: Re: [Qemu-devel] [PATCH V1 2/3] leon3: introduce the plug and play
 mecanism
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423105915.8FF_3Pg1u-GQNtS9a5gUDJfZRc-El44PIn44GbfH1-c@z>

On 19/04/2019 12:18, KONRAD Frederic wrote:
> This adds the AHB and APB plug and play devices.
> They are scanned during the linux boot to discover the various peripheral.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>

Reviewed-by: Fabien Chouteau <chouteau@adacore.com>


