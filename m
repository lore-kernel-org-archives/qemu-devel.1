Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5589C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:35:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E3B3207CD
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 13:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+lpj6Si"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E3B3207CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqzMn-0005AY-Jt
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 09:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <moharaka@gmail.com>)
 id 1jqvzj-0006gW-1x
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:59:03 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:39650)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <moharaka@gmail.com>)
 id 1jqvzh-0008LD-AR
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:59:02 -0400
Received: by mail-wm1-x32d.google.com with SMTP id w3so14720384wmi.4
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=LA1yLVcqeSGWzEuH47s6WpsYMKByeZ+4N/1ZI4Aw5sc=;
 b=j+lpj6SirnwzNz8WoQ3FqqxKLTje4wjScHLQpmECFcnPxtWyYZADpg5Ip3KjLoPiAr
 p7v4wa16gzcdZpRGPbi5hGJA3qlbMf4V8kdK2Vf2uST+gfOjc2HIieny3d7sNY3qvyvk
 TAIjupAucWLLd/kc+5Iu7/+a81ZGtsE0fINtuUt3YhS5FIKZGSu+LLL6BTu6z4ybnxuN
 RGt9lOAEhqzgIUduijU6oUucQQG1e2kU3eJ0XbwoW78IjF0IZK0hUl/WaAHrXNHIPXlr
 7jkAWBlPa6OtPHYjWg1RMMtmyESHOghmIkT6CFEHRjMsDGmTAPAtRKXZ3SADmAQKln9B
 cEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=LA1yLVcqeSGWzEuH47s6WpsYMKByeZ+4N/1ZI4Aw5sc=;
 b=FJyFybhxwN9bkmdfIqKyL+XvzRJt5a0LS+Hbdn7C5t3y1f3wr8g2Vy5G/NSZiIxvMo
 w+ZkM8R2JgPkXNwB5Gel7QwzDqeb45x2AbV6DSWiUfBHX245iSAwC9Fhss4ShKpZblB1
 E3vWHxP8jgknKRHBtJhGVjlkyjuHHArY16/0Eftn4rhgWFGkiaLxPP0Ga7Ih36VYnyc7
 aB+mKG3dvhq92oEQ3B8nP7G5gjOQPD4yUVnQ1KMxH4h7tBSrJXZZozkhuIGfoZpAFVNf
 NtFiYulcYTXKe3WURTs9pmgCdfi7/ciS5igZCg5934mqM4ScPv1OTgglscLbfIWxtPwY
 IDhg==
X-Gm-Message-State: AOAM532zOgxtbNYv9/4AmfqHyMR83BOlfTnBzqTME9h+XFqWuiGCOp2Q
 rr3xUdRL6+Ku+uOHKCrsjFmJNWBn8EMQ9npy69jqs8ovZrM=
X-Google-Smtp-Source: ABdhPJx0JAgoGi+img5AK48yf4DgThj5WGIk67TrvP5S0OSCQWqt1TJwIGtjYkK77e7YcGdRwhHkZW5wQ1coQmrmmzM=
X-Received: by 2002:a1c:acc2:: with SMTP id v185mr29562858wme.81.1593683938708; 
 Thu, 02 Jul 2020 02:58:58 -0700 (PDT)
MIME-Version: 1.0
From: Karaoui mohamed lamine <moharaka@gmail.com>
Date: Thu, 2 Jul 2020 11:58:47 +0200
Message-ID: <CAEEuMqfOGyMrF7kCSVV5w5SA1waGb+Jyn1oUGkKngS3+qqJyjA@mail.gmail.com>
Subject: Questions regarding the usage of the QIO API
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=moharaka@gmail.com; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 02 Jul 2020 09:32:35 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

(Not sure if this is the right place to ask such a question. Please
redirect me if it is the case.)

I am currently debugging a problem related to the usage of the QIO
interface (qio_channel_closee, qio_channel_add_watch, ...). Where can
I find more information on the internal working of this queues? How
does the "watch" work. Is there a thread in the background handling
these operations?

Regards,
Mohamed

