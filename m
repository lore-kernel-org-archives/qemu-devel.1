Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CA1C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 18:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4BA2073B
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 18:53:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YBwtVds5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4BA2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je1BS-0000pb-2Y
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 14:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1je1Ai-0000O0-Eg
 for qemu-devel@nongnu.org; Wed, 27 May 2020 14:53:00 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26922
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1je1Ag-00044s-Re
 for qemu-devel@nongnu.org; Wed, 27 May 2020 14:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590605576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wvkFYdgYYv1luT7blFQY0u/Btwse79JUHJ4SkNK/4xA=;
 b=YBwtVds5tA6sHE6LeacNE7A83DzAMqkfXwaU4PyWnlHXJRXrLkq5ZRIdKyBAFSrm9FP5yf
 Nt7aASGfxeTZYhikU9fQDIlvOvWKMmOqxAwVDiSnThi5kEYKH8qvaDyN8cpTNuUWfGGR/2
 Q1lzq6ARnmshh57fcewmFhD4yndXYdo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-yHy0Mxs3NQ-nX8f60Z6WNQ-1; Wed, 27 May 2020 14:52:55 -0400
X-MC-Unique: yHy0Mxs3NQ-nX8f60Z6WNQ-1
Received: by mail-qk1-f198.google.com with SMTP id i10so360269qkm.23
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 11:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wvkFYdgYYv1luT7blFQY0u/Btwse79JUHJ4SkNK/4xA=;
 b=LLux2Pz/G3gYnvmoiNrsnhF5J8Yo76RzV70bK7Jh9XI5VNa/vfroHJTaKc1QEcesyP
 7bjm2FTqesQY+OmRgYsFO2LXR8ttcFKs5j7qYdQiO5zxFupdvdNVm7E0z86tuUOKpjkq
 AvPe6TUVPTvboUNNyp76LqGjZ+Ad5nWrEkrpW2vsda+qtIYF8R8tstiR0zWGuJUWhHRM
 yovJTN0ftdXcxaU2VmFFWZifKEu1L3f3p50siGy/Ozpri1rYT1OFZgsPWD/oNqkoDU1E
 +ATMY7oEklYM5Hz8/+0ial9aXb4OFidI4Ywp8+02jN1jIS6mmaVdnPvsM6bOR+lywEx5
 R4Kw==
X-Gm-Message-State: AOAM533zcxff0fMFtyy7UdWBu07UXX68at9GS5vnfnRhFjGLVCTICsy9
 v5bXqutBsZVm3b2Inv4MBdhFtX5OswlpwWv5HwmyXf5psbFcNrgMdXeVwTVlH6lRA/dAnKxyKBl
 b+/yh9XyxjgxM5i0=
X-Received: by 2002:a37:49cb:: with SMTP id w194mr5819917qka.40.1590605574300; 
 Wed, 27 May 2020 11:52:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBQexkIdvyueqQlOSHsMhRV7GoXd9bcdhOl+uqY62JzxPBBvrsG45JBwk7IUgRmCCb3hhm2w==
X-Received: by 2002:a37:49cb:: with SMTP id w194mr5819771qka.40.1590605572506; 
 Wed, 27 May 2020 11:52:52 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id l9sm3143825qki.90.2020.05.27.11.52.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 11:52:51 -0700 (PDT)
Date: Wed, 27 May 2020 14:52:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] hw/vfio/common: Trace in which mode a IOMMU is opened
Message-ID: <20200527185249.GI1194141@xz-x1>
References: <20200526173542.28710-1-philmd@redhat.com>
 <6c7c445d-0335-f67d-bb72-5b0c046bb247@redhat.com>
 <24f88212-9b32-b6dc-fcd4-685cde8bf5d7@redhat.com>
 <864ac8ab-e21e-393e-d1eb-08b3c4579bbf@redhat.com>
 <20200527161603.GF1194141@xz-x1>
 <3e364895-e5e5-09fe-ee8c-782f3632e2b8@redhat.com>
 <20200527165330.GG1194141@xz-x1>
 <20200527190651.2a9ee6ea.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200527190651.2a9ee6ea.cohuck@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
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
Cc: Auger Eric <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 07:06:51PM +0200, Cornelia Huck wrote:
> Personally, I find traces to be quite handy, and it's nice if you can
> just enable more of them if they are in your debugging workflow anyway.
> Probably boils down to a matter of preference :)

Totally agree.  I am actually a heavy user of QEMU tracing system, just like
the rest of the tracing tools all over the world... :)

IMHO the difference between a tracepoint and a manual printf() is majorly the
reusablility part - if a debugging printf() is likely to be reused in the
future, then it is a good tracepoint candidate.

Thanks,

-- 
Peter Xu


