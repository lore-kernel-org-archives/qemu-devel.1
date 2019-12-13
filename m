Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27F0C2D0CA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 09:47:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81C2D24671
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 09:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4hHVbRF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C2D24671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifhXc-0002US-Nh
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 04:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ifhWm-0001yq-Cg
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ifhWk-0000uS-0U
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:46:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44408
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ifhWj-0000rf-PU
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 04:46:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576230381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEWr+rKRPOsRNNm1kXxA0xhfzPm3K6YZlBOi2Nf0/3M=;
 b=O4hHVbRFWzj8S9lE1Zntya8Psvkh3UW9cZzdExKR7a8wyz9DE3rCMmI2zXq4/GZ5FjhdqQ
 8QZrXAfi/+Aht1WKyhCWbbb1cX0hHLMfLD7J+Q4mlCYmRVgV9XyAb6gAaL5zUvcIRioNVu
 thK35fN1viTQmD1+CmHl4gL7nIO8FfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-TRHHiLO0POK_Hk8IgepPuQ-1; Fri, 13 Dec 2019 04:46:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44481DB62;
 Fri, 13 Dec 2019 09:46:17 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1E93646E77;
 Fri, 13 Dec 2019 09:46:11 +0000 (UTC)
Date: Fri, 13 Dec 2019 10:46:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH RESEND v20 7/8] tests/numa: Add case for QMP build HMAT
Message-ID: <20191213104610.0170c188@redhat.com>
In-Reply-To: <20191213011929.2520-8-tao3.xu@intel.com>
References: <20191213011929.2520-1-tao3.xu@intel.com>
 <20191213011929.2520-8-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: TRHHiLO0POK_Hk8IgepPuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: lvivier@redhat.com, thuth@redhat.com, fan.du@intel.com, ehabkost@redhat.com,
 mst@redhat.com, qemu-devel@nongnu.org, sw@weilnetz.de,
 jonathan.cameron@huawei.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com,
 jingqi.liu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Dec 2019 09:19:28 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> Check configuring HMAT usecase
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> 
> Changes in v20:
>     - Fix the wrong target in pc_hmat_erange_cfg
>     - Use g_assert_true and g_assert_false to replace g_assert
>       (Thomas and Markus)
> 
> Changes in v19:
>     - Add some fail cases for hmat-cache when level=0
> 
> Changes in v18:
>     - Rewrite the lines over 80 characters
> 
> Chenges in v17:
>     - Add some fail test cases (Igor)
> ---
>  tests/numa-test.c | 213 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 213 insertions(+)
> 
> diff --git a/tests/numa-test.c b/tests/numa-test.c
> index 8de8581231..17dd807d2a 100644
> --- a/tests/numa-test.c
> +++ b/tests/numa-test.c
> @@ -327,6 +327,216 @@ static void pc_dynamic_cpu_cfg(const void *data)
>      qtest_quit(qs);
>  }
>  
> +static void pc_hmat_build_cfg(const void *data)
> +{
> +    QTestState *qs = qtest_initf("%s -nodefaults --preconfig -machine hmat=on "
> +                     "-smp 2,sockets=2 "
> +                     "-m 128M,slots=2,maxmem=1G "
> +                     "-object memory-backend-ram,size=64M,id=m0 "
> +                     "-object memory-backend-ram,size=64M,id=m1 "
> +                     "-numa node,nodeid=0,memdev=m0 "
> +                     "-numa node,nodeid=1,memdev=m1,initiator=0 "
> +                     "-numa cpu,node-id=0,socket-id=0 "
> +                     "-numa cpu,node-id=0,socket-id=1",
> +                     data ? (char *)data : "");
> +
> +    /* Fail: Initiator should be less than the number of nodes */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 2, 'target': 0,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")));
> +
> +    /* Fail: Target should be less than the number of nodes */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 2,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")));
> +
> +    /* Fail: Initiator should contain cpu */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 1, 'target': 0,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")));
> +
> +    /* Fail: Data-type mismatch */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
> +        " 'hierarchy': \"memory\", 'data-type': \"write-latency\","
> +        " 'bandwidth': 524288000 } }")));
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
> +        " 'hierarchy': \"memory\", 'data-type': \"read-bandwidth\","
> +        " 'latency': 5 } }")));
> +
> +    /* Fail: Bandwidth should be 1MB (1048576) aligned */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
> +        " 'bandwidth': 1048575 } }")));
> +
> +    /* Configuring HMAT bandwidth and latency details */
> +    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 1 } }")));    /* 1 ns */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 5 } }")));    /* Fail: Duplicate configuration */
> +    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
> +        " 'bandwidth': 68717379584 } }")));    /* 65534 MB/s */
> +    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 65534 } }")));    /* 65534 ns */
> +    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
> +        " 'bandwidth': 34358689792 } }")));    /* 32767 MB/s */
> +
> +    /* Fail: node_id should be less than the number of nodes */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 2, 'size': 10240,"
> +        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +
> +    /* Fail: level should be less than HMAT_LB_LEVELS (4) */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
> +        " 'level': 4, 'associativity': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +
> +    /* Fail: associativity option should be 'none', if level is 0 */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
> +        " 'level': 0, 'associativity': \"direct\", 'policy': \"none\","
> +        " 'line': 0 } }")));
> +    /* Fail: policy option should be 'none', if level is 0 */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
> +        " 'level': 0, 'associativity': \"none\", 'policy': \"write-back\","
> +        " 'line': 0 } }")));
> +    /* Fail: line option should be 0, if level is 0 */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
> +        " 'level': 0, 'associativity': \"none\", 'policy': \"none\","
> +        " 'line': 8 } }")));
> +
> +    /* Configuring HMAT memory side cache attributes */
> +    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
> +        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
> +        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));    /* Fail: Duplicate configuration */
> +    /* Fail: The size of level 2 size should be small than level 1 */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
> +        " 'level': 2, 'associativity': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +    /* Fail: The size of level 0 size should be larger than level 1 */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
> +        " 'level': 0, 'associativity': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 1, 'size': 10240,"
> +        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +
> +    /* let machine initialization to complete and run */
> +    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs,
> +        "{ 'execute': 'x-exit-preconfig' }")));
> +    qtest_qmp_eventwait(qs, "RESUME");
> +
> +    qtest_quit(qs);
> +}
> +
> +static void pc_hmat_off_cfg(const void *data)
> +{
> +    QTestState *qs = qtest_initf("%s -nodefaults --preconfig "
> +                     "-smp 2,sockets=2 "
> +                     "-m 128M,slots=2,maxmem=1G "
> +                     "-object memory-backend-ram,size=64M,id=m0 "
> +                     "-object memory-backend-ram,size=64M,id=m1 "
> +                     "-numa node,nodeid=0,memdev=m0",
> +                     data ? (char *)data : "");
> +
> +    /*
> +     * Fail: Enable HMAT with -machine hmat=on
> +     * before using any of hmat specific options
> +     */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'node', 'nodeid': 1, 'memdev': \"m1\","
> +        " 'initiator': 0 } }")));
> +    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'node', 'nodeid': 1, 'memdev': \"m1\" } }")));
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 1 } }")));
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
> +        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +
> +    /* let machine initialization to complete and run */
> +    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs,
> +        "{ 'execute': 'x-exit-preconfig' }")));
> +    qtest_qmp_eventwait(qs, "RESUME");
> +
> +    qtest_quit(qs);
> +}
> +
> +static void pc_hmat_erange_cfg(const void *data)
> +{
> +    QTestState *qs = qtest_initf("%s -nodefaults --preconfig -machine hmat=on "
> +                     "-smp 2,sockets=2 "
> +                     "-m 128M,slots=2,maxmem=1G "
> +                     "-object memory-backend-ram,size=64M,id=m0 "
> +                     "-object memory-backend-ram,size=64M,id=m1 "
> +                     "-numa node,nodeid=0,memdev=m0 "
> +                     "-numa node,nodeid=1,memdev=m1,initiator=0 "
> +                     "-numa cpu,node-id=0,socket-id=0 "
> +                     "-numa cpu,node-id=0,socket-id=1",
> +                     data ? (char *)data : "");
> +
> +    /* Can't store the compressed latency */
> +    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 1 } }")));    /* 1 ns */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 65535 } }")));    /* 65535 ns */
> +
> +    /* Test the 0 input (bandwidth not provided) */
> +    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
> +        " 'bandwidth': 0 } }")));    /* 0 MB/s */
> +    /* Fail: bandwidth should be provided before memory side cache attributes */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 10240,"
> +        " 'level': 1, 'associativity': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +
> +    /* Can't store the compressed bandwidth */
> +    g_assert_true(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
> +        " 'bandwidth': 68718428160 } }")));    /* 65535 MB/s */
> +
> +    /* let machine initialization to complete and run */
> +    g_assert_false(qmp_rsp_is_err(qtest_qmp(qs,
> +        "{ 'execute': 'x-exit-preconfig' }")));
> +    qtest_qmp_eventwait(qs, "RESUME");
> +
> +    qtest_quit(qs);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      const char *args = NULL;
> @@ -346,6 +556,9 @@ int main(int argc, char **argv)
>      if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
>          qtest_add_data_func("/numa/pc/cpu/explicit", args, pc_numa_cpu);
>          qtest_add_data_func("/numa/pc/dynamic/cpu", args, pc_dynamic_cpu_cfg);
> +        qtest_add_data_func("/numa/pc/hmat/build", args, pc_hmat_build_cfg);
> +        qtest_add_data_func("/numa/pc/hmat/off", args, pc_hmat_off_cfg);
> +        qtest_add_data_func("/numa/pc/hmat/erange", args, pc_hmat_erange_cfg);
>      }
>  
>      if (!strcmp(arch, "ppc64")) {


