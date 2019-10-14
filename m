Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2B0ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:58:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2DD20873
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 14:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2DD20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK1nS-0007LB-TE
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 10:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vkuznets@redhat.com>) id 1iK1mk-0006bo-Ov
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vkuznets@redhat.com>) id 1iK1mi-0002XS-9D
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:57:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1iK1mi-0002VC-3s
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 10:57:20 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EB33F811DE
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 14:57:17 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id q9so7255397wmj.9
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 07:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=DkYmESCvkqzPI8cu0bSgZGf7oLIsgWwrCSCE1AMG5A0=;
 b=q+rpf9OGkZ69RsxBSzSDYqWHCIgBJ+2dwGra/TDdBrkiQMmMTJknlFSotidyDGQCoH
 IBbLkKJBeH/jjVIiVXEGxmQHKjIP/tMy7qk/Fr7My1Um1vafZnvSqUHX+STbLoB1R7mn
 OG5exi5drG64i/3Ec0JyUHFMLimBXtjGpFMgLxfENs0jCNpY9QvX6TQTnbN4/mET8lPc
 aYBdp2XVB7Jrbcmmq/MU0+ecONQCN3JvNs9XDnxUNlJ80wolR03YkZWEfGj5nrCHQU9j
 eXWm2fNAQ2Yikg7CVtvyO7e6T7bQdc94ee3xnelfIHsTav2SLajdkjjbVwq8HY0pCf22
 SYbw==
X-Gm-Message-State: APjAAAWY3LhSD4GTudZkPQKeM5DdOs6HvVBFkOd5hAdCkjNDpfpPgwMV
 y+cmGoEitKtbIrDEFilXUpzMuY4dsg4bnqgbXUEQNEr0Os9nTrpY4hElRWLhfmVmLEoNSLKzJXa
 e1hniVWE2DRp63Ng=
X-Received: by 2002:a7b:cb8a:: with SMTP id m10mr14371405wmi.132.1571065036697; 
 Mon, 14 Oct 2019 07:57:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw4xINcheBC8vgbQy7E0ixh7c7nKSa/MD6EfRy6mNcx99/7Gzvtdv8Al1WAYd/C2tuPgoMoNg==
X-Received: by 2002:a7b:cb8a:: with SMTP id m10mr14371386wmi.132.1571065036468; 
 Mon, 14 Oct 2019 07:57:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10])
 by smtp.gmail.com with ESMTPSA id 59sm40931491wrc.23.2019.10.14.07.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 07:57:15 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Tianyu Lan <Tianyu.Lan@microsoft.com>,
 "lantianyu1986\@gmail.com" <lantianyu1986@gmail.com>
Subject: Re: [PATCH] target/i386/kvm: Add Hyper-V direct tlb flush support
In-Reply-To: <KL1P15301MB02611D1F7C54C4A599766B8D92900@KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM>
References: <20191012034153.31817-1-Tianyu.Lan@microsoft.com>
 <87r23h58th.fsf@vitty.brq.redhat.com>
 <KL1P15301MB02611D1F7C54C4A599766B8D92900@KL1P15301MB0261.APCP153.PROD.OUTLOOK.COM>
Date: Mon, 14 Oct 2019 16:57:14 +0200
Message-ID: <875zkr5q9h.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Roman Kagan <rkagan@virtuozzo.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Tianyu Lan <Tianyu.Lan@microsoft.com> writes:

>> > --- a/linux-headers/linux/kvm.h
>> > +++ b/linux-headers/linux/kvm.h
>> > @@ -995,6 +995,7 @@ struct kvm_ppc_resize_hpt {
>> >  #define KVM_CAP_ARM_SVE 170
>> >  #define KVM_CAP_ARM_PTRAUTH_ADDRESS 171
>> >  #define KVM_CAP_ARM_PTRAUTH_GENERIC 172
>> > +#define KVM_CAP_HYPERV_DIRECT_TLBFLUSH 174
>>
>> I was once told that scripts/update-linux-headers.sh script is supposed
>> to be used instead of cherry-picking stuff you need (adn this would be a
>> separate patch - update linux headers to smth).
>>
>
> Thanks for suggestion. I just try the update-linux-headers.sh and there are a lot
> of changes which are not related with my patch. I also include these
> changes in my patch, right?
>

Yes, see e.g.

commit d9cb4336159a00bd0d9c81b93f02874ef3626057
Author: Cornelia Huck <cohuck@redhat.com>
Date:   Thu May 16 19:10:36 2019 +0200

    linux headers: update against Linux 5.2-rc1

as an example.

-- 
Vitaly

