Return-Path: <SRS0=tUBQ=3B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51432C32771
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 11:22:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC6C21744
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2020 11:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0I985aZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC6C21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqbK2-0004M3-4m
	for qemu-devel@archiver.kernel.org; Sun, 12 Jan 2020 06:22:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iqbJC-0003i7-3Y
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 06:21:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iqbJ9-0008Ey-Mj
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 06:21:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38153
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iqbJ9-00086i-43
 for qemu-devel@nongnu.org; Sun, 12 Jan 2020 06:21:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578828085;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=O0lAZXJdUs06SwuWLp8ryK0R7nRJNJIOX9/0trkcKL8=;
 b=F0I985aZqs2ssKnAm8mI+BB0E9rXmllIwpeFePHIDoJrtmujJ2BdncrBz7Jh+F3NaK00Bn
 pJrT+P/YCfzxuqBwlcVzY8LwWjlci73Ji/5Eh4MohrZ1HO6WbLyUjekXvoJ5JrYTiAkI3L
 4+VtArhNIyNy5g2Nu5e/4rKpXuBpe6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-ar_TFxbhMt-vX_S5CBrGfw-1; Sun, 12 Jan 2020 06:21:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38798107ACCA;
 Sun, 12 Jan 2020 11:21:21 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-70.ams2.redhat.com [10.36.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C1DF5DA76;
 Sun, 12 Jan 2020 11:21:17 +0000 (UTC)
Subject: Re: [PULL 0/8] qtests and docs
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200107190802.2257-1-thuth@redhat.com>
 <CAFEAcA8QODFux83esDryjEe9yYOejR4TA3UoD_vHURJx-REzAA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <88e4cbc6-b1ee-c253-eff3-8452c843b645@redhat.com>
Date: Sun, 12 Jan 2020 12:21:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8QODFux83esDryjEe9yYOejR4TA3UoD_vHURJx-REzAA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ar_TFxbhMt-vX_S5CBrGfw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/01/2020 12.19, Peter Maydell wrote:
> On Tue, 7 Jan 2020 at 19:08, Thomas Huth <thuth@redhat.com> wrote:
>>
>>  Hi!
>>
>> The following changes since commit f4d8cf148e43d942ef1202071e0cd66ce40322e0:
>>
>>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-01-06' into staging (2020-01-06 17:44:22 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-01-07
>>
>> for you to fetch changes up to 2cf30f8ecb8b64cc5ccaf77244570e7def8075a5:
>>
>>   docs: build an index page for the HTML docs (2020-01-07 19:48:30 +0100)
>>
>> ----------------------------------------------------------------
>> * Move qtests into a separate directory
>> * Build index.html for docs
>> ----------------------------------------------------------------
> 
> Conflict in tests/Makefile.include, too big for me to easily
> see the right resolution. Can you fix up and resend, please?

Sure, will do!

 Thomas


