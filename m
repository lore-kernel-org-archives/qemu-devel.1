Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FCAC76188
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 08:59:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904A0206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 08:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="RbJmLHUv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904A0206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hp7go-0007DN-Kj
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 04:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36412)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jan.kiszka@web.de>) id 1hp7ge-0006mc-TA
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 04:59:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.kiszka@web.de>) id 1hp7gd-0000kv-VT
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 04:59:20 -0400
Received: from mout.web.de ([212.227.15.4]:48241)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1hp7gd-0000kL-Ll
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 04:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1563699539;
 bh=BgVHCqMV9kYqHmM6YflW+6U7k61mP6X3jN0LmTNskhU=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=RbJmLHUvXRS2bIFgw7YVzVk7SQBFIUuMi3u5aYiHAfLLc4KAjEadbq1ghsz5yLZ7v
 3BsKArwVnQKF1/auTh64xgSc8BtGTg+cSbvPs/wJuUNDWOEsTKy/cAACh+UZvkiDLB
 HYokt3T0cdTq3mkZYZgnyVtjEoOJlKWYDtKATNLA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.10] ([95.157.55.156]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MIeCm-1hrJXf1IBU-002DCY; Sun, 21
 Jul 2019 10:58:59 +0200
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <f056c7e5-fa74-469c-87f8-0f0925301b2d@web.de>
Date: Sun, 21 Jul 2019 10:58:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MpVCjj8bxFHYrhoTDLoGakmm5jix/BFm7UywFGShpe1PmrkF01J
 NYEnZUS9y21mxEmbZdVeuGiY8jhW3GKIJEGuOmGRGKE8Tp5SNQikSmzgnwkudINr+DOPrPs
 GM604ijkdgUFTtnqtgUUkqNC2NZTZsHqG7hmhnwh5H9JYJZzTGGk9fyofxD2fBk1ZTv76AE
 NGzvQBxwb3948iDykpq9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CzFu6ydovZc=:eOGLl5H2ju1utVYv2s8EPS
 ELVOWtzNFSZ/v2sP3shMqqN0X50rT6pPEX2e5II4hwBae/72EDdfl8jSmXJNSAp4BaVRT2fHM
 cxk1XkyCqfXYO+Urcim5L42w+B8V5iyNZ0bnbefz0TbQlcK04C8T7nlsBVhrhiKm1jcVgkPU8
 djK8/YAVI3oJI9bCbB5RwHAnZa9xK4+ZsY3Y7d1Xv6vGFA8PxvZUHJMH1r7v330D2IULLFdT0
 z4enEk/8+ha4KEvGrHVUNOo2iW+mhGg3gQVZkJoy2ii/q2OTTYWkD1/fIfHqWPx0qGBb0bXo2
 dD5BJZusX3xHa43xQr2ezWhRN5XcPO8Aog9PrJBT+6ZTOsPqFPgajY7wcaG/lgxkExhTETJEq
 EJHNBzZElLla38jXcsMloTBBVnD8IcsVJ7NLiSI3BH8Je/+mbkMoORMRarvUeU1gf3sTQVVUS
 t1Ib1DgjR8EbS/FnCUrHv+ngf7s6zXAJO/OAgtszR/eotqGVNIQmZBqPaJJbc9g72VDthGipw
 IytpjItdWy7nW1XRp/otfvkHvX7+fbYNvQjya3JKxSYrOBH4wGol3JLvAdHbvRI1J7mH5k06q
 w3PmNOOwtXX4nNfAfjT3T9UbZDhS/vunzdFezkkaptSK9PrjpvYFQt60Lh2PuapB7Mfl/kdLr
 1UQXdEj50Ju+8+gl4JAcjjUuh/qop7UppBEwIChVRZ661LmHiG/24+9qYDk+FEg4on5pUihKl
 37sr+2ysLp2fF8Kho/VNOYLkMKiJQdyY3JgetCRV8iXuYf2T+LsWND1Pb3bOJFTkUam997tD/
 9gK+Jw6gRx8GbmUIbSibeOYuBKM6C/y0EwDnH4CEl5d0GYCrwspgoidhb6nc4KRlNEPV6gqrQ
 oRYrqiCdzWkrTeRkkpH4/ChcvUJa/I87fCghxT39YyVUGaGkHKGmpztAjnR1oYId80fofU1ko
 Pnf6spqH/8t6Tnfh4w14qZ1FlDEiN0SI5x1uj9ZpM8rOVIy5E5Tkn7/n9wPLhjp39c03xM4Ov
 fb9au99hjnHfN+eZj6/vALRqlcP9kP5+mwdwLxSSpwpTDuR6WqeZlT9H4+jzww2/M/rFdj0ba
 JNBSUUHsqqbCUybbcENmQl6kLvp1Z+zsADU
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.4
Subject: [Qemu-devel] [PATCH] i386/vmmouse: Properly reset state
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

From: Jan Kiszka <jan.kiszka@siemens.com>

nb_queue was not zeroed so that we no longer delivered events if a
previous guest left the device in an overflow state.

The state of absolute does not matter as the next vmmouse_update_handler
call will align it again.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
=2D--
 hw/i386/vmmouse.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index 5d2d278be4..e335bd07da 100644
=2D-- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -257,6 +257,7 @@ static void vmmouse_reset(DeviceState *d)
     VMMouseState *s =3D VMMOUSE(d);

     s->queue_size =3D VMMOUSE_QUEUE_SIZE;
+    s->nb_queue =3D 0;

     vmmouse_disable(s);
 }
=2D-
2.16.4

