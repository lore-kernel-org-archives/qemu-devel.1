Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_YAHOO_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FCEC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:27:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1992A20728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 18:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="MzhaU1m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1992A20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=yahoo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isWL4-0005qp-8O
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 13:27:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liewkj@yahoo.com>) id 1isWKF-00050q-Mv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liewkj@yahoo.com>) id 1isWKA-0007B9-M3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:26:31 -0500
Received: from sonic310-24.consmr.mail.ne1.yahoo.com ([66.163.186.205]:36213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liewkj@yahoo.com>) id 1isWKA-0007AB-HD
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 13:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1579285585; bh=xm5FYwtSgINxrZCgUNPJWpqKAU6luAW6mvgPqAjV22k=;
 h=Date:From:To:Subject:References:From:Subject;
 b=MzhaU1m6gI/dHhjtWhnjKg5X/mHjQgRhnJLwmD8gIi4Rn0+BoQA6LqCxb0WG5pZLwhD78Hq1YuYHVO181XogoN7RpJ08/gHmnlkScnJHpxUxfTWGwkvpnfzMrY51gdipu/TNtpA0fox2wwRZZyWO8TmJVVvGJZmrFn17ybAq+FDK8fHC79U66PcWImOM0z0yTkCgiiyLHdlw0apQNKOXzh3LX1nzlnkNrIskbLugDlcGSrXf7FfNo4U9nZyLtesCaB/y6yPckUB8RkddxW4/HE63xhrvlJybqqAEN8PRixiMVIi5uAdUIdcI9YCGeUfbUyiFXSWz2PawjwttSSSIxw==
X-YMail-OSG: rTY2390VM1m0dMk48sjMqHthtoijmAoB7maUfLsvlrmZNni2dxVYOa2.MXLK9Lu
 g6CLnCS_lzB4U0NKMVx2BYa2Vv8B9dJ_xcjai_LHLJNMZtXs_wG35FMA5ceTHdyGyRXKKdVAfauf
 5Jcx6mE38kPZmHDnHC3ARX4boWVVPotUHGN9TYlIIpPTRODiAOQY764z9O89rNHAk748fBUZAJ.7
 TlZ9Zfn5Z9vDh8M5sPcBXjYnBirwYUQnljPguoXUPUbwrAyj3R6Japym6JcIGPzcVgUS8m83gVOk
 MBwEk6zaREhrv7J0mRWNnmHmztSjIjBrPjOn0OM7lnEH_FKPFKyo6F7bAaYhR0wFgX3SQXC_cPtq
 KQGVzHJitNltoZ.Dl8YwJeNKtWxFMMQdeLtRTdn_ugxwQblgBmSZ8QF44KvzNAsrO.6.7SGSnkcG
 Utc6Iy1dF88vl54951eIwmXkRFxmV3X2lR9NEk.gfCJous6F3fTzHUl0A8zrdDnnFCVHUNMRpvET
 z0OEsYXMHMQV7Kq_5AMWT9JNK9xNQc_x9JTdcvylh74jmZso_DQwD44N69G2muBtDzvc_E_aiUTV
 v.XmfJezJUXlu2ffCHyTY9FheV7KlGK_Hofoi.T.JwVR0Jw9WxnBLTorSBen6N8LPkUI.ngQVslU
 Gk4sCgnJU2.taucWzyRPM6Vty8KfBH56KHIpRNdDLKOJV9YV2Oqt32nMe7P2naYkWpMLWYPDM7nL
 fTXyT5xcwjTC4Ma6yg6Aa2r7STzcPMYtv6eIDe90vchmPehzvgTSMtyH48gPkQbQzJElEie8HL7k
 4cIrjFKMcDfQhEsp1snXSFrMz84CJ.i9V6R7C_wujrozcZAhSI_EYH08tq9vSc7QlYfgf54cKhAH
 rxeQBu88rSNzWKL95CwN3g5QZLYHHJmo2az0wFc_nn59Sowr6TesP8wwMREdQJciL84YAcog.1Gf
 kraTcRAv9y6UbyZKBXVd.AP8OYMLZHg0sokfGRUXd.BGKuOJf.5Dbnc4PuOSy7PQPnmgtc0GwM68
 StI9242RVNoFzRO4yaqmtCBzEcyMFoRKnrFKxN_IjpO7g_L_SYieIjS2ucwVRetXFeIjeAIlwjku
 sLTJbbaOx6.rVqs9fiCtoUcyDKrKwuVMph9H0bKe6HuL7QfBQ6RHz0bBiJ56azmfx_hGYP4SP2YY
 _9SWqCN4R5rFne5h3J44NQVK9hUuIl06C6L2h52fXAI6ZjGOqRHEUIDqVu10GBnVEcDADLKcvH3p
 PXkt6ZrQ_TlqYWbel1Mnp09WFaaCPgdpF9rHvPGppOg39GOzY7g5hSyEcjlhG4A6.SUOBsKGV3yf
 3cqFewzflpWsjcPXUlYXqB1U6mzq_NDBcWwXGOa5ykeQO8DAijnvvHLj8v7Id2z3fYWLggQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 17 Jan 2020 18:26:25 +0000
