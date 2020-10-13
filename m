Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785BCC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB01725283
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 16:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWTrEiNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB01725283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSN1m-0008Bk-KK
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 12:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSN11-0007lJ-97
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSN0y-0001AU-2V
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 12:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602605942;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jFiDNS3DZ69HU92lnaxY7ARpWX46HTIcqG3G7YeDcSs=;
 b=UWTrEiNPKxzxsAR8H3X40WUWiJdapEJECB4X4uVIN+IZ3kQExFSy3fNY63QqZQz1mdlNJM
 AHW0Qxn3plavhKoK6amQZp5LtzS2OvGPTM9rzqnSWp8ydYyPGltyzEPAsBCR/M2WdtKalB
 dTHyU1WQUeakJD5vBv5kXZxZjYRzomQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-hpoINELbMC62_W4jyl57nQ-1; Tue, 13 Oct 2020 12:18:57 -0400
X-MC-Unique: hpoINELbMC62_W4jyl57nQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7D35914700;
 Tue, 13 Oct 2020 16:18:55 +0000 (UTC)
Received: from redhat.com (ovpn-114-78.ams2.redhat.com [10.36.114.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25D9427BDC;
 Tue, 13 Oct 2020 16:18:50 +0000 (UTC)
Date: Tue, 13 Oct 2020 17:18:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH 06/10] coroutine: add libucontext as external library
Message-ID: <20201013161848.GS70612@redhat.com>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-7-j@getutm.app>
 <20201013133135.GH164611@stefanha-x1.localdomain>
 <ff84b94c-42ff-c1ba-cb28-644678c09a21@eik.bme.hu>
MIME-Version: 1.0
In-Reply-To: <ff84b94c-42ff-c1ba-cb28-644678c09a21@eik.bme.hu>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 03:04:27
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Joelle van Dyne <j@getutm.app>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 04:49:26PM +0200, BALATON Zoltan via wrote:
> On Tue, 13 Oct 2020, Stefan Hajnoczi wrote:
> > On Mon, Oct 12, 2020 at 04:29:35PM -0700, Joelle van Dyne wrote:
> > > From: osy <osy86@users.noreply.github.com>
> > > 
> > > iOS does not support ucontext natively for aarch64 and the sigaltstack is
> > > also unsupported (even worse, it fails silently, see:
> > > https://openradar.appspot.com/13002712 )
> > > 
> > > As a workaround we include a library implementation of ucontext and add it
> > > as a build option.
> > > 
> > > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > 
> > Hi,
> > Thanks for sending posting this!
> > 
> > Please indicate what license libucontext is under, that it is compatible
> > with QEMU's overall GPL v2 license, and update QEMU license
> 
> https://github.com/utmapp/libucontext/blob/master/LICENSE

I don't recognise that license text as being an exact match for any
common open source license.

As best I can tell, it is closest to being yet another variant of the
MIT license, of which there are ridiculously many

  https://fedoraproject.org/wiki/Licensing:MIT


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


