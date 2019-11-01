Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D562BCA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 14:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11F92085B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 14:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxflT3v5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11F92085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQXtC-0008Va-Mt
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 10:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iQXs6-0007wD-76
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iQXs3-0003c1-Vv
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:25:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36856
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1iQXs3-0003WZ-N9
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572618346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kokDRfvsKvorsaZBFNrrAutzJH4obhs+X6h80onMaoc=;
 b=BxflT3v5RpjQ/jdDkEPIRqASSayoVU6+dnGic8wPQY2utqBfzNQN3WFofhP7VFc4uprWd2
 Ksn+STR+MNJ1wc8CdmxMDzHoNKmoI5rV34qQ4aDgA2FazzNMuSMnBiRPDR+jG5uXnWhrPV
 ekkxPwbntqlIehIzCDoAi2oCqt5aSx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-qhWL0HZ1PX6kUAEWC9FtPw-1; Fri, 01 Nov 2019 10:25:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 011EE1005500;
 Fri,  1 Nov 2019 14:25:44 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-63.ams2.redhat.com
 [10.36.116.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 09B34600D1;
 Fri,  1 Nov 2019 14:25:42 +0000 (UTC)
Date: Fri, 1 Nov 2019 15:25:40 +0100
From: Andrew Jones <drjones@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/11] target-arm queue
Message-ID: <20191101142540.dzu72u4fll6wcovk@kamzik.brq.redhat.com>
References: <20191101085140.5205-1-peter.maydell@linaro.org>
 <CAFEAcA-N-Fh7+NCHGPXuK-H6DUTOwjfCU6rmZGz4k8n+tkKdxw@mail.gmail.com>
 <20191101095438.a6wd2mal4w75irvg@kamzik.brq.redhat.com>
 <CAFEAcA9_PMjhEgMn3qnr1xsiGU5YkNr1KeCvez6pFm=93EzTpA@mail.gmail.com>
 <CAFEAcA9iTS8SXTFyGPwk+Wn_Aw-2rd9Wb_N3cH8iAxSOzzYyVg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9iTS8SXTFyGPwk+Wn_Aw-2rd9Wb_N3cH8iAxSOzzYyVg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: qhWL0HZ1PX6kUAEWC9FtPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Nov 01, 2019 at 12:53:42PM +0000, Peter Maydell wrote:
> On Fri, 1 Nov 2019 at 10:34, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > On Fri, 1 Nov 2019 at 09:54, Andrew Jones <drjones@redhat.com> wrote:
> > > Darn it. Sorry about that, but if it's still failing then I think QEM=
U
> > > must believe KVM is enabled, i.e. kvm_enabled() in QEMU must be true.
> > > I can try to confirm that and fix it, but I'll need to set up this
> > > environment first.
> >
> > Yeah, it looks like trying to run with KVM in an aarch32 chroot
> > doesn't work but we don't notice it -- in qemu kvm_init() succeeds
> > but then we fail when we try to actually create CPUs, so:
> > $ ./arm-softmmu/qemu-system-arm -M virt -M accel=3Dkvm:tcg
> > qemu-system-arm: kvm_init_vcpu failed: Invalid argument
> >
> > we barf rather than falling back to tcg the way we ought to.
>=20
> I spoke to Christoffer and Marc about this, and they reckoned
> this was basically a kernel bug (and ideally a 64-bit kernel
> should just refuse to open /dev/kvm for an aarch32-compat
> userspace process, because it doesn't provide the aarch32 KVM
> interface, only the aarch64 one).
>=20
> In the meantime, we should just bodge whatever we need to
> in this test to cause us not to bother to try to run the test,
> in whatever is the most expedient way.

How about just doing this (which can be cleanly applied to 2/9
without conflicts on rebase)

Thanks,
drew

From 9c5358d03528ea8a46731dcc4cfafb160ff66b5c Mon Sep 17 00:00:00 2001
From: Andrew Jones <drjones@redhat.com>
Date: Fri, 1 Nov 2019 15:18:46 +0100
Subject: [PATCH v8 10/9] fixup! tests: arm: Introduce cpu feature tests

---
 tests/arm-cpu-features.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index b132ed09806d..ec33d58e1367 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -535,8 +535,16 @@ int main(int argc, char **argv)
=20
     qtest_add_data_func("/arm/query-cpu-model-expansion",
                         NULL, test_query_cpu_model_expansion);
-    qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
-                        NULL, test_query_cpu_model_expansion_kvm);
+
+    /*
+     * For now we only run KVM specific tests with AArch64 QEMU in
+     * order avoid attempting to run an AArch32 QEMU with KVM on
+     * AArch64 hosts. That won't work and isn't easy to detect.
+     */
+    if (g_str_equal(qtest_get_arch(), "aarch64")) {
+        qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
+                            NULL, test_query_cpu_model_expansion_kvm);
+    }
=20
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         qtest_add_data_func("/arm/max/query-cpu-model-expansion/sve-max-vq=
-8",
--=20
2.21.0


