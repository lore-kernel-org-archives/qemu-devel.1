Received: from eggs.gnu.org ([2001:4830:134:3::10]:34628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1t-0001UA-W2
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6B1q-0004ZM-VQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6B1q-0004YR-Mp
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:18:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B98646198D
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 07:18:21 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  4 May 2017 09:17:52 +0200
Message-Id: <20170504071811.3547-12-kraxel@redhat.com>
In-Reply-To: <20170504071811.3547-1-kraxel@redhat.com>
References: <20170504071811.3547-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 11/30] audio: remove UINT32
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
Message-id: 20170425223739.6703-8-quintela@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/audio/fmopl.h | 17 ++++++++---------
 hw/audio/fmopl.c | 14 +++++++-------
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
index 1891a22349..b52f0392cb 100644
--- a/hw/audio/fmopl.h
+++ b/hw/audio/fmopl.h
@@ -10,7 +10,6 @@
 /* compiler dependence */
 #ifndef OSD_CPU_H
 #define OSD_CPU_H
-typedef unsigned int	UINT32;  /* unsigned 32bit */
 typedef signed char		INT8;    /* signed  8bit   */
 typedef signed short	INT16;   /* signed 16bit   */
 typedef signed int		INT32;   /* signed 32bit   */
@@ -48,9 +47,9 @@ typedef struct fm_opl_slot {
 	INT32 *RR;		/* release rate    :&DR_TABLE[RR<<2]   */
 	uint8_t ksl;		/* keyscale level  :(shift down bits)  */
 	uint8_t ksr;		/* key scale rate  :kcode>>KSR         */
-	UINT32 mul;		/* multiple        :ML_TABLE[ML]       */
-	UINT32 Cnt;		/* frequency count :                   */
-	UINT32 Incr;	/* frequency step  :                   */
+	uint32_t mul;		/* multiple        :ML_TABLE[ML]       */
+	uint32_t Cnt;		/* frequency count :                   */
+	uint32_t Incr;	/* frequency step  :                   */
 	/* envelope generator state */
 	uint8_t eg_typ;	/* envelope type flag                  */
 	uint8_t evm;		/* envelope phase                      */
@@ -76,10 +75,10 @@ typedef struct fm_opl_channel {
 	INT32 *connect2;	/* slot2 output pointer                */
 	INT32 op1_out[2];	/* slot1 output for selfeedback        */
 	/* phase generator state */
-	UINT32  block_fnum;	/* block+fnum      :                   */
+	uint32_t  block_fnum;	/* block+fnum      :                   */
 	uint8_t kcode;		/* key code        : KeyScaleCode      */
-	UINT32  fc;			/* Freq. Increment base                */
-	UINT32  ksl_base;	/* KeyScaleLevel Base step             */
+	uint32_t  fc;			/* Freq. Increment base                */
+	uint32_t  ksl_base;	/* KeyScaleLevel Base step             */
 	uint8_t keyon;		/* key on/off flag                     */
 } OPL_CH;
 
@@ -93,7 +92,7 @@ typedef struct fm_opl_f {
 	uint8_t address;		/* address register                  */
 	uint8_t status;		/* status flag                       */
 	uint8_t statusmask;	/* status mask                       */
-	UINT32 mode;		/* Reg.08 : CSM , notesel,etc.       */
+	uint32_t mode;		/* Reg.08 : CSM , notesel,etc.       */
 	/* Timer */
 	int T[2];			/* timer counter                     */
 	uint8_t st[2];		/* timer enable                      */
@@ -111,7 +110,7 @@ typedef struct fm_opl_f {
 	/* time tables */
 	INT32 AR_TABLE[75];	/* atttack rate tables */
 	INT32 DR_TABLE[75];	/* decay rate tables   */
-	UINT32 FN_TABLE[1024];  /* fnumber -> increment counter */
+	uint32_t FN_TABLE[1024];  /* fnumber -> increment counter */
 	/* LFO */
 	INT32 *ams_table;
 	INT32 *vib_table;
diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 3d14b455a7..47754e86b2 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -122,7 +122,7 @@ static const int slot_array[32]=
 /* key scale level */
 /* table is 3dB/OCT , DV converts this in TL step at 6dB/OCT */
 #define DV (EG_STEP/2)
-static const UINT32 KSL_TABLE[8*16]=
+static const uint32_t KSL_TABLE[8*16]=
 {
 	/* OCT 0 */
 	 0.000/DV, 0.000/DV, 0.000/DV, 0.000/DV,
@@ -195,7 +195,7 @@ static INT32 ENV_CURVE[2*EG_ENT+1];
 
 /* multiple table */
 #define ML 2
-static const UINT32 MUL_TABLE[16]= {
+static const uint32_t MUL_TABLE[16]= {
 /* 1/2, 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15 */
    0.50*ML, 1.00*ML, 2.00*ML, 3.00*ML, 4.00*ML, 5.00*ML, 6.00*ML, 7.00*ML,
    8.00*ML, 9.00*ML,10.00*ML,10.00*ML,12.00*ML,12.00*ML,15.00*ML,15.00*ML
@@ -319,7 +319,7 @@ static inline void OPL_KEYOFF(OPL_SLOT *SLOT)
 
 /* ---------- calcrate Envelope Generator & Phase Generator ---------- */
 /* return : envelope output */
-static inline UINT32 OPL_CALC_SLOT( OPL_SLOT *SLOT )
+static inline uint32_t OPL_CALC_SLOT( OPL_SLOT *SLOT )
 {
 	/* calcrate envelope generator */
 	if( (SLOT->evc+=SLOT->evs) >= SLOT->eve )
@@ -451,7 +451,7 @@ static inline void set_sl_rr(FM_OPL *OPL,int slot,int v)
 /* ---------- calcrate one of channel ---------- */
 static inline void OPL_CALC_CH( OPL_CH *CH )
 {
-	UINT32 env_out;
+	uint32_t env_out;
 	OPL_SLOT *SLOT;
 
 	feedback2 = 0;
@@ -496,7 +496,7 @@ static inline void OPL_CALC_CH( OPL_CH *CH )
 #define WHITE_NOISE_db 6.0
 static inline void OPL_CALC_RH( OPL_CH *CH )
 {
-	UINT32 env_tam,env_sd,env_top,env_hh;
+	uint32_t env_tam,env_sd,env_top,env_hh;
 	int whitenoise = (rand()&1)*(WHITE_NOISE_db/EG_STEP);
 	INT32 tone8;
 
@@ -989,8 +989,8 @@ void YM3812UpdateOne(FM_OPL *OPL, INT16 *buffer, int length)
     int i;
 	int data;
 	OPLSAMPLE *buf = buffer;
-	UINT32 amsCnt  = OPL->amsCnt;
-	UINT32 vibCnt  = OPL->vibCnt;
+	uint32_t amsCnt  = OPL->amsCnt;
+	uint32_t  vibCnt  = OPL->vibCnt;
 	uint8_t rhythm = OPL->rhythm&0x20;
 	OPL_CH *CH,*R_CH;
 
-- 
2.9.3
