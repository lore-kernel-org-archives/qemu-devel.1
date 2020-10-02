Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35E6C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 10:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1E78206A4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 10:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heZ5GtQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E78206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOIex-0001d9-Rr
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 06:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kOIdn-00013o-DU
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 06:50:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kOIdh-0002C8-KL
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 06:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601635811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hnn1emY8H+WAJnd488Oh/MGNPFslFJsdjMr/cy1pzYM=;
 b=heZ5GtQsd3J0RNumlhHb5QfNP8KM8T8STb8/HhAQH7VMgfs5S2lcEFZAZH8QB6DoysloVC
 2OIEddqw96gKFudZHPtg4/sKi7RTWe+DHLaCB3FZMAAOScQHVjTW9wzLc7h1IHPsS6ngVS
 kxOZo+Dm1wHxb+J+kfrw4OyqA2m8r5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-WUPK4YsPNAa-YruwHfjvZg-1; Fri, 02 Oct 2020 06:50:10 -0400
X-MC-Unique: WUPK4YsPNAa-YruwHfjvZg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5004101FFA2;
 Fri,  2 Oct 2020 10:50:08 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com
 [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E4D85D9D3;
 Fri,  2 Oct 2020 10:50:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 3FC389CA5; Fri,  2 Oct 2020 12:50:06 +0200 (CEST)
Date: Fri, 2 Oct 2020 12:50:06 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: Use of "?" for help has been deprecated for 8 years, can we drop
 it?
Message-ID: <20201002105006.2wy4iiljvah2wj3s@sirius.home.kraxel.org>
References: <87k0wa1bf8.fsf@dusky.pond.sub.org>
 <54b77382-78c8-e6bf-45d4-616595baa87f@redhat.com>
 <b2ac33d8-6358-7e19-9ced-1febbf191dfd@eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <b2ac33d8-6358-7e19-9ced-1febbf191dfd@eik.bme.hu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > Did we ever issue a warning when it was used?  It's easier to argue that
> > it can be dropped if users had notice of some form or another.  That
> > said, I'm not heartbroken if we yank it immediately instead of letting
> > it live for 2 more releases.
> 
> How about keeping it as a convenience? I find it easier to type ? than help
> and often use it instead.

Well, ? has the problem that it is a shell glob char[1], which is for me
enough reason to avoid it at least standalone ("-device ?").  When
querying properties ("-device foo,?") it is much less likely to trip you
up.

On the other hand I don't see any harm in keeping it.  What would we
save when we drop it?  Given we already have a helper function to check
it is only 2-3 lines of extra code I guess?

take care,
  Gerd

[1] IIRC that was the reason to add "help" in the first place.


