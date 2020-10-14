Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33567C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FBC621D81
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 21:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhPL2JPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FBC621D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSogJ-0001ab-21
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 17:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSoc2-00086B-QC
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 17:47:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kSoc0-0003E6-7E
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 17:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602712025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+993loCs4WZigwK6pF0HyAPO4xm97lsEVulpoRgx/48=;
 b=fhPL2JPYJbmRc7Mj7JeTBDIFCivLAirvg0VCpFAwH5IGYvvh17qKZdLAuqeb/q80Bwa4pk
 uRZ3VIPqYgFZww8peDdWUmzGtpjsefIFxj3IsUdoDpzGxm+uchauU27YQLZ5rDuxFu8x13
 CcJTKo/IQ/CiVoWWrCGK7pO4NW7TQi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-ZJRlkNasNVes0DtDS727Pg-1; Wed, 14 Oct 2020 17:47:03 -0400
X-MC-Unique: ZJRlkNasNVes0DtDS727Pg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F055E5703D;
 Wed, 14 Oct 2020 21:47:00 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89F197664F;
 Wed, 14 Oct 2020 21:47:00 +0000 (UTC)
Date: Wed, 14 Oct 2020 17:46:59 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: CACHE_NAME in .travis.yml (was Re: [Qemu-devel] [PATCH 08/10]
 .travis.yml: Cache Linux/GCC 'debug profile' jobs together)
Message-ID: <20201014214659.GC5733@habkost.net>
References: <20190903132649.20226-1-philmd@redhat.com>
 <20190903132649.20226-9-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20190903132649.20226-9-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
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
Cc: Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I just stumbled upon this when editing .travis.yml, and I'm
trying to understand how the $CACHE_NAME trick is supposed to
work.

If I understood the Travis documentation correctly, all
environment variables will affect the cache id (including
$CONFIG, in the case below).  This would mean the two entries
would still use a different cache even if $CACHE_NAME is the
same.

See, for example:
https://travis-ci.org/github/qemu/qemu/jobs/735738551#L965
https://travis-ci.org/github/qemu/qemu/jobs/735738553#L967

Both build tasks have the same value for $CACHE_NAME, but they
are fetching two different cache URLs:

master/cache--linux-focal-50ba7438064455bdb04bb41dcde2c91c34bb797265fe435b84cee4bae7d9b61d--compiler-gcc.tgz
master/cache--linux-focal-8991cfc9b7f3f268e7e50aff4218daa4c206597ae796c60643a84ed58bba0cfb--compiler-gcc.tgz


On Tue, Sep 03, 2019 at 03:26:47PM +0200, Philippe Mathieu-Daudé wrote:
> These jobs build different components but use the same
> host features. Put them in the same cache bucket.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  .travis.yml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index c64a551829..e362c3fe02 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -120,11 +120,13 @@ matrix:
>  
>      - env:
>          - CONFIG="--enable-debug --enable-debug-tcg --disable-user"
> +        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
>  
>  
>      # TCG debug can be run just on it's own and is mostly agnostic to user/softmmu distinctions
>      - env:
>          - CONFIG="--enable-debug-tcg --disable-system"
> +        - CACHE_NAME="${TRAVIS_BRANCH}-linux-gcc-debug"
>  
>  
>      - env:
> -- 
> 2.20.1
> 
> 

-- 
Eduardo


