Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2E3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4343020720
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ax2vgehU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4343020720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrInJ-0007c0-Hy
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrIex-00033D-EF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:11:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38913
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jrIev-0006sk-KF
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593771064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yEfcz2rK/9fRwPpahCFA4sEVsqZNupDgbZ7kPoWO4ww=;
 b=Ax2vgehUl/X+3MOFEt01KsdLGEKPQg1/koBwyK7DUhmgH7uHo8t1W/+itaeo8eLnYMKxGO
 2vTEZsl9dDcAh1b/kdBomdL/ppTcLRZQAC0m74ybJx2oSe46O+5RhT/BfGN3Wz78HHGaTD
 JnStVtzBHo0Yh+iLR2L8Qamy3SW4tek=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-Q8EWv4lDPpCDOXnvYGgr8Q-1; Fri, 03 Jul 2020 06:11:03 -0400
X-MC-Unique: Q8EWv4lDPpCDOXnvYGgr8Q-1
Received: by mail-wr1-f69.google.com with SMTP id w4so29220509wrm.5
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 03:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yEfcz2rK/9fRwPpahCFA4sEVsqZNupDgbZ7kPoWO4ww=;
 b=ESE7QiC+NbNbr4YY6DpV1od/lS5JCQ9P17IsLm1UmeRSDoXdVK9iUoRraCPszXL1gs
 m4a8ZyVzhmgNPz3DkN69u6wierjX60WUHDG1Rd5bEEUoIM22SEiXhZP+ZU/cOuhfrZ0U
 YT9QLCLq/uSxtujtFBD5r6IhGfqXjRolUdKxv2OTEzXpIoRVQi1WKmgs14FUKcqrDnbC
 /Hp3aOqIsDLUsDAb1AcvH9Onnc2dLyqcfAzk0DGZoI+1BDFUsV0RO5kGqJpt0inDj3++
 mI4Y6NpvoF60lFAaVedCuWdW+4UOFGIuyffbIDS56Qi7EQpgNYZpWeyrsfUXqKdxFnaf
 x7qA==
X-Gm-Message-State: AOAM531iizG/xaFpowO3ISFF7Tg/6iTMnPkE9kKeh/ZE9D019bYAdjWi
 sUctxm0M/KLGSsT8LokPdUPEt1x2/lhRK7OHAFweplNlBmwwkradIf+Z4qMJqEi8szUT7cNZ+4g
 qE7lL+Pjy3IrBLgg=
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr35222865wru.418.1593771060429; 
 Fri, 03 Jul 2020 03:11:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3pMwcCLTvn3yRt2pvWu0uPy9saUnGu03QqxhMq05Zgf2dmwgLY5CExssbUh7ZjaFRA9aajA==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr35222847wru.418.1593771060218; 
 Fri, 03 Jul 2020 03:11:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b520:5163:43e4:be52?
 ([2001:b07:6468:f312:b520:5163:43e4:be52])
 by smtp.gmail.com with ESMTPSA id i67sm11258436wma.12.2020.07.03.03.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2020 03:10:59 -0700 (PDT)
Subject: Re: [RFC v2 0/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20200626064122.9252-1-eperezma@redhat.com>
 <52d97ca5-7dbd-3178-64d6-509a8f096f0b@redhat.com>
 <CAJaqyWe3QoCQ7=pe7mCpa548kLRDdhhfLydtbgzX7nkSkJ6img@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19ad73ce-8e21-5ec2-f88f-6ec183bc1b6b@redhat.com>
Date: Fri, 3 Jul 2020 12:10:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWe3QoCQ7=pe7mCpa548kLRDdhhfLydtbgzX7nkSkJ6img@mail.gmail.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Avi Kivity <avi@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/07/20 09:39, Eugenio Perez Martin wrote:
> #4  0x0000555555888171 in memory_region_notify_one
> (notifier=0x7ffde0487fa8, entry=0x7ffde5dfe200) at
> /home/qemu/memory.c:1918
> 1918        assert(entry->iova >= notifier->start && entry_end <=
> notifier->end);
> (gdb) p *entry
> $1 = {target_as = 0x555556f6c050, iova = 0, translated_addr = 0,
> addr_mask = 18446744073709551615, perm = IOMMU_NONE}

Oh, I see now.  I am worried that an IOMMU notifier could interpret the
IOMMUTLBEntry incorrectly if there is only partial overlap.  There are
various possibilities:

1) create another IOMMUTLBEntry like

	hwaddr offset = notifier->start > entry->iova ? notifier->start -
entry->iova : 0;
	IOMMUTLBEntry partial = {
	    .target_as = entry->target_as,
	    .iova = entry->iova + offset,
	    .translated_addr = entry->translated_addr + offset,
	    .addr_mask = MIN(entry->addr_mask, notifier->end - notifier->start),
	    .perm = entry->perm
	};

The addr_mask however would not be a mask if the notifier is not
naturally aligned

2) pass the offset/size pair (computed as above) as extra arguments to
the IOMMUNotify function

3) add a function to compute the offset/size and call it in the notifier

You choose. :)

Paolo


