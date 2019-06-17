Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AF4C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 371A52087F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:16:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 371A52087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46136 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcpci-0001gS-Dd
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 07:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hcpbd-00010A-Ep
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hcpbc-0007Tz-CI
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:15:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34568)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hcpba-0007RS-29; Mon, 17 Jun 2019 07:15:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C8BFB2DC4;
 Mon, 17 Jun 2019 11:15:12 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-99.ams2.redhat.com [10.36.117.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 873D283870;
 Mon, 17 Jun 2019 11:15:05 +0000 (UTC)
Date: Mon, 17 Jun 2019 13:15:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <20190617111504.GC7397@linux.fritz.box>
References: <1560276131-683243-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1560276131-683243-3-git-send-email-andrey.shinkevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560276131-683243-3-git-send-email-andrey.shinkevich@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 17 Jun 2019 11:15:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/7] iotests: exclude killed processes
 from running under Valgrind
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
Cc: vsementsov@virtuozzo.com, berrange@redhat.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, mreitz@redhat.com, rkagan@virtuozzo.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 11.06.2019 um 20:02 hat Andrey Shinkevich geschrieben:
> The Valgrind tool fails to manage its termination when QEMU raises the
> signal SIGKILL. Lets exclude such test cases from running under the
> Valgrind because there is no sense to check memory issues that way.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

I don't fully understand the reasoning here. Most interesting memory
access errors happen before a process terminates. (I'm not talking about
leaks here, but use-after-free, buffer overflows, uninitialised memory
etc.)

However, I do see that running these test cases with -valgrind ends in a
hang because the valgrind process keeps hanging around as a zombie
process and the test case doesn't reap it. I'm not exactly sure why that
is, but it looks more like a problem with the parent process (i.e. the
bash script).

If we can't figure out how to fix this, we can disable valgrind in these
cases, but I think the explanation needs to be different.

> diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
> index 0d4e963..95115e2 100755
> --- a/tests/qemu-iotests/039
> +++ b/tests/qemu-iotests/039
> @@ -65,6 +65,7 @@ echo "== Creating a dirty image file =="
>  IMGOPTS="compat=1.1,lazy_refcounts=on"
>  _make_test_img $size
>  
> +VALGRIND_QEMU="" \
>  $QEMU_IO -c "write -P 0x5a 0 512" \
>           -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
>      | _filter_qemu_io

I agree with Vladimir that setting VALGRIND_QEMU only once at the top of
the script is probably the better option.

Kevin

