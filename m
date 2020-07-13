Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1479C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:05:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1872067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1872067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuOb-0006Vg-VH
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:05:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yi59@zte.com.cn>)
 id 1juuLw-0001Oh-FR
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:02:24 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:61988 helo=mxct.zte.com.cn)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yi59@zte.com.cn>)
 id 1juuLs-00036d-1k
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:02:24 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
 by Forcepoint Email with ESMTPS id 2C8779BDEF0125E58360
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 17:02:17 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
 by mse-fl2.zte.com.cn with ESMTP id 06D92Fo6037500
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 17:02:15 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2020071317022097-4267741 ;
 Mon, 13 Jul 2020 17:02:20 +0800 
From: Yi Wang <wang.yi59@zte.com.cn>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/12] hw: Remove superfluous breaks
Date: Mon, 13 Jul 2020 17:05:26 +0800
Message-Id: <1594631126-36631-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2020-07-13 17:02:21,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-07-13 17:02:17
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MAIL: mse-fl2.zte.com.cn 06D92Fo6037500
Received-SPF: pass client-ip=202.103.147.172;
 envelope-from=wang.yi59@zte.com.cn; helo=mxct.zte.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 05:01:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: wang.yi59@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>,
 wang.liang82@zte.com.cn, xue.zhihong@zte.com.cn
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Remove superfluous breaks, as there is a "return" before them.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/block/pflash=5Fcfi01.c     |  1 -
 hw/display/cirrus=5Fvga.c     |  1 -
 hw/display/qxl-logger.c     |  2 --
 hw/gpio/max7310.c           |  3 ---
 hw/i386/intel=5Fiommu.c       |  1 -
 hw/input/pxa2xx=5Fkeypad.c    | 10 ----------
 hw/intc/armv7m=5Fnvic.c       |  1 -
 hw/net/lan9118.c            |  2 --
 hw/usb/ccid-card-emulated.c |  1 -
 9 files changed, 22 deletions(-)

diff --git a/hw/block/pflash=5Fcfi01.c b/hw/block/pflash=5Fcfi01.c
index 8ab1d66..f0fcd63 100644
--- a/hw/block/pflash=5Fcfi01.c
+++ b/hw/block/pflash=5Fcfi01.c
@@ -213,7 +213,6 @@ static uint32=5Ft pflash=5Fdevid=5Fquery(PFlashCFI01 *p=
fl, hwaddr offset)
     default:
         trace=5Fpflash=5Fdevice=5Finfo(offset);
         return 0;
-        break;
     }
     /* Replicate responses for each device in bank. */
     if (pfl->device=5Fwidth < pfl->bank=5Fwidth) {
diff --git a/hw/display/cirrus=5Fvga.c b/hw/display/cirrus=5Fvga.c
index 212d6f5..02d9ed0 100644
--- a/hw/display/cirrus=5Fvga.c
+++ b/hw/display/cirrus=5Fvga.c
@@ -1637,7 +1637,6 @@ static int cirrus=5Fvga=5Fread=5Fcr(CirrusVGAState * =
s, unsigned reg=5Findex)
 	return s->vga.cr[s->vga.cr=5Findex];
     case 0x26:			// Attribute Controller Index Readback (R)
 	return s->vga.ar=5Findex & 0x3f;
-	break;
     default:
         qemu=5Flog=5Fmask(LOG=5FGUEST=5FERROR,
                       "cirrus: inport cr=5Findex 0x%02x\n", reg=5Findex);
diff --git a/hw/display/qxl-logger.c b/hw/display/qxl-logger.c
index 2ec6d8f..c15175b 100644
--- a/hw/display/qxl-logger.c
+++ b/hw/display/qxl-logger.c
@@ -161,7 +161,6 @@ static int qxl=5Flog=5Fcmd=5Fdraw(PCIQXLDevice *qxl, QX=
LDrawable *draw, int group=5Fid)
     switch (draw->type) {
     case QXL=5FDRAW=5FCOPY:
         return qxl=5Flog=5Fcmd=5Fdraw=5Fcopy(qxl, &draw->u.copy, group=5Fi=
d);
-        break;
     }
     return 0;
 }
@@ -180,7 +179,6 @@ static int qxl=5Flog=5Fcmd=5Fdraw=5Fcompat(PCIQXLDevice=
 *qxl, QXLCompatDrawable *draw,
     switch (draw->type) {
     case QXL=5FDRAW=5FCOPY:
         return qxl=5Flog=5Fcmd=5Fdraw=5Fcopy(qxl, &draw->u.copy, group=5Fi=
d);
-        break;
     }
     return 0;
 }
