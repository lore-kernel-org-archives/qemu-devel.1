Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C671CC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2340E22283
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 20:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Izgo5wiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2340E22283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUyar-0000eE-0t
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 16:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUyZd-0008UV-Dn
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:49:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kUyZb-0001T1-Oe
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 16:49:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603226974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s2o562BWjchd4URAJ2Wb4MebeB2F08FCV0iP8NTTsHk=;
 b=Izgo5wiLyyqQ5rZHc5Fae6KrXdcgWbi/SBn3MuQ+SH9rK++JCv1YjtrqfE93hDD1ZwUpse
 S1b/3L+cNsnQ9UZenVY4XhEwV/xN4m5PU2qhw0ujRfAWZoVmlI6nntC4Ztb4Z78KhHo/zb
 DWqHMSeHolVCD34JCq0a+1gg8QtWe5Q=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-PUWiAjDlOZSOHAUis8cJnw-1; Tue, 20 Oct 2020 16:49:32 -0400
X-MC-Unique: PUWiAjDlOZSOHAUis8cJnw-1
Received: by mail-qv1-f70.google.com with SMTP id v4so2350315qvr.19
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 13:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=s2o562BWjchd4URAJ2Wb4MebeB2F08FCV0iP8NTTsHk=;
 b=U5LxGx3fUz4XIroj8u1oqVDNyZB7OYkWRGfoHGkIkS5VvaX3dBCq6xvbQv5TdGUg08
 rlDtZ6gDjvdhzrF0Qjoyk+KV1I4VG9OsfWNwAA2lFl/I+Xvuw+424hZU7uvytCXtwulq
 qs/g6Q5i8EtOj8Cp2ree78j28kG73iKuXGrWn7D+/XwkoYvQ21F/oJqf12DGU9Wnv3IP
 gLnKnQPcYHyxEN6RZ4WpTP+5NP3cb7VHLEhRI6km/Zp2w5LP/FuY32GF79bymDOAVPpY
 fZ+vpxFGD4OTRmgcdD/CvbNQNykNPGinES/kujpSWAHodj9aemZ1fxxaqXkWk15goAjx
 Fihw==
X-Gm-Message-State: AOAM530XSGfRvgTGNaK2T98eA3X7/iYGC01j0f5FR3sybzBuGwWbFDWn
 tuKML1lQi5M6GHWge0t9xclGjwKXHh8uVatyq77vCtSK8LAzxPa9CmyfGAoMwTU06FGFcpMA4Tu
 pObm4sDlqHQa0FaU=
X-Received: by 2002:a05:620a:12a6:: with SMTP id
 x6mr94677qki.189.1603226972131; 
 Tue, 20 Oct 2020 13:49:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaatFEgyNub5u4EsjEGeJNDpnWMu4skNTIpKzmZH40BdJX18HpaK12oH+i8mtkqi27SkpNqg==
X-Received: by 2002:a05:620a:12a6:: with SMTP id
 x6mr94665qki.189.1603226971936; 
 Tue, 20 Oct 2020 13:49:31 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp140-04-174-95-215-133.dsl.bell.ca.
 [174.95.215.133])
 by smtp.gmail.com with ESMTPSA id z13sm25213qkl.2.2020.10.20.13.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 13:49:31 -0700 (PDT)
Date: Tue, 20 Oct 2020 16:49:29 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH PROTOTYPE 4/6] memory: Extend
 ram_block_discard_(require|disable) by two discard types
Message-ID: <20201020204929.GF200400@xz-x1>
References: <20200924160423.106747-1-david@redhat.com>
 <20200924160423.106747-5-david@redhat.com>
 <20201020191706.GB200400@xz-x1>
 <ea4d0acb-7ee5-7a4b-61aa-f139e0cbf585@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ea4d0acb-7ee5-7a4b-61aa-f139e0cbf585@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Oct 20, 2020 at 09:58:34PM +0200, David Hildenbrand wrote:
> I remember there were some !BQL users (but I might be confusing it with
> postcopy code that once used to inhibit the balloon without BQL). Will
> double-check. Simplifying it is certainly a good idea.
> 
> (we want to be able to check from virtio-balloon code repeatedly without
> taking a mutex over and over again :) )

Right.  Again I've no strong opinion so feel free to keep the codes as wish.
However if we'd go the other way (either BQL or another mutex) IMHO we can
simply read that flag directly without taking mutex.  IMHO here the mutex can
be used to protect write concurrency and should be enough. Considering that
this flag should rarely change and it should never flip (e.g., positive would
never go negative, and vise versa), then READ_ONCE() whould be safe enough on
read side (e.g., balloon).

Thanks,

-- 
Peter Xu


