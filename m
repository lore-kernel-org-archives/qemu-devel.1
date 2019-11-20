Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55121C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182EC22519
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LaXRquMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182EC22519
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPBE-000370-8o
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iXP9o-00023d-4X
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:32:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iXP9m-00049t-RM
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:32:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50205
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iXP9m-00049N-NO
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:32:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574253146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GwrNUcHs605g1TcqJBfyoWv/FM1VIFJfuGtZRY9Mz8g=;
 b=LaXRquMtXi5j46bCi4/7SP0QpY/DOQ4kNvWZpLGyNA+oc9x1/LHvPSR0k1V0dS4OoAJUc9
 mHlalHt/XTGZ2bOpNqFOyTUtj35VwCfPFt8ez+PQ5rAxjBmEnGMzQnZA+u/jsh3GsVwgoQ
 JeWvPD3n4EOlQAacM2zfPhYZrcV7Md0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-XO_6xI0lMvmDz2djIjSpQg-1; Wed, 20 Nov 2019 07:32:22 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1201D477;
 Wed, 20 Nov 2019 12:32:21 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 34317196BD;
 Wed, 20 Nov 2019 12:32:16 +0000 (UTC)
Date: Wed, 20 Nov 2019 13:32:14 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Tao Xu <tao3.xu@intel.com>
Subject: Re: [PATCH v16 13/14] tests/numa: Add case for QMP build HMAT
Message-ID: <20191120133214.6fb83c92@redhat.com>
In-Reply-To: <20191115075352.17734-14-tao3.xu@intel.com>
References: <20191115075352.17734-1-tao3.xu@intel.com>
 <20191115075352.17734-14-tao3.xu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: XO_6xI0lMvmDz2djIjSpQg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, jingqi.liu@intel.com, fan.du@intel.com,
 mdroth@linux.vnet.ibm.com, armbru@redhat.com, jonathan.cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 Nov 2019 15:53:51 +0800
Tao Xu <tao3.xu@intel.com> wrote:

> Check configuring HMAT usecase
>=20
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Tao Xu <tao3.xu@intel.com>
> ---
>=20
> New patch in v16.
> ---
>  tests/numa-test.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

I'd also add X-FAIL variants here, to test fail conditions.
Taking in account that QMP interface returns error without
affecting QEMU state, you can do it within one test case without
restarting it on every fail scenario.
(just add appropriate comments so reader would know that you are
testing this and that failure path)

So I'd first test x-fail variants and then finish test with
valid configuration.

>=20
> diff --git a/tests/numa-test.c b/tests/numa-test.c
> index 8de8581231..15889c26c0 100644
> --- a/tests/numa-test.c
> +++ b/tests/numa-test.c
> @@ -327,6 +327,56 @@ static void pc_dynamic_cpu_cfg(const void *data)
>      qtest_quit(qs);
>  }
> =20
> +static void pc_build_hmat_cfg(const void *data)
> +{
> +    QTestState *qs;
> +
> +    qs =3D qtest_initf("%s -nodefaults --preconfig -machine hmat=3Don "
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
> +    /* Configuring HMAT bandwidth and latency details */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 5 } }")));
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 0,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
> +        " 'bandwidth': 524288000 } }")));
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-latency\","
> +        " 'latency': 10 } }")));
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'hmat-lb', 'initiator': 0, 'target': 1,=
"
> +        " 'hierarchy': \"memory\", 'data-type': \"access-bandwidth\","
> +        " 'bandwidth': 104857600 } }")));
> +
> +    /* Configuring HMAT memory side cache attributes */
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'set-numa-node'=
,"
> +        " 'arguments': { 'type': 'hmat-cache', 'node-id': 0, 'size': 102=
40,"
> +        " 'level': 1, 'assoc': \"direct\", 'policy': \"write-back\","
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
>  int main(int argc, char **argv)
>  {
>      const char *args =3D NULL;
> @@ -346,6 +396,7 @@ int main(int argc, char **argv)
>      if (!strcmp(arch, "i386") || !strcmp(arch, "x86_64")) {
>          qtest_add_data_func("/numa/pc/cpu/explicit", args, pc_numa_cpu);
>          qtest_add_data_func("/numa/pc/dynamic/cpu", args, pc_dynamic_cpu=
_cfg);
> +        qtest_add_data_func("/numa/pc/build/hmat", args, pc_build_hmat_c=
fg);
>      }
> =20
>      if (!strcmp(arch, "ppc64")) {


