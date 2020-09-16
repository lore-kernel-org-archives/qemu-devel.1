Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CD5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A2C22274
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwqG4nTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A2C22274
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXJx-0001v4-TM
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kIXJ5-00015n-Qm
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26620)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kIXJ4-0003bc-6d
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600262225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AqrwQUMDpDHP2ZI9AWSq0IRNR2OrVKMF4JI7oYuaQF0=;
 b=fwqG4nTuGGASqxyM3m4w3Fm1pzT1VNH7NEHJNezavbJA3FRGuTDFOPuZlGFFtyi1cap9tL
 PRywa7hvCGHa9mN1KMs4mNC1To68xv/AyZl1nb12kPzAMqmw/0unxX2JFfbp7IXQij3xe0
 99WGqaLu2iFWn54ZYNVLXxKkus60ME4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-LN6If2IUN2aLAGKvoHZ5dQ-1; Wed, 16 Sep 2020 09:17:04 -0400
X-MC-Unique: LN6If2IUN2aLAGKvoHZ5dQ-1
Received: by mail-wm1-f70.google.com with SMTP id m25so1030903wmi.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 06:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=AqrwQUMDpDHP2ZI9AWSq0IRNR2OrVKMF4JI7oYuaQF0=;
 b=nKE1BaUhzULXf+0fjYt1m6WLkhWbN9UU6M34PTLqip2OqORaa0PkJr+MIZo92zx0RG
 bsLvHasGIHZrbAzY96Xs85FJkV+A2al6IIRvw2FWi/GbKMvm6o5Tiz5bpYc6T3Yc2HZa
 cgq9g9toL0DKBpFnnwsbDh31ixm/iqAt8clHALPNlP+3vvo/DPoIS8vfcbJMOHUf08jY
 JK3TCCh9xXKPxhPeVhC+GGz2FTlOJSFbD51W5cAxB7yZNn0w/vrSFMFIjQ0LF7kPTvEn
 OCIdmNtre33uEjbalRCEdIMEukNHd33ZRaOjH+FfzmL2y8BR1Jm/mi3if/Py9Ga115eo
 En2A==
X-Gm-Message-State: AOAM533BbaJNuqidgFXwbb1k01JV/qm61KIEqO//RBbcrQyUqaSjTY1B
 zDUGu/1U5kqoeQlGJaEmj2javQv/Ldq0D8nqQgTRDUknMfdjuUT/htPt4ghGTk+sKUAI/mCPaIf
 CKj7PZz9Xox2AokA=
X-Received: by 2002:a05:6000:11c5:: with SMTP id
 i5mr27277811wrx.18.1600262222842; 
 Wed, 16 Sep 2020 06:17:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbksDFuB0XOOIBUgVkZkM9BlfcwWGVxUl3cTkRjR1dusCrvcBSKKeZagUgGJc4JGoJc2aNzg==
X-Received: by 2002:a05:6000:11c5:: with SMTP id
 i5mr27277791wrx.18.1600262222600; 
 Wed, 16 Sep 2020 06:17:02 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id e18sm32260645wrx.50.2020.09.16.06.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 06:17:01 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [BUG] Migration hv_time rollback
In-Reply-To: <37b1b2b7-40f5-d0b1-2709-df9fe24fc65f@redhat.com>
References: <20200916090602.blkm7eym6g5bnvvk@tartarus>
 <20200916112956.GE2833@work-vm>
 <37b1b2b7-40f5-d0b1-2709-df9fe24fc65f@redhat.com>
Date: Wed, 16 Sep 2020 15:17:00 +0200
Message-ID: <87363hj1yr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Juan Quintela <quintela@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Antoine Damhet <antoine.damhet@blade-group.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 16/09/20 13:29, Dr. David Alan Gilbert wrote:
>>> I have tracked the bug to the fact that `kvmclock` is not exposed and
>>> disabled from qemu PoV but is in fact used by `hv-time` (in KVM).
>>>
>>> I think we should enable the `kvmclock` (qemu device) if `hv-time` is
>>> present and add Hyper-V support for the `kvmclock_current_nsec`
>>> function.
>
> Yes, this seems correct.  I would have to check but it may even be
> better to _always_ send kvmclock data in the live migration stream.
>

The question I have is: with 'kvm=off', do we actually restore TSC
reading on migration? (and I guess the answer is 'no' or Hyper-V TSC
page would 'just work' I guess). So yea, maybe dropping the
'cpu->env.features[FEAT_KVM]' check is the right fix.

-- 
Vitaly


