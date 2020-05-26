Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2D0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 854A3207CB
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 14:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jan4BRmc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854A3207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdaPp-0007ok-Mt
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 10:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jdaPD-0007GO-Qo
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:18:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50457
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jdaPC-0007jo-Cm
 for qemu-devel@nongnu.org; Tue, 26 May 2020 10:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590502688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8QVcG1I/BqkJ/y3VTw5Xoe3fDPxbuE9D3yo9tSiC/7A=;
 b=Jan4BRmc9iKpmLMfmD2rw0DH+EktIhYQ2sxQ1BpJ+Ye4OYyrZ3LqpUS3UQtZM/AUIvQB0S
 Njc+3S9iaWbxVWYc9eI8dEkQBeBWgTauoD7Q++ox3V+cG6ql+P3Utk3yM74canZl5snf1v
 cHZkFgToAxrc4MD/G0UTC69utu8OMUU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48--c1TyB85M-iOF1HrIeK8aQ-1; Tue, 26 May 2020 10:18:06 -0400
X-MC-Unique: -c1TyB85M-iOF1HrIeK8aQ-1
Received: by mail-qt1-f200.google.com with SMTP id u26so3856542qtj.21
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 07:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8QVcG1I/BqkJ/y3VTw5Xoe3fDPxbuE9D3yo9tSiC/7A=;
 b=F8RjK+AXrYuHRG52JNQ2HZaPpgYUk8btdniWUHQLUav1RF2QkzKlBJkSfdSIsUodtr
 WJY85eGSo6KdyBb1kXb7ArhIet0BLyhGSBN7U6pnIHLMFxGay/bxrW882lhWG4RDSVqB
 TaXIFmBSOb9Vus3SuVHQxAc7JkEqgwg2qIWABWCRAFfTfqqkJcDVa8Q/cG3ERFQL6kjn
 JGpDJPgx6q9FOeOLESGjkoTJ0OZfPH9kUtizNowV4VyBmkkfHlZ5vmRpGXG9NX/TqD+G
 rPDXCu6P2Mt1Mf34wCV5Zbo3VCNkr/aKtBLAm5VECm/3/ys35YrvsTN1YJQGg8MdH0EW
 k2lQ==
X-Gm-Message-State: AOAM532oMfHnqkjDHmw7M73KrIEbKxDh0kuyHp2WgcDmqRAQ+A2QMWxC
 drLtX0TOkLbUeVoUMkzE4T/6odNutB/x9YNkmlNli3vGhAi7ZTFMMDr7+6gmwOMNcjFndjItCQJ
 NW74ZlzEeJ5p4WfY=
X-Received: by 2002:ad4:44a4:: with SMTP id n4mr10765495qvt.53.1590502685864; 
 Tue, 26 May 2020 07:18:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJUFgXCH084DP/BtzeG/Tpze0evi70pBG1dP6FgxV5OIdOh9Rw853TqYVlM31ogEsuQhGEFA==
X-Received: by 2002:ad4:44a4:: with SMTP id n4mr10765470qvt.53.1590502685620; 
 Tue, 26 May 2020 07:18:05 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id q24sm6130584qtc.0.2020.05.26.07.17.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2020 07:17:59 -0700 (PDT)
Date: Tue, 26 May 2020 10:17:58 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC v3 00/11] KVM: Dirty ring support (QEMU part)
Message-ID: <20200526141758.GA1190778@xz-x1>
References: <20200523232035.1029349-1-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200523232035.1029349-1-peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, May 23, 2020 at 07:20:24PM -0400, Peter Xu wrote:
> I gave it a shot with a 24G guest, 8 vcpus, using 10g NIC as migration
> channel.  When idle or dirty workload small, I don't observe major
> difference on total migration time.  When with higher random dirty
> workload (800MB/s dirty rate upon 20G memory, worse for kvm dirty
> ring). Total migration time is (ping pong migrate for 6 times, in
> seconds):
> 
> |-------------------------+---------------|
> | dirty ring (4k entries) | dirty logging |
> |-------------------------+---------------|
> |                      70 |            58 |
> |                      78 |            70 |
> |                      72 |            48 |
> |                      74 |            52 |
> |                      83 |            49 |
> |                      65 |            54 |
> |-------------------------+---------------|
> 
> Summary:
> 
> dirty ring average:    73s
> dirty logging average: 55s
> 
> The KVM dirty ring will be slower in above case.  The number may show
> that the dirty logging is still preferred as a default value because
> small/medium VMs are still major cases, and high dirty workload
> happens frequently too.  And that's what this series did.

Two more TODOs that can potentially be worked upon:

- Consider to drop the BQL dependency when reap dirty rings: then we can run
  the reaper thread in parallel of main thread.  Needs some thoughts around the
  race conditions of main thread to see whether it's doable.

- Consider to drop the kvmslot bitmap: logically this can be dropped with kvm
  dirty ring, not only for space saving, but also it's slower, and it's yet
  another layer linear to guest mem size which is against the whole idea of kvm
  dirty ring.  This should make above number (of kvm dirty ring) even smaller,
  but probably still not as good as dirty log if workload is high.  I'm not
  sure whether it's possible to even drop the whole ramblock dirty bitmap when
  kvm enabled then we remove all the bitmap caches (I guess VGA would still
  need a very small one if it wants, or just do the refresh unconditionally),
  but that's a much bigger surgery and a wild idea, but logically it should be
  even more efficient with the ring structure, then precopy will just work
  similar to postcopy that there'll be a queue of dirty pages (probably except
  the 1st round of precopy).

I'll append them into the cover letter of next version too.

-- 
Peter Xu


