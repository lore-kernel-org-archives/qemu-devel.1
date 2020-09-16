Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA82C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:50:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F6922209
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 11:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TwZgqWaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F6922209
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIVx4-0001eE-0L
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 07:50:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIVrB-00038G-Oo
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:44:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIVr8-0007RO-Lu
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 07:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600256648;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RG27yyuiYjRfXtUywL7hT4Z1JRI0U3K4s7qn31lOFok=;
 b=TwZgqWaU/5MMdLANZUjY4RbePboWphgyk5Pn/SDfWBpq3RsXw2H6fT1LKoYQgz+paZzGAh
 ZU2BOHrpELvy2smfCmTbPybgsSD8D/8xjrbJp1TDGXsox5dPNjGsw+jafmfl/XyqUSQqsL
 Epa+024OtN7+42opDkBKxfOTwHp1gP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-oflZelVWNoeNYiPjf7xDRA-1; Wed, 16 Sep 2020 07:43:55 -0400
X-MC-Unique: oflZelVWNoeNYiPjf7xDRA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B411C1074664;
 Wed, 16 Sep 2020 11:43:54 +0000 (UTC)
Received: from redhat.com (ovpn-113-248.ams2.redhat.com [10.36.113.248])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB75F75123;
 Wed, 16 Sep 2020 11:43:49 +0000 (UTC)
Date: Wed, 16 Sep 2020 12:43:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: PATCH: Increase System Firmware Max Size
Message-ID: <20200916114346.GK1535709@redhat.com>
References: <CS1PR8401MB0327EF9D532330BA44257AFCF3240@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <CS1PR8401MB0327959D96C84FB32E071E49F3200@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <CS1PR8401MB03279AC1D869BBBA8D810A19F3200@CS1PR8401MB0327.NAMPRD84.PROD.OUTLOOK.COM>
 <eaa64c6a-18cb-69df-3154-614744e1bfa9@redhat.com>
 <20200916095633.GJ1535709@redhat.com>
 <712696ed-8f23-d8e6-f765-df7aa68f1013@redhat.com>
MIME-Version: 1.0
In-Reply-To: <712696ed-8f23-d8e6-f765-df7aa68f1013@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "McMillan,
 Erich" <erich.mcmillan@hp.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 01:31:05PM +0200, Laszlo Ersek wrote:
> On 09/16/20 11:56, Daniel P. Berrangé wrote:
> > On Wed, Sep 16, 2020 at 11:52:41AM +0200, Laszlo Ersek wrote:
> >> (5) In my opinion (which could be wrong of course), we shouldn't
> >> introduce a new command line option for this, but a new PC machine type
> >> property called "x-firmware-max-size".
> > 
> > Yeah, we definitely do not want a new top level CLI arg, just a
> > machine type property.  We don't need any "x-" prefix on it
> > though, just a plain "firmware-max-size" prop is fine.
> 
> According to the previous discussion, I'd like to request that we add
> the x- prefix (showing that either the property is experimental, or that
> it is intended in support of experimental use cases).
> 
> If you disagree, I'll accept that though.

I don't see a reason to call the property itself experimental unless
someone is proposing that there's likely to be a better way to enlarge
the max firmware size that will replace it later.

The use case is definitely not something I'd call experimental either.
The user providing their own arbirary firmware is not going to be common,
but when they do I'd consider it a valid supported use case. QEMU is
agnostic about what firmware impl is used, as long as the firmware can
support the expected services/interfaces.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


