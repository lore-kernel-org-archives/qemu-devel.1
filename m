Received: from eggs.gnu.org ([209.51.188.92]:52102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyu-00058V-N1
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyc-0004jo-NF
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:23 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldyW-0004eL-5Q
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:07:09 -0500
Received: by mail-wm1-x344.google.com with SMTP id b11so11732300wmj.1
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:07:07 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	133sm56197732wme.9.2019.01.21.10.07.04 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 Jan 2019 10:07:04 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:06:14 +0100
Message-Id: <1548093980-43088-44-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 43/49] crypto: finish removing TABs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Suggested-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 crypto/aes.c    | 414 +++++++++++++++++++--------------------
 crypto/desrfb.c | 594 ++++++++++++++++++++++++++++----------------------------
 2 files changed, 504 insertions(+), 504 deletions(-)

diff --git a/crypto/aes.c b/crypto/aes.c
index 773d246..86b3092 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1059,109 +1059,109 @@ const uint32_t AES_Td4[256] = {
     0x55555555U, 0x21212121U, 0x0c0c0c0cU, 0x7d7d7d7dU,
 };
 static const u32 rcon[] = {
-	0x01000000, 0x02000000, 0x04000000, 0x08000000,
-	0x10000000, 0x20000000, 0x40000000, 0x80000000,
-	0x1B000000, 0x36000000, /* for 128-bit blocks, Rijndael never uses more than 10 rcon values */
+        0x01000000, 0x02000000, 0x04000000, 0x08000000,
+        0x10000000, 0x20000000, 0x40000000, 0x80000000,
+        0x1B000000, 0x36000000, /* for 128-bit blocks, Rijndael never uses more than 10 rcon values */
 };
 
 /**
  * Expand the cipher key into the encryption key schedule.
  */
 int AES_set_encrypt_key(const unsigned char *userKey, const int bits,
-			AES_KEY *key) {
+                        AES_KEY *key) {
 
-	u32 *rk;
-	int i = 0;
-	u32 temp;
+        u32 *rk;
+        int i = 0;
+        u32 temp;
 
-	if (!userKey || !key)
-		return -1;
-	if (bits != 128 && bits != 192 && bits != 256)
-		return -2;
+        if (!userKey || !key)
+                return -1;
+        if (bits != 128 && bits != 192 && bits != 256)
+                return -2;
 
-	rk = key->rd_key;
+        rk = key->rd_key;
 
-	if (bits==128)
-		key->rounds = 10;
-	else if (bits==192)
-		key->rounds = 12;
-	else
-		key->rounds = 14;
+        if (bits==128)
+                key->rounds = 10;
+        else if (bits==192)
+                key->rounds = 12;
+        else
+                key->rounds = 14;
 
-	rk[0] = GETU32(userKey     );
-	rk[1] = GETU32(userKey +  4);
-	rk[2] = GETU32(userKey +  8);
-	rk[3] = GETU32(userKey + 12);
-	if (bits == 128) {
-		while (1) {
-			temp  = rk[3];
-			rk[4] = rk[0] ^
+        rk[0] = GETU32(userKey     );
+        rk[1] = GETU32(userKey +  4);
+        rk[2] = GETU32(userKey +  8);
+        rk[3] = GETU32(userKey + 12);
+        if (bits == 128) {
+                while (1) {
+                        temp  = rk[3];
+                        rk[4] = rk[0] ^
                                 (AES_Te4[(temp >> 16) & 0xff] & 0xff000000) ^
                                 (AES_Te4[(temp >>  8) & 0xff] & 0x00ff0000) ^
                                 (AES_Te4[(temp      ) & 0xff] & 0x0000ff00) ^
                                 (AES_Te4[(temp >> 24)       ] & 0x000000ff) ^
-				rcon[i];
-			rk[5] = rk[1] ^ rk[4];
-			rk[6] = rk[2] ^ rk[5];
-			rk[7] = rk[3] ^ rk[6];
-			if (++i == 10) {
-				return 0;
-			}
-			rk += 4;
-		}
-	}
-	rk[4] = GETU32(userKey + 16);
-	rk[5] = GETU32(userKey + 20);
-	if (bits == 192) {
-		while (1) {
-			temp = rk[ 5];
-			rk[ 6] = rk[ 0] ^
+                                rcon[i];
+                        rk[5] = rk[1] ^ rk[4];
+                        rk[6] = rk[2] ^ rk[5];
+                        rk[7] = rk[3] ^ rk[6];
+                        if (++i == 10) {
+                                return 0;
+                        }
+                        rk += 4;
+                }
+        }
+        rk[4] = GETU32(userKey + 16);
+        rk[5] = GETU32(userKey + 20);
+        if (bits == 192) {
+                while (1) {
+                        temp = rk[ 5];
+                        rk[ 6] = rk[ 0] ^
                                 (AES_Te4[(temp >> 16) & 0xff] & 0xff000000) ^
                                 (AES_Te4[(temp >>  8) & 0xff] & 0x00ff0000) ^
                                 (AES_Te4[(temp      ) & 0xff] & 0x0000ff00) ^
                                 (AES_Te4[(temp >> 24)       ] & 0x000000ff) ^
-				rcon[i];
-			rk[ 7] = rk[ 1] ^ rk[ 6];
-			rk[ 8] = rk[ 2] ^ rk[ 7];
-			rk[ 9] = rk[ 3] ^ rk[ 8];
-			if (++i == 8) {
-				return 0;
-			}
-			rk[10] = rk[ 4] ^ rk[ 9];
-			rk[11] = rk[ 5] ^ rk[10];
-			rk += 6;
-		}
-	}
-	rk[6] = GETU32(userKey + 24);
-	rk[7] = GETU32(userKey + 28);
-	if (bits == 256) {
-		while (1) {
-			temp = rk[ 7];
-			rk[ 8] = rk[ 0] ^
+                                rcon[i];
+                        rk[ 7] = rk[ 1] ^ rk[ 6];
+                        rk[ 8] = rk[ 2] ^ rk[ 7];
+                        rk[ 9] = rk[ 3] ^ rk[ 8];
+                        if (++i == 8) {
+                                return 0;
+                        }
+                        rk[10] = rk[ 4] ^ rk[ 9];
+                        rk[11] = rk[ 5] ^ rk[10];
+                        rk += 6;
+                }
+        }
+        rk[6] = GETU32(userKey + 24);
+        rk[7] = GETU32(userKey + 28);
+        if (bits == 256) {
+                while (1) {
+                        temp = rk[ 7];
+                        rk[ 8] = rk[ 0] ^
                                 (AES_Te4[(temp >> 16) & 0xff] & 0xff000000) ^
                                 (AES_Te4[(temp >>  8) & 0xff] & 0x00ff0000) ^
                                 (AES_Te4[(temp      ) & 0xff] & 0x0000ff00) ^
                                 (AES_Te4[(temp >> 24)       ] & 0x000000ff) ^
-				rcon[i];
-			rk[ 9] = rk[ 1] ^ rk[ 8];
-			rk[10] = rk[ 2] ^ rk[ 9];
-			rk[11] = rk[ 3] ^ rk[10];
-			if (++i == 7) {
-				return 0;
-			}
-			temp = rk[11];
-			rk[12] = rk[ 4] ^
+                                rcon[i];
+                        rk[ 9] = rk[ 1] ^ rk[ 8];
+                        rk[10] = rk[ 2] ^ rk[ 9];
+                        rk[11] = rk[ 3] ^ rk[10];
+                        if (++i == 7) {
+                                return 0;
+                        }
+                        temp = rk[11];
+                        rk[12] = rk[ 4] ^
                                 (AES_Te4[(temp >> 24)       ] & 0xff000000) ^
                                 (AES_Te4[(temp >> 16) & 0xff] & 0x00ff0000) ^
                                 (AES_Te4[(temp >>  8) & 0xff] & 0x0000ff00) ^
                                 (AES_Te4[(temp      ) & 0xff] & 0x000000ff);
-			rk[13] = rk[ 5] ^ rk[12];
-			rk[14] = rk[ 6] ^ rk[13];
-			rk[15] = rk[ 7] ^ rk[14];
+                        rk[13] = rk[ 5] ^ rk[12];
+                        rk[14] = rk[ 6] ^ rk[13];
+                        rk[15] = rk[ 7] ^ rk[14];
 
-			rk += 8;
-		}
-	}
+                        rk += 8;
+                }
+        }
         abort();
 }
 
