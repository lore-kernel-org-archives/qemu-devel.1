Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2565BC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 778C1207EA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 18:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTAjfWmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 778C1207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGQy6-0004OK-Cz
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 14:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGQsn-0000up-Gd
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:01:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20816
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGQsk-0007cR-It
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 14:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599760873;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=54+A6YhiBniSksDS6b6+M7V+fY8ulvkCSDbaexCYRVs=;
 b=cTAjfWmGnfD1+280RxFpPPOvFUhhk3NjMkNlehKyUuZ45DrAvTzaW3Lgh8Ubpjz7i7QQg5
 /uKNvj3uENmtMhqoFUuc9B0ML6cAm+t7ERaNwtMrJH3B3OSirrV2X4TGUB+dWnQ22LkDL/
 PHmecFkXsbpQUjGVgXi2rMJpKrjSDWU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-CboV6w7rM7e4RWe831rq5A-1; Thu, 10 Sep 2020 14:00:52 -0400
X-MC-Unique: CboV6w7rM7e4RWe831rq5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32AC61084C82;
 Thu, 10 Sep 2020 18:00:50 +0000 (UTC)
Received: from redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC078100238C;
 Thu, 10 Sep 2020 18:00:43 +0000 (UTC)
Date: Thu, 10 Sep 2020 19:00:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v7 17/25] cirrus: Building freebsd in a single short
Message-ID: <20200910180041.GJ1083348@redhat.com>
References: <20200910103725.1439-1-luoyonggang@gmail.com>
 <7f348ead-0f90-0b9e-0afd-7c828091753f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7f348ead-0f90-0b9e-0afd-7c828091753f@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 08:35:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 04:18:10PM +0200, Thomas Huth wrote:
> On 10/09/2020 12.37, Yonggang Luo wrote:
> > This reverts commit 45f7b7b9f38f5c4d1529a37c93dedfc26a231bba
> > ("cirrus.yml: Split FreeBSD job into two parts").
> > 
> > freebsd 1 hour limit not hit anymore
> > 
> > I think we going to a wrong direction, I think there is some tests a stall the test runner,
> > please look at
> > https://cirrus-ci.com/task/5110577531977728
> > When its running properly, the consumed time are little, but when tests running too long,
> > look at the cpu usage, the cpu usage are nearly zero. doesn't consuming time.
> > 
> > And look at
> > https://cirrus-ci.com/task/6119341601062912
> > 
> > If the tests running properly, the time consuming are little
> > We should not hide the error by split them
> 
> Ok, but before we merge this patch, I'd like to understand (and fix if
> necessary) what is/was causing the slowdowns. Otherwise we'll continue
> to see failing CI runs, which is very annoying.

I think we need the test harness to print out the time duration for
each test in order to stand a chance of find the slow one.

A hack like this could be sufficient:

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index 9cbb2e374d..9103ae65b9 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -20,7 +20,7 @@ print('''
 SPEED = quick
 
 # $1 = environment, $2 = test command, $3 = test name, $4 = dir
-.test-human-tap = $1 $(if $4,(cd $4 && $2),$2) < /dev/null | ./scripts/tap-driver.pl --test-name="$3" $(if $(V),,--show-failures-only)
+.test-human-tap = export then=`date +%s` ; $1 $(if $4,(cd $4 && $2),$2) < /dev/null | ./scripts/tap-driver.pl --test-name="$3" $(if $(V),,--show-failures-only) ; export now=`date +%s` ; delta=`expr $$now - $$then` ; $(if $(V),echo "TIME $$delta seconds",true)
 .test-human-exitcode = $1 $(PYTHON) scripts/test-driver.py $(if $4,-C$4) $(if $(V),--verbose) -- $2 < /dev/null
 .test-tap-tap = $1 $(if $4,(cd $4 && $2),$2) < /dev/null | sed "s/^[a-z][a-z]* [0-9]*/& $3/" || true
 .test-tap-exitcode = printf "%s\\n" 1..1 "`$1 $(if $4,(cd $4 && $2),$2) < /dev/null > /dev/null || echo "not "`ok 1 $3"


not sure if there is a nicer way todo this but itworks ok for make check-unit
at least


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


