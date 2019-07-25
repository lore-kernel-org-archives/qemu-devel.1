Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFB6C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:10:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 718292080C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 718292080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqahb-0003DN-NL
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50397)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqahR-0002hv-4v
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqahQ-00082e-8v
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:10:13 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33602)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqahQ-000826-4h
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:10:12 -0400
Received: by mail-qk1-f194.google.com with SMTP id r6so36003344qkc.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 03:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=G4q3NEr/C2NPhy5CWMq/iDm7gRe9whVwAUFl41Xlcmw=;
 b=IK18ZSD/+CZipuFkU42Sp+pLgAOucBOctrsQHzPV/FblJWUc9ZTF1LUMROYmlACejy
 5oIQJysr7BC0J68FXloT1l39cBkd+garDp4yhbhOjfA0TxyBHbScIhxou1W/NnXe7HwT
 nCGaBfKEKMPt3sxWSSncJprv8Ug5pruxk+kJEn44pMPxkG6QgLLZcBI4YzPAg8hVQKZn
 pZ+5WS+pV2mGvfNZhU7QIuqpYwLo6l2w9euQYw7H70U82N/9/krk57beUXUitla114zH
 RF6o4yG6kUfYsFNw9Q7q6TVJT0zRdtASBoJzT+oJwyRscol8Pg+ahWvv97zBZlg/8G1B
 UFOQ==
X-Gm-Message-State: APjAAAWHiIb86ZCk5q1ytSlWf51f2yoaZSrsDSgcdtkZCnskmRSl7T71
 ch31MLceXtUcv3xJ1SkvBzDPfQ==
X-Google-Smtp-Source: APXvYqx3llZTpw7SpglB8mVUh+73jiYp+XmjvXa30dpyQGk9Zw2MazdFDeQrEfYXxjP7QZPuNoFeIA==
X-Received: by 2002:a37:8d04:: with SMTP id p4mr58153987qkd.113.1564049411638; 
 Thu, 25 Jul 2019 03:10:11 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 p23sm19836809qkm.55.2019.07.25.03.10.08
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 03:10:10 -0700 (PDT)
Date: Thu, 25 Jul 2019 06:10:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190725060858-mutt-send-email-mst@kernel.org>
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.194
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 maran.wilson@oracle.com, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 11:05:05AM +0100, Peter Maydell wrote:
> On Thu, 25 Jul 2019 at 10:59, Michael S. Tsirkin <mst@redhat.com> wrote:
> > OK so please start with adding virtio 1 support. Guest bits
> > have been ready for years now.
> 
> I'd still rather we just used pci virtio. If pci isn't
> fast enough at startup, do something to make it faster...
> 
> thanks
> -- PMM

Oh that's putting microvm aside - if we have a maintainer for
virtio mmio that's great because it does need a maintainer,
and virtio 1 would be the thing to fix before adding features ;)

-- 
MST

