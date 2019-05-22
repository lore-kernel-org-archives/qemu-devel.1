Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2AFC072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:31:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED0A204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 08:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED0A204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38414 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTMev-0003Ns-Ow
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 04:31:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hTMdC-00027x-Ul
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hTMd9-0007X5-Fu
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:29:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hTMd2-0007Nu-F4
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:29:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id f10so1221279wre.7
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 01:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=xX4jzD7rvGD1ipojV5aCpZ9JBCg71X2h8h8GHoavWvk=;
	b=gyZecndetBMbVMVioMY3F1PsIr20BlqO6RGZztywwMVZgDkW8Mz4YaKu2tTyfhW1kv
	HX05bfA/64/SZ6Lj/E5sOqFUkjw1t8Dzam4ZODN14d6KtF1vOYASy2Ogc83C7eC+jZxd
	/zL740MMAWlsBL6h2XRDflvqtBDAA7Nfyi2ZWVX9f6+fplI5xYEEK82UIRaRPjt4x/mz
	fbh9SZp7I8+x9em+4n8OEmAw+KFO/qm2kzERouhwe+9wG0Ujczhby/mopEw05L1FtC+b
	XM1gzZcVV0xSDIHq0Ny745qmRmAR1LOfBzPhRMs+vcXCnlUELCeeF8PqA0pEF8qPvH40
	wTxQ==
X-Gm-Message-State: APjAAAXfnfL7yOl0HBWeck41+xZlxtVbadE+PNki5uhlf9PmJz3vL7kr
	aJ6tqE1Jw7hIzWJC2e/swx/lZw==
X-Google-Smtp-Source: APXvYqwa5WyEsCzm6U/I4ojUGRR+pvTh8b1Zaa3Il0pCttUKDiMJarRGYf0nHjjLzQG/zkb3SoYq2w==
X-Received: by 2002:adf:9c8a:: with SMTP id d10mr37588041wre.9.1558513775776; 
	Wed, 22 May 2019 01:29:35 -0700 (PDT)
Received: from [10.32.181.147] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
	by smtp.gmail.com with ESMTPSA id 16sm3918173wmx.45.2019.05.22.01.29.35
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 01:29:35 -0700 (PDT)
To: Li Qiang <liq3ea@gmail.com>, Li Qiang <liq3ea@163.com>
References: <20190510164349.81507-1-liq3ea@163.com>
	<CAKXe6SLe1_ppEACqKVesvfrieN=c28rj9ro_xSGZ6F=Rf7iWew@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e278d0cc-df8d-01c6-df02-79757134d35a@redhat.com>
Date: Wed, 22 May 2019 10:29:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKXe6SLe1_ppEACqKVesvfrieN=c28rj9ro_xSGZ6F=Rf7iWew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v4 0/3] hw: edu: some fixes
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Jiri Slaby <jslaby@suse.cz>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/05/19 15:30, Li Qiang wrote:
> Ping....
> 
> Paolo, could you merge these to your misc tree?

Queued now, thanks.

Paolo

> Thanks,
> Li Qiang
> 
> Li Qiang <liq3ea@163.com <mailto:liq3ea@163.com>> 于2019年5月11日周六 上
> 午12:44写道：
> 
>     Recently I am considering write a driver for edu device.
>     After reading the spec, I found these three small issue.
>     Two first two related the MMIO access and the third is
>     related the DMA operation.
> 
>     Change since v2:
>     Fix an error in patch 2
>     Fix some commit message and title.
> 
>     Change since v1:
>     Fix format compile error
> 
>     Li Qiang (3):
>       edu: mmio: allow 64-bit access
>       edu: mmio: allow 64-bit access in read dispatch
>       edu: uses uint64_t in dma operation
> 
>      hw/misc/edu.c | 32 +++++++++++++++++++++++---------
>      1 file changed, 23 insertions(+), 9 deletions(-)
> 
>     -- 
>     2.17.1
> 
> 


