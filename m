Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E07C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74CDB20737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BW4Vkh+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CDB20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB2ok-0001wp-FW
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:18:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k9-0008Qi-KM
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:05 -0400
Received: from mout.gmx.net ([212.227.17.20]:36315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k4-0002VE-Cs
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598476428;
 bh=z/QXmt5sYC3nu5t+U0TkgIU+Re5QzTPu4ajnWt9P04Y=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BW4Vkh+MculITY9YW+eer7MEuXJy3eDABPnabhY6oojR0i6W+K28HOqX1byH0kzR1
 0hu06skxC434cyIXGOvkVZIznk1xy+7/QKHVxWoyc+seRg0YyDu7XPxc/TJwcM7g6r
 3ny3Uty4hTOh1DL0fDQMduR3IvhqGjN5i9IrD978=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.186.77]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiaYJ-1kn7Nr2gSt-00fiSS; Wed, 26
 Aug 2020 23:13:48 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v5 03/12] hw/hppa: Implement proper SeaBIOS version check
Date: Wed, 26 Aug 2020 23:13:36 +0200
Message-Id: <20200826211345.14295-4-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200826211345.14295-1-deller@gmx.de>
References: <20200826211345.14295-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hZRjB35ILXehYOFanBQJT7ly3B8bcatuDNHc9Qo2Sozf65FKiXu
 4bDMJv/muQgfmdTsKvE9cuXRq3LDWJfm0GjPErFr6RNdk0icZIvXEXn6kg7lGdLZqg3XlKo
 jKHDPlWvm3BbjApgTODFui8mY0K4C4D7aZlXVKWem0JGRthtu7Gh83Wnj5D/D5rBKsqnkpV
 WMCnSsnAwBx4NoJ0mDc/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r/Dtl7Wwh0M=:64DZoukRB1sy6fhPaZL+7k
 fl8K6DPWXBboSetilcb1sXVNqYFwemCLpxFoQRYk/wCzfc/N9RiSSP3UbFhy2kF3g1iKmGLva
 WnocHn7LTD3iV2iOjXgl42qhms/rcSbd9EUu15eaIioGLvBcoroqOEy6Enm5GdePUx7Qs/Xnv
 V7nJxsgPinqsTWibBxAh9tgebgK5zyUFFq9C8fMSkYJBljuvn+aBihx97STjcFMSdzSspIzEE
 AmM4kJ1fgLe85NAwgqczd14ZWULd4RC+tf63x+MyqXAYlWxhdzpHeLPO5XNs7v0n0YMpPuhFA
 90JGi17OXxHeMmKfA8vXoqVeAlkDzjBn4FfR5KAd/gXntZgMa2HdSf+4zewC/5IKrRiyacM3j
 qWSHk/x0B69LfdvNJMj2fBhzzdYR4W0jdd4AvCZh34uNJPcxJvBV9EPWFy4KuBwVsAnVK65Xu
 p22Nt/EHFGXAJSGjjYCnBmJXxZPqqpgTfz/BJvMbuHnzN9VYVeA+AtmLoqIDRgenTjwOUPGRg
 VEa1dfXnFT7qBVxAFdnhrbMTCQTqh8OKl8lVcp11G4mEnFf3L3Y+ISycwouvePngznxRXW2iR
 VKrUpz5fvTR7dI9HYm75dCZc0hp7d8LRSfjn4OwW2lKBxwxm8+0j91OgUNN7b/nGzZlGGaqnh
 O+6WIKlTAnGHClSavr2McljjchUMLr9S/fnuC2p4raVPrxP7lqi27OPictn8WQs81IIU3Lm9k
 O0ZJQhhCyjATuwIREORm0/vjtknjP9ouaw4CfXvGfk0UVPyuJXBxznqXRdkkhfDQpH7BceTzg
 X/sfyiaf8bJaO9+VuVkL3Hbe1Lr/FUudpP4WuKrjGyve5mS9P+Z0EQ5DPrm/8GpbAITDth6No
 DuSIER2Gq+5qIIKEkkm3FjJhAcC+HYGyGZ3icH5DH3/zddxqaUjeMQv7qiTMXg69n/KTXBJd3
 iGfqB7/tKlBArlHzp70LrFhgjsJwUTySmli5J68XcHXzPXGsIOniFVpgst2yN7BtWb4vSdEHf
 63+m10gQNUz5FTrKYUDQVoKripkxXM3N1P8Si8W4mWkFK87hJJrE9k/LHocmVaKavz5myEUM4
 xUqmQB6eb3xr/ocM/kS4AThV54ulgZqYlN8nTYvcwkljHaBTI3ge1X0w3DVV7HPq12kaXylUI
 J5OgzCQ/SI9XzEGA0lTApoDwkqLDghmsUgwLAHZghy4vY17buS2ZD7OQygLoisRNNGgU+nAB6
 9qzpXpzSRLEMP1J45
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 17:13:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's important that the SeaBIOS hppa firmware is at least at a minimal
level to ensure proper interaction between qemu and firmware.

Implement a proper firmware version check by telling SeaBIOS via the
fw_cfg interface which minimal SeaBIOS version is required by this
running qemu instance. If the firmware detects that it's too old, it
will stop.

Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/hppa/machine.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 49155537cd..90aeefe2a4 100644
=2D-- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -25,6 +25,8 @@

 #define MAX_IDE_BUS 2

+#define MIN_SEABIOS_HPPA_VERSION 1 /* require at least this fw version */
+
 static ISABus *hppa_isa_bus(void)
 {
     ISABus *isa_bus;
@@ -56,6 +58,23 @@ static uint64_t cpu_hppa_to_phys(void *opaque, uint64_t=
 addr)
 static HPPACPU *cpu[HPPA_MAX_CPUS];
 static uint64_t firmware_entry;

+static FWCfgState *create_fw_cfg(MachineState *ms)
+{
+    FWCfgState *fw_cfg;
+    uint64_t val;
+
+    fw_cfg =3D fw_cfg_init_mem(QEMU_FW_CFG_IO_BASE, QEMU_FW_CFG_IO_BASE +=
 4);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_NB_CPUS, ms->smp.cpus);
+    fw_cfg_add_i16(fw_cfg, FW_CFG_MAX_CPUS, HPPA_MAX_CPUS);
+    fw_cfg_add_i64(fw_cfg, FW_CFG_RAM_SIZE, ram_size);
+
+    val =3D cpu_to_le64(MIN_SEABIOS_HPPA_VERSION);
+    fw_cfg_add_file(fw_cfg, "/etc/firmware-min-version",
+                    g_memdup(&val, sizeof(val)), sizeof(val));
+
+    return fw_cfg;
+}
+
 static void machine_hppa_init(MachineState *machine)
 {
     const char *kernel_filename =3D machine->kernel_filename;
@@ -118,6 +137,9 @@ static void machine_hppa_init(MachineState *machine)
                        115200, serial_hd(0), DEVICE_BIG_ENDIAN);
     }

+    /* fw_cfg configuration interface */
+    create_fw_cfg(machine);
+
     /* SCSI disk setup. */
     dev =3D DEVICE(pci_create_simple(pci_bus, -1, "lsi53c895a"));
     lsi53c8xx_handle_legacy_cmdline(dev);
=2D-
2.21.3


