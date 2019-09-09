Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE21C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:00:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11042206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 15:00:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11042206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7L9j-0003TH-0O
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 11:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i7L8i-0002oT-Tq
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i7L8g-00074E-BN
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:59:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i7L8g-00073o-2p
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:59:34 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1D054C057F2C
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 14:59:33 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id 11so16599945qkh.15
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 07:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OauqdMLYIu9WshlhBImZpZ+nUZD+Qn1ANWAFpyjWPI0=;
 b=dago0/YY08rJeugNQpa58heTOM2BqkFESgROfzs/p89Yj2H+S20FTmmDtzDcsGhnz3
 ZvJGihnkQAJCsP//aRxyyhNfjtXm3ycsY+v7m18GaeZ8ohZR47wFTvKupCg5rOvqaLWG
 q5sIf7N8faGxiLl1t+0ej+MTUdqVRKcfTClXQwPSLDFhTRGksGaShMCcH7N4hxSKFQ2i
 sF40h6eA95ciDVzpPNAI4GrzQHUvj9fQkDZ+24wO8+a1gZhe5pEW65551e1w30PkBxz/
 ac5VBOjOMgSYdv36YCmmSI0Dt1clAWwUn0LFJ0GVDckx4zk2GlqXQd2E+DJ0w0gDi8qc
 maSw==
X-Gm-Message-State: APjAAAVNpICpzX6mWH3ROaIGE2EXU8lXPxKWlfwMp4K5A7nVwcketmZl
 A7Ow20CCXVIs3eehD2NEYo8LBSOFfYB5pTqZT6AxzWABiD3F9KbA2W7RMusu8F6gCYoyb/22Ig7
 WkPaO47mNCMikAV4=
X-Received: by 2002:ac8:7157:: with SMTP id h23mr23307845qtp.72.1568041172494; 
 Mon, 09 Sep 2019 07:59:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwM6e54pUeDfLpe502KflAcnCukXadL6jjTJTbNtbHe+NQL98h/qV12mAB8x5Eao36Uyt/HNQ==
X-Received: by 2002:ac8:7157:: with SMTP id h23mr23307827qtp.72.1568041172282; 
 Mon, 09 Sep 2019 07:59:32 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
 by smtp.gmail.com with ESMTPSA id u23sm6425960qkm.49.2019.09.09.07.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2019 07:59:31 -0700 (PDT)
Date: Mon, 9 Sep 2019 10:59:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190909105057-mutt-send-email-mst@kernel.org>
References: <20190906102217-mutt-send-email-mst@kernel.org>
 <be405c3ba658cdac7f68c91213c3b714ac24c1e3.camel@sipsolutions.net>
 <20190906110340-mutt-send-email-mst@kernel.org>
 <fe0f3f7bfa730088454790dc2d863285c4461134.camel@sipsolutions.net>
 <20190908091207-mutt-send-email-mst@kernel.org>
 <8a9cf8a1726afce7fed8992a4f19fc808004ef88.camel@sipsolutions.net>
 <20190909083902-mutt-send-email-mst@kernel.org>
 <89f25546ffa71c799c533e50658a3a58e066f436.camel@sipsolutions.net>
 <20190909094609-mutt-send-email-mst@kernel.org>
 <d2e750aaec396bd0aa7ea8c05ef5705567d16595.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2e750aaec396bd0aa7ea8c05ef5705567d16595.camel@sipsolutions.net>
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

On Mon, Sep 09, 2019 at 03:50:48PM +0200, Johannes Berg wrote:
> On Mon, 2019-09-09 at 09:48 -0400, Michael S. Tsirkin wrote:
> 
> > > I suppose we could fail a later command that already needs a reply
> > > without REPLY_ACK, but that seems difficult to debug?
> > 
> > Next command is GET_FEATURES. Return an error response from that
> > and device init will fail.
> 
> Hmm, what's an error here though? You can only return a value, no?

Either returning id that does not match GET_FEATURES or
returning size != 8 bytes will work.

Using 0 size payload has precedent in VHOST_USER_GET_CONFIG:
	vhost-user slave uses zero length of
	  payload to indicate an error to vhost-user master.

It's annoying that we don't get an error indicator in that case though.
Worth returning e.g. a 4 byte code?

And let's generalize for all other messages with response?

> > > Anyway, if you feel that we should have this as some sort of safeguard I
> > > can try to do that; to me it feels rather pointless as libvhost-user is
> > > more of a sample implementation than anything else.
> > 
> > Exactly for this reason :)
> 
> :)
> 
> > > Unless you also wanted to write into the spec that F_KICK_CALL_MSGS
> > > absolutely *requires* F_REPLY_ACK,
> > 
> > yep
> 
> Sure, I'm fine with that.
> 
> > We can document how to behave in case of inconsistent protocol features,
> > yes.
> 
> OK.
> 
> johannes

