Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2FBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9963824684
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cmdtFYNC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="yBuAO1xI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9963824684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuEF5-0007AL-LY
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 06:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=283669e78=Anup.Patel@wdc.com>)
 id 1iuEDg-0006Bu-8o
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:30:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=283669e78=Anup.Patel@wdc.com>)
 id 1iuEDe-0005UW-PB
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:30:48 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:57987)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=283669e78=Anup.Patel@wdc.com>)
 id 1iuEDb-0005S3-Hi; Wed, 22 Jan 2020 06:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1579692643; x=1611228643;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ugn6ohbjf7wkTqV3AgqHzAB9dmtThjoqvLQwVbepm7g=;
 b=cmdtFYNCp2DkHjWH7ihRYy3wnsGDeA31W9gXTIceN5eFWlt9I11Om5mt
 CouQZ3w6o8KKjro6nx6U7YIV/WUyb2MdMU11mOqO8g59m5xeJKRAvOw7a
 rbsiliDe1EhiVBqpSsmVoWY8Hzf/b7h3G2A0O2JxCqYJ6zbz5vKkI/DOK
 wcdk1NwZEQsncnl8MFn6R/rFmRaz68HF/Iv2DWqJnBRN3gQK17pk9eYN9
 pAxGae1HDN6YZ3v7ZaSPYNxy689vYmaVFfHSnCwgENsQhZpWxZvex8f9f
 uny0agC9Xw7gK9Ueo2ddul2odMUI20JNQ0MvFlsNp5Pipu4ohDJMLBKzS Q==;
IronPort-SDR: hAqCfcB+fzUr1Mnx52EzQVM1nDW0loEeh27Gyu0CHLKtn+tSYZu9h8w9NifOoB9aREZSws70TG
 miZWFcnExeBodrpNXBETUFNJSaWQd5Braib4dY9lSQrpwiHVEuAe6ULWzebi9IyKb1Ktj8vqHK
 TC5LZDgY4cJkU/YyYl+qmn0Hg1/gtkfTvPMh31GT4VAUKm40RuqA9Wp7hGXOT04n4juKRtCDIO
 IcI8HlFaGl5E1iW6/AhDSAM18Gs2m1uaTp0C+hX2SboQqTOJId7QrawAj61hq4nacLOY/bnKbg
 DvY=
X-IronPort-AV: E=Sophos;i="5.70,349,1574092800"; d="scan'208";a="236053335"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
 by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2020 19:30:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJn0ZQS4Js8xJxO6p6VCySAajiNUVfUudwtQhGGvDvS1MYw3f5PkRTUyS33EnC9UunZ1QqTAE6nqMC+B08pNf7JjwIn8uYsJztUiJyMacBcVRZw0paLKDdODM1P0bX995Y/2d9O/eMB57sPI6XsLqsCtBhE0+hSFsX/37xOd+GKO1q0MPizuL/hHUrRzBI9A+xkPzvX+it4uhwWv3hGnnpV5Yiq6epRi32zOHLEx6q0lO86RdYel7S67BQ4xAHSJ/Itl4CjdpR7waZ3Ti8Fu/h8nkyL39fJ2u21BMT6CfvZ5xDO7aGb4/mVmVtugwcd/WwWyY8lIzNogVrc56po+Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zHyiDxWrS4UFml17He7AybBtvIcRdJ5DqqXdCASQv0=;
 b=OtTqNZu6wpf9dh+GxdTZUB7wXoZZL7YQNcy+60MVMhcWgs1XXxdJVU5NtUyPdjINqm617USIgAOtBUHwYANjbBpKlTxnb+k1sIWYiZ/JmlaZENVN9/fjhQ7lNrkhhJbjo3Y+M8timfHdWoz+oHkMsC7QEze2P8KerDdFTk9LeLzXYZ2mCptSRywdi3d1jb8dXb1dEl5i0e5LSdF+BgHJXOXLwl+Trq/amDrSw9ZzFz7cDE8yCw1N27YDJGKv0B3TDju0DwUWM9lNnUQancWvRuNRIwhIAd2Z+00EM8JQlRvg0mcGvtqArPMVRuL/lA/VZcpkbBdCzqJvMKdAzp8U5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zHyiDxWrS4UFml17He7AybBtvIcRdJ5DqqXdCASQv0=;
 b=yBuAO1xIAm/eo1Wi7k5ow8NpO7ppCwqFd6luoZdIWP1qWdta/lviHqXZkguv/87S0wRnRplr9ggKiPKh9I/VATca0Xa9h5XjcWJp7DSpxGKf48BurYUGgXKZoDPyp9TFz+T/89iZwoN1JXeATv1kgnCodZS1TM2dPjv29KOK8Es=
