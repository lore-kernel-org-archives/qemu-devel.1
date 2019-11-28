Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83791C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02F582176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 11:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZToRSrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02F582176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaIRI-0007LS-L6
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 06:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaIMi-000568-JM
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iaIMc-0002dF-Dk
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:53:40 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24774
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iaIMc-0002OJ-4j
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574942015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CKNyJyxqMCJZ6tXQZfEdGoDAnFa/vTjzlVjmZ87v7WE=;
 b=SZToRSrnhYlKOHitc8bcDd1uA2km1Btbd/I6mNuW8A98MtFrjw1VELX4kNzBU8qkomtIsJ
 gW47EOpk+zToUwprBA8uaNZCPl6bDqU3cEl2v4Mi0ViWSgX0VvyKUeQ8mZRKb4zBnASyBF
 lnErWTVFvKsKPn9TtVTPo8uZQb15Z7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-0rvC_2U4M7iBYRM2sYzi4w-1; Thu, 28 Nov 2019 06:53:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 502E380183D;
 Thu, 28 Nov 2019 11:53:29 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-114.ams2.redhat.com [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C550819C6A;
 Thu, 28 Nov 2019 11:53:23 +0000 (UTC)
Subject: Re: [PATCH v19 7/8] tests/numa: Add case for QMP build HMAT
To: Markus Armbruster <armbru@redhat.com>, Tao Xu <tao3.xu@intel.com>
References: <20191128082109.30081-1-tao3.xu@intel.com>
 <20191128082109.30081-8-tao3.xu@intel.com>
 <87pnhcnru9.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <09bb1d3f-222a-e84e-ab6a-55496bba1d9a@redhat.com>
Date: Thu, 28 Nov 2019 12:53:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87pnhcnru9.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 0rvC_2U4M7iBYRM2sYzi4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: lvivier@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 jonathan.cameron@huawei.com, sw@weilnetz.de, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org, jingqi.liu@intel.com,
 imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/11/2019 12.49, Markus Armbruster wrote:
> Tao Xu <tao3.xu@intel.com> writes:
> 
>> Check configuring HMAT usecase
>>
>> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
>> Suggested-by: Igor Mammedov <imammedo@redhat.com>
>> Signed-off-by: Tao Xu <tao3.xu@intel.com>
>> ---
>>
>> Changes in v19:
>>      - Add some fail cases for hmat-cache when level=0
>>
>> Changes in v18:
>>      - Rewrite the lines over 80 characters
>>
>> Chenges in v17:
>>      - Add some fail test cases (Igor)
>> ---
>>   tests/numa-test.c | 213 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 213 insertions(+)
>>
>> diff --git a/tests/numa-test.c b/tests/numa-test.c
>> index 8de8581231..aed7b2f31b 100644
>> --- a/tests/numa-test.c
>> +++ b/tests/numa-test.c
>> @@ -327,6 +327,216 @@ static void pc_dynamic_cpu_cfg(const void *data)
>>       qtest_quit(qs);
>>   }
>>   
>> +static void pc_hmat_build_cfg(const void *data)
>> +{
>> +    QTestState *qs = qtest_initf("%s -nodefaults --preconfig -machine hmat=on "
>> +                     "-smp 2,sockets=2 "
>> +                     "-m 128M,slots=2,maxmem=1G "
>> +                     "-object memory-backend-ram,size=64M,id=m0 "
>> +                     "-object memory-backend-ram,size=64M,id=m1 "
>> +                     "-numa node,nodeid=0,memdev=m0 "
>> +                     "-numa node,nodeid=1,memdev=m1,initiator=0 "
>> +                     "-numa cpu,node-id=0,socket-id=0 "
>> +                     "-numa cpu,node-id=0,socket-id=1",
>> +                     data ? (char *)data : "");
>> +
>> +    /* Fail: Initiator should be less than the number of nodes */
>> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
>> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 2, 'target': 0,"
>> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")));
> 
> Code smell: side effect within assert().
> 
> Harmless here, because compiling tests with NDEBUG is pointless.  Still,
> it sets a bad example.  Not your idea, the pattern seems to go back to
> commit c35665e1ee3 and fb1e58f72ba.

... maybe best to use g_assert_true() which can't be disabled and thus 
should be used in tests. See:

  https://developer.gnome.org/glib/unstable/glib-Testing.html#g-assert-true

  Thomas


