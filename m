Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD56C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A6D206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 20:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W2mQrtf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A6D206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTWlx-0001Ec-Pn
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 16:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWje-0005Y5-Q6
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jTWiq-0005iZ-8D
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:21:42 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55582
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jTWip-0005iQ-Qb
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 16:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588105250;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dhEWpyo+Q0EUz3VV8U/FNddmyz/kRxcBk51oAgaeNwo=;
 b=W2mQrtf2P/OebdEbyQNOv4F3GZ+HjoS3Vt9CQio28H+0akp7NFBshMAi1Etskomso7ezIs
 QfKGkC/FgQTros/NbobTVO4SJHlV35J9aVhE16N7tkOiDgf6v/JFQBxGwjkUZ03483DjlZ
 +aMvSZefahZ/aDFZBweUcJ7yxXn/0UQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-BbCo-acROmKGTb0oasXQZg-1; Tue, 28 Apr 2020 16:20:48 -0400
X-MC-Unique: BbCo-acROmKGTb0oasXQZg-1
Received: by mail-qk1-f197.google.com with SMTP id l19so24681080qki.14
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 13:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pr75bz5CF/LtKMO69yDpgBPILn3PrEjdTGM0+okmUQM=;
 b=A/MbZCEgLURhPMgKYDeI9rlxb8zOE7/speeECVIGMmqzgT2l5dWU0yEELUjMKP+KKV
 ZWen5b0lVAIg3zy5KA80wjCg0CkdpJU8dWVjGWuARQeFfZwfpxVrmRP4N30NppbVTdPn
 dKCGy8baN8NZCvIA+/rqdTZqC24XofbpRae6AZR1CAdAbLLOv3kuW6HeJCERr4Q6euJ8
 jnhtupi7rh721kWBwoHq91fJHyUy1rEYRFPCyGEbV/tk4wqxJ1JmW4/detq1anYAdlG7
 YsDdbelTDzzjG/8YPk+PCnd0Nc/8QzNVg0q8CHoP/LbTBPR2ycsEh1qjtiWkcUXWQPti
 Oiiw==
X-Gm-Message-State: AGi0PuY0Ic1SfyOFn0uxGGfjRdp/mnFxU6/f0KyBCEHrXU/9ze7Qb+sV
 5yjrJuxDIAbUgyab6wOIVhkzj+57Uwcug8/XN4KsVrjU7KW+JdFGd2Z3Ywr1DmEplO4ENSWDCcS
 U65dInWJhxr987vE=
X-Received: by 2002:ac8:6c6:: with SMTP id j6mr30634772qth.194.1588105243260; 
 Tue, 28 Apr 2020 13:20:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypIeRzoKSB0gO3ZL3lCw15W2Rf4LXDAiJ4IZ3C4BAsi/p3gfx10CfBepjKpH20ztL/7XjpsH5w==
X-Received: by 2002:ac8:6c6:: with SMTP id j6mr30634754qth.194.1588105242987; 
 Tue, 28 Apr 2020 13:20:42 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id k58sm15000518qtf.40.2020.04.28.13.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 13:20:42 -0700 (PDT)
Date: Tue, 28 Apr 2020 16:20:41 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC v2 9/9] KVM: Dirty ring support
Message-ID: <20200428202041.GA4280@xz-x1>
References: <20200428195707.11980-1-peterx@redhat.com>
 <20200428200509.13150-7-peterx@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200428200509.13150-7-peterx@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:11:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pbonzini@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 28, 2020 at 04:05:09PM -0400, Peter Xu wrote:
> +/*
> + * Flush all the existing dirty pages to the KVM slot buffers.  When
> + * this call returns, we guarantee that all the touched dirty pages
> + * before calling this function have been put into the per-kvmslot
> + * dirty bitmap.
> + *
> + * To achieve this, we need to:
> + *
> + * (1) Kick all vcpus out, this will make sure that we flush all the
> + *     dirty buffers that potentially in the hardware (PML) into the
> + *     dirty rings, after that,
> + *
> + * (2) Kick the reaper thread and make sure it reaps all the dirty
> + *     page that is in the dirty rings.

Please note that some of the comments might be outdated, like this one...

(I think I'll remove these two paragraph in the next post)

> + *
> + * This function must be called with BQL held.
> + */
> +static void kvm_dirty_ring_flush(struct KVMDirtyRingReaper *r)
> +{
> +    trace_kvm_dirty_ring_flush(0);
> +
> +    /*
> +     * The function needs to be serialized.  Since this function
> +     * should always be with BQL held, serialization is guaranteed.
> +     * However, let's be sure of it.
> +     */
> +    assert(qemu_mutex_iothread_locked());
> +
> +    /*
> +     * First make sure to flush the hardware buffers by kicking all
> +     * vcpus out in a synchronous way.
> +     */
> +    kvm_cpu_synchronize_kick_all();
> +
> +    /*
> +     * Recycle the dirty bits outside the reaper thread.  We're safe bec=
ause
> +     * kvm_dirty_ring_reap() is internally protected by a mutex.

Same here; the comment is obsolete.  There used to be a mutex after v1 and
before v2, but I removed the mutex because now we simply always take the BQ=
L so
that mutex is not needed any more.

I'm not sure whether there's still obsolete comments here and there (since =
the
code does changed quite a bit).  Anyway please stick to the code if there's
conflicts, and I'll try to fix the comments up.

> +     */
> +    kvm_dirty_ring_reap(kvm_state);
> +
> +    trace_kvm_dirty_ring_flush(1);
> +}

--=20
Peter Xu


