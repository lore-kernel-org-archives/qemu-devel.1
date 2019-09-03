Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B5BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:05:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D8020870
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 14:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D8020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i59Qo-0003ht-Vb
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 10:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i590i-0004gr-HG
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i590h-0007e3-HT
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 09:38:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i590f-0007cp-7e; Tue, 03 Sep 2019 09:38:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8F7E330860CF;
 Tue,  3 Sep 2019 13:38:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-195.ams2.redhat.com
 [10.36.116.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 86B9E6107E;
 Tue,  3 Sep 2019 13:38:11 +0000 (UTC)
Date: Tue, 3 Sep 2019 15:38:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190903133810.GI4582@localhost.localdomain>
References: <20190903132110.380933-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903132110.380933-1-vsementsov@virtuozzo.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 03 Sep 2019 13:38:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] iotests: skip 232 when run tests as root
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 03.09.2019 um 15:21 hat Vladimir Sementsov-Ogievskiy geschrieben:
> chmod a-w don't help under root, so skip the test in such case.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
>  tests/qemu-iotests/232 | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tests/qemu-iotests/232 b/tests/qemu-iotests/232
> index 2063f78876..da35a63d85 100755
> --- a/tests/qemu-iotests/232
> +++ b/tests/qemu-iotests/232
> @@ -70,6 +70,12 @@ size=128M
>  
>  _make_test_img $size
>  
> +chmod a-w $TEST_IMG
> +(echo test > $TEST_IMG) 2>/dev/null && \
> +    _notrun "Readonly attribute is ignored, probably you run this test as" \
> +            "root, which is unsupported."
> +chmod a+w $TEST_IMG
> +
>  if [ -n "$TEST_IMG_FILE" ]; then
>      TEST_IMG=$TEST_IMG_FILE
>  fi

I think you need to move the new check below this so that $TEST_IMG_FILE
is considered because otherwise the test will fail for luks:

+chmod: cannot access 'driver=luks,key-secret=keysec0,file.filename=/home/kwolf/source/qemu/tests/qemu-iotests/scratch/t.luks': No such file or directory
+chmod: cannot access 'driver=luks,key-secret=keysec0,file.filename=/home/kwolf/source/qemu/tests/qemu-iotests/scratch/t.luks': No such file or directory

Kevin

