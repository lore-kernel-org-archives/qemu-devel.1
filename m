Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC02C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:21:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66AC1246BA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:21:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66AC1246BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXjVn-0004M1-97
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 07:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreas.konopik@efs-auto.de>)
 id 1kXjUV-0003Ud-Ck
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:19:43 -0400
Received: from mailin3.audi.de ([143.164.102.17]:33210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andreas.konopik@efs-auto.de>)
 id 1kXjUS-0000Px-MB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:19:43 -0400
From: "Konopik, Andreas (EFS-GH2)" <andreas.konopik@efs-auto.de>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: RE: [PULL 0/1] tricore queue
Thread-Topic: [PULL 0/1] tricore queue
Thread-Index: AQHWgSiCNy4Yf0aYl02BJ4jtP0jCA6mtE8qg
Date: Wed, 28 Oct 2020 11:19:34 +0000
Message-ID: <2ab6a67b3a734e628021bafd461620d5@efs-auto.de>
References: <20200901095924.21738-1-kbastian@mail.uni-paderborn.de>
 <CAFEAcA-ikpjOz4rfbhqG=RisDAiLD9GcuQfdzAvg-+Pc09jXoQ@mail.gmail.com>
 <20200902125546.vyw5ugjygvzw45k3@schnipp-desktop>
In-Reply-To: <20200902125546.vyw5ugjygvzw45k3@schnipp-desktop>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.241.109.103]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-AS-GCONF: 00
Received-SPF: none client-ip=143.164.102.17;
 envelope-from=andreas.konopik@efs-auto.de; helo=mailin3.audi.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 07:19:35
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, "Brenken,
 David \(EFS-GH5\)" <david.brenken@efs-auto.de>,
 QEMU Developers <qemu-devel@nongnu.org>, "Hofstetter, 
 Georg \(EFS-GH2\)" <georg.hofstetter@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Bastian,

sorry for the late reply.

On Wed, 2 Sep 2020 at 14:56, Bastian Koppelmann
<kbastian@mail.uni-paderborn.de> wrote:
> On Tue, Sep 01, 2020 at 03:18:40PM +0100, Peter Maydell wrote:
> > On Tue, 1 Sep 2020 at 10:59, Bastian Koppelmann
> > <kbastian@mail.uni-paderborn.de> wrote:
> > >
> > > The following changes since commit
> 2f4c51c0f384d7888a04b4815861e6d5fd244d75:
> > >
> > >   Merge remote-tracking branch
> > > 'remotes/kraxel/tags/usb-20200831-pull-request' into staging
> > > (2020-08-31 19:39:13 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://github.com/bkoppelmann/qemu.git tags/pull-tricore-20200901
> > >
> > > for you to fetch changes up to
> 2c15af48abb71b3cddadd63c5bb416b250f53fef:
> > >
> > >   tricore: added triboard with tc27x_soc (2020-09-01 11:54:11 +0200)
> > >
> > > ----------------------------------------------------------------
> > > Add the Infineon Aurix D-Step board
> > >
> > > ----------------------------------------------------------------
> > > Andreas Konopik (1):
> > >       tricore: added triboard with tc27x_soc
> >
> > This fails "make check" (all platforms):
> >
> > OSX fails like this:
> >
> > MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> > QTEST_QEMU_IMG=3D./qemu-img
> > G_TEST_DBUS_DAEMON=3D/Users/pm215/src/qemu-for-merges/tests/dbus-
> vmstate
> > -daemon.sh QTEST_QEMU_BINARY=3D./qemu-system-tricore
> > tests/qtest/device-introspect-test --tap -k PASS 1 qtest-tricore:
> > device-introspect-test /tricore/device/introspect/list PASS 2
> > qtest-tricore: device-introspect-test
> > /tricore/device/introspect/list-fields
> > PASS 3 qtest-tricore: device-introspect-test
> > /tricore/device/introspect/none PASS 4 qtest-tricore:
> > device-introspect-test /tricore/device/introspect/abstract
> > PASS 5 qtest-tricore: device-introspect-test
> > /tricore/device/introspect/abstract-interfaces
> > RAMBlock "CPU0.DSPR" already registered, abort!
> > Broken pipe
> > ../../tests/qtest/libqtest.c:175: kill_qemu() detected QEMU death from
> > signal 6 (Abort trap: 6) ERROR qtest-tricore: device-introspect-test -
> > too few tests run (expected 6, got 5)
> > make: *** [Makefile.mtest:1429: check-qtest] Error 1
>=20
> This patch seems to fix this problem.
>=20
> diff --git a/hw/tricore/tc27x_soc.c b/hw/tricore/tc27x_soc.c index
> 4f28e39c8c..2c7aa8e901 100644
> --- a/hw/tricore/tc27x_soc.c
> +++ b/hw/tricore/tc27x_soc.c
> @@ -100,9 +100,9 @@ static void make_alias(MemoryRegion *mr, const char
> *name,
>      memory_region_add_subregion(get_system_memory(), base, mr);  }
>=20
> -static void tc27x_soc_init_memory_mapping(Object *obj)
> +static void tc27x_soc_init_memory_mapping(DeviceState *dev_soc)
>  {
> -    TC27XSoCState *s =3D TC27X_SOC(obj);
> +    TC27XSoCState *s =3D TC27X_SOC(dev_soc);
>      TC27XSoCClass *sc =3D TC27X_SOC_GET_CLASS(s);
>=20
>      make_ram(&s->cpu0mem.dspr, "CPU0.DSPR", @@ -192,6 +192,7 @@ static
> void tc27x_soc_realize(DeviceState *dev_soc, Error **errp)
>          error_propagate(errp, err);
>          return;
>      }
> +    tc27x_soc_init_memory_mapping(dev_soc);
>  }
>=20
>  static void tc27x_soc_init(Object *obj) @@ -201,7 +202,6 @@ static void
> tc27x_soc_init(Object *obj)
>=20
>      object_initialize_child(obj, "tc27x", &s->cpu, sc->cpu_type);
>=20
> -    tc27x_soc_init_memory_mapping(obj);
>  }
>=20
> However, it just leads to the next one:
>=20
> Running test qtest-tricore: device-introspect-test Running test qtest-tri=
core:
> machine-none-test Running test qtest-tricore: qmp-test Running test qtest=
-
> tricore: qmp-cmd-test Running test qtest-tricore: qom-test Bad address
> qemu-system-tricore: no kernel file '(null)'
> Broken pipe
> ../tests/qtest/libqtest.c:166: kill_qemu() tried to terminate QEMU proces=
s but
> encountered exit status 1 (expected 0) ERROR qtest-tricore: qom-test - to=
o few
> tests run (expected 3, got 1)
>=20
> Andreas, can you look into this?

I looked multiple times into this problem. With trial and error I found a w=
orking
patch today. I also included Thomas Huths suggestions regarding KConfig and
meson.build
(https://lists.nongnu.org/archive/html/qemu-devel/2020-09/msg00867.html),
so feel free to modify. I will send the patch as soon as possible.
=20
> Thanks,
> Bastian

Kind regards,

Andreas

