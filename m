Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC91C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C53120758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Un70O3il"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C53120758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDY9f-0002YL-69
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDY8z-00022r-BN
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDY8w-0008QU-UL
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599073801;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WcBPAzTgAgGZTYEKS3Kbvdyqp+iXM5ANJs+vnmXOjvo=;
 b=Un70O3ilVQsWo3/zYtXs/JZZEllpVCxyX7WIQjRd7ZKclMq1c1y1v2rY5VoxgHwK7REbv4
 YzxQOdwC1ojOaEDKRgnCr+m6hy/EKSh3nET1E7DphmgQIzhwBzfOIYY3oQRKA7eCSY2Xub
 YgPJPQfkL+E/d5XhQktY3+UMYI96YUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-pSKPFxU6NtSCYvauckOPBw-1; Wed, 02 Sep 2020 15:09:59 -0400
X-MC-Unique: pSKPFxU6NtSCYvauckOPBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88A96109106A;
 Wed,  2 Sep 2020 19:09:58 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-76.ams2.redhat.com [10.36.112.76])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 348B687E24;
 Wed,  2 Sep 2020 19:09:56 +0000 (UTC)
Subject: Re: [PULL v2 00/76] target/microblaze improvements
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200901152054.922595-1-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <3eb9a404-b856-6337-680c-462a765e2b42@redhat.com>
Date: Wed, 2 Sep 2020 21:09:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200901152054.922595-1-richard.henderson@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 01:13:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.324, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 01/09/2020 17.20, Richard Henderson wrote:
> Version 2.  Serves me right for not testing 32-bit host
> when I knew there was a patch that mattered.

 Hi Richard,

I'm afraid, but I think this PR broke the
tests/acceptance/replay_kernel.py:ReplayKernel.test_microblaze_s3adsp1800 acceptance
test:

https://gitlab.com/qemu-project/qemu/-/jobs/716158589#L176

Could you please have a look?

 Thanks,
  Thomas


