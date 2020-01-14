Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD1AC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99677206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 13:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aM8IrJwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99677206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irMPM-000509-Kz
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 08:39:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1irMOe-0004Gz-88
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1irMOd-0004NS-A8
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:38:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57177
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1irMOd-0004NI-70
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 08:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579009091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=gPoBcc2aHn1ToeFSiNbgw2VuJX2qesF95FQlmMKDxkc=;
 b=aM8IrJwqUaCD+mxsnXXHPT47agRklnRFY257FR6Su88ftCs2MMRrxxGkfNBZoZDkWQg8YT
 E84vm/xoUD6rW6LEgrTHkryL5DDeK1/8DGbbJo0qj8M1xlvve0Wd/VTgPkeAGybi6tV40F
 MzRfTc3568293lWLgoKRH//zjCUyvx8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-Wpdzd31CPDOT5M_MZpgVGg-1; Tue, 14 Jan 2020 08:38:07 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EA6D4184C73C;
 Tue, 14 Jan 2020 13:38:06 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.36.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 71E69100164D;
 Tue, 14 Jan 2020 13:38:05 +0000 (UTC)
Subject: Re: [PATCH v2] iotests: Add more "skip_if_unsupported" statements to
 the python tests
To: Kevin Wolf <kwolf@redhat.com>
References: <20191218144349.19354-1-thuth@redhat.com>
 <20191219121928.GH5230@linux.fritz.box>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <31b81415-0679-089b-788b-cc6364c0ebff@redhat.com>
Date: Tue, 14 Jan 2020 14:38:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191219121928.GH5230@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Wpdzd31CPDOT5M_MZpgVGg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/12/2019 13.19, Kevin Wolf wrote:
> Am 18.12.2019 um 15:43 hat Thomas Huth geschrieben:
>> The python code already contains a possibility to skip tests if the
>> corresponding driver is not available in the qemu binary - use it
>> in more spots to avoid that the tests are failing if the driver has
>> been disabled.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2: Thanks to Max' "iotests: Allow skipping test cases" patch (see
>>      commit 6be012252018249d3a), this patch has been greatly simplified
>>      by only marking the setUp functions instead of all functions from
>>      a class.
> 
> Ah, nice. I didn't know this worked on setup() functions.
> 
>> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
>> index f3766f2a81..a585554c61 100755
>> --- a/tests/qemu-iotests/030
>> +++ b/tests/qemu-iotests/030
>> @@ -530,6 +530,7 @@ class TestQuorum(iotests.QMPTestCase):
>>      children = []
>>      backing = []
>>  
>> +    @iotests.skip_if_unsupported(['quorum'])
>>      def setUp(self):
>>          opts = ['driver=quorum', 'vote-threshold=2']
> 
> test_stream_quorum(), which is the only test case in this class, already
> contains a check:
> 
>     if not iotests.supports_quorum():
>         return
> 
> We should probably remove this check because it's dead code now.

Interesting - but apparently, the check did not work right, since the
test aborts if I run it with a QEMU binary that does not have quorum
enabled.
Anyway, I'll respin the patch with the old check removed.

 Thanks,
  Thomas


