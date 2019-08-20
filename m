Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEC5C3A59D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:47:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E5FC2070B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 14:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYul3AMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5FC2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i05Pl-0002bF-80
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 10:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1i05O9-0001g7-JQ
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1i05O8-0001cf-Mk
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 10:45:33 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45051)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1i05O6-0001bb-EJ; Tue, 20 Aug 2019 10:45:30 -0400
Received: by mail-pf1-x443.google.com with SMTP id c81so3516378pfc.11;
 Tue, 20 Aug 2019 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mEJQ2VlBrX/Ljs1G71OQwQ4IdSoZUDBUf2d6iCCfin0=;
 b=JYul3AMZKwQOuFwoIrWCiUOItvqru/o4rsl+h6Q6rToSWmx+iKER2e6rHTJB7pulVj
 sdH1+MIep9KPFNrfErjwB/VLhj9sicuJqJvz4GP6uduRYIuf2G77nNbza/LKkaClTlNS
 sj64a2MJzq1YCoap1I40xeo7a6m5EHP5Dcoj+fbTGeZhcbd+AUOMWUhss7G10ym24wAW
 BIPsEs6YikQk68iYoNJ4dPUSpTnKmKRso9Q7UXnFdkxtAwlpgOO82roDXVpVuxLhGNmA
 4xspGq2P+BCEuZqDefQGg1oLVd4UjCen4V7qjClnEwmRyxqBRqnuEsj9qyhbEFLgvX6P
 iKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mEJQ2VlBrX/Ljs1G71OQwQ4IdSoZUDBUf2d6iCCfin0=;
 b=rcalLtP9veDwLDFaB/1iknd5gQz1mVB4EzhEfRx0PzSY0/V1nnIe0p9cvqtQoV/1CD
 5wNxkVWiOkFDbHTW0i8b9ceYH3HMVVeyVpdxcNBNBl8wiEe7kFyWdtv9LxaUJrJZ/yYH
 gSyOEiG7oCnlcSg0XuRMPuz5vyBDZLKJt12fNqF3zB82Z0vIyQcxpoJRiE939CyQqJiU
 vTB/ieZ6BSMHfYgbijJmoSSluOxHG5yG9yYFjJs9TCMOrMIF0LMx14WjaXjAB8bXrqp1
 3dEwxGo9Arz1RsGaaRKWFeygGY8a6PiqaxLTNhu1ivbsRRZN2SDlLo74LgjQm2Br6dtc
 rekQ==
X-Gm-Message-State: APjAAAX7/qzKI1io48knM0c+etqYJ9nsgfpBCl42+X0eSaZl84h/V3fh
 vvHZeg3ADuhKARZl2aR8crw=
X-Google-Smtp-Source: APXvYqz2VY7kTyw60g6hMzioZmI+YuY4rvf3UJKFNQYD17FE2v7oYMKRyrG/huAbTRgb6jR4VQnk7Q==
X-Received: by 2002:a17:90a:d598:: with SMTP id v24mr417798pju.8.1566312329208; 
 Tue, 20 Aug 2019 07:45:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 l25sm19888275pff.143.2019.08.20.07.45.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Aug 2019 07:45:28 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190820123417.27930-1-philmd@redhat.com>
 <3e3fcb30-1e12-eaf4-07a2-47d09aea2511@roeck-us.net>
 <CAFEAcA99kKzWL89gCQ8NZi4XKL=YzKDCJR1tLbXwQDLLmZyZJA@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2e7bf9a5-b0e7-63ec-1872-0ba0bb44e00b@roeck-us.net>
Date: Tue, 20 Aug 2019 07:45:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA99kKzWL89gCQ8NZi4XKL=YzKDCJR1tLbXwQDLLmZyZJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] hw/char/bcm2835_aux: Provide full
 16550 UART support
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 7:34 AM, Peter Maydell wrote:
> On Tue, 20 Aug 2019 at 15:31, Guenter Roeck <linux@roeck-us.net> wrote:
>> I tested with qemu 4.0, 4.1, and mainline (with my patch series applied on top of each).
>> One problem I do see is that booting mainline (as of right now) is _slow_ compared
>> to released versions of qemu. It takes some 35 seconds to get to "Unpacking initramfs",
>> compared to ~8 seconds for v4.1 and earlier. Otherwise it works.
> 
> Hmm, slow compared to v4.1.0 ? That's not so long in the past so
> that seems worth trying to bisect to find the culprit...
> 

Yes, I know. I put it on my task list.

Guenter

