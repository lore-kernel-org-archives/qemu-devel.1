Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3EEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A117206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T41IUf8q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A117206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADn7-0003zi-G3
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kADm6-0002Vp-Mw
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:48:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34838
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kADm3-0005xV-O0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598280517;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mw8ozmPB/MkPgj3YTsV0uMFAawQDj167IVsTuGBE3xg=;
 b=T41IUf8qtGbtW/BQXxk6WDeQ/uw/ZLmYQAqd/qc4QWrib+FxJU0zen8W6UYYmsyL6psmxd
 kSsbmNZhAuPl7E2pCcyrxnpitnbjHn8eYrr2VCPu4WnJQuHi/ghoA72Pkyo0DHE0KjEim2
 HG6fGIHTsNcWvdlqG74aTNLL7Rx6XFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-w6cLp763PLmSd2ZhTUX12g-1; Mon, 24 Aug 2020 10:48:31 -0400
X-MC-Unique: w6cLp763PLmSd2ZhTUX12g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D927518A2259;
 Mon, 24 Aug 2020 14:48:30 +0000 (UTC)
Received: from redhat.com (ovpn-114-223.ams2.redhat.com [10.36.114.223])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B91660BF1;
 Mon, 24 Aug 2020 14:48:29 +0000 (UTC)
Date: Mon, 24 Aug 2020 15:48:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH 3/4] configure: Prefer gmake on darwin
Message-ID: <20200824144827.GO10011@redhat.com>
References: <20200822212129.97758-1-r.bolshakov@yadro.com>
 <20200822212129.97758-4-r.bolshakov@yadro.com>
MIME-Version: 1.0
In-Reply-To: <20200822212129.97758-4-r.bolshakov@yadro.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 06:40:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 23, 2020 at 12:21:28AM +0300, Roman Bolshakov wrote:
> New meson/make build requires GNU make 3.82+ but macOS ships 3.81 even
> on Big Sur while homebrew provides GNU make 4.3 as 'gmake' in $PATH.
> 
> With the change, 'make' switches over to gmake implicitly.
> 
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  configure | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/configure b/configure
> index 9e0d505067..90b02b7271 100755
> --- a/configure
> +++ b/configure
> @@ -903,6 +903,7 @@ Darwin)
>    darwin="yes"
>    hax="yes"
>    hvf="yes"
> +  make="${MAKE-gmake}"
>    LDFLAGS_SHARED="-bundle -undefined dynamic_lookup"
>    if [ "$cpu" = "x86_64" ] ; then
>      QEMU_CFLAGS="-arch x86_64 $QEMU_CFLAGS"
> @@ -916,6 +917,27 @@ Darwin)
>    # won't work when we're compiling with gcc as a C compiler.
>    QEMU_CFLAGS="-DOS_OBJECT_USE_OBJC=0 $QEMU_CFLAGS"
>    HOST_VARIANT_DIR="darwin"
> +  cat > GNUmakefile <<'EOF'
> +# This file is auto-generated by configure to implicitly switch from a 'make'
> +# invocation to 'gmake'
> +
> +OLD_MAKE := $(MAKE)
> +
> +include config-host.mak
> +
> +ifeq ($(MAKECMDGOALS),)
> +recurse: all
> +endif
> +
> +.NOTPARALLEL: %
> +%: force
> +	@echo 'Switch from $(OLD_MAKE) to $(MAKE)'
> +	@$(MAKE) -f Makefile $(MAKECMDGOALS)
> +force: ;
> +.PHONY: force
> +GNUmakefile: ;
> +
> +EOF


I was wondering why you duplicated the GNUmakefile I created earlier, then
I realized this one is created in the build dir, whereas the other was
created in the source dir. I would note this works for macOS which has a
GNU make, but doesn't work for FreeBSD has non-GNU make by default.

I kind of feel like the previous patch which raises an error is good
enough. User can just put the homebrew  newer GNU make first in their
$PATH, which is sensible regardless IMHO.

None the less, this patch does what it claims so

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