@@ -1169,51 +1169,51 @@ int AES_set_encrypt_key(const unsigned char *userKey, const int bits,
  * Expand the cipher key into the decryption key schedule.
  */
 int AES_set_decrypt_key(const unsigned char *userKey, const int bits,
-			 AES_KEY *key) {
+                         AES_KEY *key) {
 
         u32 *rk;
-	int i, j, status;
-	u32 temp;
+        int i, j, status;
+        u32 temp;
 
-	/* first, start with an encryption schedule */
-	status = AES_set_encrypt_key(userKey, bits, key);
-	if (status < 0)
-		return status;
+        /* first, start with an encryption schedule */
+        status = AES_set_encrypt_key(userKey, bits, key);
+        if (status < 0)
+                return status;
 
-	rk = key->rd_key;
+        rk = key->rd_key;
 
-	/* invert the order of the round keys: */
-	for (i = 0, j = 4*(key->rounds); i < j; i += 4, j -= 4) {
-		temp = rk[i    ]; rk[i    ] = rk[j    ]; rk[j    ] = temp;
-		temp = rk[i + 1]; rk[i + 1] = rk[j + 1]; rk[j + 1] = temp;
-		temp = rk[i + 2]; rk[i + 2] = rk[j + 2]; rk[j + 2] = temp;
-		temp = rk[i + 3]; rk[i + 3] = rk[j + 3]; rk[j + 3] = temp;
-	}
-	/* apply the inverse MixColumn transform to all round keys but the first and the last: */
-	for (i = 1; i < (key->rounds); i++) {
-		rk += 4;
-		rk[0] =
+        /* invert the order of the round keys: */
+        for (i = 0, j = 4*(key->rounds); i < j; i += 4, j -= 4) {
+                temp = rk[i    ]; rk[i    ] = rk[j    ]; rk[j    ] = temp;
+                temp = rk[i + 1]; rk[i + 1] = rk[j + 1]; rk[j + 1] = temp;
+                temp = rk[i + 2]; rk[i + 2] = rk[j + 2]; rk[j + 2] = temp;
+                temp = rk[i + 3]; rk[i + 3] = rk[j + 3]; rk[j + 3] = temp;
+        }
+        /* apply the inverse MixColumn transform to all round keys but the first and the last: */
+        for (i = 1; i < (key->rounds); i++) {
+                rk += 4;
+                rk[0] =
                         AES_Td0[AES_Te4[(rk[0] >> 24)       ] & 0xff] ^
                         AES_Td1[AES_Te4[(rk[0] >> 16) & 0xff] & 0xff] ^
                         AES_Td2[AES_Te4[(rk[0] >>  8) & 0xff] & 0xff] ^
                         AES_Td3[AES_Te4[(rk[0]      ) & 0xff] & 0xff];
-		rk[1] =
+                rk[1] =
                         AES_Td0[AES_Te4[(rk[1] >> 24)       ] & 0xff] ^
                         AES_Td1[AES_Te4[(rk[1] >> 16) & 0xff] & 0xff] ^
                         AES_Td2[AES_Te4[(rk[1] >>  8) & 0xff] & 0xff] ^
                         AES_Td3[AES_Te4[(rk[1]      ) & 0xff] & 0xff];
-		rk[2] =
+                rk[2] =
                         AES_Td0[AES_Te4[(rk[2] >> 24)       ] & 0xff] ^
                         AES_Td1[AES_Te4[(rk[2] >> 16) & 0xff] & 0xff] ^
                         AES_Td2[AES_Te4[(rk[2] >>  8) & 0xff] & 0xff] ^
                         AES_Td3[AES_Te4[(rk[2]      ) & 0xff] & 0xff];
-		rk[3] =
+                rk[3] =
                         AES_Td0[AES_Te4[(rk[3] >> 24)       ] & 0xff] ^
                         AES_Td1[AES_Te4[(rk[3] >> 16) & 0xff] & 0xff] ^
                         AES_Td2[AES_Te4[(rk[3] >>  8) & 0xff] & 0xff] ^
                         AES_Td3[AES_Te4[(rk[3]      ) & 0xff] & 0xff];
-	}
-	return 0;
+        }
+        return 0;
 }
 
 #ifndef AES_ASM
@@ -1222,67 +1222,67 @@ int AES_set_decrypt_key(const unsigned char *userKey, const int bits,
  * in and out can overlap
  */
 void AES_encrypt(const unsigned char *in, unsigned char *out,
-		 const AES_KEY *key) {
+                 const AES_KEY *key) {
 
-	const u32 *rk;
-	u32 s0, s1, s2, s3, t0, t1, t2, t3;
+        const u32 *rk;
+        u32 s0, s1, s2, s3, t0, t1, t2, t3;
 #ifndef FULL_UNROLL
-	int r;
+        int r;
 #endif /* ?FULL_UNROLL */
 
-	assert(in && out && key);
-	rk = key->rd_key;
+        assert(in && out && key);
+        rk = key->rd_key;
 
-	/*
-	 * map byte array block to cipher state
-	 * and add initial round key:
-	 */
-	s0 = GETU32(in     ) ^ rk[0];
-	s1 = GETU32(in +  4) ^ rk[1];
-	s2 = GETU32(in +  8) ^ rk[2];
-	s3 = GETU32(in + 12) ^ rk[3];
+        /*
+         * map byte array block to cipher state
+         * and add initial round key:
+         */
+        s0 = GETU32(in     ) ^ rk[0];
+        s1 = GETU32(in +  4) ^ rk[1];
+        s2 = GETU32(in +  8) ^ rk[2];
+        s3 = GETU32(in + 12) ^ rk[3];
 #ifdef FULL_UNROLL
-	/* round 1: */
+        /* round 1: */
         t0 = AES_Te0[s0 >> 24] ^ AES_Te1[(s1 >> 16) & 0xff] ^ AES_Te2[(s2 >>  8) & 0xff] ^ AES_Te3[s3 & 0xff] ^ rk[ 4];
         t1 = AES_Te0[s1 >> 24] ^ AES_Te1[(s2 >> 16) & 0xff] ^ AES_Te2[(s3 >>  8) & 0xff] ^ AES_Te3[s0 & 0xff] ^ rk[ 5];
         t2 = AES_Te0[s2 >> 24] ^ AES_Te1[(s3 >> 16) & 0xff] ^ AES_Te2[(s0 >>  8) & 0xff] ^ AES_Te3[s1 & 0xff] ^ rk[ 6];
         t3 = AES_Te0[s3 >> 24] ^ AES_Te1[(s0 >> 16) & 0xff] ^ AES_Te2[(s1 >>  8) & 0xff] ^ AES_Te3[s2 & 0xff] ^ rk[ 7];
-	/* round 2: */
+        /* round 2: */
         s0 = AES_Te0[t0 >> 24] ^ AES_Te1[(t1 >> 16) & 0xff] ^ AES_Te2[(t2 >>  8) & 0xff] ^ AES_Te3[t3 & 0xff] ^ rk[ 8];
         s1 = AES_Te0[t1 >> 24] ^ AES_Te1[(t2 >> 16) & 0xff] ^ AES_Te2[(t3 >>  8) & 0xff] ^ AES_Te3[t0 & 0xff] ^ rk[ 9];
         s2 = AES_Te0[t2 >> 24] ^ AES_Te1[(t3 >> 16) & 0xff] ^ AES_Te2[(t0 >>  8) & 0xff] ^ AES_Te3[t1 & 0xff] ^ rk[10];
         s3 = AES_Te0[t3 >> 24] ^ AES_Te1[(t0 >> 16) & 0xff] ^ AES_Te2[(t1 >>  8) & 0xff] ^ AES_Te3[t2 & 0xff] ^ rk[11];
-	/* round 3: */
+        /* round 3: */
         t0 = AES_Te0[s0 >> 24] ^ AES_Te1[(s1 >> 16) & 0xff] ^ AES_Te2[(s2 >>  8) & 0xff] ^ AES_Te3[s3 & 0xff] ^ rk[12];
         t1 = AES_Te0[s1 >> 24] ^ AES_Te1[(s2 >> 16) & 0xff] ^ AES_Te2[(s3 >>  8) & 0xff] ^ AES_Te3[s0 & 0xff] ^ rk[13];
         t2 = AES_Te0[s2 >> 24] ^ AES_Te1[(s3 >> 16) & 0xff] ^ AES_Te2[(s0 >>  8) & 0xff] ^ AES_Te3[s1 & 0xff] ^ rk[14];
         t3 = AES_Te0[s3 >> 24] ^ AES_Te1[(s0 >> 16) & 0xff] ^ AES_Te2[(s1 >>  8) & 0xff] ^ AES_Te3[s2 & 0xff] ^ rk[15];
-	/* round 4: */
+        /* round 4: */
         s0 = AES_Te0[t0 >> 24] ^ AES_Te1[(t1 >> 16) & 0xff] ^ AES_Te2[(t2 >>  8) & 0xff] ^ AES_Te3[t3 & 0xff] ^ rk[16];
         s1 = AES_Te0[t1 >> 24] ^ AES_Te1[(t2 >> 16) & 0xff] ^ AES_Te2[(t3 >>  8) & 0xff] ^ AES_Te3[t0 & 0xff] ^ rk[17];
         s2 = AES_Te0[t2 >> 24] ^ AES_Te1[(t3 >> 16) & 0xff] ^ AES_Te2[(t0 >>  8) & 0xff] ^ AES_Te3[t1 & 0xff] ^ rk[18];
         s3 = AES_Te0[t3 >> 24] ^ AES_Te1[(t0 >> 16) & 0xff] ^ AES_Te2[(t1 >>  8) & 0xff] ^ AES_Te3[t2 & 0xff] ^ rk[19];
-	/* round 5: */
+        /* round 5: */
         t0 = AES_Te0[s0 >> 24] ^ AES_Te1[(s1 >> 16) & 0xff] ^ AES_Te2[(s2 >>  8) & 0xff] ^ AES_Te3[s3 & 0xff] ^ rk[20];
         t1 = AES_Te0[s1 >> 24] ^ AES_Te1[(s2 >> 16) & 0xff] ^ AES_Te2[(s3 >>  8) & 0xff] ^ AES_Te3[s0 & 0xff] ^ rk[21];
         t2 = AES_Te0[s2 >> 24] ^ AES_Te1[(s3 >> 16) & 0xff] ^ AES_Te2[(s0 >>  8) & 0xff] ^ AES_Te3[s1 & 0xff] ^ rk[22];
         t3 = AES_Te0[s3 >> 24] ^ AES_Te1[(s0 >> 16) & 0xff] ^ AES_Te2[(s1 >>  8) & 0xff] ^ AES_Te3[s2 & 0xff] ^ rk[23];
-	/* round 6: */
+        /* round 6: */
         s0 = AES_Te0[t0 >> 24] ^ AES_Te1[(t1 >> 16) & 0xff] ^ AES_Te2[(t2 >>  8) & 0xff] ^ AES_Te3[t3 & 0xff] ^ rk[24];
         s1 = AES_Te0[t1 >> 24] ^ AES_Te1[(t2 >> 16) & 0xff] ^ AES_Te2[(t3 >>  8) & 0xff] ^ AES_Te3[t0 & 0xff] ^ rk[25];
         s2 = AES_Te0[t2 >> 24] ^ AES_Te1[(t3 >> 16) & 0xff] ^ AES_Te2[(t0 >>  8) & 0xff] ^ AES_Te3[t1 & 0xff] ^ rk[26];
         s3 = AES_Te0[t3 >> 24] ^ AES_Te1[(t0 >> 16) & 0xff] ^ AES_Te2[(t1 >>  8) & 0xff] ^ AES_Te3[t2 & 0xff] ^ rk[27];
-	/* round 7: */
+        /* round 7: */
         t0 = AES_Te0[s0 >> 24] ^ AES_Te1[(s1 >> 16) & 0xff] ^ AES_Te2[(s2 >>  8) & 0xff] ^ AES_Te3[s3 & 0xff] ^ rk[28];
         t1 = AES_Te0[s1 >> 24] ^ AES_Te1[(s2 >> 16) & 0xff] ^ AES_Te2[(s3 >>  8) & 0xff] ^ AES_Te3[s0 & 0xff] ^ rk[29];
         t2 = AES_Te0[s2 >> 24] ^ AES_Te1[(s3 >> 16) & 0xff] ^ AES_Te2[(s0 >>  8) & 0xff] ^ AES_Te3[s1 & 0xff] ^ rk[30];
         t3 = AES_Te0[s3 >> 24] ^ AES_Te1[(s0 >> 16) & 0xff] ^ AES_Te2[(s1 >>  8) & 0xff] ^ AES_Te3[s2 & 0xff] ^ rk[31];
-	/* round 8: */
+        /* round 8: */
         s0 = AES_Te0[t0 >> 24] ^ AES_Te1[(t1 >> 16) & 0xff] ^ AES_Te2[(t2 >>  8) & 0xff] ^ AES_Te3[t3 & 0xff] ^ rk[32];
         s1 = AES_Te0[t1 >> 24] ^ AES_Te1[(t2 >> 16) & 0xff] ^ AES_Te2[(t3 >>  8) & 0xff] ^ AES_Te3[t0 & 0xff] ^ rk[33];
         s2 = AES_Te0[t2 >> 24] ^ AES_Te1[(t3 >> 16) & 0xff] ^ AES_Te2[(t0 >>  8) & 0xff] ^ AES_Te3[t1 & 0xff] ^ rk[34];
         s3 = AES_Te0[t3 >> 24] ^ AES_Te1[(t0 >> 16) & 0xff] ^ AES_Te2[(t1 >>  8) & 0xff] ^ AES_Te3[t2 & 0xff] ^ rk[35];
-	/* round 9: */
+        /* round 9: */
         t0 = AES_Te0[s0 >> 24] ^ AES_Te1[(s1 >> 16) & 0xff] ^ AES_Te2[(s2 >>  8) & 0xff] ^ AES_Te3[s3 & 0xff] ^ rk[36];
         t1 = AES_Te0[s1 >> 24] ^ AES_Te1[(s2 >> 16) & 0xff] ^ AES_Te2[(s3 >>  8) & 0xff] ^ AES_Te3[s0 & 0xff] ^ rk[37];
         t2 = AES_Te0[s2 >> 24] ^ AES_Te1[(s3 >> 16) & 0xff] ^ AES_Te2[(s0 >>  8) & 0xff] ^ AES_Te3[s1 & 0xff] ^ rk[38];
@@ -1375,37 +1375,37 @@ void AES_encrypt(const unsigned char *in, unsigned char *out,
     }
 #endif /* ?FULL_UNROLL */
     /*
-	 * apply last round and
-	 * map cipher state to byte array block:
-	 */
-	s0 =
+         * apply last round and
+         * map cipher state to byte array block:
+         */
+        s0 =
                 (AES_Te4[(t0 >> 24)       ] & 0xff000000) ^
                 (AES_Te4[(t1 >> 16) & 0xff] & 0x00ff0000) ^
                 (AES_Te4[(t2 >>  8) & 0xff] & 0x0000ff00) ^
                 (AES_Te4[(t3      ) & 0xff] & 0x000000ff) ^
-		rk[0];
-	PUTU32(out     , s0);
-	s1 =
+                rk[0];
+        PUTU32(out     , s0);
+        s1 =
                 (AES_Te4[(t1 >> 24)       ] & 0xff000000) ^
                 (AES_Te4[(t2 >> 16) & 0xff] & 0x00ff0000) ^
                 (AES_Te4[(t3 >>  8) & 0xff] & 0x0000ff00) ^
                 (AES_Te4[(t0      ) & 0xff] & 0x000000ff) ^
-		rk[1];
-	PUTU32(out +  4, s1);
-	s2 =
+                rk[1];
+        PUTU32(out +  4, s1);
+        s2 =
                 (AES_Te4[(t2 >> 24)       ] & 0xff000000) ^
                 (AES_Te4[(t3 >> 16) & 0xff] & 0x00ff0000) ^
                 (AES_Te4[(t0 >>  8) & 0xff] & 0x0000ff00) ^
                 (AES_Te4[(t1      ) & 0xff] & 0x000000ff) ^
-		rk[2];
-	PUTU32(out +  8, s2);
-	s3 =
+                rk[2];
+        PUTU32(out +  8, s2);
+        s3 =
                 (AES_Te4[(t3 >> 24)       ] & 0xff000000) ^
                 (AES_Te4[(t0 >> 16) & 0xff] & 0x00ff0000) ^
                 (AES_Te4[(t1 >>  8) & 0xff] & 0x0000ff00) ^
                 (AES_Te4[(t2      ) & 0xff] & 0x000000ff) ^
-		rk[3];
-	PUTU32(out + 12, s3);
+                rk[3];
+        PUTU32(out + 12, s3);
 }
 
 /*
@@ -1413,21 +1413,21 @@ void AES_encrypt(const unsigned char *in, unsigned char *out,
  * in and out can overlap
  */
 void AES_decrypt(const unsigned char *in, unsigned char *out,
-		 const AES_KEY *key) {
+                 const AES_KEY *key) {
 
-	const u32 *rk;
-	u32 s0, s1, s2, s3, t0, t1, t2, t3;
+        const u32 *rk;
+        u32 s0, s1, s2, s3, t0, t1, t2, t3;
 #ifndef FULL_UNROLL
-	int r;
+        int r;
 #endif /* ?FULL_UNROLL */
 
-	assert(in && out && key);
-	rk = key->rd_key;
+        assert(in && out && key);
+        rk = key->rd_key;
 
-	/*
-	 * map byte array block to cipher state
-	 * and add initial round key:
-	 */
+        /*
+         * map byte array block to cipher state
+         * and add initial round key:
+         */
     s0 = GETU32(in     ) ^ rk[0];
     s1 = GETU32(in +  4) ^ rk[1];
     s2 = GETU32(in +  8) ^ rk[2];
@@ -1502,7 +1502,7 @@ void AES_decrypt(const unsigned char *in, unsigned char *out,
             t3 = AES_Td0[s3 >> 24] ^ AES_Td1[(s2 >> 16) & 0xff] ^ AES_Td2[(s1 >>  8) & 0xff] ^ AES_Td3[s0 & 0xff] ^ rk[55];
         }
     }
-	rk += key->rounds << 2;
+        rk += key->rounds << 2;
 #else  /* !FULL_UNROLL */
     /*
      * Nr - 1 full rounds:
@@ -1566,88 +1566,88 @@ void AES_decrypt(const unsigned char *in, unsigned char *out,
     }
 #endif /* ?FULL_UNROLL */
     /*
-	 * apply last round and
-	 * map cipher state to byte array block:
-	 */
-	s0 =
+         * apply last round and
+         * map cipher state to byte array block:
+         */
+        s0 =
                 (AES_Td4[(t0 >> 24)       ] & 0xff000000) ^
                 (AES_Td4[(t3 >> 16) & 0xff] & 0x00ff0000) ^
                 (AES_Td4[(t2 >>  8) & 0xff] & 0x0000ff00) ^
                 (AES_Td4[(t1      ) & 0xff] & 0x000000ff) ^
-		rk[0];
-	PUTU32(out     , s0);
-	s1 =
+                rk[0];
+        PUTU32(out     , s0);
+        s1 =
                 (AES_Td4[(t1 >> 24)       ] & 0xff000000) ^
                 (AES_Td4[(t0 >> 16) & 0xff] & 0x00ff0000) ^
                 (AES_Td4[(t3 >>  8) & 0xff] & 0x0000ff00) ^
                 (AES_Td4[(t2      ) & 0xff] & 0x000000ff) ^
-		rk[1];
-	PUTU32(out +  4, s1);
-	s2 =
+                rk[1];
+        PUTU32(out +  4, s1);
+        s2 =
                 (AES_Td4[(t2 >> 24)       ] & 0xff000000) ^
                 (AES_Td4[(t1 >> 16) & 0xff] & 0x00ff0000) ^
                 (AES_Td4[(t0 >>  8) & 0xff] & 0x0000ff00) ^
                 (AES_Td4[(t3      ) & 0xff] & 0x000000ff) ^
-		rk[2];
-	PUTU32(out +  8, s2);
-	s3 =
+                rk[2];
+        PUTU32(out +  8, s2);
+        s3 =
                 (AES_Td4[(t3 >> 24)       ] & 0xff000000) ^
                 (AES_Td4[(t2 >> 16) & 0xff] & 0x00ff0000) ^
                 (AES_Td4[(t1 >>  8) & 0xff] & 0x0000ff00) ^
                 (AES_Td4[(t0      ) & 0xff] & 0x000000ff) ^
-		rk[3];
-	PUTU32(out + 12, s3);
+                rk[3];
+        PUTU32(out + 12, s3);
 }
 
 #endif /* AES_ASM */
 
 void AES_cbc_encrypt(const unsigned char *in, unsigned char *out,
-		     const unsigned long length, const AES_KEY *key,
-		     unsigned char *ivec, const int enc)
+                     const unsigned long length, const AES_KEY *key,
+                     unsigned char *ivec, const int enc)
 {
 
-	unsigned long n;
-	unsigned long len = length;
-	unsigned char tmp[AES_BLOCK_SIZE];
+        unsigned long n;
+        unsigned long len = length;
+        unsigned char tmp[AES_BLOCK_SIZE];
 
-	assert(in && out && key && ivec);
+        assert(in && out && key && ivec);
 
-	if (enc) {
-		while (len >= AES_BLOCK_SIZE) {
-			for(n=0; n < AES_BLOCK_SIZE; ++n)
-				tmp[n] = in[n] ^ ivec[n];
-			AES_encrypt(tmp, out, key);
-			memcpy(ivec, out, AES_BLOCK_SIZE);
-			len -= AES_BLOCK_SIZE;
-			in += AES_BLOCK_SIZE;
-			out += AES_BLOCK_SIZE;
-		}
-		if (len) {
-			for(n=0; n < len; ++n)
-				tmp[n] = in[n] ^ ivec[n];
-			for(n=len; n < AES_BLOCK_SIZE; ++n)
-				tmp[n] = ivec[n];
-			AES_encrypt(tmp, tmp, key);
-			memcpy(out, tmp, AES_BLOCK_SIZE);
-			memcpy(ivec, tmp, AES_BLOCK_SIZE);
-		}
-	} else {
-		while (len >= AES_BLOCK_SIZE) {
-			memcpy(tmp, in, AES_BLOCK_SIZE);
-			AES_decrypt(in, out, key);
-			for(n=0; n < AES_BLOCK_SIZE; ++n)
-				out[n] ^= ivec[n];
-			memcpy(ivec, tmp, AES_BLOCK_SIZE);
-			len -= AES_BLOCK_SIZE;
-			in += AES_BLOCK_SIZE;
-			out += AES_BLOCK_SIZE;
-		}
-		if (len) {
-			memcpy(tmp, in, AES_BLOCK_SIZE);
-			AES_decrypt(tmp, tmp, key);
-			for(n=0; n < len; ++n)
-				out[n] = tmp[n] ^ ivec[n];
-			memcpy(ivec, tmp, AES_BLOCK_SIZE);
-		}
-	}
+        if (enc) {
+                while (len >= AES_BLOCK_SIZE) {
+                        for(n=0; n < AES_BLOCK_SIZE; ++n)
+                                tmp[n] = in[n] ^ ivec[n];
+                        AES_encrypt(tmp, out, key);
+                        memcpy(ivec, out, AES_BLOCK_SIZE);
+                        len -= AES_BLOCK_SIZE;
+                        in += AES_BLOCK_SIZE;
+                        out += AES_BLOCK_SIZE;
+                }
+                if (len) {
+                        for(n=0; n < len; ++n)
+                                tmp[n] = in[n] ^ ivec[n];
+                        for(n=len; n < AES_BLOCK_SIZE; ++n)
+                                tmp[n] = ivec[n];
+                        AES_encrypt(tmp, tmp, key);
+                        memcpy(out, tmp, AES_BLOCK_SIZE);
+                        memcpy(ivec, tmp, AES_BLOCK_SIZE);
+                }
+        } else {
+                while (len >= AES_BLOCK_SIZE) {
+                        memcpy(tmp, in, AES_BLOCK_SIZE);
+                        AES_decrypt(in, out, key);
+                        for(n=0; n < AES_BLOCK_SIZE; ++n)
+                                out[n] ^= ivec[n];
+                        memcpy(ivec, tmp, AES_BLOCK_SIZE);
+                        len -= AES_BLOCK_SIZE;
+                        in += AES_BLOCK_SIZE;
+                        out += AES_BLOCK_SIZE;
+                }
+                if (len) {
+                        memcpy(tmp, in, AES_BLOCK_SIZE);
+                        AES_decrypt(tmp, tmp, key);
+                        for(n=0; n < len; ++n)
+                                out[n] = tmp[n] ^ ivec[n];
+                        memcpy(ivec, tmp, AES_BLOCK_SIZE);
+                }
+        }
 }
