Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF72BC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:38:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A846521556
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 20:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CuC4ZwQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A846521556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8rpA-0002cp-Fg
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 15:38:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1j8rlr-0001nn-6C
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:34:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1j8rln-0004Y3-Pk
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:34:35 -0500
Received: from mout.gmx.net ([212.227.15.19]:51467)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1j8rln-0004Xq-5H
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 15:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1583181268;
 bh=i4seu1R3kr+RcN936l5FMY71gnZkTocgHg5LcteMgXw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CuC4ZwQjskpBXf1TduPWFabMdyRBUd4DtdIuL33L00bLr51f6NgE8z8ZcZHaHMhVz
 rgm0pM0d9EvvbloqMR5UBk5G064gKQ1YauiJ/+f7txhcQj1WXnV7ZuURke1KFDvT+y
 ClGnNX5xaQzZ7HdH8WkAWM5R6GHIwfFrsEfrBIKw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.130.108]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbirE-1jfRMr2uVy-00dIko; Mon, 02
 Mar 2020 21:34:27 +0100
Date: Mon, 2 Mar 2020 21:34:25 +0100
From: Helge Deller <deller@gmx.de>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v3 02/11] hppa: Add support for LASI chip with i82596 NIC
Message-ID: <20200302203425.GA15253@ls3530.fritz.box>
References: <20200124232009.12928-1-richard.henderson@linaro.org>
 <20200124232009.12928-3-richard.henderson@linaro.org>
 <CAFEAcA_aA1jNkkgmdxLqUhSbAz7JL2chAU1+s475HSoqKQiukg@mail.gmail.com>
 <e0e3cf61-33ef-3b95-4a2b-2458cdcab296@gmx.de>
 <CAFEAcA_80Hm-FX0-OWW3yJ2H1d=mqxt8tKsvP7LpDayQBXRtGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_80Hm-FX0-OWW3yJ2H1d=mqxt8tKsvP7LpDayQBXRtGw@mail.gmail.com>
X-Provags-ID: V03:K1:4Kxb5palEvoKRWb2oD+aJKNuQoILE6v29iT73/lZnRLNZu62hZr
 32mGMrBiRtVDb3iX7Fx2gFQKYrDnXBjtzkI0qqLfQj8FToNT59KY75zSGwPgWeDZAAckiwe
 utCJZ1z/CNQ0Zs1BHBb0mdp2xaWOApPkPi4Dm7P2f7VEwRzRVPPlGZkg0XG5HXudwsD/pkI
 Skev6iHASIilZh9vm9ikw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yf7q+3jJmuQ=:hvZtw359fg3iTemN4d3hZX
 HucgCrTx6WkW/f8BV4VFCi1T/oJ8CUyCH+NioxrTeA/Y2qCGPzAUh6lMeVB09AVP6PhUuiO9k
 iNtPcCfFBW03Ka6XUpxu8Xvu8Ede1NaVLS1ti0m6cS+80zZPhSbX1Hle5DgiJnCVJm/vXFXZz
 A28HZvbW6C7A27+VJS1jwyTC54+tD7txTIONfKBWTRKAFV5GNNzMcbhD3rpMxTApg6zuYH9Rd
 VZrN/9DLEmw9W4XWLR0AJPeT2wo1vFHgln2moCzJKHPd67p6QDOyxyD0vZGqx4ioPZ22/LeHq
 JGgnXbrWMDPB3TaurcspOAz85q0bMdRiUn1kBs4zoOZN9hCS/UCSFF7a/kPgif9CzvmUT0w16
 AVwIRCRay1PT1EGEHeaskuYmGDllCeNIhBb6n635I2kvFLUCUpHQDb0ZPkOEs76iLEZrtVwMz
 16auosA+HRT98Mv8yyd70lOD4IIlusEmC8k3CB5fco+MOLLtjqF1GGaMa7iUM6xkHK6SJTixG
 qCKizuYLV3iXEE0EhPR/ZRBYszrRDI//vBHZ/RloLvXc6aZyESj4uwsmKf3iPO5QZ1As/Xrp+
 vXFzMA4IgPxJk37yrthTmaWMddBGBjkRF4SHBdZyv6O3h7eqIGTv3mVeU52J97mUVxoVCKJ5t
 q5xVf9xNekUdKSWWHGZxZDtoinA3+kI6y0RajxgbvDCoyuyhiViqrQdQrJbOFv3iv7Pvn/pma
 fmLV0ZDhD75ftT1ebFbuwldt5/ZVwCpkJZLyckDbmFAKuYEYxrOPn/74Ut+UdmqfjshXcRLFh
 XUxatMtNqVyWL3YbJEPA2nA/bPPtqy5k/s6qd4j6+KoEE5VhqZTRZbTCB+G4ga3MoyWPuXXbq
 UDjvitpegAsq2kJyJlqqSvJktgwC9uL2ee+U+xf8mGIDVooA3QPJ8ySLB2Kn3j2n73UFl10Tj
 5B3ZDd7sJeVcTJvcwRBw2QTzGw5ShqvVFe08dXvOjvIMttzw4YhqkTsc7iqSv5YUr3BVnaLl4
 6FAlWMBv7bhXjHCMaIsFp+PGsePPuL99wkT0tk3IGc1o8MCfphyOSZ0iass/oGQJhLBgwZ4FO
 BmETsu0j9CrqmtAEF1/CT2ufDwG0iGb5gDRx1MY9CKfE7kkWBTadr/vRreBCvbxZNGrbAtd7g
 qTQ2K2+es+VNtkneEXz3c0BP+8Bu/WPAsMVSKn1qJ/8LwxZZyxq6xpO4sFpjHl5VWCgMm+WiW
 S8dtcuEDvx5agRx+1
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.19
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
Cc: Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell <peter.maydell@linaro.org>:
> On Mon, 2 Mar 2020 at 19:23, Helge Deller <deller@gmx.de> wrote:
> >
> > On 17.02.20 18:56, Peter Maydell wrote:
> > > On Fri, 24 Jan 2020 at 23:20, Richard Henderson
> > > <richard.henderson@linaro.org> wrote:
> > >>
> > >> From: Helge Deller <deller@gmx.de>
> > >>
> > >> LASI is a built-in multi-I/O chip which supports serial, parallel,
> > >> network (Intel i82596 Apricot), sound and other functionalities.
> > >> LASI has been used in many HP PARISC machines.
> > >> This patch adds the necessary parts to allow Linux and HP-UX to det=
ect
> > >> LASI and the network card.
>
> > > So we could be reading off the end of the buffer.
> > >
> > > I don't know whether the buffer should be 4 bytes
> > > larger to allow for the checksum, or if the len calculation
> > > is wrong.
> >
> > I'm working on a bigger patch which will improve this driver.
> > It still has some issues with the emulation in Linux and HP-UX.
> > With the patch I will take try to fix those out-of-bounds
> > accesses too.
> > It will take some time though, until I will send the patch.
>
> As this is a bug fix and in particular a fix for a buffer
> overrun, I think it would be better if you could send a
> patch that just fixes this.

