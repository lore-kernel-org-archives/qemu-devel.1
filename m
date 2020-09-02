Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5153C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:57:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9025D20709
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="knFVLLej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9025D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDSK2-0002q7-N3
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 08:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1kDSJ5-0002O7-IH
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:56:07 -0400
Received: from nylar.uni-paderborn.de ([2001:638:502:c003::18]:41054)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1kDSIv-0006fL-To
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+tTGEQKH/wwDLCjpOL1rBLx+DvCK3iz+Dv/pvD+t+X4=; b=knFVLLej43u3LoCt4Q+cKNFAzL
 JnPWWgjqmA2akFnUdKvdctme+kyg+fU9+2vC1c4aK1eXD98vfNYGqiOh8zJT8Q1v5wSPqWyJ25rab
 mz3ppLbGYlrkhvFQyBV701c1fvfGcB89ipyjtkqc2EIQnMyTaiVUuMZWllyTpwNC+5GA=;
Date: Wed, 2 Sep 2020 14:55:46 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 0/1] tricore queue
Message-ID: <20200902125546.vyw5ugjygvzw45k3@schnipp-desktop>
References: <20200901095924.21738-1-kbastian@mail.uni-paderborn.de>
 <CAFEAcA-ikpjOz4rfbhqG=RisDAiLD9GcuQfdzAvg-+Pc09jXoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-ikpjOz4rfbhqG=RisDAiLD9GcuQfdzAvg-+Pc09jXoQ@mail.gmail.com>
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.9.2.125117, AntiVirus-Engine: 5.77.0,
 AntiVirus-Data: 2020.9.2.5770000
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=14688731, da=86660412,
 mc=300, sc=3, hc=297, sp=1, fso=14688731, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::18;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=nylar.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, andreas.konopik@efs-auto.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 03:18:40PM +0100, Peter Maydell wrote:
> On Tue, 1 Sep 2020 at 10:59, Bastian Koppelmann
> <kbastian@mail.uni-paderborn.de> wrote:
> >
> > The following changes since commit 2f4c51c0f384d7888a04b4815861e6d5fd244d75:
> >
> >   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200831-pull-request' into staging (2020-08-31 19:39:13 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/bkoppelmann/qemu.git tags/pull-tricore-20200901
> >
> > for you to fetch changes up to 2c15af48abb71b3cddadd63c5bb416b250f53fef:
> >
> >   tricore: added triboard with tc27x_soc (2020-09-01 11:54:11 +0200)
> >
> > ----------------------------------------------------------------
> > Add the Infineon Aurix D-Step board
> >
> > ----------------------------------------------------------------
> > Andreas Konopik (1):
> >       tricore: added triboard with tc27x_soc
> 
> This fails "make check" (all platforms):
> 
> OSX fails like this:
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_IMG=./qemu-img
> G_TEST_DBUS_DAEMON=/Users/pm215/src/qemu-for-merges/tests/dbus-vmstate-daemon.sh
> QTEST_QEMU_BINARY=./qemu-system-tricore
> tests/qtest/device-introspect-test --tap -k
> PASS 1 qtest-tricore: device-introspect-test /tricore/device/introspect/list
> PASS 2 qtest-tricore: device-introspect-test
> /tricore/device/introspect/list-fields
> PASS 3 qtest-tricore: device-introspect-test /tricore/device/introspect/none
> PASS 4 qtest-tricore: device-introspect-test /tricore/device/introspect/abstract
> PASS 5 qtest-tricore: device-introspect-test
> /tricore/device/introspect/abstract-interfaces
> RAMBlock "CPU0.DSPR" already registered, abort!
> Broken pipe
> ../../tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from
> signal 6 (Abort trap: 6)
> ERROR qtest-tricore: device-introspect-test - too few tests run
> (expected 6, got 5)
> make: *** [Makefile.mtest:1429: check-qtest] Error 1

This patch seems to fix this problem. 

diff --git a/hw/tricore/tc27x_soc.c b/hw/tricore/tc27x_soc.c
index 4f28e39c8c..2c7aa8e901 100644
--- a/hw/tricore/tc27x_soc.c
+++ b/hw/tricore/tc27x_soc.c
@@ -100,9 +100,9 @@ static void make_alias(MemoryRegion *mr, const char *name,
     memory_region_add_subregion(get_system_memory(), base, mr);
 }
 
-static void tc27x_soc_init_memory_mapping(Object *obj)
+static void tc27x_soc_init_memory_mapping(DeviceState *dev_soc)
 {
-    TC27XSoCState *s = TC27X_SOC(obj);
+    TC27XSoCState *s = TC27X_SOC(dev_soc);
     TC27XSoCClass *sc = TC27X_SOC_GET_CLASS(s);
 
     make_ram(&s->cpu0mem.dspr, "CPU0.DSPR",
@@ -192,6 +192,7 @@ static void tc27x_soc_realize(DeviceState *dev_soc, Error **errp)
         error_propagate(errp, err);
         return;
     }
+    tc27x_soc_init_memory_mapping(dev_soc);
 }
 
 static void tc27x_soc_init(Object *obj)
@@ -201,7 +202,6 @@ static void tc27x_soc_init(Object *obj)
 
     object_initialize_child(obj, "tc27x", &s->cpu, sc->cpu_type);
 
-    tc27x_soc_init_memory_mapping(obj);
 }

However, it just leads to the next one:

Running test qtest-tricore: device-introspect-test
Running test qtest-tricore: machine-none-test
Running test qtest-tricore: qmp-test
Running test qtest-tricore: qmp-cmd-test
Running test qtest-tricore: qom-test
Bad address
qemu-system-tricore: no kernel file '(null)'
Broken pipe
../tests/qtest/libqtest.c:166: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
ERROR qtest-tricore: qom-test - too few tests run (expected 3, got 1)

Andreas, can you look into this?

Thanks,
Bastian

