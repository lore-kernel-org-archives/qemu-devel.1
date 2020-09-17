Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11281C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 00:58:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D976C206B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 00:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ihJ6FeaM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D976C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIiGF-0002iM-RD
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 20:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50420)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kIiD3-0000Xw-TJ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 20:55:37 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532]:40049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1kIiD1-0007kO-Lm
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 20:55:37 -0400
Received: by mail-ed1-x532.google.com with SMTP id t16so678118edw.7
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 17:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=JUNRgWNjRaOkPBqAWqTQIpzjuW8eRI0JJxy57SS7DQs=;
 b=ihJ6FeaMSIN9D1PcUPc5u2yrA9Doc0XOjgNa4J+1Ra9F2sBgoO7638e6q6jrPczGEd
 r6W2kN7x3SVbTRy03wg4hYZeVzSopzAsgWpZw9zhc4L4K0eBR/DoDec0BoelWC6WqoYP
 r9fTCanpUgzjuwXjnKc5sdIzbPIJt4Bjzy99k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=JUNRgWNjRaOkPBqAWqTQIpzjuW8eRI0JJxy57SS7DQs=;
 b=pHH9n/Op5blU+3bEPrUw2VwPZtdX7whMGGhPHMzBRpKiYBDMXcd1S9O7XFDMYDCtDS
 SXDvI+KWj1cU/xzOC9skXpfumfdFzGK9J+Z7PtNScoUDaCmFCzs4WeJ1Mm6dmOJY05Jp
 V4ZK50ZhMOkRG+iMxBdpCnzRAOWgW7At/jbwp+Qtr2S8Q0OEkUXT6GsJBbxqj38PhLOt
 SlnHS63dm4fRWvG1YxnUWqfwX1794DIPwKEfa+xgIr/pjdiWZZ57lp0wR0CTFg8SOcXL
 IL+XqsR1kawJE9aHkDVfsC8bGUVL8aSghh0JiYzLhWL9KwVDwxnPY32l4rwtzyr/M4ZC
 kqsw==
X-Gm-Message-State: AOAM530+j9BPyn/Er4rrwj6lHipnfYtl5oilwmCx477uPHlUGPFGwwZq
 cL//prdtM5bHvrlvJ1/7G0xftcp/ZuyZS1BnJfw=
X-Google-Smtp-Source: ABdhPJz/kGsmsiKIAFJu1pWARe9FIp85XZ3XhwQRdA8SQy/C3jAdUXuas0kXABn/vw6qJPoB13yO1JtDBWYaT59liFE=
X-Received: by 2002:aa7:d959:: with SMTP id l25mr29834232eds.383.1600304133933; 
 Wed, 16 Sep 2020 17:55:33 -0700 (PDT)
MIME-Version: 1.0
References: <BY5PR02MB6772761F83EDC56737969C18CA210@BY5PR02MB6772.namprd02.prod.outlook.com>
In-Reply-To: <BY5PR02MB6772761F83EDC56737969C18CA210@BY5PR02MB6772.namprd02.prod.outlook.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 17 Sep 2020 00:55:21 +0000
Message-ID: <CACPK8XexXLYrwMenkyou0Xkc8Tx+p1SNi7jbFBj6aObAKHcBwQ@mail.gmail.com>
Subject: Re: eMMC support
To: Sai Pavan Boddu <saipava@xilinx.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Edgar Iglesias <edgari@xilinx.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 at 18:35, Sai Pavan Boddu <saipava@xilinx.com> wrote:
>
> Hi Philippe,
>
>
>
> We are looking to add eMMC support, I searched the mailing list and found=
 a series posted on eMMC by =E2=80=9CVincent Palatin=E2=80=9D
>
> https://lists.gnu.org/archive/html/qemu-devel/2011-07/msg02833.html

I would be interested in emmc support for the aspeed machines. Please
cc me when you post patches.

> I would like to consider the above work and mix-up with more changes to s=
tart adding support for eMMC. Do you have any suggestions on the approach f=
ollowed in above patches ?

The patches had minor review comments, but I assume the reason they
didn't go anywhere is the author never followed up with further
revisions. I would suggest applying them to the current tree, cleaning
up any style changes that have happened since they were posted, and
re-posting them for review.

Cheers,

Joel

>
>
>
> Note: Here is the existing support available in Xilinx fork, which might =
require some work
> https://github.com/Xilinx/qemu/blob/master/hw/sd/sd.c
>
>
>
> Regards,
> Sai Pavan

