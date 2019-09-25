Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74142C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 03:13:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42A1E2146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 03:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42A1E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCxk2-0006nP-76
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 23:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iCxj8-00062d-5i
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 23:12:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iCxj7-0005JQ-5K
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 23:12:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55476)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iCxj6-0005JB-UG
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 23:12:25 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1E6EC356C9
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 03:12:23 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id i28so2959259pfq.16
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 20:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=SxWeFAftkLVD5Ddb9kYAIGa760Orcn7HpvueUtL2Lq4=;
 b=bHpHsvAbWbcg47qw+vUncQP3eoS3qw0/2SqsqHLorFKlPGTM3V/NWvV9plR3LcO8fC
 EZu74t8R22Y1yO3LFldWa0OEc34NwdnQvaePUZ2LDtx3y/0WNWYYq3rrlivk16ebuIjt
 nk+RCKRRnOgg/Uig1t3sjN02Y07msdJbG/1Q+ugzG8F1NPPZ6fObcz2J3miX/X9ikRI5
 Z/cJ37NvhMSvlU4iEXV4aq1k35puwbtbADynF06V3FZ9+cQcFMYS4Nmu1thch4jo/1T9
 nfccRKYP+7Y0EwoMpbKnrwjrd6qXydQqsEtXkFEj4seQwRNPP6UxiTDB1ESmJeAY8N/h
 NsGQ==
X-Gm-Message-State: APjAAAXSQXguZSi4rktzm6gLBAnN3f2tL9XucaDF5gLEi3ILwtbWJZzS
 Wc3P/U6mZOb8wiIAqNJSX/ASMUOA71HepoJT3AkS7btOkBgHStfcFsAS/OkjPSvaVV6fUY149Al
 BdAe/J3XuEnSd2xY=
X-Received: by 2002:a62:1a4d:: with SMTP id a74mr7180314pfa.179.1569381142510; 
 Tue, 24 Sep 2019 20:12:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz0WkdzEmFMNW8f0ghzAznZnG9Yicu09l1xVZxdmHenXIcPAD8zoxo28z2J7lbr2lcBy/LQoQ==
X-Received: by 2002:a62:1a4d:: with SMTP id a74mr7180297pfa.179.1569381142308; 
 Tue, 24 Sep 2019 20:12:22 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id g4sm3621169pfo.33.2019.09.24.20.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 20:12:21 -0700 (PDT)
Date: Wed, 25 Sep 2019 11:12:11 +0800
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v7 3/4] kvm: split too big memory section on several
 memslots
Message-ID: <20190925031211.GH28074@xz-x1>
References: <20190924144751.24149-1-imammedo@redhat.com>
 <20190924144751.24149-4-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924144751.24149-4-imammedo@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 24, 2019 at 10:47:50AM -0400, Igor Mammedov wrote:

[...]

> @@ -2877,6 +2912,7 @@ static bool kvm_accel_has_memory(MachineState *ms, AddressSpace *as,
>  
>      for (i = 0; i < kvm->nr_as; ++i) {
>          if (kvm->as[i].as == as && kvm->as[i].ml) {
> +            size = MIN(kvm_max_slot_size, size);
>              return NULL != kvm_lookup_matching_slot(kvm->as[i].ml,
>                                                      start_addr, size);
>          }

Ideally we could also check that the whole (start_addr, size) region
is covered by KVM memslots here, but with current code I can't think
of a case where the result doesn't match with only checking the 1st
memslot. So I assume it's fine.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

