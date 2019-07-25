Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BC4C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369CE2173B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369CE2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqex3-00027S-6N
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37882)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqews-0001im-3R
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:42:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqewr-00061Y-7s
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:42:26 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43507)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqewr-00061D-45
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:42:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id w17so4977069qto.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tWj9lHT2quf4xVRDpOVqU4hyVOauLdD76qXV3ZKsQUk=;
 b=k/0KvOhGFkTOvYKetNI/jPxxD1FY1Uh9y8bjwymGhbNKt0Ir+HsF6PWlqLESF8QXqI
 WgjNFRIhUDUyhVo9Ne0eh1RVT1Ch13LFObpdqEEjnjEXl/hFSl9IZPe3QgFYIPPNUdX/
 p0XeQkRil9uYbdsnCcjKUrw3eNvn+l7WWl0Y2kLvUU+K+HxJ0Ag4Ls0ov//1uVBid4ic
 0mkZHoqr7i4PxFnGWT3KTuCOLKBTS58MgugCuyDw8jx4ufkt2rOaXEodEiJuIvOEit3O
 aNjUJyAf8xaqz2WolTg3RcOyaUooKs7N8SF/v8jM+RMi/yWKCj5uUsrKjQcy+PW7Hc3i
 t09A==
X-Gm-Message-State: APjAAAWhdcW6yYh/IZqMUUVEBhXvme/wFA6vwa8MJBqi8GE6k4fgKno1
 REVbkBgnYrmeM749tfn1YdFemw==
X-Google-Smtp-Source: APXvYqz++3ITpRGeNySS4XB6ESOhAgLBvKtUVx4DY4TzVN4wxwpFhlvvTTxJjn5YB6CjIHDtdk8ZvQ==
X-Received: by 2002:a0c:ad07:: with SMTP id u7mr61834415qvc.2.1564065744584;
 Thu, 25 Jul 2019 07:42:24 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 f26sm28329866qtf.44.2019.07.25.07.42.20
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 07:42:23 -0700 (PDT)
Date: Thu, 25 Jul 2019 10:42:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190725103636-mutt-send-email-mst@kernel.org>
References: <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com>
 <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
 <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
 <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com>
 <20190725094837-mutt-send-email-mst@kernel.org>
 <dd20e05b-b8f0-c9dd-fdfe-3a3804b90d95@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd20e05b-b8f0-c9dd-fdfe-3a3804b90d95@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.194
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 04:13:13PM +0200, Paolo Bonzini wrote:
> On 25/07/19 15:54, Michael S. Tsirkin wrote:
> >> FWIW the "PCI tax" seems to be ~10 ms in QEMU, ~10 ms in the firmware(*)
> >> and ~25 ms in the kernel.
> > How did you measure the qemu time btw?
> > 
> 
> It's QEMU startup, but not QEMU altogether.  For example the time spent
> in memory.c when a BAR is programmed is not part of those 10 ms.
> 
> So I just computed q35 qemu startup - microvm qemu startup, it's 65 vs
> 65 ms.
> 
> Paolo

Oh so it could be eventfd or whatever, just as well.

I actually wonder whether we spend much time within
synchronize_* calls. eventfd triggers this a  lot of times.

How about ioeventfd=off? Does this speed up things?



-- 
MST

