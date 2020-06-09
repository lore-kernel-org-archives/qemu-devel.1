Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D33BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:20:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECDEB20760
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 17:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lx1OOZzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECDEB20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihuu-0003nh-6M
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 13:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jihJV-0005zQ-DS
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:41:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jihJU-0003cp-K6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXNdRt1OqLSKIszKgiip5F2+4shk6JEVLb9FCOzArDg=;
 b=Lx1OOZzRi86gg4BujSXRQUQ3+nXMMsJrSXSBYwgssGkQs2P7He9BkFv/B3sjUiY5mdjB1R
 QqlWkdOapBrlPxVhjv1VcWYHEvb1nalnJericCT5zE5AVyLxG1AL9XO744TwykZV6i4Zmd
 n1FPGpxNf7QcsNgSurqVyzHftY/7OuQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-EM7pzqAZPBqGKMt4wcF7eg-1; Tue, 09 Jun 2020 12:41:21 -0400
X-MC-Unique: EM7pzqAZPBqGKMt4wcF7eg-1
Received: by mail-wm1-f72.google.com with SMTP id b65so890924wmb.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 09:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qXNdRt1OqLSKIszKgiip5F2+4shk6JEVLb9FCOzArDg=;
 b=oirKPWgvC50YlruPpgNvuqfLKBFGfMqm0vXyk0NbeExrp+IkY5N3iO73fa9C3UIjtC
 NEf2ntD6xmFAtMAJTl9/zikw0fUQzmX5I69W6e29ZAzbdZcb2rkwuQELywDZZ0FTXtYb
 f2bd0SaEHtXQS6mSThpocnTZwKODHIkvXVjX0HhMy/K+sx9Esy3ENO3D8C5+wSUghknC
 i46n+NyOCS+ms2hbvD2p3m54qbCP2bpjqYsOcx3r4JJ9QqAyTTJA0bihb54D9Ifw6qS0
 gJ0g+BNcw3fkOWpmRW0eXMNTpFQd7fWttzkljmd+FkoaLgNYx9WVrycq26IGwi2HsjXg
 HJxg==
X-Gm-Message-State: AOAM533/ymqeiN2BO4YJwNqZYEnMtV0mxe3kycEj7/Z2iMhZ1qvA8d32
 CDk5nKFgl9Sg4IzhzFAmCeAj4wIr4OdQHFV/d3omNVlkCMyChqz0fd3gbsyvFfG6Dq7FJkePtZE
 CeYEFmaq3USZeosk=
X-Received: by 2002:a05:600c:21d7:: with SMTP id
 x23mr5178737wmj.95.1591720880035; 
 Tue, 09 Jun 2020 09:41:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzCcf48fSTovlCRpdyLVmb/cENm6UDxaNmx0011N032V2a9QdtlkGhJypPt5WTAiaDdsRZQGg==
X-Received: by 2002:a05:600c:21d7:: with SMTP id
 x23mr5178715wmj.95.1591720879820; 
 Tue, 09 Jun 2020 09:41:19 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
 by smtp.gmail.com with ESMTPSA id f9sm3771173wre.65.2020.06.09.09.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 09:41:19 -0700 (PDT)
Date: Tue, 9 Jun 2020 12:41:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v2 1/1] virtio-ccw: auto-manage VIRTIO_F_IOMMU_PLATFORM
 if PV
Message-ID: <20200609123953-mutt-send-email-mst@kernel.org>
References: <20200514221155.32079-1-pasic@linux.ibm.com>
 <20200520121507-mutt-send-email-mst@kernel.org>
 <20200606013217.2cffa3ed.pasic@linux.ibm.com>
 <20200608181428.3c6f127c.cohuck@redhat.com>
 <20200608190045.319dd68b.pasic@linux.ibm.com>
 <20200609084402.35d317ec.cohuck@redhat.com>
 <20200609114130.0ca9190b.pasic@linux.ibm.com>
 <20200609174747.4e300818@ibm-vm>
MIME-Version: 1.0
In-Reply-To: <20200609174747.4e300818@ibm-vm>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
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
Cc: Thomas Huth <thuth@redhat.com>, Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 09, 2020 at 05:47:47PM +0200, Claudio Imbrenda wrote:
> On Tue, 9 Jun 2020 11:41:30 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> [...]
> 
> > I don't know. Janosch could answer that, but he is on vacation. Adding
> > Claudio maybe he can answer. My understanding is, that while it might
> > be possible, it is ugly at best. The ability to do a transition is
> > indicated by a CPU model feature. Indicating the feature to the guest
> > and then failing the transition sounds wrong to me.
> 
> I agree. If the feature is advertised, then it has to work. I don't
> think we even have an architected way to fail the transition for that
> reason.

So my suggestion was basically a flag that sets both the
CPU model feature and the virtio feature.



> What __could__ be done is to prevent qemu from even starting if an
> incompatible device is specified together with PV.
>
> Another option is to disable PV at the qemu level if an incompatible
> device is present. This will have the effect that trying to boot a
> secure guest will fail mysteriously, which is IMHO also not too great.
> 
> do we really have that many incompatible devices?
> 


