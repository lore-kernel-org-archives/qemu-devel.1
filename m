Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978A9C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203A320707
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 17:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJJozhSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203A320707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYDDf-0004NE-Ca
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 12:59:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYCjr-0006e8-I7
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iYCjq-0005Ko-0E
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:28:59 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41525)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iYCjp-0005KF-QW
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 12:28:57 -0500
Received: by mail-ot1-x342.google.com with SMTP id 94so6833455oty.8
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 09:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1/p4r35pOQpW9jRDTQ2sb0rhWVEyVRwRwvHslIe8sQ8=;
 b=OJJozhSDJGSGMiRydYGIH957/KUqHf5Ca0uQfMJgE8BVvJr+TRguJd7EAHbWBSmEhf
 OaO7I1+7VrFidX9VbAqyPpb0ziQx8O2PG2YD2K//LEJR2b+QTrdOiAPpZ1phMZCnxpDy
 egHpwzFFJ4TA8dAH8lJiy12em7cLffEjQO+ZXsaUXb34ueNkdSUKaxmlMWjc0qAw1UZ7
 0A5l+IvLrRc6OrGzxr8k/gBT7y6oTrzlTZMxp0vWR04Pq7L9q0qcFm5rDfl2cTREXCqb
 E1Jd3dOjalpna8kevW45e9QwiWjHcvRLrJztVjkh6/6KOBnA8gYSNbpoYxq82ty4INg6
 szcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1/p4r35pOQpW9jRDTQ2sb0rhWVEyVRwRwvHslIe8sQ8=;
 b=J5xwtcbByfughrMZxXrDuHo2bCuYQbk/8xwwOZKqkJtQ0a1+gEo4yKtFGMT68giIU8
 trO9W+xnbWrzmA3NRUIgGjqF1IZxADOm1bY7eZ/j3QExk6S+4c1CJyP2bpCPxwUdGK/T
 CgXq+qymZ+1BLAIjvoaqO+7EFYh+KgJg9ROZL/czdYHFyW7+t94R6dicT5tjM1cQNPRL
 818kaVt/7udFz5NYSEB/zwEAaMLjqhl8rIag5Spf8Um3ohwauGKEuKuP8Ujrm7lePszG
 sJx8VFcmb1FFp9KnmgLEf6qqpgKW19wGsbjQTOIJkLavbPgyAS+5tFT6ue/2YeZotwMY
 HwwA==
X-Gm-Message-State: APjAAAUcu/tykrBe7J5u8kTWtlB4qhcleHbbAjhbosvMACi30SC/eb0M
 vzofy81xeVfi/Hlce8dZK2hCbBI0yiCny7ivTBQ=
X-Google-Smtp-Source: APXvYqwJjZrp4LJF8NwxK2nO6fS+wFvBE1WQ7wCAnoJAYssk9HFF/f4bCxWP+75D+MOZ/3Q3NFDZzO5U+AW8UmXy5A4=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr12418831otc.295.1574443736660; 
 Fri, 22 Nov 2019 09:28:56 -0800 (PST)
MIME-Version: 1.0
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
In-Reply-To: <20191029212430.20617-2-mrolnik@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 22 Nov 2019 18:28:46 +0100
Message-ID: <CAL1e-=ivdac0gi3bJvmm7knSPHx5fDPXpAHOuck3CJt+yX9Vgg@mail.gmail.com>
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: Michael Rolnik <mrolnik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> +#ifndef CONFIG_USER_ONLY
> +    /* Set the number of interrupts supported by the CPU. */
> +    qdev_init_gpio_in(DEVICE(cpu), avr_cpu_set_int, 57);
> +#endif

Can you please, Michael, explain to me the origin of number "57" here?

Thanks, Aleksandar

