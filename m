Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C08C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 13:07:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00E9120787
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 13:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdscoEYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00E9120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcqMA-0008Ox-3A
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 09:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcqKk-0007Sq-GX
 for qemu-devel@nongnu.org; Sun, 24 May 2020 09:06:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jcqKi-0002U3-Ee
 for qemu-devel@nongnu.org; Sun, 24 May 2020 09:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590325586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rd44ezU6wtG9fEan0ofSgiZlCR/26n83j5jaO4x3hCQ=;
 b=GdscoEYVwS1BoZypdtNJOeQBOpoFqoIm/bUcFWv6IU4g8VVf9zfv/jin9DK6T3vO1QSIE5
 xo3cQoeTmh1UbQs/Wy2yJTngSJOQPYpZzauW4+BBVZYPfwzzAq0liD8WrgpqLif11e7O4n
 /EPdmZ5bqEXvhpWjGNJptxmxpKA+/lY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-6QtmfvNuNbmYHhkPGXHWOg-1; Sun, 24 May 2020 09:06:25 -0400
X-MC-Unique: 6QtmfvNuNbmYHhkPGXHWOg-1
Received: by mail-qv1-f71.google.com with SMTP id dm14so15206744qvb.7
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 06:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Rd44ezU6wtG9fEan0ofSgiZlCR/26n83j5jaO4x3hCQ=;
 b=JFZKGwksVil8PjqY7pgZZqpO8kugY1BSZtIENw8DINCbsAi8MwYAEVLtV6fDFQ1yuv
 qLwx1StOBR4GFjUnjOMLBSlDnhGFd/wHFzSBA5u0nnuXmgRoQn58mO9BJWrsyssOav/h
 vMWjaWhc5+IM+abKS4zqucAaBOfdmcVhHpm/uZqzPcFLGdq5NBLNWeQom97uC2PfXfjU
 q2RApS2G1Prs0acKG9rry6qvU4wcFlhtD4dNrId5EImccZXcjPEF6O6wXSfAB75nffzK
 amfvruXIG/Dui5d27j4cfeeoTDtH3h8JyLp/A5P3UKrkz7BjmMVcwYUHsq/OHfTFEuDH
 icUw==
X-Gm-Message-State: AOAM531ugDIxVcUlfzcPWLpK0ai52jWKEOojsz7u22LVz3WuCsw6zbQJ
 1GYJllyOS/+4zC2wJfHI3a+7ipi25qNb8DnH7I2zFKfLF3HQZrC3I/SCXcJwofbdv/Uy8D+c59P
 sgBMFG8DSCoBdx9s=
X-Received: by 2002:a0c:aa4c:: with SMTP id e12mr11472446qvb.12.1590325584461; 
 Sun, 24 May 2020 06:06:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwFEO5eOwi1GqEET+RO1F1Cw3I00hagMXrBxJa5ZZOrgTflXPzsbFDfDrcy6e8U0xA9f9cGPA==
X-Received: by 2002:a0c:aa4c:: with SMTP id e12mr11472436qvb.12.1590325584226; 
 Sun, 24 May 2020 06:06:24 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id a62sm5708512qkg.71.2020.05.24.06.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 06:06:23 -0700 (PDT)
Date: Sun, 24 May 2020 09:06:20 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC v3 00/11] KVM: Dirty ring support (QEMU part)
Message-ID: <20200524130620.GA1055987@xz-x1>
References: <20200523232035.1029349-1-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200523232035.1029349-1-peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 06:46:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> I kept the dirty sync in kvm_set_phys_mem() for kvmslot removals, left a
> comment on the known issue about strict dirty sync so we can fix it someday in
> the future together with dirty log and dirty ring.

Side note: patch 3,5-8 should not be RFC material at all - they either fixes
existing issues or clean code up.  Please conside to review/merge them first
even before the rest of the patches.  Thanks,

-- 
Peter Xu


