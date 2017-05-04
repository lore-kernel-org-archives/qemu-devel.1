Received: from eggs.gnu.org ([2001:4830:134:3::10]:34633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1u-0001UD-0P
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1r-0004ZZ-2r
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1q-0004YW-QX
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DFC0F7AE81
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:50 +0200
Message-Id: <20170504071811.3547-10-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 09/30] audio: Remove UINT8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: Juan Quintela <quintela@redhat.com>

uint8_t has existed since ..... all this century?

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-6-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 39 ++++++++++++++++++++-------------------
 hw/audio/fmopl.c |  8 ++++----
 2 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index e476497275..3df89425ef 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -1,6 +1,8 @@
 #ifndef FMOPL_H
 #define FMOPL_H
 
+#include <stdint.h>
+
 /* --- system optimize --- */
 /* select bit size of output : 8 or 16 */
 #define OPL_OUTPUT_BIT 16
@@ -8,7 +10,6 @@
 /* compiler dependence */
 #ifndef OSD_CPU_H
 #define OSD_CPU_H
-typedef unsigned char	UINT8;   /* unsigned  8bit */
 typedef unsigned short	UINT16;  /* unsigned 16bit */
 typedef unsigned int	UINT32;  /* unsigned 32bit */
 typedef signed char		INT8;    /* signed  8bit   */
