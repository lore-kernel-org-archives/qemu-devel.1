Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164D9C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 10:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE852070D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 10:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE852070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51939 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRE1K-0006wD-6O
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 06:53:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRDzx-0005uZ-Jm
	for qemu-devel@nongnu.org; Thu, 16 May 2019 06:52:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRDsd-0000Z2-Va
	for qemu-devel@nongnu.org; Thu, 16 May 2019 06:44:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36840)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRDsd-0000Xl-PA
	for qemu-devel@nongnu.org; Thu, 16 May 2019 06:44:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id j187so2964902wmj.1
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 03:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=yAuuq8KF9V9p/k7mioodrg95s1p9HsstM58L3ODAYaM=;
	b=Jwk/vG7SbFNT8VqbqH1evlsSnysN5J4sj2RuYiu+WgTpOgdp0JnyfY2U6DriBWY2+O
	4fKCky2C3hfB1/MOfPHy+6NoAWRTIRBdtQzMus2xNxx0BSk+dZjZlHZW7Bhk+ogwPAow
	6JQUFszxTrvDIVteFbCYdwTzD52Y1oQN1kv8HZL84NJ2ypriZZMpGbyJdWNapmyR0Ak6
	ysjq6KHrdUJ5lUMzyI3pt0c1cRabhQobarM1VkSwTR6B51UWMc6MRdcNqNENUPvGsXdd
	6LuygJtkN5HZgzNZJVo65xBvqntuu2H5hBsrtcHOT2nyf5jCbhujLCLxrROHZy/OlZZX
	QV8Q==
X-Gm-Message-State: APjAAAUQTtTwd+D21jAYSLUiYolCcCvYfo+a7Cfpmvp79yqKPHbTviFe
	t5Ub2zq/Fye/6Ny5wl/PcyGihw==
X-Google-Smtp-Source: APXvYqy76b+eAslpqy2MR9l+H7VlZG6kFCR5T09JjBQOPNHD09eIKUeGt3wBgEJYPOA9B0g4KgWkaw==
X-Received: by 2002:a7b:c40e:: with SMTP id k14mr3131970wmi.114.1558003494628; 
	Thu, 16 May 2019 03:44:54 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	h14sm5679748wrt.11.2019.05.16.03.44.53
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 03:44:53 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Henderson <richard.henderson@linaro.org>
References: <20190514061458.125225-1-ysato@users.sourceforge.jp>
	<ffcd9051-9c72-30ed-f53e-8d0351a76250@linaro.org>
	<87mujnhwa5.wl-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <73abcaad-1672-c670-2957-4b6d1bf3ec16@redhat.com>
Date: Thu, 16 May 2019 12:44:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87mujnhwa5.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v12 00/12] Add RX archtecture support
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yoshinori,

On 5/16/19 6:13 AM, Yoshinori Sato wrote:
> On Thu, 16 May 2019 01:48:29 +0900,
> Richard Henderson wrote:
[...]>> Rather than having you send out a v13 with only changes to the
tags, I will
>> apply them myself while preparing an initial pull request for this.
>>
>> Thanks for your patience.
>>
> 
> OK.
> I prepare v13 which added Reviewed-by.

No need for a v13! Richard already did the work for you :)

