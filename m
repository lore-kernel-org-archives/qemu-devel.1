Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8427C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:04:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6714B2220E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfKCUzvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6714B2220E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWAL-00058M-CH
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kIW6L-0000hU-03
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kIW6I-0001C0-KM
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600257587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hH624yEul52ULnR9EqiYlG9OV+Yh9dZyn6ubeR2SBAc=;
 b=WfKCUzvp5H8oc2mvpOuHOqP/jBmwroZoDK1nUfoGVGUiAqChz85DVEZLRdJUCl1sKrtGTo
 IU6mDJwxX5PNG9ADNeJVfXCkPrkTc1ujgNMb1W3mfrzfLkXU04x2sbOyfg8GnfDoXpQoJO
 bVc+9q81qNuiR395+0rbbRKEtJlmcF4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-0bK3UGZEMC6MpdEgRxvWoA-1; Wed, 16 Sep 2020 07:59:46 -0400
X-MC-Unique: 0bK3UGZEMC6MpdEgRxvWoA-1
Received: by mail-wr1-f71.google.com with SMTP id v12so2460041wrm.9
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 04:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=hH624yEul52ULnR9EqiYlG9OV+Yh9dZyn6ubeR2SBAc=;
 b=ciX6+FLKAxox+BoiGAB6f/zfqn5yKjcrfX94TJRmOs0nQfpRfq2at5v90V/7MPQiVq
 L3Z0M88M6QMpkwa7Cm/Zq3DHw4nApZvT6vnE0VRcU4ACwidGvmXuzKnOG9IN2aRAsrcM
 BTg/5LoHmWqRbe769IFwbRkEBFXIf0PK92QsqcBodpxii6eReOInIld+mKjX1cv4zmcf
 mhf5I1F8yQ0b5YBYRucK5NgsQagd1IZkJdy/FybinOI3ZUuzNf8RJWIGaAuYTtmlgeeY
 xnjPz9CVx6/1dZiNJOkehkaF+lz7BldimFJupW65LLVizk17be//NNSCljm7fTtMZ8JR
 FXUg==
X-Gm-Message-State: AOAM530bsjebM8li4yopiLWSc3k5FjdTlZ+Cn9v+7cYMYa0jM1n3jTEA
 /0mESum6sqS1SV7Dqk++WBFzX9ESsJKC6XfKQYKAAnRsX75YMRYgQaKFGrRGD/msMLmtdPFI382
 fbItqW79Oapiia+o=
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr13041362wrt.162.1600257585028; 
 Wed, 16 Sep 2020 04:59:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHPoIjRdathkMPoqSzY2w6iy/fDaeOn+3czvQg8WRyYQiy+NMGDrZg08acIK48s/qcHGuXgA==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12mr13041342wrt.162.1600257584816; 
 Wed, 16 Sep 2020 04:59:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id y6sm32981201wrn.41.2020.09.16.04.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2020 04:59:44 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Antoine Damhet <antoine.damhet@blade-group.com>
Subject: Re: [BUG] Migration hv_time rollback
In-Reply-To: <20200916112956.GE2833@work-vm>
References: <20200916090602.blkm7eym6g5bnvvk@tartarus>
 <20200916112956.GE2833@work-vm>
Date: Wed, 16 Sep 2020 13:59:43 +0200
Message-ID: <87bli6hqz4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
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
Cc: Juan Quintela <quintela@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> cc'ing in Vitaly who knows about the hv stuff.
>

cc'ing Marcelo who knows about clocksources :-)

> * Antoine Damhet (antoine.damhet@blade-group.com) wrote:
>> Hi,
>> 
>> We are experiencing timestamp rollbacks during live-migration of
>> Windows 10 guests

Are you migrating to the same hardware (with the same TSC frequency)? Is
TSC used as the clocksource on the host?

>>  with the following qemu configuration (linux 5.4.46
>> and qemu master):
>> ```
>> $ qemu-system-x86_64 -enable-kvm -cpu host,kvm=off,hv_time [...]
>> ```

Out of pure curiosity, what's the purpose of doing 'kvm=off'? Windows is
not going to check for KVM identification anyway so we pretend we're
Hyper-V. 

Also, have you tried adding more Hyper-V enlightenments? 

>
> How big a jump are you seeing, and how did you notice it in the guest?
>
> Dave
>
>> I have tracked the bug to the fact that `kvmclock` is not exposed and
>> disabled from qemu PoV but is in fact used by `hv-time` (in KVM).
>> 
>> I think we should enable the `kvmclock` (qemu device) if `hv-time` is
>> present and add Hyper-V support for the `kvmclock_current_nsec`
>> function.

AFAICT kvmclock_current_nsec() checks whether kvmclock was enabled by
the guest:

   if (!(env->system_time_msr & 1ULL)) {
        /* KVM clock not active */
        return 0;
    }

and this is (and way) always false for Windows guests.

>> 
>> I'm asking for advice because I am unsure this is the _right_ approach
>> and how to keep migration compatibility between qemu versions.
>> 
>> Thank you all,
>> 
>> -- 
>> Antoine 'xdbob' Damhet

-- 
Vitaly


