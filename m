Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFF5C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:08:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D886A205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DK8xvQ6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D886A205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHGA-0002J4-Dc
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHBl-00051A-Jf
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHBj-0001uU-50
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:03:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33484
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHBi-0001qi-U6
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrjE1tHkUdeVBDEqGDQEZVm2xdo3dGvaav4RUFhEjDc=;
 b=DK8xvQ6RLh0VSMCkaPNmli8PCTEsuObtvkyB3X/XZ9ATco/7sPmSmdgRh4mCKoEtv7A8lV
 kwzQwuBB7E3RzLyIBLMzbHSydlkoOByEmJczDKTI3XbdzcdDogcNJDaQLYAZLWtjUyVqek
 C+H2KS2EtcMfZ6ZPsbYtW5GBf/PoShE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-87u07QnUOcCwwWLegVd6Ug-1; Tue, 31 Dec 2019 08:03:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F9EA800D50
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:51 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A76D2620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:03:50 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/86] numa: remove not needed check
Date: Tue, 31 Dec 2019 14:02:45 +0100
Message-Id: <1577797450-88458-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 87u07QnUOcCwwWLegVd6Ug-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently parse_numa_node() is always called from already numa
enabled context.
Drop unnecessary check if numa is supported.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
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


