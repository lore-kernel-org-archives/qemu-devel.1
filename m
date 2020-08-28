Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21D8C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 04:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD042080C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 04:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBcsb7oO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BD042080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBW1C-0000vt-Sl
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 00:29:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBW0O-0000W9-5J
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 00:28:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27892
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kBW0L-0003Sk-Gx
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 00:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598588923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQqu1j93b9ji5pUHBoEABONORQvN52hpHIpntN/3bbo=;
 b=GBcsb7oOoeiRNhCuTX099ZbIwnaC1gwN3artvl6Q45dV5gbqH6GYTEWYpThUHUa2lWjh9O
 iPZq0YJhgTBYUstVrDGj99XZMHaVwtkKBFB5MU0lDmoenaCma3PZsauYlCmclc6ygfx1p4
 NZQqs4chuGlN2wMaMTaAAcSY7oB3UD8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-I0h2hrWtNr6h_Lg3cNzfWg-1; Fri, 28 Aug 2020 00:28:40 -0400
X-MC-Unique: I0h2hrWtNr6h_Lg3cNzfWg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D75C81005E5D;
 Fri, 28 Aug 2020 04:28:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-79.ams2.redhat.com [10.36.112.79])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 58A716716C;
 Fri, 28 Aug 2020 04:28:37 +0000 (UTC)
Subject: Re: [PATCH] cirrus.yml: Exclude some targets in the FreeBSD job to
 speed up the build
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200824094410.6201-1-thuth@redhat.com>
 <20200827150005.GA216263@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <52d5295a-1c64-6437-f642-4a8eda266b5a@redhat.com>
Date: Fri, 28 Aug 2020 06:28:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200827150005.GA216263@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 00:28:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.782, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/08/2020 17.00, Daniel P. Berrangé wrote:
> On Mon, Aug 24, 2020 at 11:44:10AM +0200, Thomas Huth wrote:
>> The FreeBSD jobs currently hit the 1h time limit in the Cirrus-CI.
>> We've got to exclude some build targets here to make sure that the job
>> finishes in time again. The targets that are excluded should not hurt
>> much, since e.g. all the code from i386-softmmu is covered again by
>> x86_64-softmmu.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  Not sure why the FreeBSD builds suddenly got slower and hit the 1h
>>  time limit now. Looking at https://cirrus-ci.com/github/qemu/qemu
>>  it seems like the FreeBSD jobs were already taking ca. 48 minutes
>>  since quite a while, but since the Meson build system has been merged,
>>  they now always hit the 1h limit. Could it be that Meson is slow on
>>  FreeBSD?
> 
> No, it appears to just be compiling a lot more than in the past.
> 
> $ grep Compiling main.log-meson  | wc -l
> 5468
> 
> $ grep CC main.log-config  | wc -l
> 4855

Oh, that's interesting, thanks!

> This seems to be caused my compiling lots of stuff under tests/
> that we did not previously build
> 
> $ grep Compiling main.log-meson  | grep tests/ | wc -l
> 616
> 
> not sure if this is specific to FreeBSD, or whether we're doing
> this on all platforms and merely noticed first on FreeBSD due
> to the timeout.

I also did some build time tests on my x86 Linux laptop, but I did not
notice any significant differences there.

> Mostly it seems to the libtestfloat ad libsoftfloat, but also
> a bit of libqtest stuff.

Now that you've mentioned softfloat ... I think that matches what I've
seen in the log output on cirrus-ci.com : Suddenly there is a lot of
verbose softloat test output there that I never noticed before.

I assume that's ok that we now compile/test more on FreeBSD, so I'll go
ahead with this patch and put it into my next "CI" pull
request to fix the cirrus-ci builds again.

 Thomas


