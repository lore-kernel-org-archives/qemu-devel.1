Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB89CC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19BE20854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 10:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19BE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKJzy-0003LD-UX
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 06:24:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iKJzB-0002ob-AP
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:23:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iKJz8-0007Kw-Lw
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:23:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32218)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iKJz8-0007Kh-Dg
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 06:23:22 -0400
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 75D127BDA6
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 10:23:21 +0000 (UTC)
Received: by mail-pf1-f200.google.com with SMTP id s139so15604107pfc.21
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 03:23:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2ZfJRR8jSFF61R4oFYlq61zlWwweZUAlv1dwwCV8pys=;
 b=tcKNhqMg9JP5HwiMRJeFurQxfF+LhkxaiOUfqcWKxjOjQjBNZEtYN0HIaNBpsHk90n
 BS3yzDaZ92h53rZDOB4NLphLKkmozTAGSV0qsg/ZW1wfeKhgNy7kLKYxfRwu9S/ghwks
 1S/jtnCfSqSJCrB6J7wKH7y5sT6TRNe/iKJ8Mh6nqwAcKvLK7ppEJY4B+VVViD3HkfSA
 CvDBvU+qbvtFL/p/ohp79q/hT4VxQ4aa8ngL4+ioEQocqDHQNxe4GzFlVsrO6/dztMfx
 5g0gVO8Ztg89D2A4hL0iJOxXhubxzzY4O303rYm+j9PxIAgN/umCioXG2ObBu0LrvLXQ
 KlIA==
X-Gm-Message-State: APjAAAWtNiH7K4LKRZWiWc+Iy2w1rbDihNA7uoHmueyPcR6XKwxGE20V
 KGzNG1pZvZxnNs3qhCyRxi6MoSkRPpiGMC7Xsryjt+NdMIHmoIfVQDR/e4xSfJ3e/oRHHtQLERG
 /QDdRD8+PPiIDtAM=
X-Received: by 2002:a17:902:9002:: with SMTP id
 a2mr35713372plp.147.1571135001011; 
 Tue, 15 Oct 2019 03:23:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxewDvMGnOPR2hJmBvLBx4lJ33596/37BKwpzE63fCZfAps7WE+dNaY68qb2jGJKo0jRhxKvQ==
X-Received: by 2002:a17:902:9002:: with SMTP id
 a2mr35713351plp.147.1571135000823; 
 Tue, 15 Oct 2019 03:23:20 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id i74sm23553210pfe.28.2019.10.15.03.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2019 03:23:20 -0700 (PDT)
Date: Tue, 15 Oct 2019 18:23:11 +0800
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 1/2] migration: Boost SaveStateEntry.instance_id to 64 bits
Message-ID: <20191015102310.GE8666@xz-x1>
References: <20191015075444.10955-1-peterx@redhat.com>
 <20191015075444.10955-2-peterx@redhat.com>
 <87lftmqtvi.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lftmqtvi.fsf@trasno.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 15, 2019 at 10:45:53AM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > It was "int" and used as 32bits fields (see save_section_header()).
> > It's unsafe already because sizeof(int) could be 2 on i386, I think.
> > So at least uint32_t would suite more.  While it also uses "-1" as a
> > placeholder of "we want to generate the instance ID automatically".
> > Hence a more proper value should be int64_t.
> >
> > This will start to be useful after next patch in which we can start to
> > convert a real uint32_t value as instance ID.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Hi
> 
> Being more helpful,  I think that it is better to just:
> 
> * change instance_id to be an uint32_t (notice that for all architectures
>   that we support, it is actually int32_t).
> 
> * export calculate_new_instance_id() and adjust callers that use -1.
> 
> or
> 
> * export a new function that just use the calculate_new_instance_id()
> 
> A fast search shows:
> 
> 10 callers of vmstate_register() with -1
> 1 caller of vmstate_register_with_alias_id with -1 (but it is the one
>   that sets all qdev devices).
> 1 caller of vmstate_register_with_alias_id in apic, where it can be -1.
> 1 caller of register_savevm_live() with -1 (spapr)
> 
> And call it a day?
> 
> What do you think, Juan.

Sure, I can switch instance_id to uint32_t and add a new flag to both
functions (register_savevm_live, vmstate_register_with_alias_id)

Regards,

-- 
Peter Xu

