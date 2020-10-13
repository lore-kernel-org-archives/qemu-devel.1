Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA33AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:52:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283FF2489B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283FF2489B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSLen-0002Ne-15
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSLcL-0000HD-Vf
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:49:33 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:36995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSLcI-0004WC-R0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:49:33 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id EAE49747608;
 Tue, 13 Oct 2020 16:49:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C8835747602; Tue, 13 Oct 2020 16:49:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C71DB747600;
 Tue, 13 Oct 2020 16:49:26 +0200 (CEST)
Date: Tue, 13 Oct 2020 16:49:26 +0200 (CEST)
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH 06/10] coroutine: add libucontext as external library
In-Reply-To: <20201013133135.GH164611@stefanha-x1.localdomain>
Message-ID: <ff84b94c-42ff-c1ba-cb28-644678c09a21@eik.bme.hu>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-7-j@getutm.app>
 <20201013133135.GH164611@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Joelle van Dyne <j@getutm.app>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Tue, 13 Oct 2020, Stefan Hajnoczi wrote:
> On Mon, Oct 12, 2020 at 04:29:35PM -0700, Joelle van Dyne wrote:
>> From: osy <osy86@users.noreply.github.com>
>>
>> iOS does not support ucontext natively for aarch64 and the sigaltstack is
>> also unsupported (even worse, it fails silently, see:
>> https://openradar.appspot.com/13002712 )
>>
>> As a workaround we include a library implementation of ucontext and add it
>> as a build option.
>>
>> Signed-off-by: Joelle van Dyne <j@getutm.app>
>
> Hi,
> Thanks for sending posting this!
>
> Please indicate what license libucontext is under, that it is compatible
> with QEMU's overall GPL v2 license, and update QEMU license

https://github.com/utmapp/libucontext/blob/master/LICENSE

Maybe the submodule repo should be mirrored in qemu.git eventually.

> documentation (LICENSE, etc), if necessary.
>
> Please update .gitlab-ci.yml with build tests. Is there a way to test
> building QEMU for iOS? If not, then it's difficult for the upstream QEMU
> project to carry iOS-specific features since we cannot test them.

Build testing should be possible on OS X host that I think we already have 
provided it has the right XCode version installed. (Running it is 
difficult due to app deployment requirements of iOS devices.) But I don't 
know much about these, just trying to point at some possible directions to 
solve this.

Regards,
BALATON Zoltan

