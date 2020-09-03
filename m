Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE8FC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469FB206A5
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 14:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P+YwcBu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469FB206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDq4f-0001nG-A2
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 10:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDq3y-00010t-RI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:18:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28055
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kDq3v-0006KG-N8
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 10:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599142683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KkRCfDrJdT1RYrPQWIfyBdJ/TcBPD5YJXxkc3N/4tLc=;
 b=P+YwcBu1/E1bimJVnpcV66rHOCFJZGpdWhGGsoy7A4HQ0FnzsRLWbNisRiYeVgyTjg5EW0
 SAfSgqoovfREQHAW8IPt3Wsn/SUI8a0wvrE1RC4wGWv+nBO5AIwwvH+zZIv4YEIvgCfSM2
 CEDZGpJxA0FNn3GpaLxnBN1sxdpLUJQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-Jr7VMKuQOy6Zxu4jku7TNw-1; Thu, 03 Sep 2020 10:18:01 -0400
X-MC-Unique: Jr7VMKuQOy6Zxu4jku7TNw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 954181084D62;
 Thu,  3 Sep 2020 14:17:59 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-10.ams2.redhat.com [10.36.114.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C8D6081184;
 Thu,  3 Sep 2020 14:17:47 +0000 (UTC)
Subject: Re: [PATCH v1 0/8] some testing and CI updates (re-greening)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200903112107.27367-1-alex.bennee@linaro.org>
 <20200903113437.GQ441291@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <131de702-c36a-e29a-c01a-bdac9ae6b3b6@redhat.com>
Date: Thu, 3 Sep 2020 16:17:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200903113437.GQ441291@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 00:24:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: fam@euphon.net, stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org,
 f4bug@amsat.org, qemu-devel@nongnu.org, cota@braap.org, stefanha@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/09/2020 13.34, Daniel P. Berrangé wrote:
> On Thu, Sep 03, 2020 at 12:20:59PM +0100, Alex Bennée wrote:
>> Hi,
>>
>> My first series after a holiday is a bunch of clean-ups for testing.
>> Currently they all apply on top of Thomas' pull-request-2020-09-02 tag
>> which is currently in flight. The fixes to shippable won't become
>> apparent until the main registry has been updates with the new images
>> but I have tested them locally.
>>
>> The migration and mips fixes where just quick band-aids so I would
>> appreciate the appropriate maintainers having a closer look.
>>
>> With these we get back to a mostly green state although there seem to
>> be some acceptance tests that need updating.
>>
>> Alex Bennée (5):
>>   CODING_STYLE.rst: flesh out our naming conventions.
>>   tests/docker: add python3-setuptools the docker images
>>   tests/meson.build: fp tests don't need CONFIG_TCG
>>   target/mips: simplify gen_compute_imm_branch logic
>>   migration: use pstrcpy to copy run state
>>
>> Daniel P. Berrangé (1):
>>   crypto: fix build with gcrypt enabled
> 
> Any reason you only picked 1 of the two pathces in that series.
> The second patch adds CI to validate that the first patch is
> actually correct
 I guess Alex dropped it because there is a (simple) conflict with one
of my patches ("gitlab/travis: Rework the disabled features tests") ...
should be easy to fix, though.

I'm also preparing yet another patch series for improving the gitlab-CI
(with the cross-compiler patches), so I can also put your crypto gitlab
patch in there if you like.

 Thomas


