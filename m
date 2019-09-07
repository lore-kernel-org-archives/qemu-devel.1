Return-Path: <SRS0=eB96=XC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB46C433EF
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 23:30:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4302173B
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2019 23:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B4302173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6k9s-0006TR-9o
	for qemu-devel@archiver.kernel.org; Sat, 07 Sep 2019 19:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35982)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1i6k95-00061S-NV
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 19:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1i6k94-0002SL-M2
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 19:29:31 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:46056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1i6k94-0002QN-BD
 for qemu-devel@nongnu.org; Sat, 07 Sep 2019 19:29:30 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id D197018A4B;
 Sun,  8 Sep 2019 01:29:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CW7jqoRKWvvk; Sun,  8 Sep 2019 01:29:26 +0200 (CEST)
Received: from function (lfbn-bor-1-306-163.w109-215.abo.wanadoo.fr
 [109.215.28.163])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 01F8918A40;
 Sun,  8 Sep 2019 01:29:25 +0200 (CEST)
Received: from samy by function with local (Exim 4.92.1)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1i6k8y-0007ny-NH; Sun, 08 Sep 2019 01:29:24 +0200
Date: Sun, 8 Sep 2019 01:29:24 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Chris Heinze <c.heinze@precibake.com>
Message-ID: <20190907232924.a2maha6jyf7u6xbb@function>
References: <0115e29c-2254-09c3-13d5-6dfb5307d968@precibake.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qy7ufycfnhsepnej"
Content-Disposition: inline
In-Reply-To: <0115e29c-2254-09c3-13d5-6dfb5307d968@precibake.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a0c:e300::1
Subject: Re: [Qemu-devel] slirp, incoming packets get truncated
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qy7ufycfnhsepnej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

As usual, several things here.

Chris Heinze, le mar. 03 sept. 2019 17:02:15 +0200, a ecrit:
> root@guest:~# tcpdump -ni eth0 port 19003
> tcpdump: verbose output suppressed, use -v or -vv for full protocol decode
> listening on eth0, link-type EN10MB (Ethernet), capture size 262144 bytes
> 16:49:39.430959 IP 10.0.2.2.33294 > 10.0.2.15.19003: UDP, bad length 9000 > 1472

tcpdump seems to be showing dumb output here. The packet is fragmented
by slirp, which makes tcpdump confused and show only the first
fragment. If you let tcpdump print everything, you will see the other
fragments. In reality, everything is going fine here.

> i tried to change slirp/src/if.h to: 
> 
> #define IF_MTU 9000
> #define IF_MRU 9000
> 
> but the resulting qemu-system-x86_64 binary did not behave differently.

Did you explicitly remove the qemu-system-x86_64 binary? As mentioned
previously on the list, there seems to be a missing Makefile dependency.

Now, with MTU set to 9000, the packets just don't go at all. Could you
try the attached patch? The lowest layer of slirp was indeed limited to
1600-byte frames for no good reason. With this and the virtio driver, I
could exchange 9000-byte packets.

Samuel

--qy7ufycfnhsepnej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/src/slirp.c b/src/slirp.c
index b0194cb..3fd6f68 100644
--- a/src/slirp.c
+++ b/src/slirp.c
@@ -890,20 +890,22 @@ static int if_encap6(Slirp *slirp, struct mbuf *ifm, struct ethhdr *eh,
  */
 int if_encap(Slirp *slirp, struct mbuf *ifm)
 {
-    uint8_t buf[1600];
-    struct ethhdr *eh = (struct ethhdr *)buf;
+    uint8_t *buf;
+    struct ethhdr *eh;
     uint8_t ethaddr[ETH_ALEN];
     const struct ip *iph = (const struct ip *)ifm->m_data;
     int ret;
 
-    if (ifm->m_len + ETH_HLEN > sizeof(buf)) {
-        return 1;
-    }
+    buf = g_malloc(ifm->m_len + ETH_HLEN);
+    if (!buf)
+        return 0;
+    eh = (struct ethhdr *)buf;
 
     switch (iph->ip_v) {
     case IPVERSION:
         ret = if_encap4(slirp, ifm, eh, ethaddr);
         if (ret < 2) {
+            g_free(buf);
             return ret;
         }
         break;
@@ -911,6 +913,7 @@ int if_encap(Slirp *slirp, struct mbuf *ifm)
     case IP6VERSION:
         ret = if_encap6(slirp, ifm, eh, ethaddr);
         if (ret < 2) {
+            g_free(buf);
             return ret;
         }
         break;
@@ -929,6 +932,7 @@ int if_encap(Slirp *slirp, struct mbuf *ifm)
               eh->h_dest[5]);
     memcpy(buf + sizeof(struct ethhdr), ifm->m_data, ifm->m_len);
     slirp_send_packet_all(slirp, buf, ifm->m_len + ETH_HLEN);
+    g_free(buf);
     return 1;
 }
 

--qy7ufycfnhsepnej--

