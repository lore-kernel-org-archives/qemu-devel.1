Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFF9C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37541206ED
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 06:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dA+L6E0W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37541206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSDT6-0002Sj-0c
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 02:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSDSR-0001t0-J1
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 02:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kSDSN-0000Hw-Vi
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 02:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602569202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m9B273ARsnjWwBYBnn8AGceVkfb732hx8XQ++n9v7a8=;
 b=dA+L6E0Ws4IzKJAwCpRnXH8MVI8H7gWgDxCbqzgGoWBbT615zqBOs/9sMT53QccKND+Wfn
 yNleebus+GiV4ifdzIB2NEhGa0NLyqlZpfXA7qRQhVHu6DXCQzi8ZznLlL7MXkyyP5+/s9
 Q2RJ8NL3WWo+fkpj1E/hZoArL4ABAq0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-XzCA9Qk-PnyPVWjPeueRBA-1; Tue, 13 Oct 2020 02:06:39 -0400
X-MC-Unique: XzCA9Qk-PnyPVWjPeueRBA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D05D1054F8A;
 Tue, 13 Oct 2020 06:06:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-151.ams2.redhat.com [10.36.112.151])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E7E855789;
 Tue, 13 Oct 2020 06:06:36 +0000 (UTC)
Subject: Re: [PATCH] tests/migration: Allow longer timeouts
From: Thomas Huth <thuth@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, lvivier@redhat.com, alex.bennee@linaro.org
References: <20201008160330.130431-1-dgilbert@redhat.com>
 <b2ca5be3-fa96-4ecd-32bc-26a2d27554bd@redhat.com>
Message-ID: <bc76808c-f1e1-86f8-9aaf-7a8221288772@redhat.com>
Date: Tue, 13 Oct 2020 08:06:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <b2ca5be3-fa96-4ecd-32bc-26a2d27554bd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/10/2020 15.13, Thomas Huth wrote:
> On 08/10/2020 18.03, Dr. David Alan Gilbert (git) wrote:
>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>
>> In travis, with gcov and gprof we're seeing timeouts; hopefully fix
>> this by increasing the test timeouts a bit, but for xbzrle ensure it
>> really does get a couple of cycles through to test the cache.
>>
>> I think the problem in travis is we have about 2 host CPU threads,
>> in the test we have at least 3:
>>    a) The vCPU thread (100% flat out)
>>    b) The source migration thread
>>    c) The destination migration thread
>>
>> if (b) & (c) are slow for any reason - gcov+gperf or a slow host -
>> then they're sharing one host CPU thread so limit the migration
>> bandwidth.
>>
>> Tested on my laptop with:
>>    taskset -c 0,1 ./tests/qtest/migration-test -p /x86_64/migration
>>
>> Reported-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>  tests/qtest/migration-test.c | 21 +++++++++++----------
>>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> This seems to fix the gcov/gprof test indeed:
> 
>  https://travis-ci.com/github/huth/qemu/jobs/398270396
> 
> Thus:
> 
> Tested-by: Thomas Huth <thuth@redhat.com>
> 
> I'm also queuing this to my qtest-next branch (in case you don't plan a
> migration pull request within the next days):
> 
>  https://gitlab.com/huth/qemu/-/commits/qtest-next/

FYI, this patch fails to build on non-Linux systems:

https://cirrus-ci.com/task/5951706225704960?command=main#L6076

The #define needs to be moved out of the #if defined(__linux__) block. I can
fixup the patch here locally, but if you want to include it in your next
migration pull request instead, you should do that, too.

 Cheers,
  Thomas


