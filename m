Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D36C43463
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:29:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDB5421D42
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FgBVBE2f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB5421D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJHO1-0006wo-1C
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 10:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJHMS-0005gf-Os
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:27:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35080
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kJHMQ-0001yb-UF
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 10:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600439258;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6R3ydx8iP9qL06p5RCmZfZBcrRZ4Iuqr+Hx4VnW5YOU=;
 b=FgBVBE2faL7rbrUYyDJOB+QUBzUUe6oqoyTir/ofpxYMfseVccihPHMvVocJtXGc7SiwNF
 S/dAhUt+OmS7/qY3fdvUgxQ4UHaXadPj9Dg5KEsivMlkVHCLYzUmc1l9tqA9tN/nem1o3Z
 bQ8GZHad/XQuQXfiEmaQ5TGUENsnxR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-1-zLTBe9PlelJ7ssfHUhDg-1; Fri, 18 Sep 2020 10:27:34 -0400
X-MC-Unique: 1-zLTBe9PlelJ7ssfHUhDg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 181008015A4;
 Fri, 18 Sep 2020 14:27:32 +0000 (UTC)
Received: from redhat.com (ovpn-114-199.ams2.redhat.com [10.36.114.199])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D7EA760C07;
 Fri, 18 Sep 2020 14:27:30 +0000 (UTC)
Date: Fri, 18 Sep 2020 15:27:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Deprecating --enable-gprof?
Message-ID: <20200918142727.GM1628512@redhat.com>
References: <CAJ+F1CKSBCwWZjdUJ7Q3w5uGvM0ZLe65Vw05mm8v3t6kNLKUzg@mail.gmail.com>
 <CAFEAcA8CHK49OChJ9V6g2xj=_9UZLOzy5My0KViWmSEp5Q8_Qg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8CHK49OChJ9V6g2xj=_9UZLOzy5My0KViWmSEp5Q8_Qg@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 03:47:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 18, 2020 at 03:19:00PM +0100, Peter Maydell wrote:
> On Fri, 18 Sep 2020 at 14:27, Marc-André Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > Hi
> >
> > configure has --enable-gprof since its creation, but is it actually being used, or is it sporadic enough that we could deprecate it?
> 
> This reminds me (because I can never keep gprof and gcov straight
> in my head :-)) that now the meson build has landed we should
> probably insist on gcov/gcovr being at least version 4.1, because
> older versions don't correctly handle out of tree builds:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg05823.html

I think we might not need todo anything at this point. --enable-gcov
just delegates to meson by passing  "-Db_coverage=true" to meson.

We still have a coverage-summary.sh script that is run in Travis, but
I'm not sure if that's obsolete or not

If we were using meson/ninja directly we'd just do "meson coverage-html"
to generate a report:

  https://mesonbuild.com/howtox.html#producing-a-coverage-report

and the resulting file could be published from CI as an artifact.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