@@ -41,19 +42,19 @@ typedef unsigned char (*OPL_PORTHANDLER_R)(int param);
 typedef struct fm_opl_slot {
 	INT32 TL;		/* total level     :TL << 8            */
 	INT32 TLL;		/* adjusted now TL                     */
-	UINT8  KSR;		/* key scale rate  :(shift down bit)   */
+	uint8_t  KSR;		/* key scale rate  :(shift down bit)   */
 	INT32 *AR;		/* attack rate     :&AR_TABLE[AR<<2]   */
 	INT32 *DR;		/* decay rate      :&DR_TALBE[DR<<2]   */
 	INT32 SL;		/* sustin level    :SL_TALBE[SL]       */
 	INT32 *RR;		/* release rate    :&DR_TABLE[RR<<2]   */
-	UINT8 ksl;		/* keyscale level  :(shift down bits)  */
-	UINT8 ksr;		/* key scale rate  :kcode>>KSR         */
+	uint8_t ksl;		/* keyscale level  :(shift down bits)  */
+	uint8_t ksr;		/* key scale rate  :kcode>>KSR         */
 	UINT32 mul;		/* multiple        :ML_TABLE[ML]       */
 	UINT32 Cnt;		/* frequency count :                   */
 	UINT32 Incr;	/* frequency step  :                   */
 	/* envelope generator state */
-	UINT8 eg_typ;	/* envelope type flag                  */
-	UINT8 evm;		/* envelope phase                      */
+	uint8_t eg_typ;	/* envelope type flag                  */
+	uint8_t evm;		/* envelope phase                      */
 	INT32 evc;		/* envelope counter                    */
 	INT32 eve;		/* envelope counter end point          */
 	INT32 evs;		/* envelope counter step               */
@@ -61,8 +62,8 @@ typedef struct fm_opl_slot {
 	INT32 evsd;	/* envelope step for DR :DR[ksr]           */
 	INT32 evsr;	/* envelope step for RR :RR[ksr]           */
 	/* LFO */
-	UINT8 ams;		/* ams flag                            */
-	UINT8 vib;		/* vibrate flag                        */
+	uint8_t ams;		/* ams flag                            */
+	uint8_t vib;		/* vibrate flag                        */
 	/* wave selector */
 	INT32 **wavetable;
 }OPL_SLOT;
@@ -70,38 +71,38 @@ typedef struct fm_opl_slot {
 /* ---------- OPL one of channel  ---------- */
 typedef struct fm_opl_channel {
 	OPL_SLOT SLOT[2];
-	UINT8 CON;			/* connection type                     */
-	UINT8 FB;			/* feed back       :(shift down bit)   */
+	uint8_t CON;			/* connection type                     */
+	uint8_t FB;			/* feed back       :(shift down bit)   */
 	INT32 *connect1;	/* slot1 output pointer                */
 	INT32 *connect2;	/* slot2 output pointer                */
 	INT32 op1_out[2];	/* slot1 output for selfeedback        */
 	/* phase generator state */
 	UINT32  block_fnum;	/* block+fnum      :                   */
-	UINT8 kcode;		/* key code        : KeyScaleCode      */
+	uint8_t kcode;		/* key code        : KeyScaleCode      */
 	UINT32  fc;			/* Freq. Increment base                */
 	UINT32  ksl_base;	/* KeyScaleLevel Base step             */
-	UINT8 keyon;		/* key on/off flag                     */
+	uint8_t keyon;		/* key on/off flag                     */
 } OPL_CH;
 
 /* OPL state */
 typedef struct fm_opl_f {
-	UINT8 type;			/* chip type                         */
+	uint8_t type;			/* chip type                         */
 	int clock;			/* master clock  (Hz)                */
 	int rate;			/* sampling rate (Hz)                */
 	double freqbase;	/* frequency base                    */
 	double TimerBase;	/* Timer base time (==sampling time) */
-	UINT8 address;		/* address register                  */
-	UINT8 status;		/* status flag                       */
-	UINT8 statusmask;	/* status mask                       */
+	uint8_t address;		/* address register                  */
+	uint8_t status;		/* status flag                       */
+	uint8_t statusmask;	/* status mask                       */
 	UINT32 mode;		/* Reg.08 : CSM , notesel,etc.       */
 	/* Timer */
 	int T[2];			/* timer counter                     */
-	UINT8 st[2];		/* timer enable                      */
+	uint8_t st[2];		/* timer enable                      */
 	/* FM channel slots */
 	OPL_CH *P_CH;		/* pointer of CH                     */
 	int	max_ch;			/* maximum channel                   */
 	/* Rhythm sention */
-	UINT8 rhythm;		/* Rhythm mode , key flag */
+	uint8_t rhythm;		/* Rhythm mode , key flag */
 	OPL_PORTHANDLER_R porthandler_r;
 	OPL_PORTHANDLER_W porthandler_w;
 	int port_param;
@@ -120,7 +121,7 @@ typedef struct fm_opl_f {
 	INT32 vibCnt;
 	INT32 vibIncr;
 	/* wave selector enable flag */
-	UINT8 wavesel;
+	uint8_t wavesel;
 	/* external event callback handler */
 	OPL_TIMERHANDLER  TimerHandler;		/* TIMER handler   */
 	int TimerParam;						/* TIMER parameter */
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 282662a858..3d14b455a7 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -789,8 +789,8 @@ static void OPLWriteReg(FM_OPL *OPL, int r, int v)
 			}
 			else
 			{	/* set IRQ mask ,timer enable*/
-				UINT8 st1 = v&1;
-				UINT8 st2 = (v>>1)&1;
+				uint8_t st1 = v&1;
+				uint8_t st2 = (v>>1)&1;
 				/* IRQRST,T1MSK,t2MSK,EOSMSK,BRMSK,x,ST2,ST1 */
 				OPL_STATUS_RESET(OPL,v&0x78);
 				OPL_STATUSMASK_SET(OPL,((~v)&0x78)|0x01);
@@ -838,7 +838,7 @@ static void OPLWriteReg(FM_OPL *OPL, int r, int v)
 		case 0xbd:
 			/* amsep,vibdep,r,bd,sd,tom,tc,hh */
 			{
-			UINT8 rkey = OPL->rhythm^v;
+			uint8_t rkey = OPL->rhythm^v;
 			OPL->ams_table = &AMS_TABLE[v&0x80 ? AMS_ENT : 0];
 			OPL->vib_table = &VIB_TABLE[v&0x40 ? VIB_ENT : 0];
 			OPL->rhythm  = v&0x3f;
@@ -991,7 +991,7 @@ void YM3812UpdateOne(FM_OPL *OPL, INT16 *buffer, int length)
 	OPLSAMPLE *buf = buffer;
 	UINT32 amsCnt  = OPL->amsCnt;
 	UINT32 vibCnt  = OPL->vibCnt;
-	UINT8 rhythm = OPL->rhythm&0x20;
+	uint8_t rhythm = OPL->rhythm&0x20;
 	OPL_CH *CH,*R_CH;
 
 	if( (void *)OPL != cur_chip ){
-- 
2.9.3
