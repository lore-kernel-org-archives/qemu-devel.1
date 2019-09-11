Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E0DECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:19:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11502087E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11502087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7ymt-0003Ay-Jj
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39914)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i7ykF-0000vk-Vx
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i7ykE-00052W-Vj
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:16:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48198)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i7ykE-00050b-O6
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:16:58 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F26BA7E427
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 09:16:57 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id k68so24292578qkb.19
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 02:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=aY5UQP5Dcv3BomJa2KRNPZU5sSiiMIMN+aC9tNSCk18=;
 b=SwNjT1KyvNf9366gled0YAUfd2gzeL5poFkzfEJUB2+uhmECVHinsue77lu8DedlJR
 gqCS6+mlZqvbHaQfYgZaVnG8GrWO1DtW0IOd0JAPccZOnA6V6TU6dned2rtBaMuP98tU
 T2ibcieiWQD/4DW9kiSN0HQdt9M1J9HbE9tEFHgcwTaXilsr5zqvnKS60N4n2vVPp6cm
 5YJabFkex5C5yIkwVPZ7BzFbeYLH6GIgHusSxEdQJfnwNqU0IpiP4OfLGv5jOH8m1Z89
 dX69dYch1gSS1QRJsp3OTzGmEOof9uA2VcKRc2HMAjh3s4V7PIAr86ACdvhsTtO5D1md
 Sq0g==
X-Gm-Message-State: APjAAAU+kOKEFoAQuNRVkCB0A0hDksnCFtyDI5w8z2zee3Dq0/hszjXU
 e8nx3ipjW/aue+o4ghUh8XC2mbfyfDYv1W75OC8IoDXEvgCzcGoBz/6O/GpDlHTCvV/DKytyFCt
 JpcV4uAUB/0pzexw=
X-Received: by 2002:a0c:f70c:: with SMTP id w12mr20793455qvn.200.1568193417277; 
 Wed, 11 Sep 2019 02:16:57 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwdHen/M/RZDcvQp66zAk4igZG77lO2ZrMonkccS0UdXCP7IgbAUIg9rC8tpGTdQnrwdpXPSw==
X-Received: by 2002:a0c:f70c:: with SMTP id w12mr20793441qvn.200.1568193417055; 
 Wed, 11 Sep 2019 02:16:57 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
 by smtp.gmail.com with ESMTPSA id x59sm9976176qte.20.2019.09.11.02.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 02:16:55 -0700 (PDT)
Date: Wed, 11 Sep 2019 05:16:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190911051236-mutt-send-email-mst@kernel.org>
References: <be405c3ba658cdac7f68c91213c3b714ac24c1e3.camel@sipsolutions.net>
 <20190906110340-mutt-send-email-mst@kernel.org>
 <fe0f3f7bfa730088454790dc2d863285c4461134.camel@sipsolutions.net>
 <20190908091207-mutt-send-email-mst@kernel.org>
 <8a9cf8a1726afce7fed8992a4f19fc808004ef88.camel@sipsolutions.net>
 <20190909083902-mutt-send-email-mst@kernel.org>
 <89f25546ffa71c799c533e50658a3a58e066f436.camel@sipsolutions.net>
 <20190909094609-mutt-send-email-mst@kernel.org>
 <d2e750aaec396bd0aa7ea8c05ef5705567d16595.camel@sipsolutions.net>
 <1f28c61e5caf6fc2a2125664043d1f7b9b769149.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f28c61e5caf6fc2a2125664043d1f7b9b769149.camel@sipsolutions.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] libvhost-user: implement
 VHOST_USER_PROTOCOL_F_KICK_CALL_MSGS
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 05:52:36PM +0200, Johannes Berg wrote:
> On Mon, 2019-09-09 at 15:50 +0200, Johannes Berg wrote:
> 
> > > We can document how to behave in case of inconsistent protocol features,
> > > yes.
> > 
> > OK.
> 
> Coming back to this, I was just looking at it.
> 
> How/where would you like to see this done?
> 
> There isn't really any section that lists and explains the various
> protocol features, there's only a list. I could add a new section for
> "Simulation" or something like that that explains it, but then most
> people would probably skip that and not ever read the text about how you
> shouldn't implement F_KICK_CALL_MSGS :-)
> 
> Any thoughts?
> 
> johannes

Each feature is documented near the description of the functionality it
enables, that can work for this. I don't much like F_KICK_CALL_MSGS as
not generic enough but it's not simulation as such:
IN_BAND_NOTIFICATIONS?


As for how to handle errors, that probably belongs near
"Communication".

Or maybe add a new "Error handling" section.


