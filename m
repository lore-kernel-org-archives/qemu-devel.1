Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9C1C433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6621D206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 11:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEJ2MFf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6621D206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDnWi-0001X3-Fd
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 07:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDnW8-00015J-Eo
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDnW5-0000Y7-QU
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 07:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599132895;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i5jdY8tVWW9iMW9HEImoR5ge+bgjOEyq2bDIAje6JJQ=;
 b=fEJ2MFf/fsvWBdqDg8iOGU4wDKsbF7nrzdIYaQVs9Z/S4Ss4RYxq5OWjzKwln9lfK9SysU
 y3qn+vP/sqd8ZH40dDLstGW+mI63VML0//FRcUfZi6ViDtD7aJgN7cp9pGr7qwT7vkXd9N
 H/sEYPomMvPywSaqbySTSe2cA0/8Z+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-577-I_ZYfwqFNbGlSbNTxf9EPA-1; Thu, 03 Sep 2020 07:34:52 -0400
X-MC-Unique: I_ZYfwqFNbGlSbNTxf9EPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED26E801AEA;
 Thu,  3 Sep 2020 11:34:49 +0000 (UTC)
Received: from redhat.com (ovpn-114-170.ams2.redhat.com [10.36.114.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BB4B10027A6;
 Thu,  3 Sep 2020 11:34:40 +0000 (UTC)
Date: Thu, 3 Sep 2020 12:34:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 0/8] some testing and CI updates (re-greening)
Message-ID: <20200903113437.GQ441291@redhat.com>
References: <20200903112107.27367-1-alex.bennee@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200903112107.27367-1-alex.bennee@linaro.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:47:17
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
Cc: fam@euphon.net, stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, f4bug@amsat.org, cota@braap.org, stefanha@redhat.com,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 03, 2020 at 12:20:59PM +0100, Alex Bennée wrote:
> Hi,
> 
> My first series after a holiday is a bunch of clean-ups for testing.
> Currently they all apply on top of Thomas' pull-request-2020-09-02 tag
> which is currently in flight. The fixes to shippable won't become
> apparent until the main registry has been updates with the new images
> but I have tested them locally.
> 
> The migration and mips fixes where just quick band-aids so I would
> appreciate the appropriate maintainers having a closer look.
> 
> With these we get back to a mostly green state although there seem to
> be some acceptance tests that need updating.
> 
> Alex Bennée (5):
>   CODING_STYLE.rst: flesh out our naming conventions.
>   tests/docker: add python3-setuptools the docker images
>   tests/meson.build: fp tests don't need CONFIG_TCG
>   target/mips: simplify gen_compute_imm_branch logic
>   migration: use pstrcpy to copy run state
> 
> Daniel P. Berrangé (1):
>   crypto: fix build with gcrypt enabled

Any reason you only picked 1 of the two pathces in that series.
The second patch adds CI to validate that the first patch is
actually correct

https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg00279.html

> 
> Gerd Hoffmann (1):
>   usb-host: restrict workaround to new libusb versions
> 
> Paolo Bonzini (1):
>   qemu-iotests: move check-block back to Makefiles
> 
>  CODING_STYLE.rst                         | 31 +++++++++++++++--
>  configure                                |  2 ++
>  hw/usb/host-libusb.c                     |  2 +-
>  migration/global_state.c                 |  4 +--
>  target/mips/translate.c                  | 12 ++-----
>  .travis.yml                              |  2 +-
>  crypto/meson.build                       | 42 +++++++++++++++++-------
>  meson.build                              |  7 ++--
>  tests/Makefile.include                   | 15 +++++++--
>  tests/docker/dockerfiles/debian10.docker |  1 +
>  tests/docker/dockerfiles/debian9.docker  |  1 +
>  tests/meson.build                        |  3 +-
>  tests/qemu-iotests/meson.build           |  4 ---
>  13 files changed, 89 insertions(+), 37 deletions(-)
> 
> -- 
> 2.20.1
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