Of course I usually agree on that, but in this special case the initial
patch was more or less the basic functionality that the NIC gets
detected. The driver is nevertheless full of bugs, so even if I'd try to
get this specific buffer overrun fixed, it will not give you a working
NIC emulation. Such a patch would just hide the buffer overrun without
any real benefit.

> If you include it in a larger general-improvements patch we'll
> probably just ask you to split it out when we get to code-review of
> that patchset, and doing it that way will mean we have the buggy code
> in QEMU for longer.

I've done big progress with my fixes. Below you will find the current
patch against qemu git head which does work with a Linux guest. It's not
perfect yet either, but the Linux guest gets an IP address, apt-get
update works, same as pings and such. It's still work-in-progress, so
please don't look too deep into it yet. I'm aware of the rough edges
which I plan to clean up in the next few days, but I attached it here
for your reference in the hope that you can see that there is much more
work than just trying to fix some static code analysis output.

That said, I would be happy to further clean it up, split it into
logically seperate patches and send them upstream in a few days for
review if you agree. I think with this approach we gain more than trying
to "fix" the old buggy code.

Thoughts?

Helge


diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index fe9f2390a9..f8d55601bc 100644
=2D-- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -27,29 +27,29 @@
 #define DBG(x)          do { } while (0)
 #endif

-#define USE_TIMER       0
-
 #define BITS(n, m) (((0xffffffffU << (31 - n)) >> (31 - n + m)) << m)

-#define PKT_BUF_SZ      1536
 #define MAX_MC_CNT      64

 #define ISCP_BUSY       0x0001

 #define I596_NULL       ((uint32_t)0xffffffff)

-#define SCB_STATUS_CX   0x8000 /* CU finished command with I bit */
-#define SCB_STATUS_FR   0x4000 /* RU finished receiving a frame */
-#define SCB_STATUS_CNA  0x2000 /* CU left active state */
-#define SCB_STATUS_RNR  0x1000 /* RU left active state */
+#define SCB_STAT_CX     0x8000 /* CU finished command with I bit */
+#define SCB_STAT_FR     0x4000 /* RU finished receiving a frame */
+#define SCB_STAT_CNA    0x2000 /* CU left active state */
+#define SCB_STAT_RNR    0x1000 /* RU left active state */

-#define CU_IDLE         0
+#define CU_IDLE         0       /* CUS values */
 #define CU_SUSPENDED    1
 #define CU_ACTIVE       2

-#define RX_IDLE         0
+#define RX_IDLE         0       /* RUS values */
 #define RX_SUSPENDED    1
+#define RX_NO_RESOURCES 2
 #define RX_READY        4
+#define RX_NO_RESO_RBD  (8 + RX_NO_RESOURCES)
+#define RX_NO_MORE_RBD  (8 + RX_READY)

 #define CMD_EOL         0x8000  /* The last command of the list, stop. */
 #define CMD_SUSP        0x4000  /* Suspend after doing cmd. */
