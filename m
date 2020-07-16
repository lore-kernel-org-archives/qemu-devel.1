Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB810C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4B2620739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 12:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evq2dHmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4B2620739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw3Py-0001FJ-VX
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 08:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jw3PK-0000p1-Ss
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:54:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25064
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jw3PH-0005dS-TQ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 08:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594904074;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wyRiOpViw1Q5Akmp/w8Hi4Jxr7h5dB/9IiTn5x3FA8A=;
 b=evq2dHmh/V1ly+TdT3iyJ91Rp5ant3l6f4vGZxWcblVwm3h7hJfPBMdYJ1aAv18Rx+jYf6
 Fb4iulocULGaWHfkkcEoilMq904UD5aNPJllE6OZZDbsmLbk1FVxzfunSUcFrgSs5hnKea
 5UnjHRN1WU8DUOFFPZtagH4Ya6vOjiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-MRi14MpZN6W2QzN9IIdU6Q-1; Thu, 16 Jul 2020 08:54:18 -0400
X-MC-Unique: MRi14MpZN6W2QzN9IIdU6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64CBBC746B;
 Thu, 16 Jul 2020 12:54:16 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A7B1E78A52;
 Thu, 16 Jul 2020 12:54:07 +0000 (UTC)
Date: Thu, 16 Jul 2020 13:54:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Message-ID: <20200716125404.GQ227735@redhat.com>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <3491260.5YPxQhmjAg@silver> <20200716100157.GK227735@redhat.com>
 <5717837.yeCYy4G0CH@silver>
MIME-Version: 1.0
In-Reply-To: <5717837.yeCYy4G0CH@silver>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 19:36:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, P J P <ppandit@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 02:22:14PM +0200, Christian Schoenebeck wrote:
> On Donnerstag, 16. Juli 2020 12:01:57 CEST Daniel P. Berrangé wrote:
> > > My concern here is that just distinguishing between either 'low' or 'high'
> > > is a far too rough classification.
> > > 
> > > In our preceding communication regarding 9pfs, I made clear that a) we do
> > > care about security relevant 9pfs issues, and only b) the avarage use
> > > cases (as far we know) for 9pfs are above a certain trust level.
> > > 
> > > However b) does not imply 9pfs being 'unsafe', nor that we want users to
> > > refrain using it in a security relevant environment. So 9pfs would
> > > actually be somewhere in between.
> > 
> > We shouldn't overthink this and invent many classification levels.
> > 
> > This is essentially about distinguishing code that is written with the
> > intent of protecting from a malicous guest, from code that assumes a
> > non-malicious guest. That is a pretty clear demarcation on when it is
> > reasonable to use any given feature in QEMU.
> > 
> > Within the set of code that is assuming a malicious guest, there are
> > still going to be varying levels of quality, and that is ok. We don't
> > need to express that programatically, the docs are still there to
> > describe the fine nuances of any given feature. We're just saying that
> > in general, this set of code is acceptable to use in combination with
> > a malicious guest, and if you find bugs we'll triage them as security
> > flaws.
> 
> Yes, that would be a base consideration for any security classification. And 
> it applies to 9pfs hence it would suggest 'high' for 9pfs, but ...
> 
> > 9p is generally written from the POV of protecting against a malicious
> > guest, so it would be considered part of the high security set, and
> > flaws will be treated as CVEs. We don't need to be break it down into
> > any more detail than that.
> 
> ... this is where it already differs from reality, as 9pfs security issues 
> were both handled as CVEs as well as normal reports for years, which nobody 
> objected.

Even if something is classified as "high", we still have the freedom to
decide whether each specific issue is worthy of a CVE or not.

> So I wonder how helpful it would be trying to either put 9pfs into either 
> 'high' or 'low', because another observed problematic with 9pfs is that the 
> degree of participation is so low, that if you try to impose certain formal 
> minimum requirements to contributors, you usually never hear from them again.
> 
> And BTW Prasad actually suggested the opposite classification: 

I don't personally mind whether 9p is classified high or low. It is really
upto the maintainers to decide which classification best fits. I'm just
saying that I think the simple binary choice is sufficient for our needs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


