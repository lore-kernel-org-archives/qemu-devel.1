Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D9DC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C54220578
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C54220578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxVZl-0005uO-IG
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48073)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hxVZJ-0005OO-Tm
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hxVZH-0004aD-Vq
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:06:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hxVZG-0004Yu-LA
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:06:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id p17so107499674wrf.11
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 05:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1FgOWda5SsWVgIyby+hzVupOutSSBcz73OfSRk9+v0U=;
 b=clfBnm6awJM2XjjAMXwKboUzlUfxssqCUucbice/Wklo0nNfbUev2VBQBSjkaEoqwF
 5eRMjFffDwPRSG5koY4ZRrlWYdQGedIzvB0RC6s/MTJWFo9a0Nr1VTCaQSydAAfjiOGX
 8yvKPyfcGhkHStq8Du6l+6RzrpE6DnHCp62Gh8cjJSb2LEFcROZqC5h7FWmaimwTJ87l
 TI0ZFS27SvjVW5VrijCuZIs/PbeZQHQyPUjSDDT1/f7Yiwl23sMrAO9SMzmllPt7+VjM
 1D/QL+8AN+n39LaPgYtAwlL0gBBnYuY6jPKw6/puCnUmQfwIgFzlCxqlnkj5jwM1LJN3
 hM3Q==
X-Gm-Message-State: APjAAAXXJ6To7PRLZdBEo3QDFQXhuUOQKNDmbUX8haSlRsSHCpl97qsq
 /ztH64+tJo3NGyIn+lauEPnI8w==
X-Google-Smtp-Source: APXvYqwJJgGHwPJYMA6BXB7CEKrWIkdPNOHi/bVRBN8W89Eu7ykpFi0tXSicgoimRTdJW0LxPesHyg==
X-Received: by 2002:a5d:6408:: with SMTP id z8mr45455065wru.246.1565697981018; 
 Tue, 13 Aug 2019 05:06:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5193:b12b:f4df:deb6?
 ([2001:b07:6468:f312:5193:b12b:f4df:deb6])
 by smtp.gmail.com with ESMTPSA id o5sm15836029wrv.20.2019.08.13.05.06.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 05:06:20 -0700 (PDT)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, mst@redhat.com
References: <20190813102936.32195-1-dgilbert@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c9a22096-2d05-3857-e27a-3fcc9e2d1f9e@redhat.com>
Date: Tue, 13 Aug 2019 14:06:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813102936.32195-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix MemoryRegionSection alignment and
 comparison
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/08/19 12:29, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> This fixes a symptom I've seen on vhost-user on aarch64 where the
> daemon would be falsely notified of memory region changes that didn't
> exist.
> The underlying problem was me memcmp'ing MemoryRegionSections even
> though they had padding in.
> 
> (Discovered while getting virtiofs working on aarch)
> 
> Dave
> 
> 
> Dr. David Alan Gilbert (2):
>   memory: Align and add helper for comparing MemoryRegionSections
>   vhost: Fix memory region section comparison
> 
>  hw/virtio/vhost.c     |  9 +++++++--
>  include/exec/memory.h | 14 +++++++++++++-
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

I think it can be merged through the vhost tree.

Paolo