diff --git a/hw/gpio/max7310.c b/hw/gpio/max7310.c
index bebb403..4f78774 100644
--- a/hw/gpio/max7310.c
+++ b/hw/gpio/max7310.c
@@ -51,11 +51,9 @@ static uint8=5Ft max7310=5Frx(I2CSlave *i2c)
     switch (s->command) {
     case 0x00:	/* Input port */
         return s->level ^ s->polarity;
-        break;
=20
     case 0x01:	/* Output port */
         return s->level & ~s->direction;
-        break;
=20
     case 0x02:	/* Polarity inversion */
         return s->polarity;
@@ -65,7 +63,6 @@ static uint8=5Ft max7310=5Frx(I2CSlave *i2c)
=20
     case 0x04:	/* Timeout */
         return s->status;
-        break;
=20
     case 0xff:	/* Reserved */
         return 0xff;
diff --git a/hw/i386/intel=5Fiommu.c b/hw/i386/intel=5Fiommu.c
index c56398e..7b390ca 100644
--- a/hw/i386/intel=5Fiommu.c
+++ b/hw/i386/intel=5Fiommu.c
@@ -3163,7 +3163,6 @@ static int vtd=5Firte=5Fget(IntelIOMMUState *iommu, u=
int16=5Ft index,
                               index, entry->irte.sid=5Fvtype);
             /* Take this as verification failure. */
             return -VTD=5FFR=5FIR=5FSID=5FERR;
-            break;
         }
     }
=20
diff --git a/hw/input/pxa2xx=5Fkeypad.c b/hw/input/pxa2xx=5Fkeypad.c
index 62aa6f6..7f2f739 100644
--- a/hw/input/pxa2xx=5Fkeypad.c
+++ b/hw/input/pxa2xx=5Fkeypad.c
@@ -192,10 +192,8 @@ static uint64=5Ft pxa2xx=5Fkeypad=5Fread(void *opaque,=
 hwaddr offset,
             s->kpc &=3D ~(KPC=5FDI);
         qemu=5Firq=5Flower(s->irq);
         return tmp;
-        break;
     case KPDK:
         return s->kpdk;
-        break;
     case KPREC:
         tmp =3D s->kprec;
         if(tmp & KPREC=5FOF1)
@@ -207,31 +205,23 @@ static uint64=5Ft pxa2xx=5Fkeypad=5Fread(void *opaque=
, hwaddr offset,
         if(tmp & KPREC=5FUF0)
             s->kprec &=3D ~(KPREC=5FUF0);
         return tmp;
-        break;
     case KPMK:
         tmp =3D s->kpmk;
         if(tmp & KPMK=5FMKP)
             s->kpmk &=3D ~(KPMK=5FMKP);
         return tmp;
-        break;
     case KPAS:
         return s->kpas;
-        break;
     case KPASMKP0:
         return s->kpasmkp[0];
-        break;
     case KPASMKP1:
         return s->kpasmkp[1];
-        break;
     case KPASMKP2:
         return s->kpasmkp[2];
-        break;
     case KPASMKP3:
         return s->kpasmkp[3];
-        break;
     case KPKDI:
         return s->kpkdi;
-        break;
     default:
         qemu=5Flog=5Fmask(LOG=5FGUEST=5FERROR,
                       "%s: Bad read offset 0x%"HWADDR=5FPRIx"\n",
diff --git a/hw/intc/armv7m=5Fnvic.c b/hw/intc/armv7m=5Fnvic.c
index 3c4b6e6..720ac97 100644
--- a/hw/intc/armv7m=5Fnvic.c
+++ b/hw/intc/armv7m=5Fnvic.c
@@ -1275,7 +1275,6 @@ static uint32=5Ft nvic=5Freadl(NVICState *s, uint32=
=5Ft offset, MemTxAttrs attrs)
     case 0xd90: /* MPU=5FTYPE */
         /* Unified MPU; if the MPU is not present this value is zero */
         return cpu->pmsav7=5Fdregion << 8;
-        break;
     case 0xd94: /* MPU=5FCTRL */
         return cpu->env.v7m.mpu=5Fctrl[attrs.secure];
     case 0xd98: /* MPU=5FRNR */
diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 8e2a432..e35f00f 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -931,10 +931,8 @@ static uint32=5Ft do=5Fmac=5Fread(lan9118=5Fstate *s, =
int reg)
                | (s->conf.macaddr.a[2] << 16) | (s->conf.macaddr.a[3] << 2=
4);
     case MAC=5FHASHH:
         return s->mac=5Fhashh;
-        break;
     case MAC=5FHASHL:
         return s->mac=5Fhashl;
-        break;
     case MAC=5FMII=5FACC:
         return s->mac=5Fmii=5Facc;
     case MAC=5FMII=5FDATA:
diff --git a/hw/usb/ccid-card-emulated.c b/hw/usb/ccid-card-emulated.c
index 7d6105e..0f1afd6 100644
--- a/hw/usb/ccid-card-emulated.c
+++ b/hw/usb/ccid-card-emulated.c
@@ -350,7 +350,6 @@ static void *event=5Fthread(void *arg)
         case VEVENT=5FLAST: /* quit */
             vevent=5Fdelete(event);
             return NULL;
-            break;
         default:
             break;
         }
--=20
2.9.5


