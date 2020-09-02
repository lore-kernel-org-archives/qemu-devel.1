Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825E1C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AC4E20709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 08:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8qkeQCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC4E20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDO28-0005Wl-Dz
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 04:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDNzf-00008B-0o
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57222)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kDNzb-0003J9-SQ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 04:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599034782;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4BeLEdjvY4Anlj3N4o45LhnY1vZAiOSAXRl8/6c7mAk=;
 b=I8qkeQCSmjyEAXLraXFooL5eBLiruXQjFgIJgccFgFYmt42QWthvuLnDujbLddxNJjAUW8
 Ptvv5W34zGZlKZWHrp1HhCvuqIACu9faUGIKWXz6NrG/LIXQCZLvGKMvXHx8sDDHyahhoh
 WaOwludCU29JPCZdy9lSF2e/yutfqzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-fRv2aTtiN--YHgKhCnTN1Q-1; Wed, 02 Sep 2020 04:19:38 -0400
X-MC-Unique: fRv2aTtiN--YHgKhCnTN1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FC521074642;
 Wed,  2 Sep 2020 08:19:37 +0000 (UTC)
Received: from redhat.com (ovpn-114-158.ams2.redhat.com [10.36.114.158])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32EB018B59;
 Wed,  2 Sep 2020 08:19:36 +0000 (UTC)
Date: Wed, 2 Sep 2020 09:19:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qemu-iotests: move check-block back to Makefiles
Message-ID: <20200902081933.GE403297@redhat.com>
References: <20200902080046.10412-1-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200902080046.10412-1-pbonzini@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:42:29
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 02, 2020 at 04:00:46AM -0400, Paolo Bonzini wrote:
> check-block has its own test harness, unlike every other test.  If
> we capture its output, as is in general nicer to do without V=1,
> there will be no sign of progress.  So for lack of a better option
> just move the invocation of the test back to Makefile rules.

I expect the correct long term solution here is to stop using the
check-block.sh script.  Instead have code which sets up each
of the I/O tests as an explicit test target in meson. We could
use meson's test grouping features too.


> 
> As a side effect, this will also fix "make check" in --disable-tools
> builds, as they were trying to run qemu-iotests without having
> made qemu-img before.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                    |  2 --
>  tests/Makefile.include         | 15 ++++++++++++---
>  tests/qemu-iotests/meson.build |  4 ----
>  3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 55c7d2318c..356af9142c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1095,11 +1095,9 @@ if have_tools
>               dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
>    qemu_io = executable('qemu-io', files('qemu-io.c'),
>               dependencies: [block, qemuutil], install: true)
> -  qemu_block_tools += [qemu_img, qemu_io]
>    if targetos != 'windows'
>      qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
>                 dependencies: [block, qemuutil], install: true)
> -    qemu_block_tools += [qemu_nbd]
>    endif
>  
>    subdir('storage-daemon')
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 9ac8f5b86a..08301f5bc9 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -468,7 +468,6 @@ check-tcg: $(RUN_TCG_TARGET_RULES)
>  .PHONY: clean-tcg
>  clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>  
> -
>  # Python venv for running tests
>  
>  .PHONY: check-venv check-acceptance
> @@ -523,8 +522,18 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) get-vm-images
>  # Consolidated targets
>  
>  .PHONY: check-block check-unit check check-clean get-vm-images
> -check-block:
> -check-build: build-unit
> +check:
> +
> +ifeq ($(CONFIG_TOOLS)$(CONFIG_POSIX),yy)
> +QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
> +check: check-block
> +check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
> +		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
> +		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
> +	@$<
> +endif
> +
> +check-build: build-unit $(QEMU_IOTESTS_HELPERS-y)
>  
>  check-clean:
>  	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
> diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
> index 3de09fb8fa..60470936b4 100644
> --- a/tests/qemu-iotests/meson.build
> +++ b/tests/qemu-iotests/meson.build
> @@ -4,7 +4,3 @@ if 'CONFIG_LINUX' in config_host
>  else
>      socket_scm_helper = []
>  endif
> -test('qemu-iotests', sh, args: [files('../check-block.sh')],
> -     depends: [qemu_block_tools, emulators, socket_scm_helper],
> -     suite: 'block', timeout: 10000)
> -
> -- 
> 2.26.2
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


