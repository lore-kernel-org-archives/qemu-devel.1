Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B2AC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 18:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938E720833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 18:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938E720833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRKyg-0001xg-Qh
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 14:19:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRKxJ-0001Gx-AE
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRKxI-0006t1-FS
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:18:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRKxI-0006sH-9n
	for qemu-devel@nongnu.org; Thu, 16 May 2019 14:18:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id b18so4396363wrq.12
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 11:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=FtQCug/j+z9J2b4w9SVa+vZzBzyOXeaf8RdeKt3SbO0=;
	b=FIKsTxmi3pisgyKOZdyc5kpVqKTAL9nwqm3jofD7RqRebuLJkhLsIt4HrhUAMX5zAv
	87WkQg2uu+pXi/J8NLwzar5nEM9HOvRXWNlnFZs306KrlqUbDb+SfqPaYSi5fAs7iTje
	UJuRMtvgS5Yzw7M0/hEP3Xe1pDkV61Xun3EwrmaI1w7Ac5LAmT2K5cUV11GmqkyxmVxs
	G6pAGBU2q+1qs0+DBtxMQ4q33u7WCxCt3xHKUEvcy6vVbkyhslXvAZWbnVJCgtSfAfVu
	lTsoUfm9kiJ2Vaq2u+VuNskuOlQ2+jaAZEPuVhDcHN2Cr4R5gndGQ0tWZsP1fstddlS0
	xk5Q==
X-Gm-Message-State: APjAAAVvT9Du6WC+zvirH5CNO8DUZTTbidUx0NHzAL7fWsJnN7fIB9Ky
	zdfcwlNrWIHQ3JLSeZYgh0BNjZ088PQ=
X-Google-Smtp-Source: APXvYqwGqa3HcqElnpS3VcivLQQnzwpvyolROEYQi4MO4Tmdln0kV9fuT3mLw7haXn5PzVrTYVg/kw==
X-Received: by 2002:adf:db87:: with SMTP id u7mr20287931wri.245.1558030691264; 
	Thu, 16 May 2019 11:18:11 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228])
	by smtp.gmail.com with ESMTPSA id f6sm6868250wro.12.2019.05.16.11.18.10
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 11:18:10 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190516163857.6430-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <d8c1a3f3-5dda-e1a6-64a5-9b0721a6f527@redhat.com>
Date: Thu, 16 May 2019 20:18:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516163857.6430-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 0/3] arm: Clean up and rename hw/arm/arm.h
 to hw/arm/boot.h
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/16/19 6:38 PM, Peter Maydell wrote:
> The header hw/arm/arm.h used to be a general bucket for
> putting all kinds of arm-related declarations in. It now
> has mostly kernel-boot related declarations, with one
> exception: the declaration of the system_clock_scale global.
> This patchset:
>  * moves system_clock_scale to armv7m_systick.h (since that
>    is the only device that uses it)
>  * deletes some unnecessary #includes of hw/arm/arm.h
>  * renames it to hw/arm/boot.h, since it now only has
>    declarations relating to hw/arm/boot.c functionality

Yay \o/

> Since system_clock_scale is a weird thing, I have included
> in the first patch an expansion of the comment describing
> it to be clearer about what it does, and also a TODO note
> sketching out how we could go about eradicating this global.
> 
> thanks
> -- PMM
> 
> Peter Maydell (3):
>   arm: Move system_clock_scale to armv7m_systick.h
>   arm: Remove unnecessary includes of hw/arm/arm.h
>   arm: Rename hw/arm/arm.h to hw/arm/boot.h

Series:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

