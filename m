Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430DFC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:31:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC072082E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 14:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdjmTvYS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC072082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41919 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iycl9-0003pk-6r
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 09:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyck1-0002cS-Mu
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:30:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iycjz-0002ih-JP
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:30:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32547
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iycjy-0002hQ-Ep
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 09:30:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580740217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=smiIBGeDveJXVZRT5Ti9/RKvOVz0diks5ayD8P2j4mM=;
 b=HdjmTvYSVn3AIEo2b8YY09eIEcZ1DLFNP3X9jfrLBlbsLHmqJvP/FkNzVnek0qFE+tRHMA
 jmlnRfRauuCncdmB718P3EXf3WD0aHkQx05tSHzhKrWBaIdvuI5DOiPItO1xJYqYb8Xh5W
 xb7QVdpx/TQRDmjbgnJViI65m1wF1As=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-2CdGqjRvOmSKfhb_ku1sfA-1; Mon, 03 Feb 2020 09:30:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53DF5800EBB;
 Mon,  3 Feb 2020 14:30:14 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A6F2E8642F;
 Mon,  3 Feb 2020 14:30:13 +0000 (UTC)
Subject: Re: [PULL 00/13] qtests, kconfig and misc patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200203123811.8651-1-thuth@redhat.com>
 <CAFEAcA_1KYRA=87k34zCRLqCf1tWHrULGZPcHeKwJZhDUx0=kw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2fd63018-b9f9-ab88-2d65-009c54bb6cf2@redhat.com>
Date: Mon, 3 Feb 2020 15:30:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_1KYRA=87k34zCRLqCf1tWHrULGZPcHeKwJZhDUx0=kw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 2CdGqjRvOmSKfhb_ku1sfA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/2020 15.04, Peter Maydell wrote:
> On Mon, 3 Feb 2020 at 12:38, Thomas Huth <thuth@redhat.com> wrote:
>>
>>  Hi Peter,
>>
>> the following changes since commit 28db64fce555a03b4ca256d5b6f4290abdfbd9e8:
>>
>>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2020-01-31 17:37:00 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-02-03
>>
>> for you to fetch changes up to 585c138628bbf22ea8e740b2f4f1a3ed0274ebe8:
>>
>>   trivial: Remove xenfb_enabled from sysemu.h (2020-02-03 10:33:57 +0100)
>>
>> ----------------------------------------------------------------
>> * Current qtests queue
>> * Some Kconfig updates
>> * Some trivial clean-ups here and there
>> ----------------------------------------------------------------
> 
> All the incremental rebuilds failed:
> 
> Linux cam-vm-266 4.15.0-70-generic x86_64
> From git://git-us.linaro.org/people/pmaydell/qemu-arm
>    f31160c7d1..f9e931a1d9  staging    -> pmaydell/staging
> make: Entering directory '/home/petmay01/qemu-for-merges/build/w64'
> make[1]: Entering directory '/home/petmay01/qemu-for-merges/slirp'
> make[1]: Nothing to be done for 'all'.
> make[1]: Leaving directory '/home/petmay01/qemu-for-merges/slirp'
>   CC      qga/main.o
>   CC      stubs/machine-init-done.o
>   CC      stubs/replay-user.o
>   CC      stubs/semihost.o
>   CC      qemu-img.o
>   CC      qemu-io.o
>   CC      chardev/char.o
> make: *** No rule to make target
> '/home/petmay01/qemu-for-merges/hw/bt/Kconfig', needed by
> 'aarch64-softmmu/config-devices.mak'.  Stop.
> make: *** Waiting for unfinished jobs....
>   CC      chardev/char-mux.o
> make: Leaving directory '/home/petmay01/qemu-for-merges/build/w64'

Oh, they are still failing??? Why are there still references to
hw/bt/Kconfig in these config-devices.mak files, I'd expect that they
would have been regenerated at least once during the past week?

 Thomas