Received: from MN2PR04MB6061.namprd04.prod.outlook.com (20.178.246.15) by
 MN2PR04MB6767.namprd04.prod.outlook.com (10.186.146.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 11:30:32 +0000
Received: from MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89]) by MN2PR04MB6061.namprd04.prod.outlook.com
 ([fe80::a9a0:3ffa:371f:ad89%7]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 11:30:32 +0000
Received: from wdc.com (106.51.28.174) by
 MAXPR01CA0114.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20 via Frontend Transport; Wed, 22 Jan 2020 11:30:27 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <Alistair.Francis@wdc.com>, Sagar
 Karandikar <sagark@eecs.berkeley.edu>
Subject: [PATCH v2 1/2] target/riscv: Emulate TIME CSRs for privileged mode
Thread-Topic: [PATCH v2 1/2] target/riscv: Emulate TIME CSRs for privileged
 mode
Thread-Index: AQHV0Rdak9afzv/5iU6bigeMA554xA==
Date: Wed, 22 Jan 2020 11:30:31 +0000
Message-ID: <20200122112952.94284-2-anup.patel@wdc.com>
References: <20200122112952.94284-1-anup.patel@wdc.com>
In-Reply-To: <20200122112952.94284-1-anup.patel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR01CA0114.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::32) To MN2PR04MB6061.namprd04.prod.outlook.com
 (2603:10b6:208:d8::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Anup.Patel@wdc.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [106.51.28.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e99c7705-965b-45ce-0205-08d79f2e7d51
x-ms-traffictypediagnostic: MN2PR04MB6767:|MN2PR04MB6767:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6767142373DEDF58D012C5DC8D0C0@MN2PR04MB6767.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:SPM;
 SFS:(10019020)(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(189003)(199004)(478600001)(8886007)(36756003)(110136005)(4326008)(44832011)(54906003)(316002)(55016002)(2616005)(1006002)(86362001)(2906002)(186003)(71200400001)(16526019)(8676002)(6666004)(81166006)(956004)(81156014)(66946007)(66556008)(66476007)(55236004)(66446008)(64756008)(26005)(1076003)(8936002)(5660300002)(52116002)(7696005)(32030200002);
 DIR:OUT; SFP:1501; SCL:5; SRVR:MN2PR04MB6767;
 H:MN2PR04MB6061.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; CAT:OSPM; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kfnIqjBh0rFvjzSHdoNUA4Yi+TM5QIwAmM5qePX8FsdL17pmXggnw/4mgnmt0jTRYur+78omcb6T1CLI5C5RA7xh2g8Egntj/CUNfS/KR6No7OYhJoLFyUBgiRhnpXld6zaBJPshFNgLiilmcK3agnguQVUAJTL4UxLwnUiSZ2s5dW2dHo4uj/yC2DBrhVf7Zxgn9y5w7hqThNi5FHsF0s+YWdRZ6qMb+Mcz8kNVM9S6K4wZvYPvY9Ib8hjkRqqLuBG2uiRmqfJlF+jT4uK/xa0s3RffP6NF5ieF7En+g1yK44NJO5Q+6LPVyJxmdPn5eDLh2qdLgTAofsGhTo8L2F6u2IbweHYmv29YoTTONl1k32o4mZPQpgKjw00+1yZwgy8PF3rvMG65xtSf9kRhpSe37K7YfV4+b84ui3Lg8vJ00rpdDMbIP84VOvwhxSLGVQCTamV8hjC45CtBu9sx1vYrBlE6huOtN7uh4GbkbyQcVtGTbqpUVZQ1YNCajHwHKTuqPNljGSdyKzSS3UdMA14BCgXlSTcTxXIWxIoQcDus40BmY20abeIJJjAOqiOoFCvgfv0U5ttPUzAHuwUmBkUL6mmkDcNkAPMPoS2F8w4CGoRcdNCSe3epTMRQkNQSbC0WHGJhRj5VgNRJY6OWhrBUmozovD524oqOxdpFOIvid+97pOMl1XH107+64WaWV3gJSR9FneS1h8FjfnhOVYRyJ0vIZuaz79Thg6qZkGbO7JjhAKhoPbFsVFFnpFZf0Ujf4zK2JL5aA7d87ChdtQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e99c7705-965b-45ce-0205-08d79f2e7d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 11:30:31.8645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nep1bIieRmYuWlw09We+3wblNeo/cnSsvT9YHZB+bFXoeCIeaG7w8MOG7ixklYBoCaVcpFRXmvRjTxnSOaSh6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6767
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 68.232.141.245
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
Cc: Atish Patra <Atish.Patra@wdc.com>, Anup Patel <Anup.Patel@wdc.com>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Anup Patel <anup@brainfault.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently, TIME CSRs are emulated only for user-only mode. This
patch add TIME CSRs emulation for privileged mode.

For privileged mode, the TIME CSRs will return value provided
by rdtime callback which is registered by QEMU machine/platform
emulation (i.e. CLINT emulation). If rdtime callback is not
available then the monitor (i.e. OpenSBI) will trap-n-emulate
TIME CSRs in software.

We see 25+% performance improvement in hackbench numbers when
TIME CSRs are not trap-n-emulated.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h        |  5 +++
 target/riscv/cpu_helper.c |  5 +++
 target/riscv/csr.c        | 86 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 53bc6af5f7..473e01da6c 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -169,6 +169,7 @@ struct CPURISCVState {
     target_ulong htval;
     target_ulong htinst;
     target_ulong hgatp;
+    uint64_t htimedelta;
=20
     /* Virtual CSRs */
     target_ulong vsstatus;
@@ -204,6 +205,9 @@ struct CPURISCVState {
     /* physical memory protection */
     pmp_table_t pmp_state;
=20
+    /* machine specific rdtime callback */
+    uint64_t (*rdtime_fn)(void);
+
     /* True if in debugger mode.  */
     bool debugger;
 #endif
@@ -325,6 +329,7 @@ void riscv_cpu_swap_hypervisor_regs(CPURISCVState *env)=
;
 int riscv_cpu_claim_interrupts(RISCVCPU *cpu, uint32_t interrupts);
 uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t mask, uint32_t value=
);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value =
*/
+void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void));
 #endif
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv);
=20
diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index 7166e6199e..c85f44d933 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -250,6 +250,11 @@ uint32_t riscv_cpu_update_mip(RISCVCPU *cpu, uint32_t =
mask, uint32_t value)
     return old;
 }
