Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4451C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:50:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FB4420663
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 12:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Khky0emp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FB4420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifNv2-0007ZY-C3
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 07:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ifNtj-0006AM-RS
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:48:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ifNth-0005jX-D6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:48:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ifNth-0005iL-9p
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 07:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576154928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=quY/CuROmNruxW1DGcY5ylIdglxJ30C+FEQEjGEZBzw=;
 b=Khky0empvgjLiHPuFL0ImlMJlAropC8ZAlca1h3P41sEp+X+49WAhqbix3sLnZZFaLg2OC
 Ywiw0aa/UVgcxSfNBDozTusHMpyrRI3vXLthMgy9I10bASVSTTBute5srvNtkW5HpAPw06
 KITpNYZwDT1bO789D/TpsVGU5y4mndc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-lwoQqSMtP7C664reThka4w-1; Thu, 12 Dec 2019 07:48:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05AE0DB68;
 Thu, 12 Dec 2019 12:48:46 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09D7510013A1;
 Thu, 12 Dec 2019 12:48:44 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] numa: remove not needed check
Date: Thu, 12 Dec 2019 13:48:55 +0100
Message-Id: <1576154936-178362-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1576154936-178362-1-git-send-email-imammedo@redhat.com>
References: <1576154936-178362-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: lwoQqSMtP7C664reThka4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Tao Xu <tao3.xu@intel.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently parse_numa_node() is always called from already numa
enabled context.
Drop unnecessary check if numa is supported.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/core/numa.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index e3332a9..19f082d 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -83,10 +83,6 @@ static void parse_numa_node(MachineState *ms, NumaNodeOp=
tions *node,
         return;
     }
=20
-    if (!mc->cpu_index_to_instance_props || !mc->get_default_cpu_node_id) =
{
-        error_setg(errp, "NUMA is not supported by this machine-type");
-        return;
-    }
     for (cpus =3D node->cpus; cpus; cpus =3D cpus->next) {
         CpuInstanceProperties props;
         if (cpus->value >=3D max_cpus) {
@@ -178,9 +174,8 @@ void parse_numa_distance(MachineState *ms, NumaDistOpti=
ons *dist, Error **errp)
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
 {
     Error *err =3D NULL;
-    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
=20
-    if (!mc->numa_mem_supported) {
+    if (!ms->numa_state) {
         error_setg(errp, "NUMA is not supported by this machine-type");
         goto end;
     }
--=20
2.7.4


