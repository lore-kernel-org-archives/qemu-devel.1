Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B89C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:55:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8502206A1
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 09:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8502206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7zLd-0003Op-Pj
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 05:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i7zKj-0002ss-Rz
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i7zKi-0000YP-R8
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:54:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49422)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i7zKi-0000Xn-JV
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 05:54:40 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B579FC08EC15
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 09:54:39 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id o133so24413179qke.4
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 02:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SR/G5tKbZIpvJt8thzLY5S6w1XtsYDyI3Ldn6UVG8g8=;
 b=Fbi7V/xg2Tm1MWyBhxVzvya6Dvd8/H/irwzPNBxvA03pmfqrEY9yFhktq2VAD3bWty
 9OP3eqr8znPrdZsYBdDS8UdotDaltl9syfA339ygL1zfovUCbTq3Gv8an5dd0H2xf3sw
 ROaR5AMsWg9vLu4Mvt3l8Ysrg1Mnr2wXr8cddBoHH03lswln4SoAUOaivB7mkafAlaUC
 UQz9tIUwlw9L6i30ekHKrR/o4lXSTrufD1kh21U3lPJ5hPXukCp4wZ0q7gdqiLF/PknV
 hNzzlBk+WTB8fb4GEYYvnPli9YsFfdZAt7Dc+zxsqRxs7Iek/aNuBLdCFG1fELHqpx7U
 NjPw==
X-Gm-Message-State: APjAAAX668/e6yzuUpb+8wJFdHbTspcXqT3wwFyvuc3yoDaZLm0IR8ik
 agYU0qWS7/sKKXkkaaTrwu9PEAc6dXAWGGXcHwAPSqvO7DRad8UyranozYPKJx/4VwWXAVTfyFL
 GowKmqaQyRS0+O7M=
X-Received: by 2002:a05:620a:12b1:: with SMTP id
 x17mr12681078qki.223.1568195679063; 
 Wed, 11 Sep 2019 02:54:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxJyE6BoJAC5Es8pA8wae2nZ6q7iu6kkFz6hc7yHfg07kDH+f9822uIYhi1Gekv+scAT24/ZQ==
X-Received: by 2002:a05:620a:12b1:: with SMTP id
 x17mr12681072qki.223.1568195678918; 
 Wed, 11 Sep 2019 02:54:38 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
 by smtp.gmail.com with ESMTPSA id a28sm7411368qkl.42.2019.09.11.02.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2019 02:54:38 -0700 (PDT)
Date: Wed, 11 Sep 2019 05:54:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190911055058-mutt-send-email-mst@kernel.org>
References: <fe0f3f7bfa730088454790dc2d863285c4461134.camel@sipsolutions.net>
 <20190908091207-mutt-send-email-mst@kernel.org>
 <8a9cf8a1726afce7fed8992a4f19fc808004ef88.camel@sipsolutions.net>
 <20190909083902-mutt-send-email-mst@kernel.org>
 <89f25546ffa71c799c533e50658a3a58e066f436.camel@sipsolutions.net>
 <20190909094609-mutt-send-email-mst@kernel.org>
 <d2e750aaec396bd0aa7ea8c05ef5705567d16595.camel@sipsolutions.net>
 <1f28c61e5caf6fc2a2125664043d1f7b9b769149.camel@sipsolutions.net>
 <20190911051236-mutt-send-email-mst@kernel.org>
 <b8c7ffb8dee0f7d8bb7c1a67cafbc478f8246afa.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8c7ffb8dee0f7d8bb7c1a67cafbc478f8246afa.camel@sipsolutions.net>
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

On Wed, Sep 11, 2019 at 11:20:40AM +0200, Johannes Berg wrote:
> 
> > Each feature is documented near the description of the functionality it
> > enables, that can work for this. 
> 
> Hmm, so you mean I should add a section on in-band notifications, and
> document things there?

Like other messages - look at e.g. inflight description as an example.


There's also a bunch of work finding all places that
deal with kick/call FDs and updating that they
only make sense without the new feature flag.

> > I don't much like F_KICK_CALL_MSGS as
> > not generic enough but it's not simulation as such:
> > IN_BAND_NOTIFICATIONS?
> 
> Sure, sounds good to me, I guess I'm not good at naming things :)
> 
> > As for how to handle errors, that probably belongs near
> > "Communication".
> > 
> > Or maybe add a new "Error handling" section.
> 
> OK.
> 
> Btw, I tried this yesterday in libvhost-user, but if I just do
> vu_panic() it just aborts that message handling and hangs, if I
> forcefully close the FD then it ends up crashing later ...
> 
> I'm tempted to go with vu_panic() only for now as that seems to be the
> normal way to handle unexpected protocol errors there, many such other
> errors probably should also close the FD?
> 
> johannes

I'm fine with a TODO for now.

-- 
MST

