Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899E4C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8179322283
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="go0I2GYQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8179322283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUyVx-0006qA-7j
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 16:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUyV3-0006DL-3t
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:44:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39232)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUyV0-0000sZ-21
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603226688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N3bLrn+elLkCKPeQrQyeLaLmR2Op78/zRXvhdoDQFio=;
 b=go0I2GYQ7h24FFP9wenjEZaeS/X2EALznE4SaUmzni/egD/vXOk4UKWti89Gmxj7owyjCu
 Le38Ci1aOxmu+/AI4CHf/eH1gqcttQAwUHXcAPazGBp4zovKvt+QvRx8stWH9Cr1ZuGXB6
 hv3cErT/qKhS0pwyTbVtehShnq/W/Wc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-3auQQUtnNq255u4VjaRMyA-1; Tue, 20 Oct 2020 16:44:46 -0400
X-MC-Unique: 3auQQUtnNq255u4VjaRMyA-1
Received: by mail-qv1-f69.google.com with SMTP id u17so2375362qvt.23
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 13:44:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N3bLrn+elLkCKPeQrQyeLaLmR2Op78/zRXvhdoDQFio=;
 b=jo5wL/aDid9vhpVIKV6WDweb8eKR8+7G4B4aTzrE8nlMxQ5DuPRHXnDOs6/NQrsmU/
 5ipkM7GErWB4jPRVqdKDU8qmsiNffmjlPGKLqiQyX03plxUBUryipOOMi0HRWB+Q9Jwx
 XZfhjwpCkmkVTgmWWa9nxhnYt6LCvLHAhZlOEay+5S2F8ngW3oTIu7pb81ueuOT0BfX5
 iGjv53ALFiTp4RrkyugDt8i4OhVVWA6ab69M3+sFXE7wTektcEhpE8zmvaWtcSr+sxK2
 7wTnJqBfA4mqaBhnhdwA0HlbAOjTBVElVbAUcm6SQNbLOgV778Te71k5Dqc+kg9Jzko0
 tauw==
X-Gm-Message-State: AOAM5312gVDw8EUzRISt951yDQ/FN+DOb+LH5dHWREjf6wg75Cr8vOyF
 M8RyvyAl2dzfrXhVCHB7dux9Hedd8FkVgjndLEHiJJO57LtWBhwjn84S1aTrOh2ERomI7SJdyFD
 axg1FHSp3Y9uczig=
X-Received: by 2002:ac8:1699:: with SMTP id r25mr15352qtj.188.1603226685841;
 Tue, 20 Oct 2020 13:44:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy+yqj3CcqBxlSqQiGaMwQe5gXyF13SGNmuY5NypeIQGrFCzc+1S8yegrPaMi3/ntH4ArB7Q==
X-Received: by 2002:ac8:1699:: with SMTP id r25mr15332qtj.188.1603226685557;
 Tue, 20 Oct 2020 13:44:45 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id k64sm1496047qkc.97.2020.10.20.13.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 13:44:44 -0700 (PDT)
Date: Tue, 20 Oct 2020 16:44:43 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH PROTOTYPE 3/6] vfio: Implement support for sparse RAM
 memory regions
Message-ID: <20201020204443.GE200400@xz-x1>
References: <20200924160423.106747-1-david@redhat.com>
 <20200924160423.106747-4-david@redhat.com>
 <20201020194434.GD200400@xz-x1>
 <14aaf9f1-9aa4-3a6b-ff25-8a4c7e29c2a6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <14aaf9f1-9aa4-3a6b-ff25-8a4c7e29c2a6@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Luiz Capitulino <lcapitulino@redhat.com>, Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Wei Yang <richardw.yang@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 10:01:12PM +0200, David Hildenbrand wrote:
> Thanks ... but I have an AMD system. Will try to find out how to get
> that running with AMD :)

May still start with trying intel-iommu first. :) I think it should work for
amd hosts too.

Just another FYI - Wei is working on amd-iommu for vfio [1], but it's still
during review.

[1] https://lore.kernel.org/qemu-devel/20201002145907.1294353-1-wei.huang2@amd.com/

-- 
Peter Xu


