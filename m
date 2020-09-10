Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD42C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72448207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K4Fhys+7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72448207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGIfM-0006v4-VL
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kGIe4-0005lT-TE
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:13:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50214
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kGIe2-0004Ru-KL
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:13:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599729209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/5AQztNYHwwJ5hQ66DuML/KSqkJbT0YqhTYu4pGO7N8=;
 b=K4Fhys+7h97qf+8u5N5Z0nN/8WdjrIhNin1PE+1h3QfTKsSKtaoqDMpDPic5VEA8nIUx8J
 Brjj7GAq1b1DjvPeM8VOevfz5Mp7tvt8JwT291LmMBRL7Hf9SR33yV32FMdmV2y5yoajAV
 AgpsGcVKW5Cn9iV8XnXTVm55VnqxKVw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-WbdsEDQ-MyiFrOgX6D2-NQ-1; Thu, 10 Sep 2020 05:13:27 -0400
X-MC-Unique: WbdsEDQ-MyiFrOgX6D2-NQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 930FE1007483;
 Thu, 10 Sep 2020 09:13:26 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-29.ams2.redhat.com [10.36.112.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6FC051002D62;
 Thu, 10 Sep 2020 09:13:25 +0000 (UTC)
Date: Thu, 10 Sep 2020 11:13:23 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PULL v2] Block layer patches
Message-ID: <20200910091323.GC7100@linux.fritz.box>
References: <20200908115322.325832-1-kwolf@redhat.com>
 <CAFEAcA-wrgOC9oqdqBuVSTiidaRcwbgQWF08zD=TSetSwn_tjA@mail.gmail.com>
 <480db253-9aa4-39c3-592f-bc5cfea1997b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <480db253-9aa4-39c3-592f-bc5cfea1997b@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 00:49:43
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.09.2020 um 00:09 hat Eric Blake geschrieben:
> On 9/9/20 4:55 PM, Peter Maydell wrote:
> 
> > 
> > This fails 'make check' on NetBSD and OpenBSD:
> > 
> > ./check: line 47: realpath: command not found
> > ./check: line 60: /common.env: No such file or directory
> > check: failed to source common.env (make sure the qemu-iotests are run
> > from tests/qemu-iotests in the build tree)
> > gmake: *** [/home/qemu/qemu-test.vcb7nz/src/tests/Makefile.include:144:
> > check-block] Error 1
> 
> BSD has 'readlink -f' (and so does coreutils on Linux), which does the same
> thing as the Linux-only realpath.

Thanks, I'll use that in v3.

Max, if v3 doesn't go through either, please take over the pull request
as I will be on PTO until the 22th.

Kevin


