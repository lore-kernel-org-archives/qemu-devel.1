Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9ACC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:56:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 327152086A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZgnRUJho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 327152086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLoD5-0002Pd-6I
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kLo3g-0008Ui-B6
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:46:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kLo3e-0000WF-Ey
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:46:43 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601041601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u+PTCwbI92mESxT97awff80rbzW6pzd40xZ32fTMYC0=;
 b=ZgnRUJhosbjqpgen1HpKBnxb6ONHIkYzMolwxeFDP/GJ5VR1Ldi9Q6JkcNf0KhRG1raQbX
 fH8eu/gbeUuVgjb8x00UEhmNV5o4D4pkeI2kPPbuP3DycSQpOq867QB37s9/TmcT5h5p5K
 wLrNL404bettjAbZzJciYdxeC4yRG7M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-ZrqkFbDFONeq142QPJFzxw-1; Fri, 25 Sep 2020 09:46:39 -0400
X-MC-Unique: ZrqkFbDFONeq142QPJFzxw-1
Received: by mail-qv1-f71.google.com with SMTP id z12so1684280qvp.11
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 06:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=u+PTCwbI92mESxT97awff80rbzW6pzd40xZ32fTMYC0=;
 b=T5ez0+6nOAuCTBv/+X1Mwuar83Vb6FJJxjm2D5WOAnoaPw4JUjgr1QLtspbArZ0/rZ
 Y9vG3V/p+H9wajPyZXN2n2wJMVCaRV/H1Sb8Z7AynMNZMkD7CAxkcuev1FUHUcxd5dI8
 sTZ+YyQfPLU6QPk99B8oIpuAl95L5IlqnlFndFNJgUS3QWLHcCmcm/WU60yudM7Jsdkf
 CDRHx3PciZgQEVh0o1mz1jOHqQfXSJQ+cFubY5I+OGCe9E/qwsYa4AE6nhLZYnVI2SDM
 FjUut+xD2G1qlhgsVvCE8cF6XdA4dT7PikZNx5udIWiu8XMl4Se8PrBjz1rrZEdd8xnM
 WU/A==
X-Gm-Message-State: AOAM533SNm0n223TUikmkhSmrFDHRqwI+CFsy7mknC1v+S37fJ0xaC4t
 LKqBq139GTWQrGtE5uAWMi9pOPzK4ZKazIQd/Ik8qE6G1wQeVEEFKZqNoNtkUZdUlyRLkXhJI5c
 N8rkKqnHAEod6GXQ=
X-Received: by 2002:a05:6214:601:: with SMTP id z1mr4667541qvw.0.1601041599406; 
 Fri, 25 Sep 2020 06:46:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSuIcMNzLFYwzz3oESL5DTKn7YQWWS0lRAB0noFOO97ayLrSwaagdvyJs2FJfM79nlUVrm9Q==
X-Received: by 2002:a05:6214:601:: with SMTP id z1mr4667521qvw.0.1601041599107; 
 Fri, 25 Sep 2020 06:46:39 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id v56sm2014957qtc.49.2020.09.25.06.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 06:46:38 -0700 (PDT)
Date: Fri, 25 Sep 2020 09:46:37 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v2 0/6] migration/postcopy: Sync faulted addresses after
 network recovered
Message-ID: <20200925134637.GA188812@xz-x1>
References: <20200908203022.341615-1-peterx@redhat.com>
 <20200923174311.GA124840@work-vm> <20200925115026.GA2874@work-vm>
MIME-Version: 1.0
In-Reply-To: <20200925115026.GA2874@work-vm>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Xiaohui Li <xiaohli@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 25, 2020 at 12:50:26PM +0100, Dr. David Alan Gilbert wrote:
> * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > v2:
> > 
> > Queued
> 
> Hi Peter,
>   I've had to unqueue most of this; it doesn't like building on 32bit.
> I fixed up the trace_ stuff easily (_del can take a void*, add just
> needs to use PRIX64) but there are other places where it doesn't like
> the casting from pointers to uint64_t's etc.
> 
>   I've kept the first couple of commits.

Thanks, Dave.  I'll have a look later and repost.

-- 
Peter Xu


