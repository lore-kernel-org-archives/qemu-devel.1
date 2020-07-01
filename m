Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10A6C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BACCE20702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 12:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBqM9eva"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACCE20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqc4B-0003bM-2j
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 08:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jqc3D-0002uo-F3
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:41:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45745
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jqc3B-00026S-RO
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 08:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593607275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qu7NoQcwfj3GIxg5isp/XfeUiXdeJ5PNWiSwdyb0oAs=;
 b=aBqM9evau0Fj7EUp40x+TIvXSg6DUhpvnH7paRSxh+msnmMibUWMya/2IxH9cJiLgVHlGd
 4Hjr372ArhOVw0qHYViXxjgZD+5eE1QpKYwagg4csCW6bmuI4uEk6JzUGyx24yN4zHRE+r
 bRiRl1BbTE+MgXVjak9uYFbbdprFrOY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-vQYqWvq_PMamw55mIkgBiA-1; Wed, 01 Jul 2020 08:41:14 -0400
X-MC-Unique: vQYqWvq_PMamw55mIkgBiA-1
Received: by mail-qv1-f70.google.com with SMTP id bk16so15973751qvb.11
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 05:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Qu7NoQcwfj3GIxg5isp/XfeUiXdeJ5PNWiSwdyb0oAs=;
 b=pCkeCR2r02sEtkXMBn05/hSAFWIJYPIGVD8IH/uz8DpJ/rVL4BOXe7DA/YAqRDA9KY
 nEnE7d9pe1sPdzIdLl8DP5iJRNfVbXrAgegj5kW8AAvN19ffJ8B+DF/eEy3VNkeG1ZTq
 QXceT1vw93z0jSkeJ3ufY5Zab48MslazQpF0YFfeEULS/tCnYzbxohLIYvqEJFWS4YRn
 8EJWXJ3Yybr/KMrARyoWohFOGFQEFFw5QheMtTczT9nKTs9KOfM17FqkJHdR6EEYqAN1
 IFXYnyjCGFpIhaX6amv6cJ5EIpNLy/sGiMU46JrhMwA9GkhgruthobGgUABTVUGof7tU
 ICmg==
X-Gm-Message-State: AOAM531iUPNbi0RzZE08DxYqqfJ1iK15MzvUqew1AYO4G6JWByMJrlY4
 Y4UOAi+D8oCLQXizfUr9E+JF0c3LFTPfaPSDvqye6W1ZIshtrJ03rtNK9vPbBu4993EgqNUV5SP
 boGvSYYR8UkQWTGU=
X-Received: by 2002:a0c:e048:: with SMTP id y8mr25093119qvk.11.1593607273578; 
 Wed, 01 Jul 2020 05:41:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsrY+2GPFiDR63kBvMCyIMbbugxkLl1y3K4PeTUdYN09AksrflHjtNdvFDmlx7k9hFcie+Ig==
X-Received: by 2002:a0c:e048:: with SMTP id y8mr25093095qvk.11.1593607273245; 
 Wed, 01 Jul 2020 05:41:13 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id t9sm5783334qke.68.2020.07.01.05.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2020 05:41:12 -0700 (PDT)
Date: Wed, 1 Jul 2020 08:41:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200701124111.GF40675@xz-x1>
References: <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
 <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
 <1b4eaaaf-c2ab-0da8-afb4-1b7b4221e6cf@redhat.com>
 <20200630052148-mutt-send-email-mst@kernel.org>
 <49f547e1-dd87-7abe-1075-9dcece75b641@redhat.com>
 <20200630152050.GC3138@xz-x1>
 <d9dd8662-33e3-03fe-f227-f519858534e0@redhat.com>
 <20200701121626.GD40675@xz-x1>
 <f4d031fc-6951-be63-991c-c5689274dbf1@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f4d031fc-6951-be63-991c-c5689274dbf1@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 01, 2020 at 08:30:07PM +0800, Jason Wang wrote:
> > I overlooked myself that the IR region will be there even if ir=off.
> 
> 
> Yes, but the point stands still but the issue is still if ir=off.
> 
> 
> >    So I
> > think the assert should stand.
> 
> 
> Do you mean vhost can't trigger the assert()? If yes, I don't get how it
> can't.

Yes.  vhost can only trigger the translate() via memory API.  No matter whether
ir is on/off, the memory region is always enabled, so any access to 0xfeexxxxx
from memory API should still land at s->mr_ir, afaict, rather than the dmar region.

-- 
Peter Xu


