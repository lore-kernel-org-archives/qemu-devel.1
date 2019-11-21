Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F96C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:59:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD3A020672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="nTWHOfm+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD3A020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXqjn-000544-Km
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 12:59:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iXqae-0000Es-VU
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:50:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iXqae-00073e-46
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:50:00 -0500
Received: from mout.web.de ([212.227.15.3]:38935)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iXqad-000728-R9
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574358569;
 bh=/tWQRuIu4SR7FaDWRPHY2EoqGlYDYuB7/4qetBCJls0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=nTWHOfm+2sSk+XdI2d0ISmtpBkEhGngKui5Ir3sWpJX39x8SKt4dEBPMidcwavEEI
 8SMVzXbukXUwkIRW2O/A6Bh9kMtPT+qF7jLQaP3amO+/Q2Fh2Mj3kxmecWoQvqcyHv
 vl1kab2vYuLBhnROlG7sP+aYy/MmnxrSimPIqs2I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.160]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MP2Sl-1iS5IE1mMB-006QdI; Thu, 21
 Nov 2019 18:49:29 +0100
Date: Thu, 21 Nov 2019 18:49:24 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 1/4] block/quorum.c: stable children names
Message-ID: <ce10f8cf2bb9ae8a1505b59bbc2199f7b4966990.1574356137.git.lukasstraub2@web.de>
In-Reply-To: <cover.1574356137.git.lukasstraub2@web.de>
References: <cover.1574356137.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+QrQyax3xz6u5ZUK7gqFU8+jrbwvqLzy/3g+LfT4UXkF+aAouY9
 4XaTokmPEaiwucyueROhWtkLxWC6QGp69R2AoC83JlThb0n+f0exXZEOd5gylghQPkzrnYx
 megDTVBEEatB8WGd9GE8Qktmmgly5ec9XWgHfmY+XEBMATXT6uN2mXrt9P2r21Msq53K1mk
 /1PpvnuqOsCRfn1zY6XOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DzyybryLu1U=:wOwLHO64xJ/H5IOJSZbUIp
 xdU8C/3I/UckyQl21rGB6ojsLUBN33vYtR4FdnQZacLq860RM47b+LBiC72jtQw6uTYho5jNU
 +V3TibSUOH5HugF9yOw9zBFkNhLHbhTTSClJrORvKZz2cFVk302frynx8AfOxqAhqSyrEHUJO
 qUr4dnPFni2APZ2S6CG+42XKSRU48yrCl60c5LxJ2uV0bBBKn6zi0aV5PRdW/RT3Tq1FL5TBj
 UR9t5xzSNnxWJqN6UKlYqG8akDoLj41AnH7xcfSLmwc8pPfU1ZfiYCGzG/bOqMn7/TIp9jExx
 bSCTQLyA9DAc6q5omlXazxSUCz0mQK8n2GHzQZDkIo0tR7KipeNA6JwJ46Aa+o8UQaPu4S7Rx
 h4ygqjU/X1owkS91TXPV8xUebcCKgOO4KYe2Zkcvz0Cp3Yo8ikHDXLtLV46nGpx86GZyb66wD
 7g4IV9mox2hayx/WB/M4n0M5bUwSsyAvVeZV9XjEW86vd+n1cWjaJVYD/1/9iq4tN5ilQAY1U
 WvhsBg1I2pE1c5pAhEiCZyoMTYu1OezmgjZo1y2KaGqpEyt+OXgTcP390WzaZsre+DB7aXj9n
 GiV6eVttHt2+UxeRnzA/yphNp13hqSK2cE+K94bf1+3j2gFyStzTaslr1oxBDNt2pxj//0KxU
 g+cKvXldkmE6Fng7DkJnanBZiLPZ9yf3VotEEokFc3ZcDqw7jeoDIP8lhFm9OFJ6YxJORmxRU
 /817fuPZSar6cxThBQi8K7uNuoolzRoFu6syp9fZp7pTdx2GNhGJN51qiL0nm3NFvO/YlXMiZ
 AJOnl3o+zjkEWt4b57iDzPWWF+ppUtahBFMB4jMUc8MQll/keHP+5DPbGWzKkL45wbEjjPe1n
 EiaZC05tUH2yxegGtjPzPtBoPdqaTR2EE1VgYASbDoIn+rbhLpegUwQ94PsmShkdi4ws1fRrc
 pLh7pkJYdlaYctNL5V8ukhyGEIqN2pH8YB6hTzUrYVx0cyIp+lW91IipZlIkQ3P6nu37GISnC
 xDN65A7s6L8/ceKLOZi8bUjHvAfSxsanOWIaUQkn67OxLaEXywMuWEizwIsOQeabSUGUqedHd
 qvaZGyffJPze3+mQKm8KL9/tdxxhv8khf867eaL1ju3hfunRxc+Dsg4zd7kCf2IV4NFXApAlW
 2L7gbcMxxdhEs46gX8/xJWuL9PnqCqm6ReKVmAdmO7EgUKqOy6rcM23i2mGKZTyP9Dt/WddXN
 D/NkhvOH/daL2NnALQnczNpV0wRXIzqxVCt14u+o9L990LHOZia5fJ+WKUPs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.3
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we remove the child with the highest index from the quorum,
decrement s->next_child_index. This way we get stable children
names as long as we only remove the last child.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 block/quorum.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/quorum.c b/block/quorum.c
index df68adcfaa..6100d4108a 100644
=2D-- a/block/quorum.c
+++ b/block/quorum.c
@@ -1054,6 +1054,12 @@ static void quorum_del_child(BlockDriverState *bs, =
BdrvChild *child,
     /* We know now that num_children > threshold, so blkverify must be fa=
lse */
     assert(!s->is_blkverify);

+    unsigned child_id;
+    sscanf(child->name, "children.%u", &child_id);
+    if (child_id =3D=3D s->next_child_index - 1) {
+        s->next_child_index--;
+    }
+
     bdrv_drained_begin(bs);

     /* We can safely remove this child now */
=2D-
2.20.1