Received: by smtp430.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID ddc13d78cfad84e37aab329e7a6a0888; 
 Fri, 17 Jan 2020 18:26:23 +0000 (UTC)
Date: Fri, 17 Jan 2020 10:26:21 -0800
From: KJ Liew <liewkj@yahoo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] audio/dsound: fix invalid parameters error
Message-ID: <20200117182621.GB13724@chuwi-lt0>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
References: <20200117182621.GB13724.ref@chuwi-lt0>
X-Mailer: WebService/1.1.15077 hermes Apache-HttpAsyncClient/4.1.4
 (Java/1.8.0_181)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 66.163.186.205
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

QEMU Windows has broken dsound backend since the rewrite of audio API in
version 4.2.0. Both playback and capture buffers failed to lock with
invalid parameters error.

--- ../orig/qemu-4.2.0/audio/dsoundaudio.c	2019-12-12 10:20:47.000000000 -0800
+++ ../qemu-4.2.0/audio/dsoundaudio.c	2020-01-17 08:05:46.783966900 -0800
@@ -53,6 +53,7 @@
 typedef struct {
     HWVoiceOut hw;
     LPDIRECTSOUNDBUFFER dsound_buffer;
+    void *last_buf;
     dsound *s;
 } DSoundVoiceOut;
 
@@ -414,10 +415,10 @@
     DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
     LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
     HRESULT hr;
-    DWORD ppos, act_size;
+    DWORD ppos, act_size, last_size;
     size_t req_size;
     int err;
-    void *ret;
+    void *ret, *last_ret;
 
     hr = IDirectSoundBuffer_GetCurrentPosition(dsb, &ppos, NULL);
     if (FAILED(hr)) {
@@ -426,17 +427,24 @@
         return NULL;
     }
 
+    if (ppos == hw->pos_emul) {
+        *size = 0;
+        return ds->last_buf;
+    }
+
     req_size = audio_ring_dist(ppos, hw->pos_emul, hw->size_emul);
     req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
 
-    err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
-                          &act_size, NULL, false, ds->s);
+    err = dsound_lock_out(dsb, &hw->info, hw->pos_emul, req_size, &ret, &last_ret,
+                          &act_size, &last_size, false, ds->s);
     if (err) {
         dolog("Failed to lock buffer\n");
         *size = 0;
         return NULL;
     }
 
+    ds->last_buf = g_realloc(ds->last_buf, act_size);
+    memcpy(ds->last_buf, ret, act_size);
     *size = act_size;
     return ret;
 }
@@ -445,6 +453,8 @@
 {
     DSoundVoiceOut *ds = (DSoundVoiceOut *) hw;
     LPDIRECTSOUNDBUFFER dsb = ds->dsound_buffer;
+    if (len == 0)
+        return 0;
     int err = dsound_unlock_out(dsb, buf, NULL, len, 0);
 
     if (err) {
@@ -508,10 +518,10 @@
     DSoundVoiceIn *ds = (DSoundVoiceIn *) hw;
     LPDIRECTSOUNDCAPTUREBUFFER dscb = ds->dsound_capture_buffer;
     HRESULT hr;
-    DWORD cpos, act_size;
+    DWORD cpos, act_size, last_size;
     size_t req_size;
     int err;
-    void *ret;
+    void *ret, *last_ret;
 
     hr = IDirectSoundCaptureBuffer_GetCurrentPosition(dscb, &cpos, NULL);
     if (FAILED(hr)) {
@@ -520,11 +530,16 @@
         return NULL;
     }
 
+    if (cpos == hw->pos_emul) {
+        *size = 0;
+        return NULL;
+    }
+
     req_size = audio_ring_dist(cpos, hw->pos_emul, hw->size_emul);
     req_size = MIN(req_size, hw->size_emul - hw->pos_emul);
 
-    err = dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, &ret, NULL,
-                         &act_size, NULL, false, ds->s);
+    err = dsound_lock_in(dscb, &hw->info, hw->pos_emul, req_size, &ret, &last_ret,
+                         &act_size, &last_size, false, ds->s);
     if (err) {
         dolog("Failed to lock buffer\n");
         *size = 0;

