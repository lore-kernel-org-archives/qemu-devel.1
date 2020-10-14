Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8354AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:39:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF49820B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bk7du/G7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF49820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjog-0007dm-Tp
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38008)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSjnP-0006dM-KD
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kSjnN-0005yD-EU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 12:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602693511;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SKy8wPLBZ9hJNUFWYOdy1GpNhEXh/ngR9pSG406kwMs=;
 b=Bk7du/G7k0+eD9+SdyLQ376vllhWlCzD9gV/t4093s1PyeNVftAwHZUNjaqInZ4yikEv1j
 h6H6o8S0Ngfet/cREcT9aFn28po9dDJ2cjwVWjVClufNqTdtRZn00ruE53jkY+Hf/tzYAp
 mk4Qm3EhHQolOevBBgRp210YR2pmGV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-YHikv-fFNp6f3bSCMyw2tA-1; Wed, 14 Oct 2020 12:38:27 -0400
X-MC-Unique: YHikv-fFNp6f3bSCMyw2tA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89A6318CBC41;
 Wed, 14 Oct 2020 16:38:26 +0000 (UTC)
Received: from redhat.com (ovpn-113-137.ams2.redhat.com [10.36.113.137])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5005127C21;
 Wed, 14 Oct 2020 16:38:25 +0000 (UTC)
Date: Wed, 14 Oct 2020 17:38:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 7/7] build: replace ninjatool with ninja
Message-ID: <20201014163822.GQ115189@redhat.com>
References: <20201014135416.1290679-1-pbonzini@redhat.com>
 <20201014135416.1290679-8-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201014135416.1290679-8-pbonzini@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 14, 2020 at 09:54:16AM -0400, Paolo Bonzini wrote:
> Now that the build is done entirely by Meson, there is no need
> to keep the Makefile conversion.  Instead, we can ask Ninja about
> the targets it exposes and forward them.
> 
> The main advantages are, from smallest to largest:
> 
> - reducing the possible namespace pollution within the Makefile
> 
> - removal of a relatively large Python program
> 
> - faster build because parsing Makefile.ninja is slower than
> parsing build.ninja; and faster build after Meson runs because
> we do not have to generate Makefile.ninja.
> 
> - tracking of command lines, which provides more accurate rebuilds
> 
> In addition the change removes the requirement for GNU make 3.82, which
> was annoying on Mac, and avoids bugs on Windows due to ninjatool not
> knowing how to convert Windows escapes to POSIX escapes.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  Makefile                    |   40 +-
>  configure                   |    9 +-
>  docs/devel/build-system.rst |    6 +-
>  meson.build                 |    4 -
>  scripts/mtest2make.py       |    4 +-
>  scripts/ninjatool.py        | 1008 -----------------------------------
>  tests/Makefile.include      |    2 +-
>  7 files changed, 40 insertions(+), 1033 deletions(-)
>  delete mode 100755 scripts/ninjatool.py

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


