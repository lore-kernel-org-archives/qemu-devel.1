Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD403C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 04:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11BD4206DB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 04:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lv03COPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BD4206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLIZT-0005eX-UC
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 00:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kLIYu-00059S-W8
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 00:08:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kLIYr-0003PX-ME
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 00:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600920528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krJ59Voq3NZjRa7raXO1kPEhnZjPmPxGEhSnEXcsbks=;
 b=Lv03COPEC6fdBSTcMS8sChxHYMox2I5+9g4hA020oNeHEbd5OLYEkl62X5DNJnlYGtbKDx
 D9lwrdO8cUURvDLy3Jn7HYuAue5ra8NF+0ct8ovu1BhD+WsNMJF269+75csfuziT30uuK+
 iIUzQGVxmKb5RgRDoigH9EGNmEB26ss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-Dpen2vhbMlqZ54qlhtiDIg-1; Thu, 24 Sep 2020 00:08:44 -0400
X-MC-Unique: Dpen2vhbMlqZ54qlhtiDIg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C91B21084C8A;
 Thu, 24 Sep 2020 04:08:41 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-69.ams2.redhat.com [10.36.112.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FE8C100238C;
 Thu, 24 Sep 2020 04:08:39 +0000 (UTC)
Subject: Re: [PATCH] iotests: Remove 030 from the auto group
To: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>
References: <20200904055701.462482-1-thuth@redhat.com>
 <20200904082513.GA6237@linux.fritz.box>
 <w51ft789x1x.fsf@maestria.local.igalia.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <32238753-ca8c-82c2-7b4b-a92c9f2c21e8@redhat.com>
Date: Thu, 24 Sep 2020 06:08:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <w51ft789x1x.fsf@maestria.local.igalia.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/09/2020 20.18, Alberto Garcia wrote:
> On Fri 04 Sep 2020 10:25:13 AM CEST, Kevin Wolf wrote:
>>> Test 030 is still occasionally failing in the CI ... so for the
>>> time being, let's disable it in the "auto" group. We can add it
>>> back once it got more stable.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>
>> I would rather just disable this one test function as 030 is a pretty
>> important one that tends to catch bugs.
>>
>>>  I just saw the problem here:
>>>   https://cirrus-ci.com/task/5449330930745344?command=main#L6482
>>>  and Peter hit it a couple of weeks ago:
>>>   https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg00136.html
>>
>> I wonder how this can still happen. The test should have more than
>> enough time to complete now. Except if the throttling doesn't work as
>> expected.
>>
>> I can't seem to reproduce this even if I add rather long delays. After
>> 40 seconds, all jobs have moved either by 512k (which is STREAM_CHUNK)
>> or not at all.
> 
> I also don't understand how this can fail... I assume the test is not
> running for that long in the cases when it fails, right?

Hard to say ... the problem only occurs occasionally, and I've never
seen it happen "live", only in the CI logs after the job has failed. I
guess you'd have to print timestamps in the code and then submit a lot
of jobs to the CI systems that are sensitive to this problem (e.g.
Cirrus and Travis) to find out...

 Thomas


