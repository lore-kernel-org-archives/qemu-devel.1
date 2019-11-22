Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84C6C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:46:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F75320706
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="csqfj5Nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F75320706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY8KK-0001eo-PP
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 07:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48412)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iY8JU-0001B6-MA
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:45:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iY8JS-0007Mt-Np
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:45:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28051
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iY8JM-0007Kl-DR
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574426719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L0SoTK/uMK4NIWeclaQzghBhpeksEKWo4iMJV8M8xXo=;
 b=csqfj5NfXrT41/BPyr/98aFBv6QQix+Wy0z3A4yB95yof691vMq76m2myXR8HuvO35wRNd
 5wJD3XKhQKcV4KOco/W7hLxBJWeibKlzgO2z+91Q8PZny6GRbztjQd10yx0f6oZlnZV+zf
 pLBhXL6AkbNDct6NAPxElLsrYDVCPmM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-gjqQgYx5Oe6xlBkvLehSEg-1; Fri, 22 Nov 2019 07:45:16 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8AB65107ACC5;
 Fri, 22 Nov 2019 12:45:14 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F4C563620;
 Fri, 22 Nov 2019 12:45:08 +0000 (UTC)
Date: Fri, 22 Nov 2019 13:45:07 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v17 13/14] tests/numa: Add case for QMP build HMAT
Message-ID: <20191122134507.21f8ac93@redhat.com>
In-Reply-To: <20191122074826.1373-14-tao3.xu@intel.com>
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <20191122074826.1373-14-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: gjqQgYx5Oe6xlBkvLehSEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

