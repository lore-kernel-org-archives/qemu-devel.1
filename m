Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DABC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:44:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B5E207DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IvV8dEck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B5E207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFviH-00024A-OC
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFvdu-0002O7-DZ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFvdr-00079K-NH
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599640786;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L0EDBS66U2NqVrWphr5fNLtK51uhpGPnhE5R9Ug5otQ=;
 b=IvV8dEckpO7GPMLXQeOQtLErIZ1/2PlTRm63jDXEfYAH/xiVaxwm4W8QOLbeHPC+Ax2gu+
 CeKYBrvJL48Yh0M0V/XDuaRQOSzo9w5J08bYsUULdKvLZh9nq94wbt3j4RhZUZpRpdSrVl
 umfp4GPCVbNNO4bcJmyR+uCeTs4GcmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-Sc-zbp53NFmGlRe9gSY5SQ-1; Wed, 09 Sep 2020 04:39:42 -0400
X-MC-Unique: Sc-zbp53NFmGlRe9gSY5SQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6121B8015F6;
 Wed,  9 Sep 2020 08:39:40 +0000 (UTC)
Received: from redhat.com (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1AFC83564;
 Wed,  9 Sep 2020 08:39:33 +0000 (UTC)
Date: Wed, 9 Sep 2020 09:39:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Subject: Re: [PATCH 11/16] meson: disable crypto tests are empty under win32
Message-ID: <20200909083930.GI1011023@redhat.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <20200908194820.702-12-luoyonggang@gmail.com>
 <20200909081021.GD1011023@redhat.com>
 <CAE2XoE9-DzwqXw7mh8jom8f2Bu+i1jSqxoD+C=4ZbnA-B_X7Xg@mail.gmail.com>
 <20200909082229.GF1011023@redhat.com>
 <CAE2XoE_SW0t-r0urDb12ENZrXzKuKCPMM7cETo13p5-tJ3+E_Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAE2XoE_SW0t-r0urDb12ENZrXzKuKCPMM7cETo13p5-tJ3+E_Q@mail.gmail.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:25:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>, Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 04:30:26PM +0800, 罗勇刚(Yonggang Luo) wrote:
> On Wed, Sep 9, 2020 at 4:22 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Wed, Sep 09, 2020 at 04:17:22PM +0800, 罗勇刚(Yonggang Luo) wrote:
> > > On Wed, Sep 9, 2020 at 4:11 PM Daniel P. Berrangé <berrange@redhat.com>
> > > wrote:
> > >
> > > > On Wed, Sep 09, 2020 at 03:48:15AM +0800, Yonggang Luo wrote:
> > > > > Disable following tests on msys2/mingw
> > > > >       'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c',
> > > > 'pkix_asn1_tab.c',
> > > > >                                    tasn1, crypto],
> > > > >       'test-crypto-tlssession': ['crypto-tls-x509-helpers.c',
> > > > 'pkix_asn1_tab.c', 'crypto-tls-psk-helpers.c',
> > > > >                                  tasn1, crypto],
> > > > >       'test-io-channel-tls': ['io-channel-helpers.c',
> > > > 'crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
> > > > >                               tasn1, io, crypto]}
> > > >
> > > > Why ?   GNUTLS is available on Windows and if it is enabled
> > > > at build time, then we should certainly be running the tests.
> > > >
> > >
> > > Don't know why., the header disable it totally.
> >
> > Yes, I know the source disables it, because it creates various
> > files and no effort has been made to use WIndows filename
> > building code.
> >
> > Given that it is already disabled in the source, why do we need
> > to disable it a second time in meson.build ?
> >
> Because when there is no testcase ,the test runner would complain
> ERROR - missing test plan

Ok, please say that in the commit message to explain why the change
is needed.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


