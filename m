Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2109DC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E5021738
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 11:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E5021738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=adacore.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51797 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hItFg-0002dl-UA
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 07:06:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1hItAJ-0007GU-PK
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 07:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1hIt8Y-0007WR-0t
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:58:54 -0400
Received: from mel.act-europe.fr ([2a02:2ab8:224:1::a0a:d2]:51911
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chouteau@adacore.com>)
	id 1hIt8X-0007Td-RG
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:58:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-smtp.eu.adacore.com (Postfix) with ESMTP id 43C5A81387;
	Tue, 23 Apr 2019 12:58:51 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at eu.adacore.com
Received: from smtp.eu.adacore.com ([127.0.0.1])
	by localhost (smtp.eu.adacore.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J7Y6iKEN8PzO; Tue, 23 Apr 2019 12:58:51 +0200 (CEST)
Received: from [192.168.42.81] (unknown [37.175.125.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.eu.adacore.com (Postfix) with ESMTPSA id B042781386;
	Tue, 23 Apr 2019 12:58:50 +0200 (CEST)
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
References: <1555669092-10351-1-git-send-email-frederic.konrad@adacore.com>
	<1555669092-10351-2-git-send-email-frederic.konrad@adacore.com>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <92f9bdab-36af-d76a-02b4-0ea2610b7498@adacore.com>
Date: Tue, 23 Apr 2019 12:58:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1555669092-10351-2-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 2a02:2ab8:224:1::a0a:d2
Subject: Re: [Qemu-devel] [PATCH V1 1/3] leon3: add a little bootloader
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
Message-ID: <20190423105847.D-2RnkhQy_Tp4qX9be8gn-UD13BX-6rloql3FI1E2vs@z>

On 19/04/2019 12:18, KONRAD Frederic wrote:
> This adds a little bootloader to the leon3_machine when a ram image is
> given through the kernel parameter and no bios are provided:
>   * The UART transmiter is enabled.
>   * The TIMER is initialized.
> 
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>

Reviewed-by: Fabien Chouteau <chouteau@adacore.com>

