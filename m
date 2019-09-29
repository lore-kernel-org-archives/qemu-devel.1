Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7BAC4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4BBC20673
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 16:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4BBC20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEcJR-0002cV-6m
	for qemu-devel@archiver.kernel.org; Sun, 29 Sep 2019 12:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc9F-0001gv-JK
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:34:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1iEc9E-0005T8-0X
 for qemu-devel@nongnu.org; Sun, 29 Sep 2019 12:34:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51452)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1iEc9B-0005NE-Ba; Sun, 29 Sep 2019 12:34:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 69AA481F10;
 Sun, 29 Sep 2019 16:34:07 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2DD2E60C05;
 Sun, 29 Sep 2019 16:34:05 +0000 (UTC)
Message-ID: <d49e9c30a858d1c9f1d340c38cbfc6bfb4827f05.camel@redhat.com>
Subject: Re: [PATCH 13/18] iotests: Make 091 work with data_file
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Sun, 29 Sep 2019 19:34:05 +0300
In-Reply-To: <20190927094242.11152-14-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
 <20190927094242.11152-14-mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Sun, 29 Sep 2019 16:34:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-27 at 11:42 +0200, Max Reitz wrote:
> The image end offset as reported by qemu-img check is different when
> using an external data file; we do not care about its value here, so we
> can just filter it.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/091     | 3 ++-
>  tests/qemu-iotests/091.out | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/091 b/tests/qemu-iotests/091
> index f4b44659ae..7536ca4607 100755
> --- a/tests/qemu-iotests/091
> +++ b/tests/qemu-iotests/091
> @@ -101,7 +101,8 @@ echo "Check image pattern"
>  ${QEMU_IO} -c "read -P 0x22 0 4M" "${TEST_IMG}" | _filter_testdir | _filter_qemu_io
>  
>  echo "Running 'qemu-img check -r all \$TEST_IMG'"
> -"${QEMU_IMG}" check -r all "${TEST_IMG}" 2>&1 | _filter_testdir | _filter_qemu
> +"${QEMU_IMG}" check -r all "${TEST_IMG}" 2>&1 | _filter_testdir | _filter_qemu \
> +    | sed '/Image end offset/d'

Maybe use _filter_qemu_img_check instead? I see it actually filters this already.


>  
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/091.out b/tests/qemu-iotests/091.out
> index 5017f8c2d9..343fac69e0 100644
> --- a/tests/qemu-iotests/091.out
> +++ b/tests/qemu-iotests/091.out
> @@ -24,5 +24,4 @@ read 4194304/4194304 bytes at offset 0
>  Running 'qemu-img check -r all $TEST_IMG'
>  No errors were found on the image.
>  80/16384 = 0.49% allocated, 0.00% fragmented, 0.00% compressed clusters
> -Image end offset: 5570560
>  *** done

Best regards,
	Maxim Levitsky