On Fri, 22 Nov 2019 15:48:25 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> Check configuring HMAT usecase
>=20
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>=20
> Chenges in v17:
>     - Add some fail test cases (Igor)
> ---
>  tests/numa-test.c | 194 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 194 insertions(+)
>=20
> diff --git a/tests/numa-test.c b/tests/numa-test.c
> index 8de8581231..9c69da973c 100644
> --- a/tests/numa-test.c
> +++ b/tests/numa-test.c
> @@ -327,6 +327,197 @@ static void pc_dynamic_cpu_cfg(const void *data)
>      qtest_quit(qs);
>  }
> =20
> +static void pc_hmat_build_cfg(const void *data)
> +{
> +    QTestState *qs =3D qtest_initf("%s -nodefaults --preconfig -machine =
hmat=3Don "
> +                     "-smp 2,sockets=3D2 "
> +                     "-m 128M,slots=3D2,maxmem=3D1G "
> +                     "-object memory-backend-ram,size=3D64M,id=3Dm0 "
> +                     "-object memory-backend-ram,size=3D64M,id=3Dm1 "
> +                     "-numa node,nodeid=3D0,memdev=3Dm0 "
> +                     "-numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0 "
> +                     "-numa cpu,node-id=3D0,socket-id=3D0 "
> +                     "-numa cpu,node-id=3D0,socket-id=3D1",
> +                     data ? (char *)data : "");
> +
> +    /* Fail: Initiator should be less than the number of nodes */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 2, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")=
));
> +
> +    /* Fail: Target should be less than the number of nodes */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 2,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")=
));
> +
> +    /* Fail: Initiator should contain cpu */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 1, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\" } }")=
));
> +
> +    /* Fail: Data-type mismatch */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"write-latency\","
> +        " 'bandwidth': 524288000 } }")));
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"read-bandwidth\","
> +        " 'latency': 5 } }")));
> +
> +    /* Fail: Bandwidth should be 1MB (1048576) aligned */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
> +        " 'bandwidth': 1048575 } }")));
> +
> +    /* Configuring HMAT bandwidth and latency details */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 1 } }")));    /* 1 ns */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 5 } }")));    /* Fail: Duplicate configuration */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
> +        " 'bandwidth': 68717379584 } }")));    /* 65534 MB/s */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 65534 } }")));    /* 65534 ns */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
> +        " 'bandwidth': 34358689792 } }")));    /* 32767 MB/s */
> +
> +    /* Fail: node_id should be less than the number of nodes */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 2, 'size': 102=
40,"
> +        " 'level': 1, 'assoc': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +
> +    /* Fail: level should be less than HMAT_LB_LEVELS (4) */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 102=
40,"
> +        " 'level': 4, 'assoc': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +
> +    /* Configuring HMAT memory side cache attributes */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 102=
40,"
> +        " 'level': 1, 'assoc': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 102=
40,"
> +        " 'level': 1, 'assoc': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));    /* Fail: Duplicate configuration */
> +    /* Fail: The size of level 2 size should be small than level 1 */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 102=
40,"
> +        " 'level': 2, 'assoc': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +    /* Fail: The size of level 0 size should be larger than level 1 */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 102=
40,"
> +        " 'level': 0, 'assoc': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 1, 'size': 102=
40,"
> +        " 'level': 1, 'assoc': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +
> +    /* let machine initialization to complete and run */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'x-exit-preconf=
ig' }")));
> +    qtest_qmp_eventwait(qs, "RESUME");
> +
> +    qtest_quit(qs);
> +}
> +
> +static void pc_hmat_off_cfg(const void *data)
> +{
> +    QTestState *qs =3D qtest_initf("%s -nodefaults --preconfig "
> +                     "-smp 2,sockets=3D2 "
> +                     "-m 128M,slots=3D2,maxmem=3D1G "
> +                     "-object memory-backend-ram,size=3D64M,id=3Dm0 "
> +                     "-object memory-backend-ram,size=3D64M,id=3Dm1 "
> +                     "-numa node,nodeid=3D0,memdev=3Dm0",
> +                     data ? (char *)data : "");
> +
> +    /*
> +     * Fail: Enable HMAT with -machine hmat=3Don
> +     * before using any of hmat specific options
> +     */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'node', 'nodeid': 1, 'memdev': \"m1\","
> +        " 'initiator': 0 } }")));
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'node', 'nodeid': 1, 'memdev': \"m1\" }=
 }")));
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 1 } }")));
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 102=
40,"
> +        " 'level': 1, 'assoc': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +
> +    /* let machine initialization to complete and run */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'x-exit-preconf=
ig' }")));
> +    qtest_qmp_eventwait(qs, "RESUME");
> +
> +    qtest_quit(qs);
> +}
> +
> +static void pc_hmat_erange_cfg(const void *data)
> +{
> +    QTestState *qs =3D qtest_initf("%s -nodefaults --preconfig -machine =
hmat=3Don "
> +                     "-smp 2,sockets=3D2 "
> +                     "-m 128M,slots=3D2,maxmem=3D1G "
> +                     "-object memory-backend-ram,size=3D64M,id=3Dm0 "
> +                     "-object memory-backend-ram,size=3D64M,id=3Dm1 "
> +                     "-numa node,nodeid=3D0,memdev=3Dm0 "
> +                     "-numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0 "
> +                     "-numa cpu,node-id=3D0,socket-id=3D0 "
> +                     "-numa cpu,node-id=3D0,socket-id=3D1",
> +                     data ? (char *)data : "");
> +
> +    /* Can't store the compressed latency */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 1 } }")));    /* 1 ns */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 65535 } }")));    /* 65535 ns */
> +
> +    /* Test the 0 input (bandwidth not provided) */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
> +        " 'bandwidth': 0 } }")));    /* 0 MB/s */
> +    /* Fail: bandwidth should be provided before memory side cache attri=
butes */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 102=
40,"
> +        " 'level': 1, 'assoc': \"direct\", 'policy': \"write-back\","
> +        " 'line': 8 } }")));
> +
> +    /* Can't store the compressed bandwidth */
> +    g_assert(qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node',=
"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
> +        " 'bandwidth': 68718428160 } }")));    /* 65535 MB/s */
> +
> +    /* let machine initialization to complete and run */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'x-exit-preconf=
ig' }")));
> +    qtest_qmp_eventwait(qs, "RESUME");
> +
> +    qtest_quit(qs);
> +}
> +
>  int main(int argc, char **argv)
>  {
>      const char *args =3D NULL;
> @@ -346,6 +537,9 @@ int main(int argc, char **argv)
>      if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
>          qtest_add_data_func("/numa/pc/cpu/explicit", args, pc_numa_cpu);
>          qtest_add_data_func("/numa/pc/dynamic/cpu", args, pc_dynamic_cpu=
_cfg);
> +        qtest_add_data_func("/numa/pc/hmat/build", args, pc_hmat_build_c=
fg);
> +        qtest_add_data_func("/numa/pc/hmat/off", args, pc_hmat_off_cfg);
> +        qtest_add_data_func("/numa/pc/hmat/erange", args, pc_hmat_erange=
_cfg);
>      }
> =20
>      if (!strcmp(arch, "ppc64")) {


