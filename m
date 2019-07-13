Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B4AC31E40
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 19:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 603EC20863
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 19:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603EC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmNuU-00042o-4C
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 15:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46255)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hmNuK-0003eu-NX
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 15:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hmNuJ-0006ZG-Ik
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 15:42:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34585)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hmNuJ-0006YZ-Ck
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 15:42:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so11444166wmd.1
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 12:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LHx6gfoBNbemS/9Mn9G9hg3hweVg/RHjkEuA7HWtY/k=;
 b=XYRb1fCLyYlKmzwZBLdcXxGHNifPvON5tiLu7bu66Hmz+HqXtity6XByqVKmKJ/hCE
 yfMJpayb2EKNHvvSGm3+XtfnqOoAGNW6IVNTPFHt9XcFVh+xN1mak9sOxUpW4sKgPohQ
 T4q+u60bTTckzZE9p5OlYYM6/VZ8aJuNcz3U4QPouyIMLFOQxs3DiKYNSTGWSeArMuJ3
 tjB+8w2whmk2NMxZgCqEoBm62NF7KFL6GYgmQuqWSWH+Wk9YlyT102yp4qFuwbtJTRk4
 rNsCi71qzZ//8YwuezbolIdA8N9hemvbcE3owUh4M1jxsyV58J7TII+qkeFHU3mHykhf
 J9SQ==
X-Gm-Message-State: APjAAAUHSy/Lgpr1lr4x+gh8Yjd9vz+wJmCmTpfV0oYXfba2s3dsT8Q5
 scH0DFS0hFNFgJn2maoVqwWrTw==
X-Google-Smtp-Source: APXvYqxzRrTGV1RcMILVKRmegFFJCV3YQI7xvBL2T2nRC7WG+arUpMrfG860EcNMz1VHkeY0iurU8Q==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr15047442wmh.129.1563046925477; 
 Sat, 13 Jul 2019 12:42:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c1b9:e491:30e8:c02?
 ([2001:b07:6468:f312:c1b9:e491:30e8:c02])
 by smtp.gmail.com with ESMTPSA id x17sm10294446wrq.64.2019.07.13.12.42.02
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Sat, 13 Jul 2019 12:42:04 -0700 (PDT)
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 peter.maydell@linaro.org
References: <030a439f-bb17-8232-bd1c-3585905e8feb@weilnetz.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <f3735415-bd75-8ed6-1dc7-ff51cc7ab03f@redhat.com>
Date: Sat, 13 Jul 2019 21:42:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <030a439f-bb17-8232-bd1c-3585905e8feb@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [BUG] 216 Alerts reported by LGTM for QEMU (some
 might be release critical)
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

On 13/07/19 19:46, Stefan Weil wrote:
> 
> LGTM reports 16 errors, 81 warnings and 119 recommendations:
> https://lgtm.com/projects/g/qemu/qemu/alerts/?mode=list.
> 
> Some of them are already know (wrong format strings), others look like
> real errors:
> 
> - several multiplication results which don't work as they should in
> contrib/vhost-user-gpu, block/* (m->nb_clusters * s->cluster_size only
> 32 bit!),  target/i386/translate.c and other files

m->nb_clusters here is limited by s->l2_slice_size (see for example
handle_alloc) so I wouldn't be surprised if this is a false positive.  I
couldn't find this particular multiplication in Coverity, but it has
about 250 issues marked as intentional or false positive so there's
probably a lot of overlap with what LGTM found.

Paolo

