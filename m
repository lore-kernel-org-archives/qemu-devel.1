Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A691C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:13:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB8AC20674
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gAoAeKC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB8AC20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiOi-0004wD-3p
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:13:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jaiNk-0003VD-9c
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:12:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23970
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jaiNh-0006LP-Ag
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589818363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=AIWWR1JhR9kL7pKOeK+aGbOQhUtb8Frp+dZMzQAhE8Y=;
 b=gAoAeKC5bqzE+OS82h/jomd1smQQ4jCmI0fNzxCj1BOkVECuO1kiFjX3M+1SAgca1ivMpP
 kyqdV3MbSw1WQZhGQ71oTKKqUk4FlMZq20NVPKdCdAbNUM5u5m+soCN1Qiw8Iw5egoDci3
 7d6ZxvqHg4CsZElbt8PBzlsC+L53PlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-DOKphBMEPMGGwQ6ViWu42Q-1; Mon, 18 May 2020 12:12:41 -0400
X-MC-Unique: DOKphBMEPMGGwQ6ViWu42Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A25F8015CE;
 Mon, 18 May 2020 16:12:40 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-242.ams2.redhat.com [10.36.112.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08C707958D;
 Mon, 18 May 2020 16:12:37 +0000 (UTC)
Subject: Re: [PATCH v4 9/9] iotests: rename and move 169 and 199 tests
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200515211505.3042-1-vsementsov@virtuozzo.com>
 <20200515211505.3042-10-vsementsov@virtuozzo.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6ad020e7-ed54-5bc8-0c70-9776dab903ac@redhat.com>
Date: Mon, 18 May 2020 18:12:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200515211505.3042-10-vsementsov@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 23:32:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/05/2020 23.15, Vladimir Sementsov-Ogievskiy wrote:
> Rename bitmaps migration tests and move them to tests subdirectory to
> demonstrate new human-friendly test naming.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test}   | 0
>  .../{199.out => tests/migrate-bitmaps-postcopy-test.out}          | 0
>  tests/qemu-iotests/{169 => tests/migrate-bitmaps-test}            | 0
>  tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out}    | 0
>  4 files changed, 0 insertions(+), 0 deletions(-)
>  rename tests/qemu-iotests/{199 => tests/migrate-bitmaps-postcopy-test} (100%)
>  rename tests/qemu-iotests/{199.out => tests/migrate-bitmaps-postcopy-test.out} (100%)
>  rename tests/qemu-iotests/{169 => tests/migrate-bitmaps-test} (100%)
>  rename tests/qemu-iotests/{169.out => tests/migrate-bitmaps-test.out} (100%)
> 
> diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
> similarity index 100%
> rename from tests/qemu-iotests/199
> rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test
> diff --git a/tests/qemu-iotests/199.out b/tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
> similarity index 100%
> rename from tests/qemu-iotests/199.out
> rename to tests/qemu-iotests/tests/migrate-bitmaps-postcopy-test.out
> diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/tests/migrate-bitmaps-test
> similarity index 100%
> rename from tests/qemu-iotests/169
> rename to tests/qemu-iotests/tests/migrate-bitmaps-test
> diff --git a/tests/qemu-iotests/169.out b/tests/qemu-iotests/tests/migrate-bitmaps-test.out
> similarity index 100%
> rename from tests/qemu-iotests/169.out
> rename to tests/qemu-iotests/tests/migrate-bitmaps-test.out

I like the idea ... but the path name + file names get now quite long.
While you're at it, what about renaming the "qemu-iotests" directory to
just "iotests" or even just "io" now?

 Thomas