@@ -76,10 +76,13 @@ enum commands {

 /* various flags in the chip config registers */
 #define I596_PREFETCH   (s->config[0] & 0x80)
+#define I596_NO_SRC_ADD_IN (s->config[3] & 0x08) /* if 1, do not insert M=
AC in Tx Packet */
+#define I596_LOOPBACK   (s->config[3] >> 6)     /* loopback mode, 3 =3D e=
xternal loopback */
 #define I596_PROMISC    (s->config[8] & 0x01)
-#define I596_BC_DISABLE (s->config[8] & 0x02) /* broadcast disable */
-#define I596_NOCRC_INS  (s->config[8] & 0x08)
-#define I596_CRCINM     (s->config[11] & 0x04) /* CRC appended */
+#define I596_BC_DISABLE (s->config[8] & 0x02)   /* broadcast disable */
+#define I596_NOCRC_INS  (s->config[8] & 0x08)   /* do not append CRC to T=
x frame */
+#define I596_CRC16_32   (s->config[8] & 0x10)   /* CRC-16 or CRC-32 */
+#define I596_CRCINM     (s->config[11] & 0x04)  /* Rx CRC appended in mem=
ory */
 #define I596_MC_ALL     (s->config[11] & 0x20)
 #define I596_MULTIIA    (s->config[13] & 0x40)

@@ -134,9 +137,14 @@ struct qemu_ether_header {
 static void i82596_transmit(I82596State *s, uint32_t addr)
 {
     uint32_t tdb_p; /* Transmit Buffer Descriptor */
+    uint16_t cmd;
+    int insert_crc;

-    /* TODO: Check flexible mode */
+    cmd =3D get_uint16(addr + 2);
+    assert(cmd & 8);    /* check flexible mode */
     tdb_p =3D get_uint32(addr + 8);
+    /* check NC bit and possibly insert CRC */
+    insert_crc =3D (I596_NOCRC_INS =3D=3D 0) && ((cmd & 0x10) =3D=3D 0) &=
& !I596_LOOPBACK;
     while (tdb_p !=3D I596_NULL) {
         uint16_t size, len;
         uint32_t tba;
@@ -147,16 +155,43 @@ static void i82596_transmit(I82596State *s, uint32_t=
 addr)
         trace_i82596_transmit(len, tba);

         if (s->nic && len) {
-            assert(len <=3D sizeof(s->tx_buffer));
+            uint16_t new_len;
+            new_len =3D len + 4;
+            assert(new_len <=3D sizeof(s->tx_buffer));
             address_space_read(&address_space_memory, tba,
                                MEMTXATTRS_UNSPECIFIED, s->tx_buffer, len)=
;
+
+            if (I596_NO_SRC_ADD_IN =3D=3D 0) {
+                /* insert MAC in Tx Packet */
+                memcpy(&s->tx_buffer[ETH_ALEN], s->conf.macaddr.a, ETH_AL=
EN);
+            }
+
+            DBG(printf("i82596_transmit: insert_crc =3D %d  insert SRC =
=3D %d\n",
+                        insert_crc, I596_NO_SRC_ADD_IN =3D=3D 0));
+            if (insert_crc) {
+                uint32_t crc =3D crc32(~0, s->tx_buffer, len);
+                crc =3D cpu_to_be32(crc);
+                memcpy(&s->tx_buffer[len], &crc, sizeof(crc));
+                len +=3D sizeof(crc);
+            }
+
             DBG(PRINT_PKTHDR("Send", &s->tx_buffer));
-            DBG(printf("Sending %d bytes\n", len));
-            qemu_send_packet(qemu_get_queue(s->nic), s->tx_buffer, len);
+            DBG(printf("Sending %d bytes (crc_inserted=3D%d)\n", len, ins=
ert_crc));
+            switch (I596_LOOPBACK) {
+            case 0:     /* no loopback, send packet */
+                qemu_send_packet_raw(qemu_get_queue(s->nic), s->tx_buffer=
, len);
+                break;
+            case 1:     /* external loopback enabled */
+                i82596_receive(qemu_get_queue(s->nic), s->tx_buffer, len)=
;
+                break;
+            default:    /* all other loopback modes: ignore! */
+                break;
+            }
         }

         /* was this the last package? */
         if (size & I596_EOF) {
+            qemu_flush_queued_packets(qemu_get_queue(s->nic));
             break;
         }

@@ -175,6 +210,7 @@ static void set_individual_address(I82596State *s, uin=
t32_t addr)
     address_space_read(&address_space_memory, addr + 8,
                        MEMTXATTRS_UNSPECIFIED, m, ETH_ALEN);
     qemu_format_nic_info_str(nc, m);
+    DBG(printf("MAC addr set to %s\n", nc->info_str));
     trace_i82596_new_mac(nc->info_str);
 }

@@ -188,6 +224,7 @@ static void set_multicast_list(I82596State *s, uint32_=
t addr)
     if (mc_count > MAX_MC_CNT) {
         mc_count =3D MAX_MC_CNT;
     }
+    DBG(printf("Add %d multicast entries.\n", mc_count));
     for (i =3D 0; i < mc_count; i++) {
         uint8_t multicast_addr[ETH_ALEN];
         address_space_read(&address_space_memory, addr + i * ETH_ALEN,
@@ -212,7 +249,9 @@ void i82596_set_link_status(NetClientState *nc)
 static void update_scb_status(I82596State *s)
 {
     s->scb_status =3D (s->scb_status & 0xf000)
-        | (s->cu_status << 8) | (s->rx_status << 4);
+        | (s->CUS << 8) | (s->RUS << 4)
+        | 8 /* 8: bus throttle timers loaded */;
+    DBG(printf("update_scb_status 0x%04x CUS: %d, RUS: %d\n", s->scb_stat=
us, s->CUS, s->RUS));
     set_uint16(s->scb, s->scb_status);
 }

@@ -220,13 +259,13 @@ static void update_scb_status(I82596State *s)
 static void i82596_s_reset(I82596State *s)
 {
     trace_i82596_s_reset(s);
-    s->scp =3D 0;
+    DBG(printf("i82596_s_reset()\n"));
+    s->scp =3D 0x00FFFFF4;
     s->scb_status =3D 0;
-    s->cu_status =3D CU_IDLE;
-    s->rx_status =3D RX_SUSPENDED;
+    s->CUS =3D CU_IDLE;
+    s->RUS =3D RX_IDLE;
     s->cmd_p =3D I596_NULL;
     s->lnkst =3D 0x8000; /* initial link state: up */
-    s->ca =3D s->ca_active =3D 0;
     s->send_irq =3D 0;
 }

@@ -237,7 +276,7 @@ static void command_loop(I82596State *s)
     uint16_t status;
     uint8_t byte_cnt;

-    DBG(printf("STARTING COMMAND LOOP cmd_p=3D%08x\n", s->cmd_p));
+    DBG(printf("STARTING COMMAND LOOP cmd_p=3D0x%08x\n", s->cmd_p));

     while (s->cmd_p !=3D I596_NULL) {
         /* set status */
@@ -246,7 +285,8 @@ static void command_loop(I82596State *s)
         status =3D STAT_C | STAT_OK; /* update, but write later */

         cmd =3D get_uint16(s->cmd_p + 2);
-        DBG(printf("Running command %04x at %08x\n", cmd, s->cmd_p));
+        DBG(printf("Running command 0x%04x (cmd %d) at 0x%08x\n",
+                cmd, cmd & 7, s->cmd_p));

         switch (cmd & 0x07) {
         case CmdNOp:
@@ -264,11 +304,17 @@ static void command_loop(I82596State *s)
             /* config byte according to page 35ff */
             s->config[2] &=3D 0x82; /* mask valid bits */
             s->config[2] |=3D 0x40;
+            DBG(printf("I596_CONFIG3 =3D 0x%02x  LOOPBACK 0x%x\n", s->con=
fig[3], I596_LOOPBACK));
+            if (I596_NO_SRC_ADD_IN =3D=3D 0) {
+                assert((s->config[3] & 0x07) =3D=3D ETH_ALEN);
+            }
             s->config[7]  &=3D 0xf7; /* clear zero bit */
-            assert(I596_NOCRC_INS =3D=3D 0); /* do CRC insertion */
+            assert(I596_CRC16_32 =3D=3D 0); /* only CRC-32 implemented */
+            DBG(printf("I596_CRCINM =3D %d\n\n", I596_CRCINM));
             s->config[10] =3D MAX(s->config[10], 5); /* min frame length =
*/
             s->config[12] &=3D 0x40; /* only full duplex field valid */
             s->config[13] |=3D 0x3f; /* set ones in byte 13 */
+            s->scb_status |=3D SCB_STAT_CX;
             break;
         case CmdTDR:
             /* get signal LINK */
@@ -290,7 +336,7 @@ static void command_loop(I82596State *s)
         set_uint16(s->cmd_p, status);

         s->cmd_p =3D get_uint32(s->cmd_p + 4); /* get link address */
-        DBG(printf("NEXT addr would be %08x\n", s->cmd_p));
+        DBG(printf("NEXT loop addr is 0x%08x\n", s->cmd_p));
         if (s->cmd_p =3D=3D 0) {
             s->cmd_p =3D I596_NULL;
         }
@@ -301,71 +347,51 @@ static void command_loop(I82596State *s)
         }
         /* Suspend after doing cmd? */
         if (cmd & CMD_SUSP) {
-            s->cu_status =3D CU_SUSPENDED;
-            printf("FIXME SUSPEND !!\n");
+            s->CUS =3D CU_SUSPENDED;
+            printf("FIXME SUSPEND ?\n");
         }
-        /* Interrupt after doing cmd? */
-        if (cmd & CMD_INTR) {
-            s->scb_status |=3D SCB_STATUS_CX;
-        } else {
-            s->scb_status &=3D ~SCB_STATUS_CX;
-        }
-        update_scb_status(s);

         /* Interrupt after doing cmd? */
         if (cmd & CMD_INTR) {
+            s->scb_status |=3D SCB_STAT_CX;
             s->send_irq =3D 1;
         }

-        if (s->cu_status !=3D CU_ACTIVE) {
+        if (s->CUS =3D=3D CU_SUSPENDED) {
             break;
         }
     }
     DBG(printf("FINISHED COMMAND LOOP\n"));
-    qemu_flush_queued_packets(qemu_get_queue(s->nic));
-}
-
-static void i82596_flush_queue_timer(void *opaque)
-{
-    I82596State *s =3D opaque;
-    if (0) {
-        timer_del(s->flush_queue_timer);
-        qemu_flush_queued_packets(qemu_get_queue(s->nic));
-        timer_mod(s->flush_queue_timer,
-              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
-    }
 }

 static void examine_scb(I82596State *s)
 {
-    uint16_t command, cuc, ruc;
+    uint16_t command, cuc, ruc, c;

     /* get the scb command word */
     command =3D get_uint16(s->scb + 2);
+    DBG(printf("COMMAND =3D 0x%04x\n", command));
     cuc =3D (command >> 8) & 0x7;
     ruc =3D (command >> 4) & 0x7;
-    DBG(printf("MAIN COMMAND %04x  cuc %02x ruc %02x\n", command, cuc, ru=
c));
-    /* and clear the scb command word */
-    set_uint16(s->scb + 2, 0);
+    DBG(printf("MAIN CU COMMAND 0x%04x: stat 0x%02x cuc 0x%02x ruc 0x%02x=
\n",
+            command, command >> 12,  cuc, ruc));

-    if (command & BIT(31))      /* ACK-CX */
-        s->scb_status &=3D ~SCB_STATUS_CX;
-    if (command & BIT(30))      /*ACK-FR */
-        s->scb_status &=3D ~SCB_STATUS_FR;
-    if (command & BIT(29))      /*ACK-CNA */
-        s->scb_status &=3D ~SCB_STATUS_CNA;
-    if (command & BIT(28))      /*ACK-RNR */
-        s->scb_status &=3D ~SCB_STATUS_RNR;
+    /* toggle the STAT flags in SCB status word */
+    c =3D command & (SCB_STAT_CX | SCB_STAT_FR | SCB_STAT_CNA | SCB_STAT_=
RNR);
+    s->scb_status &=3D ~c;

     switch (cuc) {
     case 0:     /* no change */
+    case 5:
+    case 6:
         break;
     case 1:     /* CUC_START */
-        s->cu_status =3D CU_ACTIVE;
+        s->CUS =3D CU_ACTIVE;
         break;
     case 4:     /* CUC_ABORT */
-        s->cu_status =3D CU_SUSPENDED;
-        s->scb_status |=3D SCB_STATUS_CNA; /* CU left active state */
+        s->CUS =3D CU_IDLE;
+        s->scb_status |=3D SCB_STAT_CNA; /* CU left active state */
+        s->send_irq =3D 1;
         break;
     default:
         printf("WARNING: Unknown CUC %d!\n", cuc);
@@ -376,16 +402,17 @@ static void examine_scb(I82596State *s)
         break;
     case 1:     /* RX_START */
     case 2:     /* RX_RESUME */
-        s->rx_status =3D RX_IDLE;
-        if (USE_TIMER) {
-            timer_mod(s->flush_queue_timer, qemu_clock_get_ms(
-                                QEMU_CLOCK_VIRTUAL) + 1000);
-        }
+        s->RUS =3D RX_READY;
         break;
     case 3:     /* RX_SUSPEND */
+        s->RUS =3D RX_SUSPENDED;
+        s->scb_status |=3D SCB_STAT_RNR; /* RU left active state */
+        s->send_irq =3D 1;
+        break;
     case 4:     /* RX_ABORT */
-        s->rx_status =3D RX_SUSPENDED;
-        s->scb_status |=3D SCB_STATUS_RNR; /* RU left active state */
+        s->RUS =3D RX_IDLE;
+        s->scb_status |=3D SCB_STAT_RNR; /* RU left active state */
+        s->send_irq =3D 1;
         break;
     default:
         printf("WARNING: Unknown RUC %d!\n", ruc);
@@ -396,66 +423,92 @@ static void examine_scb(I82596State *s)
     }

     /* execute commands from SCBL */
-    if (s->cu_status !=3D CU_SUSPENDED) {
+    if (s->CUS =3D=3D CU_ACTIVE) {
         if (s->cmd_p =3D=3D I596_NULL) {
             s->cmd_p =3D get_uint32(s->scb + 4);
         }
+        command_loop(s);
+        s->CUS =3D CU_IDLE;
+        s->send_irq =3D 1;
     }

-    /* update scb status */
-    update_scb_status(s);
-
-    command_loop(s);
+    qemu_flush_queued_packets(qemu_get_queue(s->nic));
 }

 static void signal_ca(I82596State *s)
 {
-    uint32_t iscp =3D 0;
+    DBG(printf("-- CA start\n"));

     /* trace_i82596_channel_attention(s); */
     if (s->scp) {
+        uint32_t iscp;
+        uint8_t sysbus;
+        uint8_t mode;       /* MODE_82586 or MODE_LINEAR */
+
         /* CA after reset -> do init with new scp. */
-        s->sysbus =3D get_byte(s->scp + 3); /* big endian */
-        DBG(printf("SYSBUS =3D %08x\n", s->sysbus));
-        if (((s->sysbus >> 1) & 0x03) !=3D 2) {
-            printf("WARNING: NO LINEAR MODE !!\n");
-        }
-        if ((s->sysbus >> 7)) {
+        sysbus =3D get_byte(s->scp + 3); /* big endian */
+        DBG(printf("SYSBUS =3D %08x\n", sysbus));
+        mode =3D (sysbus >> 1) & 0x03;
+        /* Only MODE_LINEAR is currently implemented. */
+        assert(mode =3D=3D MODE_LINEAR);
+        if ((sysbus >> 7)) {
             printf("WARNING: 32BIT LINMODE IN B-STEPPING NOT SUPPORTED !!=
\n");
         }
         iscp =3D get_uint32(s->scp + 8);
         s->scb =3D get_uint32(iscp + 4);
+        DBG(printf("ISCP =3D 0x%08x, SCB =3D 0x%08x\n", iscp,s->scb));
+        /* set_uint32(iscp + 4, 0); NOT: clear SCB pointer */
         set_byte(iscp + 1, 0); /* clear BUSY flag in iscp */
+        /* sets CX and CNR to equal 1 in the SCB, clears the SCB command =
word,
+         * sends an interrupt to the CPU, and awaits another CA signal */
+        s->scb_status =3D SCB_STAT_CX | SCB_STAT_CNA;
+        s->CUS =3D CU_IDLE;
+        s->RUS =3D RX_IDLE;
         s->scp =3D 0;
+        s->send_irq =3D 1;
+        goto _cont;
     }

-    s->ca++;    /* count ca() */
-    if (!s->ca_active) {
-        s->ca_active =3D 1;
-        while (s->ca)   {
-            examine_scb(s);
-            s->ca--;
-        }
-        s->ca_active =3D 0;
-    }
+    examine_scb(s);
+
+_cont:
+    /* update scb status */
+    update_scb_status(s);
+
+    /* and clear the scb command word */
+    set_uint16(s->scb + 2, 0);

     if (s->send_irq) {
         s->send_irq =3D 0;
+        DBG(printf("Send IRQ\n"));
         qemu_set_irq(s->irq, 1);
     }
+    DBG(printf("-- CA end\n"));
 }

 void i82596_ioport_writew(void *opaque, uint32_t addr, uint32_t val)
 {
     I82596State *s =3D opaque;
-    /* printf("i82596_ioport_writew addr=3D0x%08x val=3D0x%04x\n", addr, =
val); */
-    switch (addr) {
+    uint32_t res, tmp;
+    DBG(printf("i82596_ioport_writew addr=3D0x%08x val=3D0x%04x\n", addr,=
 val));
+    switch (addr & PORT_BYTEMASK) {
     case PORT_RESET: /* Reset */
         i82596_s_reset(s);
         break;
+    case PORT_SELFTEST:
+        res =3D val + sizeof(uint32_t);
+        tmp =3D get_uint32(res); /* should be -1 */
+        DBG(printf("i82596 SELFTEST at 0x%04x val 0x%04x requested.\n", r=
es, tmp));
+        assert(tmp =3D=3D I596_NULL);
+        set_uint32(res, 0); /* set to zero */
+        break;
     case PORT_ALTSCP:
+        DBG(printf("i82596 ALTSCP requested.\n"));
         s->scp =3D val;
         break;
+    case PORT_ALTDUMP:
+        printf("i82596 PORT_ALTDUMP not implemented yet.\n");
+        break;
     case PORT_CA:
         signal_ca(s);
         break;
@@ -478,18 +531,15 @@ int i82596_can_receive(NetClientState *nc)
 {
     I82596State *s =3D qemu_get_nic_opaque(nc);

-    if (s->rx_status =3D=3D RX_SUSPENDED) {
-        return 0;
+    if (s->RUS !=3D RX_READY) {
+        /* return 0; */
     }

+    /* Link down? */
     if (!s->lnkst) {
         return 0;
     }

-    if (USE_TIMER && !timer_pending(s->flush_queue_timer)) {
-        return 1;
-    }
-
     return 1;
 }

@@ -500,7 +550,7 @@ ssize_t i82596_receive(NetClientState *nc, const uint8=
_t *buf, size_t sz)
     I82596State *s =3D qemu_get_nic_opaque(nc);
     uint32_t rfd_p;
     uint32_t rbd;
-    uint16_t is_broadcast =3D 0;
+    uint16_t status, is_broadcast =3D 0;
     size_t len =3D sz;
     uint32_t crc;
     uint8_t *crc_ptr;
@@ -508,14 +558,10 @@ ssize_t i82596_receive(NetClientState *nc, const uin=
t8_t *buf, size_t sz)
     static const uint8_t broadcast_macaddr[6] =3D {
                 0xff, 0xff, 0xff, 0xff, 0xff, 0xff };

-    DBG(printf("i82596_receive() start\n"));
-
-    if (USE_TIMER && timer_pending(s->flush_queue_timer)) {
-        return 0;
-    }
+    DBG(printf("i82596_receive() start, sz =3D %lu\n", sz));

     /* first check if receiver is enabled */
-    if (s->rx_status =3D=3D RX_SUSPENDED) {
+    if (s->RUS =3D=3D RX_SUSPENDED) {
         trace_i82596_receive_analysis(">>> Receiving suspended");
         return -1;
     }
@@ -527,14 +573,14 @@ ssize_t i82596_receive(NetClientState *nc, const uin=
t8_t *buf, size_t sz)

     /* Received frame smaller than configured "min frame len"? */
     if (sz < s->config[10]) {
-        printf("Received frame too small, %zu vs. %u bytes\n",
-               sz, s->config[10]);
-        return -1;
+        if (0) printf("Received frame too small, %lu vs. %u bytes\n",
+            sz, s->config[10]);
+        sz =3D 60; /* return -1; */
     }

     DBG(printf("Received %lu bytes\n", sz));

-    if (I596_PROMISC) {
+    if (I596_PROMISC || I596_LOOPBACK) {

         /* promiscuous: receive all */
         trace_i82596_receive_analysis(
@@ -598,69 +644,90 @@ ssize_t i82596_receive(NetClientState *nc, const uin=
t8_t *buf, size_t sz)
     }

     /* Calculate the ethernet checksum (4 bytes) */
-    len +=3D 4;
-    crc =3D cpu_to_be32(crc32(~0, buf, sz));
-    crc_ptr =3D (uint8_t *) &crc;
-
-    rfd_p =3D get_uint32(s->scb + 8); /* get Receive Frame Descriptor */
-    assert(rfd_p && rfd_p !=3D I596_NULL);
+    if (I596_CRCINM && !I596_LOOPBACK) {
+        len +=3D 4;
+        crc =3D crc32(~0, buf, sz);
+        crc =3D cpu_to_be32(crc);
+        crc_ptr =3D (uint8_t *) &crc;
+    }

-    /* get first Receive Buffer Descriptor Address */
-    rbd =3D get_uint32(rfd_p + 8);
-    assert(rbd && rbd !=3D I596_NULL);
+    rfd_p =3D get_uint32(s->scb + 8); /* get initial Receive Frame Descri=
ptor */
+    do {
+        assert(rfd_p && rfd_p !=3D I596_NULL);
+        status =3D get_uint16(rfd_p+0);
+        /* if rfd is filled, get next one from link addr */
+        if (status & STAT_OK)
+            rfd_p =3D get_uint32(rfd_p+4);
+    } while (status & STAT_OK);

     trace_i82596_receive_packet(len);
-    /* PRINT_PKTHDR("Receive", buf); */
+    DBG(PRINT_PKTHDR("Receive", buf));

     while (len) {
-        uint16_t command, status;
+        uint16_t command;
         uint32_t next_rfd;
+        uint32_t rba;
+        uint16_t rba_size;
+        uint32_t actual_count_ptr;

+        DBG(printf("Receive: rfd is 0x%08x, len =3D %lu\n", rfd_p, len));
         command =3D get_uint16(rfd_p + 2);
         assert(command & CMD_FLEX); /* assert Flex Mode */
-        /* get first Receive Buffer Descriptor Address */
+
+        /* get first Receive Buffer Descriptor address */
         rbd =3D get_uint32(rfd_p + 8);
-        assert(get_uint16(rfd_p + 14) =3D=3D 0);
+        assert(rbd && rbd !=3D I596_NULL);

-        /* printf("Receive: rfd is %08x\n", rfd_p); */
+        /* possibly store first bytes in rfd */
+        rba =3D rfd_p + 16;       /* 30 ?? data is behind the length fiel=
d */
+        rba_size =3D get_uint16(rfd_p + 14); /* count of additional bytes=
 in rfd */
+        actual_count_ptr =3D rfd_p + 12;

         while (len) {
-            uint16_t buffer_size, num;
-            uint32_t rba;
+            uint16_t num, actual_count;

-            /* printf("Receive: rbd is %08x\n", rbd); */
-            buffer_size =3D get_uint16(rbd + 12);
-            /* printf("buffer_size is 0x%x\n", buffer_size); */
-            assert(buffer_size !=3D 0);
+            DBG(printf("rba is at 0x%x, rba_size =3D %d, cnt_ptr 0x%08x\n=
", rba, rba_size, actual_count_ptr));

-            num =3D buffer_size & SIZE_MASK;
+            /* store number of received bytes first */
+            num =3D rba_size & SIZE_MASK;
             if (num > len) {
                 num =3D len;
             }
-            rba =3D get_uint32(rbd + 8);
-            /* printf("rba is 0x%x\n", rba); */
-            address_space_write(&address_space_memory, rba,
-                                MEMTXATTRS_UNSPECIFIED, buf, num);
+            actual_count =3D num;
+            if (num =3D=3D len) {
+                actual_count |=3D I596_EOF; /* set EOF BIT */
+            }
+
+            if (num) {
+                actual_count |=3D 0x4000; /* set F BIT */
+                set_uint16(actual_count_ptr, actual_count); /* write actu=
al count with flags */
+
+                address_space_write(&address_space_memory, rba,
+                                    MEMTXATTRS_UNSPECIFIED, buf, num);
+            }
             rba +=3D num;
             buf +=3D num;
             len -=3D num;
-            if (len =3D=3D 0) { /* copy crc */
+            if (len =3D=3D 0 && I596_CRCINM && !I596_LOOPBACK) { /* copy =
crc */
                 address_space_write(&address_space_memory, rba - 4,
                                     MEMTXATTRS_UNSPECIFIED, crc_ptr, 4);
             }

-            num |=3D 0x4000; /* set F BIT */
-            if (len =3D=3D 0) {
-                num |=3D I596_EOF; /* set EOF BIT */
+            if (len =3D=3D 0) { // do not get next rbd
+                break;
             }
-            set_uint16(rbd + 0, num); /* write actual count with flags */
+
+            if (rba_size & I596_EOF) /* last entry */
+                break;
+
+            DBG(printf("Receive: rbd is 0x%08x\n", rbd));
+            rba_size =3D get_uint16(rbd + 12);
+            rba =3D get_uint32(rbd + 8);
+            actual_count_ptr =3D rbd + 0;
+            assert(rba_size !=3D 0);

             /* get next rbd */
             rbd =3D get_uint32(rbd + 4);
-            /* printf("Next Receive: rbd is %08x\n", rbd); */
-
-            if (buffer_size & I596_EOF) /* last entry */
-                break;
         }

         /* Housekeeping, see pg. 18 */
@@ -671,8 +738,8 @@ ssize_t i82596_receive(NetClientState *nc, const uint8=
_t *buf, size_t sz)
         set_uint16(rfd_p, status);

         if (command & CMD_SUSP) {  /* suspend after command? */
-            s->rx_status =3D RX_SUSPENDED;
-            s->scb_status |=3D SCB_STATUS_RNR; /* RU left active state */
+            s->RUS =3D RX_SUSPENDED;
+            s->scb_status |=3D SCB_STAT_RNR; /* RU left active state */
             break;
         }
         if (command & CMD_EOL) /* was it last Frame Descriptor? */
@@ -683,24 +750,28 @@ ssize_t i82596_receive(NetClientState *nc, const uin=
t8_t *buf, size_t sz)

     assert(len =3D=3D 0);

-    s->scb_status |=3D SCB_STATUS_FR; /* set "RU finished receiving frame=
" bit. */
+    s->scb_status |=3D SCB_STAT_FR; /* set "RU finished receiving frame" =
bit. */
     update_scb_status(s);

     /* send IRQ that we received data */
-    qemu_set_irq(s->irq, 1);
-    /* s->send_irq =3D 1; */
+    if (I596_LOOPBACK) {
+        s->send_irq =3D 1;
+    } else {
+        qemu_set_irq(s->irq, 1);
+    }

     if (0) {
         DBG(printf("Checking:\n"));
         rfd_p =3D get_uint32(s->scb + 8); /* get Receive Frame Descriptor=
 */
-        DBG(printf("Next Receive: rfd is %08x\n", rfd_p));
+        DBG(printf("Next Receive: rfd is 0x%08x\n", rfd_p));
         rfd_p =3D get_uint32(rfd_p + 4); /* get Next Receive Frame Descri=
ptor */
-        DBG(printf("Next Receive: rfd is %08x\n", rfd_p));
+        DBG(printf("Next Receive: rfd is 0x%08x\n", rfd_p));
         /* get first Receive Buffer Descriptor Address */
         rbd =3D get_uint32(rfd_p + 8);
-        DBG(printf("Next Receive: rbd is %08x\n", rbd));
+        DBG(printf("Next Receive: rbd is 0x%08x\n", rbd));
     }

+    DBG(printf("i82596_receive() end sz =3D %lu\n", sz));
     return sz;
 }

@@ -711,7 +782,6 @@ const VMStateDescription vmstate_i82596 =3D {
     .minimum_version_id =3D 1,
     .fields =3D (VMStateField[]) {
         VMSTATE_UINT16(lnkst, I82596State),
-        VMSTATE_TIMER_PTR(flush_queue_timer, I82596State),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -725,9 +795,5 @@ void i82596_common_init(DeviceState *dev, I82596State =
*s, NetClientInfo *info)
                 dev->id, s);
     qemu_format_nic_info_str(qemu_get_queue(s->nic), s->conf.macaddr.a);

-    if (USE_TIMER) {
-        s->flush_queue_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                    i82596_flush_queue_timer, s);
-    }
     s->lnkst =3D 0x8000; /* initial link state: up */
 }
diff --git a/hw/net/i82596.h b/hw/net/i82596.h
index 1238ac11f8..0b1c0ce2aa 100644
=2D-- a/hw/net/i82596.h
+++ b/hw/net/i82596.h
@@ -10,7 +10,14 @@
 #define PORT_SELFTEST           0x01    /* selftest */
 #define PORT_ALTSCP             0x02    /* alternate SCB address */
 #define PORT_ALTDUMP            0x03    /* Alternate DUMP address */
-#define PORT_CA                 0x10    /* QEMU-internal CA signal */
+#define PORT_CA                 0x04    /* QEMU-internal CA signal */
+#define PORT_BYTEMASK           0x0f    /* all valid bits */
+
+/* modes in which the 82596 can operate */
+#define MODE_82586              0       /* 24 bit address space */
+#define MODE_32BIT_SEGMENTED    1
+#define MODE_LINEAR             2       /* 32 bit address space */
+#define MODE_UNKNOWN            3

 typedef struct I82596State_st I82596State;

@@ -23,22 +30,19 @@ struct I82596State_st {
     QEMUTimer *flush_queue_timer;

     hwaddr scp;         /* pointer to SCP */
-    uint8_t sysbus;
     uint32_t scb;       /* SCB */
     uint16_t scb_status;
-    uint8_t cu_status, rx_status;
+    uint8_t  send_irq;
+    uint8_t  CUS:3;     /* Command Unit status word in SCB */
+    uint8_t  RUS:4;     /* Receive Unit status word in SCB */
     uint16_t lnkst;
-
     uint32_t cmd_p;     /* addr of current command */
-    int ca;
-    int ca_active;
-    int send_irq;

     /* Hash register (multicast mask array, multiple individual addresses=
). */
     uint8_t mult[8];
     uint8_t config[14]; /* config bytes from CONFIGURE command */

-    uint8_t tx_buffer[0x4000];
+    uint8_t tx_buffer[1540];
 };

 void i82596_h_reset(void *opaque);
diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
index 52637a562d..dc37591ad8 100644
=2D-- a/hw/net/lasi_i82596.c
+++ b/hw/net/lasi_i82596.c
@@ -42,8 +42,8 @@ static void lasi_82596_mem_write(void *opaque, hwaddr ad=
dr,
         d->val_index++;
         if (d->val_index =3D=3D 0) {
             uint32_t v =3D d->last_val | (val << 16);
-            v =3D v & ~0xff;
-            i82596_ioport_writew(&d->state, d->last_val & 0xff, v);
+            v &=3D ~PORT_BYTEMASK;
+            i82596_ioport_writew(&d->state, d->last_val & PORT_BYTEMASK, =
v);
         }
         d->last_val =3D val;
         break;

