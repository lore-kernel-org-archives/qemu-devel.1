Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEA6C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:20:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB3D208FE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 08:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVFjgJdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB3D208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFvL8-0005AL-58
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 04:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFvIe-0001yG-Dv
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:17:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50637
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kFvIa-0003mP-Sf
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 04:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599639468;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/bU1KN+JFHtSXRGCY4oPG5MjkxrSVdRO7vvZSHF+Mo4=;
 b=cVFjgJdL/5adD8ZZv6Xv7laX2vjGjhJ3WhZ+CAdET7Jg22jZb7hnbuOVHK6WrIblHYXcrb
 1+a5xefZAWGCpSkmJ/0I9HvGDub1YYgbeNY0j6nj9SqWTw2puBgZoEpapf4HnJVJ/W0zde
 OxTj4WE9A3nYBxxEKPeC9zUKcFtirME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-UY6MEyqWN1WaioCi8sGQGA-1; Wed, 09 Sep 2020 04:17:46 -0400
X-MC-Unique: UY6MEyqWN1WaioCi8sGQGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 976742FD13;
 Wed,  9 Sep 2020 08:17:44 +0000 (UTC)
Received: from redhat.com (ovpn-115-8.ams2.redhat.com [10.36.115.8])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0BA5A5C221;
 Wed,  9 Sep 2020 08:17:37 +0000 (UTC)
Date: Wed, 9 Sep 2020 09:17:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH 14/16] cirrus: Building freebsd in a single short
Message-ID: <20200909081735.GE1011023@redhat.com>
References: <20200908194820.702-1-luoyonggang@gmail.com>
 <20200908194820.702-15-luoyonggang@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200908194820.702-15-luoyonggang@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:13:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 09, 2020 at 03:48:18AM +0800, Yonggang Luo wrote:
> freebsd 1 hour limit not hit anymore

How long does the combined job take with this change ? If it is
within 10 minutes of the limit, then we still want the split, as
transient changes in the CI system can push it over the limit
making the test unreliable.

> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  .cirrus.yml | 35 ++++++++---------------------------
>  1 file changed, 8 insertions(+), 27 deletions(-)
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 49335e68c9..b0004273bb 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -1,38 +1,19 @@
>  env:
>    CIRRUS_CLONE_DEPTH: 1
>  
> -freebsd_1st_task:
> +freebsd_12_task:
>    freebsd_instance:
>      image_family: freebsd-12-1
> -    cpu: 4
> -    memory: 4G
> -  install_script: ASSUME_ALWAYS_YES=yes pkg bootstrap -f ; pkg install -y
> -    bash curl cyrus-sasl git glib gmake gnutls gsed
> -    nettle perl5 pixman pkgconf png usbredir
> +    cpu: 8
> +    memory: 8G
> +  install_script:
> +    - ASSUME_ALWAYS_YES=yes pkg bootstrap -f ;
> +    - pkg install -y bash curl cyrus-sasl git glib gmake gnutls gsed 
> +          nettle perl5 pixman pkgconf png usbredir
>    script:
>      - mkdir build
>      - cd build
> -    - ../configure --disable-user --target-list-exclude='alpha-softmmu
> -        ppc64-softmmu ppc-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu
> -        sparc64-softmmu sparc-softmmu x86_64-softmmu i386-softmmu'
> -        --enable-werror || { cat config.log; exit 1; }
> -    - gmake -j$(sysctl -n hw.ncpu)
> -    - gmake -j$(sysctl -n hw.ncpu) check
> -
> -freebsd_2nd_task:
> -  freebsd_instance:
> -    image_family: freebsd-12-1
> -    cpu: 4
> -    memory: 4G
> -  install_script: ASSUME_ALWAYS_YES=yes pkg bootstrap -f ; pkg install -y
> -    bash curl cyrus-sasl git glib gmake gnutls gtk3 gsed libepoxy mesa-libs
> -    nettle perl5 pixman pkgconf png SDL2 usbredir
> -  script:
> -    - ./configure --enable-werror --target-list='alpha-softmmu ppc64-softmmu
> -        ppc-softmmu riscv32-softmmu riscv64-softmmu s390x-softmmu
> -        sparc64-softmmu sparc-softmmu x86_64-softmmu i386-softmmu
> -        sparc-bsd-user sparc64-bsd-user x86_64-bsd-user i386-bsd-user'
> -        || { cat config.log; exit 1; }
> +    - ../configure --enable-werror || { cat config.log; exit 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
>      - gmake -j$(sysctl -n hw.ncpu) check
>  
> -- 
> 2.28.0.windows.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


