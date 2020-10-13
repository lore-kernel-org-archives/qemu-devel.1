Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBC0C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2330C24896
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bjG93d2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2330C24896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSLbb-0007MD-2O
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSLZa-0006DK-84
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:46:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47666)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSLZW-0004ES-E0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602600396;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJj5f9A5WrV7h8AUvTjOTIxhS18SUpuH8gjnbe5l/og=;
 b=bjG93d2i9V5MwfIXeI0ISu22yAnbTPz6rEADLHJX6VBG35SNDEijlkTMAFaiDIsY1V+04E
 Rs9Ay7ZESceEVDZN5LyiKtZ11jOHg5wMpvRJvY0sN8oZeoV88yhTtkkzONJSCqw1/LpONk
 TliCd8SFW1UcDJj7YWcDgDAVHNGS7Q0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-Jgbe00V4O6qqsCK_7tI2Jg-1; Tue, 13 Oct 2020 10:46:30 -0400
X-MC-Unique: Jgbe00V4O6qqsCK_7tI2Jg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78BB1800C60;
 Tue, 13 Oct 2020 14:46:29 +0000 (UTC)
Received: from redhat.com (ovpn-114-78.ams2.redhat.com [10.36.114.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 95F455C1C2;
 Tue, 13 Oct 2020 14:46:28 +0000 (UTC)
Date: Tue, 13 Oct 2020 15:46:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 04/10] meson: option to build as shared library
Message-ID: <20201013144625.GP70612@redhat.com>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-5-j@getutm.app>
 <20201013075104.GA70612@redhat.com>
 <e27acf2-4dbe-4674-78cc-67aa7b505c54@eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <e27acf2-4dbe-4674-78cc-67aa7b505c54@eik.bme.hu>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 04:41:06PM +0200, BALATON Zoltan wrote:
> On Tue, 13 Oct 2020, Daniel P. Berrangé wrote:
> > On Mon, Oct 12, 2020 at 04:29:33PM -0700, Joelle van Dyne wrote:
> > > From: osy <osy86@users.noreply.github.com>
> > > 
> > > On iOS, we cannot fork() new processes, so the best way to load QEMU into an
> > > app is through a shared library. We add a new configure option
> > > `--enable-shared-lib` that will build the bulk of QEMU into a shared lib.
> > > The usual executables will then link to the library.
> > 
> > Note that QEMU as a combined work is licensed GPLv2-only, so if an app is
> > linking to it as a shared library, the application's license has to be
> > GPLv2 compatible. I fear that shipping as a shared library is an easy way
> > for apps to get into a license violating situation without realizing.
> 
> Please don't let that be an obstacle in merging this series. They'll do it
> anyway as seen here so having it upstream is probably better than having a
> lot of different/divergent forks.

"They'll violate the license anyway" is not a compelling argument.

> In case of UTM it seems to be licensed under Apache License 2.0:
> 
> https://github.com/utmapp/UTM/blob/master/LICENSE
> 
> which FSF says not compatible with GPLv2 but it is with GPLv3:
> 
> http://www.gnu.org/licenses/license-list.html#apache2
> 
> Not sure however if that's for using Apache licenced part in GPLv2 code or
> the other way around like in UTM in which case I think the whole work will
> effectively become GPLv3 as most parts of QEMU is probably GPLv2+ already or
> BSD like free that should be possible to combine with only files explicitely
> GPLv2 in QEMU remaining at that license and UTM parts are Apache 2.0 when
> separated from QEMU. I have no idea about legal stuff whatsoever but
> combining two free software components should be legal some way (otherwise
> it's not possible to combine GPLv2 with GPLv3 either).

You need to distinguish between GPLv2-only and GPLv2-or-later.

GPLv2-or-later is fine as that upgrades to GPLv3 when used in a
combined work with Apache License or GPLv3 software.

GPLv2-only will, by design, *not* upgrade to newer GPL versions
when combined - it is simply license incompatible.

QEMU unfortunately has a bunch a GPLv2-only code present that we
cannot eliminate.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