diff --git a/crypto/desrfb.c b/crypto/desrfb.c
index ec47dea..3274c36 100644
--- a/crypto/desrfb.c
+++ b/crypto/desrfb.c
@@ -37,353 +37,353 @@ static void cookey(unsigned long *);
 static unsigned long KnL[32] = { 0L };
 
 static const unsigned short bytebit[8]	= {
-	01, 02, 04, 010, 020, 040, 0100, 0200 };
+        01, 02, 04, 010, 020, 040, 0100, 0200 };
 
 static const unsigned long bigbyte[24] = {
-	0x800000L,	0x400000L,	0x200000L,	0x100000L,
-	0x80000L,	0x40000L,	0x20000L,	0x10000L,
-	0x8000L,	0x4000L,	0x2000L,	0x1000L,
-	0x800L, 	0x400L, 	0x200L, 	0x100L,
-	0x80L,		0x40L,		0x20L,		0x10L,
-	0x8L,		0x4L,		0x2L,		0x1L	};
+        0x800000L,	0x400000L,	0x200000L,	0x100000L,
+        0x80000L,	0x40000L,	0x20000L,	0x10000L,
+        0x8000L,	0x4000L,	0x2000L,	0x1000L,
+        0x800L, 	0x400L, 	0x200L, 	0x100L,
+        0x80L,		0x40L,		0x20L,		0x10L,
+        0x8L,		0x4L,		0x2L,		0x1L	};
 
 /* Use the key schedule specified in the Standard (ANSI X3.92-1981). */
 
 static const unsigned char pc1[56] = {
-	56, 48, 40, 32, 24, 16,  8,	 0, 57, 49, 41, 33, 25, 17,
-	 9,  1, 58, 50, 42, 34, 26,	18, 10,  2, 59, 51, 43, 35,
-	62, 54, 46, 38, 30, 22, 14,	 6, 61, 53, 45, 37, 29, 21,
-	13,  5, 60, 52, 44, 36, 28,	20, 12,  4, 27, 19, 11,  3 };
+        56, 48, 40, 32, 24, 16,  8,	 0, 57, 49, 41, 33, 25, 17,
+         9,  1, 58, 50, 42, 34, 26,	18, 10,  2, 59, 51, 43, 35,
+        62, 54, 46, 38, 30, 22, 14,	 6, 61, 53, 45, 37, 29, 21,
+        13,  5, 60, 52, 44, 36, 28,	20, 12,  4, 27, 19, 11,  3 };
 
 static const unsigned char totrot[16] = {
-	1,2,4,6,8,10,12,14,15,17,19,21,23,25,27,28 };
+        1,2,4,6,8,10,12,14,15,17,19,21,23,25,27,28 };
 
 static const unsigned char pc2[48] = {
-	13, 16, 10, 23,  0,  4,  2, 27, 14,  5, 20,  9,
-	22, 18, 11,  3, 25,  7, 15,  6, 26, 19, 12,  1,
-	40, 51, 30, 36, 46, 54, 29, 39, 50, 44, 32, 47,
-	43, 48, 38, 55, 33, 52, 45, 41, 49, 35, 28, 31 };
+        13, 16, 10, 23,  0,  4,  2, 27, 14,  5, 20,  9,
+        22, 18, 11,  3, 25,  7, 15,  6, 26, 19, 12,  1,
+        40, 51, 30, 36, 46, 54, 29, 39, 50, 44, 32, 47,
+        43, 48, 38, 55, 33, 52, 45, 41, 49, 35, 28, 31 };
 
 /* Thanks to James Gillogly & Phil Karn! */
 void deskey(unsigned char *key, int edf)
 {
-	register int i, j, l, m, n;
-	unsigned char pc1m[56], pcr[56];
-	unsigned long kn[32];
-
-	for ( j = 0; j < 56; j++ ) {
-		l = pc1[j];
-		m = l & 07;
-		pc1m[j] = (key[l >> 3] & bytebit[m]) ? 1 : 0;
-		}
-	for( i = 0; i < 16; i++ ) {
-		if( edf == DE1 ) m = (15 - i) << 1;
-		else m = i << 1;
-		n = m + 1;
-		kn[m] = kn[n] = 0L;
-		for( j = 0; j < 28; j++ ) {
-			l = j + totrot[i];
-			if( l < 28 ) pcr[j] = pc1m[l];
-			else pcr[j] = pc1m[l - 28];
-			}
-		for( j = 28; j < 56; j++ ) {
-		    l = j + totrot[i];
-		    if( l < 56 ) pcr[j] = pc1m[l];
-		    else pcr[j] = pc1m[l - 28];
-		    }
-		for( j = 0; j < 24; j++ ) {
-			if( pcr[pc2[j]] ) kn[m] |= bigbyte[j];
-			if( pcr[pc2[j+24]] ) kn[n] |= bigbyte[j];
-			}
-		}
-	cookey(kn);
-	return;
-	}
+        register int i, j, l, m, n;
+        unsigned char pc1m[56], pcr[56];
+        unsigned long kn[32];
+
+        for ( j = 0; j < 56; j++ ) {
+                l = pc1[j];
+                m = l & 07;
+                pc1m[j] = (key[l >> 3] & bytebit[m]) ? 1 : 0;
+                }
+        for( i = 0; i < 16; i++ ) {
+                if( edf == DE1 ) m = (15 - i) << 1;
+                else m = i << 1;
+                n = m + 1;
+                kn[m] = kn[n] = 0L;
+                for( j = 0; j < 28; j++ ) {
+                        l = j + totrot[i];
+                        if( l < 28 ) pcr[j] = pc1m[l];
+                        else pcr[j] = pc1m[l - 28];
+                        }
+                for( j = 28; j < 56; j++ ) {
+                    l = j + totrot[i];
+                    if( l < 56 ) pcr[j] = pc1m[l];
+                    else pcr[j] = pc1m[l - 28];
+                    }
+                for( j = 0; j < 24; j++ ) {
+                        if( pcr[pc2[j]] ) kn[m] |= bigbyte[j];
+                        if( pcr[pc2[j+24]] ) kn[n] |= bigbyte[j];
+                        }
+                }
+        cookey(kn);
+        return;
+        }
 
 static void cookey(register unsigned long *raw1)
 {
-	register unsigned long *cook, *raw0;
-	unsigned long dough[32];
-	register int i;
-
-	cook = dough;
-	for( i = 0; i < 16; i++, raw1++ ) {
-		raw0 = raw1++;
-		*cook	 = (*raw0 & 0x00fc0000L) << 6;
-		*cook	|= (*raw0 & 0x00000fc0L) << 10;
-		*cook	|= (*raw1 & 0x00fc0000L) >> 10;
-		*cook++ |= (*raw1 & 0x00000fc0L) >> 6;
-		*cook	 = (*raw0 & 0x0003f000L) << 12;
-		*cook	|= (*raw0 & 0x0000003fL) << 16;
-		*cook	|= (*raw1 & 0x0003f000L) >> 4;
-		*cook++ |= (*raw1 & 0x0000003fL);
-		}
-	usekey(dough);
-	return;
-	}
+        register unsigned long *cook, *raw0;
+        unsigned long dough[32];
+        register int i;
+
+        cook = dough;
+        for( i = 0; i < 16; i++, raw1++ ) {
+                raw0 = raw1++;
+                *cook	 = (*raw0 & 0x00fc0000L) << 6;
+                *cook	|= (*raw0 & 0x00000fc0L) << 10;
+                *cook	|= (*raw1 & 0x00fc0000L) >> 10;
+                *cook++ |= (*raw1 & 0x00000fc0L) >> 6;
+                *cook	 = (*raw0 & 0x0003f000L) << 12;
+                *cook	|= (*raw0 & 0x0000003fL) << 16;
+                *cook	|= (*raw1 & 0x0003f000L) >> 4;
+                *cook++ |= (*raw1 & 0x0000003fL);
+                }
+        usekey(dough);
+        return;
+        }
 
 void usekey(register unsigned long *from)
 {
-	register unsigned long *to, *endp;
+        register unsigned long *to, *endp;
 
-	to = KnL, endp = &KnL[32];
-	while( to < endp ) *to++ = *from++;
-	return;
-	}
+        to = KnL, endp = &KnL[32];
+        while( to < endp ) *to++ = *from++;
+        return;
+        }
 
 void des(unsigned char *inblock, unsigned char *outblock)
 {
-	unsigned long work[2];
+        unsigned long work[2];
 
-	scrunch(inblock, work);
-	desfunc(work, KnL);
-	unscrun(work, outblock);
-	return;
-	}
+        scrunch(inblock, work);
+        desfunc(work, KnL);
+        unscrun(work, outblock);
+        return;
+        }
 
 static void scrunch(register unsigned char *outof, register unsigned long *into)
 {
-	*into	 = (*outof++ & 0xffL) << 24;
-	*into	|= (*outof++ & 0xffL) << 16;
-	*into	|= (*outof++ & 0xffL) << 8;
-	*into++ |= (*outof++ & 0xffL);
-	*into	 = (*outof++ & 0xffL) << 24;
-	*into	|= (*outof++ & 0xffL) << 16;
-	*into	|= (*outof++ & 0xffL) << 8;
-	*into	|= (*outof   & 0xffL);
-	return;
-	}
+        *into	 = (*outof++ & 0xffL) << 24;
+        *into	|= (*outof++ & 0xffL) << 16;
+        *into	|= (*outof++ & 0xffL) << 8;
+        *into++ |= (*outof++ & 0xffL);
+        *into	 = (*outof++ & 0xffL) << 24;
+        *into	|= (*outof++ & 0xffL) << 16;
+        *into	|= (*outof++ & 0xffL) << 8;
+        *into	|= (*outof   & 0xffL);
+        return;
+        }
 
 static void unscrun(register unsigned long *outof, register unsigned char *into)
 {
-	*into++ = (unsigned char)((*outof >> 24) & 0xffL);
-	*into++ = (unsigned char)((*outof >> 16) & 0xffL);
-	*into++ = (unsigned char)((*outof >>  8) & 0xffL);
-	*into++ = (unsigned char)(*outof++	 & 0xffL);
-	*into++ = (unsigned char)((*outof >> 24) & 0xffL);
-	*into++ = (unsigned char)((*outof >> 16) & 0xffL);
-	*into++ = (unsigned char)((*outof >>  8) & 0xffL);
-	*into	=  (unsigned char)(*outof	 & 0xffL);
-	return;
-	}
+        *into++ = (unsigned char)((*outof >> 24) & 0xffL);
+        *into++ = (unsigned char)((*outof >> 16) & 0xffL);
+        *into++ = (unsigned char)((*outof >>  8) & 0xffL);
+        *into++ = (unsigned char)(*outof++	 & 0xffL);
+        *into++ = (unsigned char)((*outof >> 24) & 0xffL);
+        *into++ = (unsigned char)((*outof >> 16) & 0xffL);
+        *into++ = (unsigned char)((*outof >>  8) & 0xffL);
+        *into	=  (unsigned char)(*outof	 & 0xffL);
+        return;
+        }
 
 static const unsigned long SP1[64] = {
-	0x01010400L, 0x00000000L, 0x00010000L, 0x01010404L,
-	0x01010004L, 0x00010404L, 0x00000004L, 0x00010000L,
-	0x00000400L, 0x01010400L, 0x01010404L, 0x00000400L,
-	0x01000404L, 0x01010004L, 0x01000000L, 0x00000004L,
-	0x00000404L, 0x01000400L, 0x01000400L, 0x00010400L,
-	0x00010400L, 0x01010000L, 0x01010000L, 0x01000404L,
-	0x00010004L, 0x01000004L, 0x01000004L, 0x00010004L,
-	0x00000000L, 0x00000404L, 0x00010404L, 0x01000000L,
-	0x00010000L, 0x01010404L, 0x00000004L, 0x01010000L,
-	0x01010400L, 0x01000000L, 0x01000000L, 0x00000400L,
-	0x01010004L, 0x00010000L, 0x00010400L, 0x01000004L,
-	0x00000400L, 0x00000004L, 0x01000404L, 0x00010404L,
-	0x01010404L, 0x00010004L, 0x01010000L, 0x01000404L,
-	0x01000004L, 0x00000404L, 0x00010404L, 0x01010400L,
-	0x00000404L, 0x01000400L, 0x01000400L, 0x00000000L,
-	0x00010004L, 0x00010400L, 0x00000000L, 0x01010004L };
+        0x01010400L, 0x00000000L, 0x00010000L, 0x01010404L,
+        0x01010004L, 0x00010404L, 0x00000004L, 0x00010000L,
+        0x00000400L, 0x01010400L, 0x01010404L, 0x00000400L,
+        0x01000404L, 0x01010004L, 0x01000000L, 0x00000004L,
+        0x00000404L, 0x01000400L, 0x01000400L, 0x00010400L,
+        0x00010400L, 0x01010000L, 0x01010000L, 0x01000404L,
+        0x00010004L, 0x01000004L, 0x01000004L, 0x00010004L,
+        0x00000000L, 0x00000404L, 0x00010404L, 0x01000000L,
+        0x00010000L, 0x01010404L, 0x00000004L, 0x01010000L,
+        0x01010400L, 0x01000000L, 0x01000000L, 0x00000400L,
+        0x01010004L, 0x00010000L, 0x00010400L, 0x01000004L,
+        0x00000400L, 0x00000004L, 0x01000404L, 0x00010404L,
+        0x01010404L, 0x00010004L, 0x01010000L, 0x01000404L,
+        0x01000004L, 0x00000404L, 0x00010404L, 0x01010400L,
+        0x00000404L, 0x01000400L, 0x01000400L, 0x00000000L,
+        0x00010004L, 0x00010400L, 0x00000000L, 0x01010004L };
 
 static const unsigned long SP2[64] = {
-	0x80108020L, 0x80008000L, 0x00008000L, 0x00108020L,
-	0x00100000L, 0x00000020L, 0x80100020L, 0x80008020L,
-	0x80000020L, 0x80108020L, 0x80108000L, 0x80000000L,
-	0x80008000L, 0x00100000L, 0x00000020L, 0x80100020L,
-	0x00108000L, 0x00100020L, 0x80008020L, 0x00000000L,
-	0x80000000L, 0x00008000L, 0x00108020L, 0x80100000L,
-	0x00100020L, 0x80000020L, 0x00000000L, 0x00108000L,
-	0x00008020L, 0x80108000L, 0x80100000L, 0x00008020L,
-	0x00000000L, 0x00108020L, 0x80100020L, 0x00100000L,
-	0x80008020L, 0x80100000L, 0x80108000L, 0x00008000L,
-	0x80100000L, 0x80008000L, 0x00000020L, 0x80108020L,
-	0x00108020L, 0x00000020L, 0x00008000L, 0x80000000L,
-	0x00008020L, 0x80108000L, 0x00100000L, 0x80000020L,
-	0x00100020L, 0x80008020L, 0x80000020L, 0x00100020L,
-	0x00108000L, 0x00000000L, 0x80008000L, 0x00008020L,
-	0x80000000L, 0x80100020L, 0x80108020L, 0x00108000L };
+        0x80108020L, 0x80008000L, 0x00008000L, 0x00108020L,
+        0x00100000L, 0x00000020L, 0x80100020L, 0x80008020L,
+        0x80000020L, 0x80108020L, 0x80108000L, 0x80000000L,
+        0x80008000L, 0x00100000L, 0x00000020L, 0x80100020L,
+        0x00108000L, 0x00100020L, 0x80008020L, 0x00000000L,
+        0x80000000L, 0x00008000L, 0x00108020L, 0x80100000L,
+        0x00100020L, 0x80000020L, 0x00000000L, 0x00108000L,
+        0x00008020L, 0x80108000L, 0x80100000L, 0x00008020L,
+        0x00000000L, 0x00108020L, 0x80100020L, 0x00100000L,
+        0x80008020L, 0x80100000L, 0x80108000L, 0x00008000L,
+        0x80100000L, 0x80008000L, 0x00000020L, 0x80108020L,
+        0x00108020L, 0x00000020L, 0x00008000L, 0x80000000L,
+        0x00008020L, 0x80108000L, 0x00100000L, 0x80000020L,
+        0x00100020L, 0x80008020L, 0x80000020L, 0x00100020L,
+        0x00108000L, 0x00000000L, 0x80008000L, 0x00008020L,
+        0x80000000L, 0x80100020L, 0x80108020L, 0x00108000L };
 
 static const unsigned long SP3[64] = {
-	0x00000208L, 0x08020200L, 0x00000000L, 0x08020008L,
-	0x08000200L, 0x00000000L, 0x00020208L, 0x08000200L,
-	0x00020008L, 0x08000008L, 0x08000008L, 0x00020000L,
-	0x08020208L, 0x00020008L, 0x08020000L, 0x00000208L,
-	0x08000000L, 0x00000008L, 0x08020200L, 0x00000200L,
-	0x00020200L, 0x08020000L, 0x08020008L, 0x00020208L,
-	0x08000208L, 0x00020200L, 0x00020000L, 0x08000208L,
-	0x00000008L, 0x08020208L, 0x00000200L, 0x08000000L,
-	0x08020200L, 0x08000000L, 0x00020008L, 0x00000208L,
-	0x00020000L, 0x08020200L, 0x08000200L, 0x00000000L,
-	0x00000200L, 0x00020008L, 0x08020208L, 0x08000200L,
-	0x08000008L, 0x00000200L, 0x00000000L, 0x08020008L,
-	0x08000208L, 0x00020000L, 0x08000000L, 0x08020208L,
-	0x00000008L, 0x00020208L, 0x00020200L, 0x08000008L,
-	0x08020000L, 0x08000208L, 0x00000208L, 0x08020000L,
-	0x00020208L, 0x00000008L, 0x08020008L, 0x00020200L };
+        0x00000208L, 0x08020200L, 0x00000000L, 0x08020008L,
+        0x08000200L, 0x00000000L, 0x00020208L, 0x08000200L,
+        0x00020008L, 0x08000008L, 0x08000008L, 0x00020000L,
+        0x08020208L, 0x00020008L, 0x08020000L, 0x00000208L,
+        0x08000000L, 0x00000008L, 0x08020200L, 0x00000200L,
+        0x00020200L, 0x08020000L, 0x08020008L, 0x00020208L,
+        0x08000208L, 0x00020200L, 0x00020000L, 0x08000208L,
+        0x00000008L, 0x08020208L, 0x00000200L, 0x08000000L,
+        0x08020200L, 0x08000000L, 0x00020008L, 0x00000208L,
+        0x00020000L, 0x08020200L, 0x08000200L, 0x00000000L,
+        0x00000200L, 0x00020008L, 0x08020208L, 0x08000200L,
+        0x08000008L, 0x00000200L, 0x00000000L, 0x08020008L,
+        0x08000208L, 0x00020000L, 0x08000000L, 0x08020208L,
+        0x00000008L, 0x00020208L, 0x00020200L, 0x08000008L,
+        0x08020000L, 0x08000208L, 0x00000208L, 0x08020000L,
+        0x00020208L, 0x00000008L, 0x08020008L, 0x00020200L };
 
 static const unsigned long SP4[64] = {
-	0x00802001L, 0x00002081L, 0x00002081L, 0x00000080L,
-	0x00802080L, 0x00800081L, 0x00800001L, 0x00002001L,
-	0x00000000L, 0x00802000L, 0x00802000L, 0x00802081L,
-	0x00000081L, 0x00000000L, 0x00800080L, 0x00800001L,
-	0x00000001L, 0x00002000L, 0x00800000L, 0x00802001L,
-	0x00000080L, 0x00800000L, 0x00002001L, 0x00002080L,
-	0x00800081L, 0x00000001L, 0x00002080L, 0x00800080L,
-	0x00002000L, 0x00802080L, 0x00802081L, 0x00000081L,
-	0x00800080L, 0x00800001L, 0x00802000L, 0x00802081L,
-	0x00000081L, 0x00000000L, 0x00000000L, 0x00802000L,
-	0x00002080L, 0x00800080L, 0x00800081L, 0x00000001L,
-	0x00802001L, 0x00002081L, 0x00002081L, 0x00000080L,
-	0x00802081L, 0x00000081L, 0x00000001L, 0x00002000L,
-	0x00800001L, 0x00002001L, 0x00802080L, 0x00800081L,
-	0x00002001L, 0x00002080L, 0x00800000L, 0x00802001L,
-	0x00000080L, 0x00800000L, 0x00002000L, 0x00802080L };
+        0x00802001L, 0x00002081L, 0x00002081L, 0x00000080L,
+        0x00802080L, 0x00800081L, 0x00800001L, 0x00002001L,
+        0x00000000L, 0x00802000L, 0x00802000L, 0x00802081L,
+        0x00000081L, 0x00000000L, 0x00800080L, 0x00800001L,
+        0x00000001L, 0x00002000L, 0x00800000L, 0x00802001L,
+        0x00000080L, 0x00800000L, 0x00002001L, 0x00002080L,
+        0x00800081L, 0x00000001L, 0x00002080L, 0x00800080L,
+        0x00002000L, 0x00802080L, 0x00802081L, 0x00000081L,
+        0x00800080L, 0x00800001L, 0x00802000L, 0x00802081L,
+        0x00000081L, 0x00000000L, 0x00000000L, 0x00802000L,
+        0x00002080L, 0x00800080L, 0x00800081L, 0x00000001L,
+        0x00802001L, 0x00002081L, 0x00002081L, 0x00000080L,
+        0x00802081L, 0x00000081L, 0x00000001L, 0x00002000L,
+        0x00800001L, 0x00002001L, 0x00802080L, 0x00800081L,
+        0x00002001L, 0x00002080L, 0x00800000L, 0x00802001L,
+        0x00000080L, 0x00800000L, 0x00002000L, 0x00802080L };
 
 static const unsigned long SP5[64] = {
-	0x00000100L, 0x02080100L, 0x02080000L, 0x42000100L,
-	0x00080000L, 0x00000100L, 0x40000000L, 0x02080000L,
-	0x40080100L, 0x00080000L, 0x02000100L, 0x40080100L,
-	0x42000100L, 0x42080000L, 0x00080100L, 0x40000000L,
-	0x02000000L, 0x40080000L, 0x40080000L, 0x00000000L,
-	0x40000100L, 0x42080100L, 0x42080100L, 0x02000100L,
-	0x42080000L, 0x40000100L, 0x00000000L, 0x42000000L,
-	0x02080100L, 0x02000000L, 0x42000000L, 0x00080100L,
-	0x00080000L, 0x42000100L, 0x00000100L, 0x02000000L,
-	0x40000000L, 0x02080000L, 0x42000100L, 0x40080100L,
-	0x02000100L, 0x40000000L, 0x42080000L, 0x02080100L,
-	0x40080100L, 0x00000100L, 0x02000000L, 0x42080000L,
-	0x42080100L, 0x00080100L, 0x42000000L, 0x42080100L,
-	0x02080000L, 0x00000000L, 0x40080000L, 0x42000000L,
-	0x00080100L, 0x02000100L, 0x40000100L, 0x00080000L,
-	0x00000000L, 0x40080000L, 0x02080100L, 0x40000100L };
+        0x00000100L, 0x02080100L, 0x02080000L, 0x42000100L,
+        0x00080000L, 0x00000100L, 0x40000000L, 0x02080000L,
+        0x40080100L, 0x00080000L, 0x02000100L, 0x40080100L,
+        0x42000100L, 0x42080000L, 0x00080100L, 0x40000000L,
+        0x02000000L, 0x40080000L, 0x40080000L, 0x00000000L,
+        0x40000100L, 0x42080100L, 0x42080100L, 0x02000100L,
+        0x42080000L, 0x40000100L, 0x00000000L, 0x42000000L,
+        0x02080100L, 0x02000000L, 0x42000000L, 0x00080100L,
+        0x00080000L, 0x42000100L, 0x00000100L, 0x02000000L,
+        0x40000000L, 0x02080000L, 0x42000100L, 0x40080100L,
+        0x02000100L, 0x40000000L, 0x42080000L, 0x02080100L,
+        0x40080100L, 0x00000100L, 0x02000000L, 0x42080000L,
+        0x42080100L, 0x00080100L, 0x42000000L, 0x42080100L,
+        0x02080000L, 0x00000000L, 0x40080000L, 0x42000000L,
+        0x00080100L, 0x02000100L, 0x40000100L, 0x00080000L,
+        0x00000000L, 0x40080000L, 0x02080100L, 0x40000100L };
 
 static const unsigned long SP6[64] = {
-	0x20000010L, 0x20400000L, 0x00004000L, 0x20404010L,
-	0x20400000L, 0x00000010L, 0x20404010L, 0x00400000L,
-	0x20004000L, 0x00404010L, 0x00400000L, 0x20000010L,
-	0x00400010L, 0x20004000L, 0x20000000L, 0x00004010L,
-	0x00000000L, 0x00400010L, 0x20004010L, 0x00004000L,
-	0x00404000L, 0x20004010L, 0x00000010L, 0x20400010L,
-	0x20400010L, 0x00000000L, 0x00404010L, 0x20404000L,
-	0x00004010L, 0x00404000L, 0x20404000L, 0x20000000L,
-	0x20004000L, 0x00000010L, 0x20400010L, 0x00404000L,
-	0x20404010L, 0x00400000L, 0x00004010L, 0x20000010L,
-	0x00400000L, 0x20004000L, 0x20000000L, 0x00004010L,
-	0x20000010L, 0x20404010L, 0x00404000L, 0x20400000L,
-	0x00404010L, 0x20404000L, 0x00000000L, 0x20400010L,
-	0x00000010L, 0x00004000L, 0x20400000L, 0x00404010L,
-	0x00004000L, 0x00400010L, 0x20004010L, 0x00000000L,
-	0x20404000L, 0x20000000L, 0x00400010L, 0x20004010L };
+        0x20000010L, 0x20400000L, 0x00004000L, 0x20404010L,
+        0x20400000L, 0x00000010L, 0x20404010L, 0x00400000L,
+        0x20004000L, 0x00404010L, 0x00400000L, 0x20000010L,
+        0x00400010L, 0x20004000L, 0x20000000L, 0x00004010L,
+        0x00000000L, 0x00400010L, 0x20004010L, 0x00004000L,
+        0x00404000L, 0x20004010L, 0x00000010L, 0x20400010L,
+        0x20400010L, 0x00000000L, 0x00404010L, 0x20404000L,
+        0x00004010L, 0x00404000L, 0x20404000L, 0x20000000L,
+        0x20004000L, 0x00000010L, 0x20400010L, 0x00404000L,
+        0x20404010L, 0x00400000L, 0x00004010L, 0x20000010L,
+        0x00400000L, 0x20004000L, 0x20000000L, 0x00004010L,
+        0x20000010L, 0x20404010L, 0x00404000L, 0x20400000L,
+        0x00404010L, 0x20404000L, 0x00000000L, 0x20400010L,
+        0x00000010L, 0x00004000L, 0x20400000L, 0x00404010L,
+        0x00004000L, 0x00400010L, 0x20004010L, 0x00000000L,
+        0x20404000L, 0x20000000L, 0x00400010L, 0x20004010L };
 
 static const unsigned long SP7[64] = {
-	0x00200000L, 0x04200002L, 0x04000802L, 0x00000000L,
-	0x00000800L, 0x04000802L, 0x00200802L, 0x04200800L,
-	0x04200802L, 0x00200000L, 0x00000000L, 0x04000002L,
-	0x00000002L, 0x04000000L, 0x04200002L, 0x00000802L,
-	0x04000800L, 0x00200802L, 0x00200002L, 0x04000800L,
-	0x04000002L, 0x04200000L, 0x04200800L, 0x00200002L,
-	0x04200000L, 0x00000800L, 0x00000802L, 0x04200802L,
-	0x00200800L, 0x00000002L, 0x04000000L, 0x00200800L,
-	0x04000000L, 0x00200800L, 0x00200000L, 0x04000802L,
-	0x04000802L, 0x04200002L, 0x04200002L, 0x00000002L,
-	0x00200002L, 0x04000000L, 0x04000800L, 0x00200000L,
-	0x04200800L, 0x00000802L, 0x00200802L, 0x04200800L,
-	0x00000802L, 0x04000002L, 0x04200802L, 0x04200000L,
-	0x00200800L, 0x00000000L, 0x00000002L, 0x04200802L,
-	0x00000000L, 0x00200802L, 0x04200000L, 0x00000800L,
-	0x04000002L, 0x04000800L, 0x00000800L, 0x00200002L };
+        0x00200000L, 0x04200002L, 0x04000802L, 0x00000000L,
+        0x00000800L, 0x04000802L, 0x00200802L, 0x04200800L,
+        0x04200802L, 0x00200000L, 0x00000000L, 0x04000002L,
+        0x00000002L, 0x04000000L, 0x04200002L, 0x00000802L,
+        0x04000800L, 0x00200802L, 0x00200002L, 0x04000800L,
+        0x04000002L, 0x04200000L, 0x04200800L, 0x00200002L,
+        0x04200000L, 0x00000800L, 0x00000802L, 0x04200802L,
+        0x00200800L, 0x00000002L, 0x04000000L, 0x00200800L,
+        0x04000000L, 0x00200800L, 0x00200000L, 0x04000802L,
+        0x04000802L, 0x04200002L, 0x04200002L, 0x00000002L,
+        0x00200002L, 0x04000000L, 0x04000800L, 0x00200000L,
+        0x04200800L, 0x00000802L, 0x00200802L, 0x04200800L,
+        0x00000802L, 0x04000002L, 0x04200802L, 0x04200000L,
+        0x00200800L, 0x00000000L, 0x00000002L, 0x04200802L,
+        0x00000000L, 0x00200802L, 0x04200000L, 0x00000800L,
+        0x04000002L, 0x04000800L, 0x00000800L, 0x00200002L };
 
 static const unsigned long SP8[64] = {
-	0x10001040L, 0x00001000L, 0x00040000L, 0x10041040L,
-	0x10000000L, 0x10001040L, 0x00000040L, 0x10000000L,
-	0x00040040L, 0x10040000L, 0x10041040L, 0x00041000L,
-	0x10041000L, 0x00041040L, 0x00001000L, 0x00000040L,
-	0x10040000L, 0x10000040L, 0x10001000L, 0x00001040L,
-	0x00041000L, 0x00040040L, 0x10040040L, 0x10041000L,
-	0x00001040L, 0x00000000L, 0x00000000L, 0x10040040L,
-	0x10000040L, 0x10001000L, 0x00041040L, 0x00040000L,
-	0x00041040L, 0x00040000L, 0x10041000L, 0x00001000L,
-	0x00000040L, 0x10040040L, 0x00001000L, 0x00041040L,
-	0x10001000L, 0x00000040L, 0x10000040L, 0x10040000L,
-	0x10040040L, 0x10000000L, 0x00040000L, 0x10001040L,
-	0x00000000L, 0x10041040L, 0x00040040L, 0x10000040L,
-	0x10040000L, 0x10001000L, 0x10001040L, 0x00000000L,
-	0x10041040L, 0x00041000L, 0x00041000L, 0x00001040L,
-	0x00001040L, 0x00040040L, 0x10000000L, 0x10041000L };
+        0x10001040L, 0x00001000L, 0x00040000L, 0x10041040L,
+        0x10000000L, 0x10001040L, 0x00000040L, 0x10000000L,
+        0x00040040L, 0x10040000L, 0x10041040L, 0x00041000L,
+        0x10041000L, 0x00041040L, 0x00001000L, 0x00000040L,
+        0x10040000L, 0x10000040L, 0x10001000L, 0x00001040L,
+        0x00041000L, 0x00040040L, 0x10040040L, 0x10041000L,
+        0x00001040L, 0x00000000L, 0x00000000L, 0x10040040L,
+        0x10000040L, 0x10001000L, 0x00041040L, 0x00040000L,
+        0x00041040L, 0x00040000L, 0x10041000L, 0x00001000L,
+        0x00000040L, 0x10040040L, 0x00001000L, 0x00041040L,
+        0x10001000L, 0x00000040L, 0x10000040L, 0x10040000L,
+        0x10040040L, 0x10000000L, 0x00040000L, 0x10001040L,
+        0x00000000L, 0x10041040L, 0x00040040L, 0x10000040L,
+        0x10040000L, 0x10001000L, 0x10001040L, 0x00000000L,
+        0x10041040L, 0x00041000L, 0x00041000L, 0x00001040L,
+        0x00001040L, 0x00040040L, 0x10000000L, 0x10041000L };
 
 static void desfunc(register unsigned long *block, register unsigned long *keys)
 {
-	register unsigned long fval, work, right, leftt;
-	register int round;
-
-	leftt = block[0];
-	right = block[1];
-	work = ((leftt >> 4) ^ right) & 0x0f0f0f0fL;
-	right ^= work;
-	leftt ^= (work << 4);
-	work = ((leftt >> 16) ^ right) & 0x0000ffffL;
-	right ^= work;
-	leftt ^= (work << 16);
-	work = ((right >> 2) ^ leftt) & 0x33333333L;
-	leftt ^= work;
-	right ^= (work << 2);
-	work = ((right >> 8) ^ leftt) & 0x00ff00ffL;
-	leftt ^= work;
-	right ^= (work << 8);
-	right = ((right << 1) | ((right >> 31) & 1L)) & 0xffffffffL;
-	work = (leftt ^ right) & 0xaaaaaaaaL;
-	leftt ^= work;
-	right ^= work;
-	leftt = ((leftt << 1) | ((leftt >> 31) & 1L)) & 0xffffffffL;
-
-	for( round = 0; round < 8; round++ ) {
-		work  = (right << 28) | (right >> 4);
-		work ^= *keys++;
-		fval  = SP7[ work		 & 0x3fL];
-		fval |= SP5[(work >>  8) & 0x3fL];
-		fval |= SP3[(work >> 16) & 0x3fL];
-		fval |= SP1[(work >> 24) & 0x3fL];
-		work  = right ^ *keys++;
-		fval |= SP8[ work		 & 0x3fL];
-		fval |= SP6[(work >>  8) & 0x3fL];
-		fval |= SP4[(work >> 16) & 0x3fL];
-		fval |= SP2[(work >> 24) & 0x3fL];
-		leftt ^= fval;
-		work  = (leftt << 28) | (leftt >> 4);
-		work ^= *keys++;
-		fval  = SP7[ work		 & 0x3fL];
-		fval |= SP5[(work >>  8) & 0x3fL];
-		fval |= SP3[(work >> 16) & 0x3fL];
-		fval |= SP1[(work >> 24) & 0x3fL];
-		work  = leftt ^ *keys++;
-		fval |= SP8[ work		 & 0x3fL];
-		fval |= SP6[(work >>  8) & 0x3fL];
-		fval |= SP4[(work >> 16) & 0x3fL];
-		fval |= SP2[(work >> 24) & 0x3fL];
-		right ^= fval;
-		}
-
-	right = (right << 31) | (right >> 1);
-	work = (leftt ^ right) & 0xaaaaaaaaL;
-	leftt ^= work;
-	right ^= work;
-	leftt = (leftt << 31) | (leftt >> 1);
-	work = ((leftt >> 8) ^ right) & 0x00ff00ffL;
-	right ^= work;
-	leftt ^= (work << 8);
-	work = ((leftt >> 2) ^ right) & 0x33333333L;
-	right ^= work;
-	leftt ^= (work << 2);
-	work = ((right >> 16) ^ leftt) & 0x0000ffffL;
-	leftt ^= work;
-	right ^= (work << 16);
-	work = ((right >> 4) ^ leftt) & 0x0f0f0f0fL;
-	leftt ^= work;
-	right ^= (work << 4);
-	*block++ = right;
-	*block = leftt;
-	return;
-	}
+        register unsigned long fval, work, right, leftt;
+        register int round;
+
+        leftt = block[0];
+        right = block[1];
+        work = ((leftt >> 4) ^ right) & 0x0f0f0f0fL;
+        right ^= work;
+        leftt ^= (work << 4);
+        work = ((leftt >> 16) ^ right) & 0x0000ffffL;
+        right ^= work;
+        leftt ^= (work << 16);
+        work = ((right >> 2) ^ leftt) & 0x33333333L;
+        leftt ^= work;
+        right ^= (work << 2);
+        work = ((right >> 8) ^ leftt) & 0x00ff00ffL;
+        leftt ^= work;
+        right ^= (work << 8);
+        right = ((right << 1) | ((right >> 31) & 1L)) & 0xffffffffL;
+        work = (leftt ^ right) & 0xaaaaaaaaL;
+        leftt ^= work;
+        right ^= work;
+        leftt = ((leftt << 1) | ((leftt >> 31) & 1L)) & 0xffffffffL;
+
+        for( round = 0; round < 8; round++ ) {
+                work  = (right << 28) | (right >> 4);
+                work ^= *keys++;
+                fval  = SP7[ work		 & 0x3fL];
+                fval |= SP5[(work >>  8) & 0x3fL];
+                fval |= SP3[(work >> 16) & 0x3fL];
+                fval |= SP1[(work >> 24) & 0x3fL];
+                work  = right ^ *keys++;
+                fval |= SP8[ work		 & 0x3fL];
+                fval |= SP6[(work >>  8) & 0x3fL];
+                fval |= SP4[(work >> 16) & 0x3fL];
+                fval |= SP2[(work >> 24) & 0x3fL];
+                leftt ^= fval;
+                work  = (leftt << 28) | (leftt >> 4);
+                work ^= *keys++;
+                fval  = SP7[ work		 & 0x3fL];
+                fval |= SP5[(work >>  8) & 0x3fL];
+                fval |= SP3[(work >> 16) & 0x3fL];
+                fval |= SP1[(work >> 24) & 0x3fL];
+                work  = leftt ^ *keys++;
+                fval |= SP8[ work		 & 0x3fL];
+                fval |= SP6[(work >>  8) & 0x3fL];
+                fval |= SP4[(work >> 16) & 0x3fL];
+                fval |= SP2[(work >> 24) & 0x3fL];
+                right ^= fval;
+                }
+
+        right = (right << 31) | (right >> 1);
+        work = (leftt ^ right) & 0xaaaaaaaaL;
+        leftt ^= work;
+        right ^= work;
+        leftt = (leftt << 31) | (leftt >> 1);
+        work = ((leftt >> 8) ^ right) & 0x00ff00ffL;
+        right ^= work;
+        leftt ^= (work << 8);
+        work = ((leftt >> 2) ^ right) & 0x33333333L;
+        right ^= work;
+        leftt ^= (work << 2);
+        work = ((right >> 16) ^ leftt) & 0x0000ffffL;
+        leftt ^= work;
+        right ^= (work << 16);
+        work = ((right >> 4) ^ leftt) & 0x0f0f0f0fL;
+        leftt ^= work;
+        right ^= (work << 4);
+        *block++ = right;
+        *block = leftt;
+        return;
+        }
 
 /* Validation sets:
  *
-- 
1.8.3.1
