Received: from eggs.gnu.org ([2001:4830:134:3::10]:34765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1w-0001Uw-IF
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1s-0004am-1h
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1r-0004Zt-Pt
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4311C04B943
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:22 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:55 +0200
Message-Id: <20170504071811.3547-15-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 14/30] audio: Remove INT32
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

Signed-off-by: Juan Quintela <quintela@redhat.com>
Message-id: 20170425223739.6703-11-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 54 ++++++++++++++++++++++++------------------------------
 hw/audio/fmopl.c | 42 +++++++++++++++++++++---------------------
 2 files changed, 45 insertions(+), 51 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index 0bc3415cd3..1e74019586 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -7,12 +7,6 @@
 /* select bit size of output : 8 or 16 */
 #define OPL_OUTPUT_BIT 16
 
-/* compiler dependence */
-#ifndef OSD_CPU_H
-#define OSD_CPU_H
-typedef signed int		INT32;   /* signed 32bit   */
-#endif
-
 #if (OPL_OUTPUT_BIT==16)
 typedef int16_t OPLSAMPLE;
 #endif
@@ -36,13 +30,13 @@ typedef unsigned char (*OPL_PORTHANDLER_R)(int param);
 /* Saving is necessary for member of the 'R' mark for suspend/resume */
 /* ---------- OPL one of slot  ---------- */
 typedef struct fm_opl_slot {
-	INT32 TL;		/* total level     :TL << 8            */
-	INT32 TLL;		/* adjusted now TL                     */
+	int32_t TL;		/* total level     :TL << 8            */
+	int32_t TLL;		/* adjusted now TL                     */
 	uint8_t  KSR;		/* key scale rate  :(shift down bit)   */
-	INT32 *AR;		/* attack rate     :&AR_TABLE[AR<<2]   */
-	INT32 *DR;		/* decay rate      :&DR_TALBE[DR<<2]   */
-	INT32 SL;		/* sustin level    :SL_TALBE[SL]       */
-	INT32 *RR;		/* release rate    :&DR_TABLE[RR<<2]   */
+	int32_t *AR;		/* attack rate     :&AR_TABLE[AR<<2]   */
+	int32_t *DR;		/* decay rate      :&DR_TALBE[DR<<2]   */
+	int32_t SL;		/* sustin level    :SL_TALBE[SL]       */
+	int32_t *RR;		/* release rate    :&DR_TABLE[RR<<2]   */
 	uint8_t ksl;		/* keyscale level  :(shift down bits)  */
 	uint8_t ksr;		/* key scale rate  :kcode>>KSR         */
 	uint32_t mul;		/* multiple        :ML_TABLE[ML]       */
@@ -51,17 +45,17 @@ typedef struct fm_opl_slot {
 	/* envelope generator state */
 	uint8_t eg_typ;	/* envelope type flag                  */
 	uint8_t evm;		/* envelope phase                      */
-	INT32 evc;		/* envelope counter                    */
-	INT32 eve;		/* envelope counter end point          */
-	INT32 evs;		/* envelope counter step               */
-	INT32 evsa;	/* envelope step for AR :AR[ksr]           */
-	INT32 evsd;	/* envelope step for DR :DR[ksr]           */
-	INT32 evsr;	/* envelope step for RR :RR[ksr]           */
+	int32_t evc;		/* envelope counter                    */
+	int32_t eve;		/* envelope counter end point          */
+	int32_t evs;		/* envelope counter step               */
+	int32_t evsa;	/* envelope step for AR :AR[ksr]           */
+	int32_t evsd;	/* envelope step for DR :DR[ksr]           */
+	int32_t evsr;	/* envelope step for RR :RR[ksr]           */
 	/* LFO */
 	uint8_t ams;		/* ams flag                            */
 	uint8_t vib;		/* vibrate flag                        */
 	/* wave selector */
-	INT32 **wavetable;
+	int32_t **wavetable;
 }OPL_SLOT;
 
 /* ---------- OPL one of channel  ---------- */
@@ -69,9 +63,9 @@ typedef struct fm_opl_channel {
 	OPL_SLOT SLOT[2];
 	uint8_t CON;			/* connection type                     */
 	uint8_t FB;			/* feed back       :(shift down bit)   */
-	INT32 *connect1;	/* slot1 output pointer                */
-	INT32 *connect2;	/* slot2 output pointer                */
-	INT32 op1_out[2];	/* slot1 output for selfeedback        */
+	int32_t *connect1;	/* slot1 output pointer                */
+	int32_t *connect2;	/* slot2 output pointer                */
+	int32_t op1_out[2];	/* slot1 output for selfeedback        */
 	/* phase generator state */
 	uint32_t  block_fnum;	/* block+fnum      :                   */
 	uint8_t kcode;		/* key code        : KeyScaleCode      */
@@ -106,16 +100,16 @@ typedef struct fm_opl_f {
 	OPL_PORTHANDLER_W keyboardhandler_w;
 	int keyboard_param;
 	/* time tables */
-	INT32 AR_TABLE[75];	/* atttack rate tables */
-	INT32 DR_TABLE[75];	/* decay rate tables   */
+	int32_t AR_TABLE[75];	/* atttack rate tables */
+	int32_t DR_TABLE[75];	/* decay rate tables   */
 	uint32_t FN_TABLE[1024];  /* fnumber -> increment counter */
 	/* LFO */
-	INT32 *ams_table;
-	INT32 *vib_table;
-	INT32 amsCnt;
-	INT32 amsIncr;
-	INT32 vibCnt;
-	INT32 vibIncr;
+	int32_t *ams_table;
+	int32_t *vib_table;
+	int32_t amsCnt;
+	int32_t amsIncr;
+	int32_t vibCnt;
+	int32_t vibIncr;
 	/* wave selector enable flag */
 	uint8_t wavesel;
 	/* external event callback handler */
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index ebd3dbbf80..8f935f62b6 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -170,7 +170,7 @@ static const uint32_t KSL_TABLE[8*16]=
 /* sustain lebel table (3db per step) */
 /* 0 - 15: 0, 3, 6, 9,12,15,18,21,24,27,30,33,36,39,42,93 (dB)*/
 #define SC(db) (db*((3/EG_STEP)*(1<<ENV_BITS)))+EG_DST
-static const INT32 SL_TABLE[16]={
+static const int32_t SL_TABLE[16]={
  SC( 0),SC( 1),SC( 2),SC(3 ),SC(4 ),SC(5 ),SC(6 ),SC( 7),
  SC( 8),SC( 9),SC(10),SC(11),SC(12),SC(13),SC(14),SC(31)
 };
@@ -180,18 +180,18 @@ static const INT32 SL_TABLE[16]={
 /* TotalLevel : 48 24 12  6  3 1.5 0.75 (dB) */
 /* TL_TABLE[ 0      to TL_MAX          ] : plus  section */
 /* TL_TABLE[ TL_MAX to TL_MAX+TL_MAX-1 ] : minus section */
-static INT32 *TL_TABLE;
+static int32_t *TL_TABLE;
 
 /* pointers to TL_TABLE with sinwave output offset */
-static INT32 **SIN_TABLE;
+static int32_t **SIN_TABLE;
 
 /* LFO table */
-static INT32 *AMS_TABLE;
-static INT32 *VIB_TABLE;
+static int32_t *AMS_TABLE;
+static int32_t *VIB_TABLE;
 
 /* envelope output curve table */
 /* attack + decay + OFF */
-static INT32 ENV_CURVE[2*EG_ENT+1];
+static int32_t ENV_CURVE[2*EG_ENT+1];
 
 /* multiple table */
 #define ML 2
@@ -203,7 +203,7 @@ static const uint32_t MUL_TABLE[16]= {
 #undef ML
 
 /* dummy attack / decay rate ( when rate == 0 ) */
-static INT32 RATE_0[16]=
+static int32_t RATE_0[16]=
 {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
 
 /* -------------------- static state --------------------- */
@@ -219,14 +219,14 @@ static OPL_CH *S_CH;
 static OPL_CH *E_CH;
 static OPL_SLOT *SLOT7_1, *SLOT7_2, *SLOT8_1, *SLOT8_2;
 
-static INT32 outd[1];
-static INT32 ams;
-static INT32 vib;
-static INT32 *ams_table;
-static INT32 *vib_table;
-static INT32 amsIncr;
-static INT32 vibIncr;
-static INT32 feedback2;		/* connect for SLOT 2 */
+static int32_t outd[1];
+static int32_t ams;
+static int32_t vib;
+static int32_t *ams_table;
+static int32_t *vib_table;
+static int32_t amsIncr;
+static int32_t vibIncr;
+static int32_t feedback2;		/* connect for SLOT 2 */
 
 /* log output level */
 #define LOG_ERR  3      /* ERROR       */
@@ -359,7 +359,7 @@ static inline uint32_t OPL_CALC_SLOT( OPL_SLOT *SLOT )
 /* set algorithm connection */
 static void set_algorithm( OPL_CH *CH)
 {
-	INT32 *carrier = &outd[0];
+	int32_t *carrier = &outd[0];
 	CH->connect1 = CH->CON ? carrier : &feedback2;
 	CH->connect2 = carrier;
 }
@@ -498,7 +498,7 @@ static inline void OPL_CALC_RH( OPL_CH *CH )
 {
 	uint32_t env_tam,env_sd,env_top,env_hh;
 	int whitenoise = (rand()&1)*(WHITE_NOISE_db/EG_STEP);
-	INT32 tone8;
+	int32_t tone8;
 
 	OPL_SLOT *SLOT;
 	int env_out;
@@ -616,20 +616,20 @@ static int OPLOpenTable( void )
 	double pom;
 
 	/* allocate dynamic tables */
-	if( (TL_TABLE = malloc(TL_MAX*2*sizeof(INT32))) == NULL)
+	if( (TL_TABLE = malloc(TL_MAX*2*sizeof(int32_t))) == NULL)
 		return 0;
-	if( (SIN_TABLE = malloc(SIN_ENT*4 *sizeof(INT32 *))) == NULL)
+	if( (SIN_TABLE = malloc(SIN_ENT*4 *sizeof(int32_t *))) == NULL)
 	{
 		free(TL_TABLE);
 		return 0;
 	}
-	if( (AMS_TABLE = malloc(AMS_ENT*2 *sizeof(INT32))) == NULL)
+	if( (AMS_TABLE = malloc(AMS_ENT*2 *sizeof(int32_t))) == NULL)
 	{
 		free(TL_TABLE);
 		free(SIN_TABLE);
 		return 0;
 	}
-	if( (VIB_TABLE = malloc(VIB_ENT*2 *sizeof(INT32))) == NULL)
+	if( (VIB_TABLE = malloc(VIB_ENT*2 *sizeof(int32_t))) == NULL)
 	{
 		free(TL_TABLE);
 		free(SIN_TABLE);
-- 
2.9.3