=20
+void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void))
+{
+    env->rdtime_fn =3D fn;
+}
+
 void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
 {
     if (newpriv > PRV_M) {
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index b28058f9d5..44ff1d80ec 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -238,6 +238,32 @@ static int read_timeh(CPURISCVState *env, int csrno, t=
arget_ulong *val)
=20
 #else /* CONFIG_USER_ONLY */
=20
+static int read_time(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    uint64_t delta =3D riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
+
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+    *val =3D env->rdtime_fn() + delta;
+    return 0;
+}
+
+#if defined(TARGET_RISCV32)
+static int read_timeh(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    uint64_t delta =3D riscv_cpu_virt_enabled(env) ? env->htimedelta : 0;
+
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+    *val =3D (env->rdtime_fn() + delta) >> 32;
+    return 0;
+}
+#endif
+
 /* Machine constants */
=20
 #define M_MODE_INTERRUPTS  (MIP_MSIP | MIP_MTIP | MIP_MEIP)
@@ -931,6 +957,56 @@ static int write_hgatp(CPURISCVState *env, int csrno, =
target_ulong val)
     return 0;
 }
=20
+static int read_htimedelta(CPURISCVState *env, int csrno, target_ulong *va=
l)
+{
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+#if defined(TARGET_RISCV32)
+    *val =3D env->htimedelta & 0xffffffff;
+#else
+    *val =3D env->htimedelta;
+#endif
+    return 0;
+}
+
+static int write_htimedelta(CPURISCVState *env, int csrno, target_ulong va=
l)
+{
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+#if defined(TARGET_RISCV32)
+    env->htimedelta =3D deposit64(env->htimedelta, 0, 32, (uint64_t)val);
+#else
+    env->htimedelta =3D val;
+#endif
+    return 0;
+}
+
+#if defined(TARGET_RISCV32)
+static int read_htimedeltah(CPURISCVState *env, int csrno, target_ulong *v=
al)
+{
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+    *val =3D env->htimedelta >> 32;
+    return 0;
+}
+
+static int write_htimedeltah(CPURISCVState *env, int csrno, target_ulong v=
al)
+{
+    if (!env->rdtime_fn) {
+        return -1;
+    }
+
+    env->htimedelta =3D deposit64(env->htimedelta, 32, 32, (uint64_t)val);
+    return 0;
+}
+#endif
+
 /* Virtual CSR Registers */
 static int read_vsstatus(CPURISCVState *env, int csrno, target_ulong *val)
 {
@@ -1203,14 +1279,12 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE]=
 =3D {
     [CSR_INSTRETH] =3D            { ctr,  read_instreth                   =
    },
 #endif
=20
-    /* User-level time CSRs are only available in linux-user
-     * In privileged mode, the monitor emulates these CSRs */
-#if defined(CONFIG_USER_ONLY)
+    /* In privileged mode, the monitor will have to emulate TIME CSRs only=
 if
+     * rdtime callback is not provided by machine/platform emulation */
     [CSR_TIME] =3D                { ctr,  read_time                       =
    },
 #if defined(TARGET_RISCV32)
     [CSR_TIMEH] =3D               { ctr,  read_timeh                      =
    },
 #endif
-#endif
=20
 #if !defined(CONFIG_USER_ONLY)
     /* Machine Timers and Counters */
@@ -1276,6 +1350,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =
=3D {
     [CSR_HTVAL] =3D               { hmode,   read_htval,       write_htval=
      },
     [CSR_HTINST] =3D              { hmode,   read_htinst,      write_htins=
t     },
     [CSR_HGATP] =3D               { hmode,   read_hgatp,       write_hgatp=
      },
+    [CSR_HTIMEDELTA] =3D          { hmode,   read_htimedelta,  write_htime=
delta },
+#if defined(TARGET_RISCV32)
+    [CSR_HTIMEDELTAH] =3D         { hmode,   read_htimedeltah, write_htime=
deltah},
+#endif
=20
     [CSR_VSSTATUS] =3D            { hmode,   read_vsstatus,    write_vssta=
tus   },
     [CSR_VSIP] =3D                { hmode,   NULL,     NULL,     rmw_vsip =
      },
--=20
2.17.1


