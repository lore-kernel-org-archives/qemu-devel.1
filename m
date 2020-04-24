Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90714C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:33:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CEE520767
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 15:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dV7TWQsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEE520767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS0Kt-0007Wc-6M
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 11:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52526)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jS0Ep-0005vY-GH
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:27:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1jS0El-0003aH-Hj
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:27:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:48797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1jS0Ek-0003MU-Qn
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 11:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1587742044;
 bh=RQnxRAcFfTxYO/TOjWAL/mMIQX+VJMuKrw42U0l0Plg=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dV7TWQsSQhGzJTQIJCWhANenSCMZRFTZt3DJkJ+nTYFpGFz449Uuv1d5aeQgS4/aE
 NSgN0pyDbs1RTM6lzqHHjekmMdSfpM9CQJR4aTq8xQVpPP7xFRueVyi24CR8GGk+JV
 KyyAirPKVqSGG84f+/6EVIMCCF2ZjvMpmPApIuSQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.192]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M8hVB-1jW8xp1iML-004gRf; Fri, 24
 Apr 2020 17:27:24 +0200
Date: Fri, 24 Apr 2020 17:27:22 +0200
From: Helge Deller <deller@gmx.de>
To: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 0/3] hw/net/tulip: Fix LP#1874539
Message-ID: <20200424152722.GA14573@ls3530.fritz.box>
References: <20200423231644.15786-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200423231644.15786-1-f4bug@amsat.org>
X-Provags-ID: V03:K1:4dNWKUzRLYSHObzkcuxR6uFCsy/P0QBxniQyGOzDTlZ4au+47yy
 GO3YtWS/AWXueohxUhyXxpmU2U3QAEQLmlIBa1/mHVKRg6AGISHn9tBL4HcGOqUHyM41XVM
 eHWAe6MdmaX+XHFWdesTkcgFSUB4CaCjrlKf5EMVm7t/37ki9UAh2mlNfC2Z+e8kGFtM3Ag
 Yd3heX322OFBZbFjwlcrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yahWAu9YBMQ=:05iJucDu3PeleJ10aLxMIU
 oZjLK432UD8usqXoR7qUxemguvg3703AWK1MPQimiDtW8+ZKWqZLyAAnP+T3vbBKt3Ugz1AkQ
 rROzTHqVvHLh5iCd2qeT2m8xt2L62ms2EoxbCVBS2/0AXf4EWKz/F4MBi/xOSX/q9vTbjQJvg
 xZQjE8tKlYIY3UC9bI2S0KWWBefnlHY+lu00ovLgjr5bNtlmcUZoaaVSASgWMRXW4SfQVhJ/X
 0uMoCSjuDpXc4u3UIgZhepQML+6EuO3bFtm2/w/Fv9SlYwvqdSof0295nTL48ZH7Bqc/NnIl8
 PjC5G1UKLKOEOe6QJ0rWXmLXeOBjatCqbUADDXh+4cjDxWmyaPl/pwrbQrfinqikefOJ3mf5a
 HPZcqlyQu1Zcq+tpfWGwK80UWByOmhi2eZYzYtwsN3IJIQBAu+qQQ+PULFMurQ/Wgl9CxFLsU
 uETEzzxRTQYD4A3O/o7fceAarEIxeImT1/7NuFAOWNSFrIeuPBb+cjnz6QUFZzY6BDqFg42i5
 drAfWDBqaiyhfzsut3Nbxz6bjBWSTcJwgtf22GoLJs3VL2oZOV8n9M2tuvJTvSINESivipcGM
 uljfc3DcxRuOeAKV93FyYVGQ3pip7uxo10SQf7kSXa8GqXXkv+abZsuhLtSqWUPCA2pW+NRC2
 6fWCEGSMnoZyawqdW27oUw/MFc7WGBIyJ7ghHhdbl5xtk2pj/jVdcA4v0Rm8mfrY0EsQQr4WK
 AcWrY7qrmzEd/LcfZeuj4drryRjnUe+T56SjphIOYHGScAXjiD+kHHSz7Uc8pJYYH2lOK9qHl
 +EzJvvxczYL6mrgl8IFCt1OwQaL6i2cOmTRqoacjmMOjeIs+EXRoo2X75iQAl78givu7DPxNl
 yCo8sENezF7bo7HXaQJthduzCgWGExsn/WkFWYX0sRuhXw2ZytaymTfD4nHjfJv4J/lKanRNe
 PzrXIPn8StRMhTisXLDIG0k0MAcrgl8tv6kFCBE4N60DWcjVpbvCXJtiboUkqoZOcOoD0g69n
 HGH9VrKCMr3ZFEbLXBk67T7vTzHW+HoAA+RzRVSnc9WN/vP+mgt5eRR0qMuybeNCUaNxE+f5Q
 fRRE5ByB3UehdfLXCpyTs5Zg+2LLZbgDgkZXd/B8wZZZngyEVenb8hr55uB5dNjXI2H/NUMq/
 7zyRDwAOpngWct3sOxT8YBlUMKchzQRYgVyF2uipxRbUy1wsC2QQILZex0YoclmFYYapDKRgr
 As/UsFWKM3RZvSWZt
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 09:42:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.21
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
Cc: Jason Wang <jasowang@redhat.com>, Helge Deller <deller@gmx.de>,
 Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 <f4bug@amsat.org>:
> Attempt to fix the launchpad bug filled by Helge:
>
>   In a qemu-system-hppa system, qemu release v5.0.0-rc,
>   the tulip nic driver is broken.  The tulip nic is detected,
>   even getting DHCP info does work.  But when trying to
>   download bigger files via network, the tulip driver gets
>   stuck.
>
> Philippe Mathieu-Daud=E9 (3):
>   hw/net/tulip: Fix 'Descriptor Error' definition
>   hw/net/tulip: Log descriptor overflows
>   hw/net/tulip: Set descriptor error bit when lenght is incorrect
>
>  hw/net/tulip.h |  2 +-
>  hw/net/tulip.c | 32 ++++++++++++++++++++++++++++----
>  2 files changed, 29 insertions(+), 5 deletions(-)

Philippe, thanks for your efforts. Sadly your patch did not fixed the
bug itself, but it had some nice cleanups which should be included at
some point.

Regarding the tulip hang reported by me, the patch below does fix the
issue.

[PATCH] Fix tulip rx hang
Cc: Prasad J Pandit <pjp@fedoraproject.org>
Fixes: 8ffb7265af ("check frame size and r/w data length")
Buglink: https://bugs.launchpad.net/bugs/1874539
Signed-off-by: Helge Deller <deller@gmx.de>

Commit 8ffb7265af ("check frame size and r/w data length") introduced
checks to prevent accesses outside of the rx/tx buffers. But the new
checks were plain wrong. rx_frame_len does count backwards, and the
surrounding code ensures that rx_frame_len will not be bigger than
rx_frame_size. Remove those checks again.

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index 1295f51d07..59d21defcc 100644
=2D-- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -171,9 +171,6 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct =
tulip_descriptor *desc)
             len =3D s->rx_frame_len;
         }

-        if (s->rx_frame_len + len > sizeof(s->rx_frame)) {
-            return;
-        }
         pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
             (s->rx_frame_size - s->rx_frame_len), len);
         s->rx_frame_len -=3D len;
@@ -186,9 +183,6 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct =
tulip_descriptor *desc)
             len =3D s->rx_frame_len;
         }

-        if (s->rx_frame_len + len > sizeof(s->rx_frame)) {
-            return;
-        }
         pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
             (s->rx_frame_size - s->rx_frame_len), len);
         s->rx_frame_len -=3D len;

