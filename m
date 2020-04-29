Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A12AC83000
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:57:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34872072A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 16:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQAWjORV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34872072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTq1O-0001oo-0G
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 12:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTpzQ-00009p-B1
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:55:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jTpyY-0007Ug-Gq
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:55:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47156
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jTpyR-0007Tw-S6
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 12:54:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588179253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=04cE46b+XwMuf3qMdy8XM6DzChLGo0GaryYqzAjasME=;
 b=UQAWjORVD0CS9Vm2FC8rJSCXO59z8ETg4NAxbSNGNX0QoakwOCB0sBmpK+zaFyipyVfk3z
 yZQFbc9mDlpYu6gQn/H6UTTJPxsPiyy3RI7Jhnw8c4FC0dc/cF9XPcmjLNUk6GfQieb2bH
 oPq79xxg07IzWrDkFAY8VsxKizaEKyI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-kyBWyR6sPt-sn8s3Tf83nw-1; Wed, 29 Apr 2020 12:54:12 -0400
X-MC-Unique: kyBWyR6sPt-sn8s3Tf83nw-1
Received: by mail-wr1-f72.google.com with SMTP id i10so2042321wrq.8
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 09:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=04cE46b+XwMuf3qMdy8XM6DzChLGo0GaryYqzAjasME=;
 b=KmMAFrS5lKZ5vACe9FuGNJRcZHhgguAkMUUD6p3Ib/JoTu58q7Th8ngp/K17Ab6CUi
 VWXtFdX0PjLYZOxaQhzjing6VNzU74CWdteqanpUenN8Mz64B2Xwn0F2DMMT05rVyQuP
 agBd7BPXLx1r0M7UYQccCbjcisj1njDPZUWgddloMHp4AlICLo45dEtKdq3uXHyQE+r+
 s9y0fd5+hzCcvUfJGUR7ktg0sE7d8lLXGWQehGBn8Wni9Lx+4v4Csh6iBIjXThPeuPzy
 PqiIjUOCmqOYOPrt7mJht+QXHyxYPV4FeEdtKBvDgoX/zAHMxgNujaj/QKWdhLBjvI5h
 f3KA==
X-Gm-Message-State: AGi0PuZ70/L48cdb+09Ag7gtE0jc8IITSsAKH+6E0NRSNiT5lJyjmVZr
 OuVUSkWaiFDAw/uOPFnKxGMrNOxYUtO93n6fyjoDf8l/ZRIyoWtOzRh1LdMypyJWO2YBOHci29Y
 0Ad6MRyjXpsqQ+I8=
X-Received: by 2002:a1c:808c:: with SMTP id b134mr4472068wmd.131.1588179250952; 
 Wed, 29 Apr 2020 09:54:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypIlGEJroF6dKS5WiBi5dPYw3JzSsRAd2vTLpbgQF9TftZdIh9zOza4RBbyN7aeQEpxuKC4blA==
X-Received: by 2002:a1c:808c:: with SMTP id b134mr4472032wmd.131.1588179250559; 
 Wed, 29 Apr 2020 09:54:10 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id e21sm32283309wrc.1.2020.04.29.09.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Apr 2020 09:54:09 -0700 (PDT)
Subject: Re: [PATCH 00/12] audio: deprecate -soundhw
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200429110214.29037-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f2d7187a-953c-2b53-07fb-0a3e5f32193d@redhat.com>
Date: Wed, 29 Apr 2020 18:54:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429110214.29037-1-kraxel@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,

On 4/29/20 1:02 PM, Gerd Hoffmann wrote:
> 
> 
> Gerd Hoffmann (12):
>    stubs: add isa_create_simple
>    stubs: add pci_create_simple
>    audio: add deprecated_register_soundhw
>    audio: deprecate -soundhw ac97
>    audio: deprecate -soundhw es1370
>    audio: deprecate -soundhw adlib
>    audio: deprecate -soundhw cs4231a
>    audio: deprecate -soundhw gus
>    audio: deprecate -soundhw sb16
>    audio: deprecate -soundhw hda
>    audio: deprecate -soundhw pcspk
>    [RFC] audio: try use onboard audiodev for pcspk

I don't understand what you are trying to fix with this series.

I suppose there is a problem with the pcspk, as I had a problem when I 
tried to make the soundhw more QOM-friendly. pcspk needs rethink and 
some work so I didn't finished. Also I had a problem with intel-hda. I 
see in your series both are handled differently. I'll send the patch 
with the broken code marked XXX, maybe you can it figure out.

> 
>   include/hw/audio/soundhw.h |  2 ++
>   hw/audio/ac97.c            |  9 ++-------
>   hw/audio/adlib.c           |  8 +-------
>   hw/audio/cs4231a.c         |  8 +-------
>   hw/audio/es1370.c          |  9 ++-------
>   hw/audio/gus.c             |  8 +-------
>   hw/audio/intel-hda.c       |  3 +++
>   hw/audio/pcspk.c           | 27 ++++++++++++++++++++++++---
>   hw/audio/sb16.c            |  9 ++-------
>   hw/audio/soundhw.c         | 24 +++++++++++++++++++++++-
>   qdev-monitor.c             |  2 ++
>   stubs/isa-bus.c            |  7 +++++++
>   stubs/pci-bus.c            |  7 +++++++
>   stubs/Makefile.objs        |  2 ++
>   14 files changed, 79 insertions(+), 46 deletions(-)
>   create mode 100644 stubs/isa-bus.c
>   create mode 100644 stubs/pci-bus.c
> 


