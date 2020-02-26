Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E215C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D0724685
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 11:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkqCp7Ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D0724685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6v5c-0001IH-DB
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 06:42:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j6uxU-0006jI-E7
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j6uxT-0002oI-9c
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:34:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22313
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j6uxT-0002ml-3r
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 06:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582716870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KZ9xyAN/fKfJ+/H8CTU+tfHmyyUm3c5B95Cg7SaxOkM=;
 b=PkqCp7GeuWUmpqCuLCO4d32CO12Zui0Q9X2ZsqUcasHwgSlcu1uNrSwbNpd3SyOROtFn0v
 Bvztn2Gu9nNBk+sT0NYAKLDoQ98Nv4oZqctaIReYsXvHnxKbji1yRQT3fo/zuZE32Z4jLS
 AEO2YAI3P5HfcVYTE7TYxfmD3rr89F4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-iKrsMkV8OsuinlBxD1_aXA-1; Wed, 26 Feb 2020 06:34:29 -0500
X-MC-Unique: iKrsMkV8OsuinlBxD1_aXA-1
Received: by mail-wm1-f72.google.com with SMTP id w12so581605wmc.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 03:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KZ9xyAN/fKfJ+/H8CTU+tfHmyyUm3c5B95Cg7SaxOkM=;
 b=Osli7CSWoOLDly2v2FtNhzlDoBbUFEhGMnPpQ5UyKnO/jahZwk0F94fz13hFStULUH
 hEomgGoeSvUtM0YfGLIZdcPsmE3kcQrublJ86LAtU3Ql07eDyVhjgbRngUkQxTmyq+gT
 0VvNobXsb2D1BYqbIqioTRXKBDfDK/Q2l2HuM1FHt4tj+k2Fg3zI7LGJ1KpUqtEExgqR
 pNQdBRsXBZjWHzbfNhAAM5y2Uz3+WB86ltcNaqiMxilGV5UqJNnetcLncqNDK9bWAF4s
 CdIGwWxabflDURg/ukwPaQdW0oeWmBhbMRC60VBT1Nq1NWVWSUnzf4eAy4SYu1Tp0ifK
 qKrg==
X-Gm-Message-State: APjAAAUba3yXfCALFDnCuGRp89tjyfM5aO+cfAhVbyTZ9fOeTyxNJMEt
 kx0Mz5RjieI9qG1UubcUOBUJyQdXKT9G8BrXNT7egTj+29+2zSGyImosBihsQavA2yLdynYMPwT
 xk4DhxZ+uyaxHAUA=
X-Received: by 2002:a5d:514b:: with SMTP id u11mr5042080wrt.322.1582716867711; 
 Wed, 26 Feb 2020 03:34:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqx21tN5L6KTT+nqZ2PzffeNVPxcK/Ra4gJamuiXFN0b/AGMtAVYfPhUXQ4HXJeVXcuhARNWvg==
X-Received: by 2002:a5d:514b:: with SMTP id u11mr5042054wrt.322.1582716867383; 
 Wed, 26 Feb 2020 03:34:27 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f?
 ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
 by smtp.gmail.com with ESMTPSA id l6sm2986203wrn.26.2020.02.26.03.34.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 03:34:26 -0800 (PST)
Subject: Re: [PATCH qemu v7 0/5] spapr: Kill SLOF
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <20200220061622.15064-1-aik@ozlabs.ru>
 <db675fc6-9d07-1780-134d-6a9279328b29@redhat.com>
 <68b71292-48db-e2ec-5f22-fe4580c2938e@ozlabs.ru>
 <4109357e-0912-9633-20ad-28269efb2422@redhat.com>
 <9fc15711-5d06-e73a-798c-6f7c9ee05884@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1c8cffc2-9a4a-9389-814b-c40d60a6a919@redhat.com>
Date: Wed, 26 Feb 2020 12:34:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9fc15711-5d06-e73a-798c-6f7c9ee05884@ozlabs.ru>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/02/20 00:58, Alexey Kardashevskiy wrote:
> 
> 
> On 21/02/2020 19:27, Paolo Bonzini wrote:
>> On 21/02/20 01:18, Alexey Kardashevskiy wrote:
>>> I am not quite sure I understood the request.  Write my own small
>>> firmware and replace GRUB with it? The firmware from 5/5 reads first 2
>>> sectors and the entire PReP, I could add there stuff if that helps (I
>>> have "work in progress" patch for the firmware with printk/etc borrowed
>>> from SLOF).
>>
>> Okay, that's great!  I'll take a look next week.
> 
> Just to make sure I understood - you'll take a look on this series, you
> do not expect other patches on top, right?

No, thanks.

> ps. while I have your attention, what was the practical reason for
> including capstone to QEMU? Thanks,

Newer versions of the binutils disassembler are GPLv3.

Paolo


