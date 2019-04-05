Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B6CC4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:48:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407AE21855
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 15:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407AE21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43708 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCR4y-0003Ou-55
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 11:48:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCR3y-00035w-H3
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCR3x-0001oQ-3v
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:47:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCR3r-0001f4-I4
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 11:47:27 -0400
Received: by mail-wr1-f67.google.com with SMTP id w1so8616895wrp.2
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 08:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=zalpRg/LTX5UQUquy+nu5dJvyZL4geT439n5m5JGgQ0=;
	b=GstStXmjtTPi8cD/XdECrPt+NwXSR8xHa09Y6wPgigm/goe1fqIoc7uw/STzuo9kkm
	ES9w0fqWAeM0PC3akN59CSIaeHcf4u45m1QmTUOu9mc0tQaqGU365OdRiwynyAcSKlb+
	/WHyKDhyaI40tFtSTkeqLjCt31k5+4ZkGjD+urUuK7nz/wc0q96tksX6WTUABxfMB3Zm
	p+JWuCBFRidww66R5P986uJTlfz6lV7/BzBqZRXmDseWa3IHU/Ytbcjrqp9xxUx/fDzE
	8qSwB6tmSqSHevtMDZcUtKwa5LtsQULjdHFV58xzRIqM3fhxhBFM+IKzQSfMmOZAW5xc
	lcsg==
X-Gm-Message-State: APjAAAX3cex4w0gOIGqW15bYsF95l+M6sivaAnUfF1cFd+0v6r+JAvu+
	HBOGGR0kSBLzSSz0E5o18oM6cA==
X-Google-Smtp-Source: APXvYqzCPS89VZbR3ahAtalyUTt8bUmgWgfhnQH0fqBkLKQFNR1binHQg+qoyn5mpQIXfYk0yicAAg==
X-Received: by 2002:adf:cd90:: with SMTP id q16mr9318388wrj.75.1554479240911; 
	Fri, 05 Apr 2019 08:47:20 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193])
	by smtp.gmail.com with ESMTPSA id u2sm3000750wmc.45.2019.04.05.08.47.19
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 08:47:19 -0700 (PDT)
To: =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>
References: <20190319023030.947-1-liq3ea@163.com>
	<4359b7c8.12ac0.169c3e7ba5d.Coremail.liq3ea@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e752c491-1761-7c08-c963-f106b5b178dd@redhat.com>
Date: Fri, 5 Apr 2019 17:47:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4359b7c8.12ac0.169c3e7ba5d.Coremail.liq3ea@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 0/2] tests: fw_cfg: add reboot-timeout test
 case
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
Cc: lvivier@redhat.com, thuth@redhat.com, liq3ea@gmail.com,
	qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
	lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405154718.lWHXZ1-w4HhbOVSs2EYdgEUI9twXrSYjHinFxqGgVPk@z>

On 3/28/19 11:45 AM, ÀîÇ¿ wrote:
> Ping...
> 
> What's your opinion, Philippe?

Eh sorry my email client tagged this series as reviewed since your
previous v1 was reviewed by Laszlo. I'll review your patches, but please
increase the version between series next time so I won't miss it that
easily ;)

> 
> Thanks,
> Li Qiang

