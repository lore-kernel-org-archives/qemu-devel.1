Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63836C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28BD9206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzO8STMD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28BD9206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOmI-0006PA-6p
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOOdZ-0000wF-N1
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:42:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOOdY-0006Mo-A0
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:42:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23900
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOLec-0008CQ-Im
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 09:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586871066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=42lVAfyseGz1VGufIzij+GuSVkOjvcpSK4kWq6V6gmk=;
 b=HzO8STMDDgZl5dL2Y9vXGJvm/TKx/4/4TO97T/alIxOK00ACgBuNHKJub7/T6sGouLPqEP
 TxT7h1cJdTZyxmAI2+8fLtqwCds+qSAjIm5JBTEynbB1OVidlwUKxNDrPPOfq2WYFGpu/O
 pPoxn0+AVNAuXnAPro6Z9wytXk9bY6Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-8hi55XSEM5WwVFPGRdm9Nw-1; Tue, 14 Apr 2020 09:31:02 -0400
X-MC-Unique: 8hi55XSEM5WwVFPGRdm9Nw-1
Received: by mail-wr1-f72.google.com with SMTP id m5so5560435wru.15
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 06:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kGKRmnKwmRxlOxdVqgxjmKtx9Q2hpJOt1NAPPmcNK0Y=;
 b=ikeU5bX9d8W19zyu85KnMn4Mx0PIIIq0HdRZ/qY3lYAabXGsJJknR/uZ+RsXd/1knY
 AxYvcloxgA8u9kM0kotDQ/nAQG0G19w2GRb7mw50YUvo2aNBlOp7QgMt7KA3mOvJdcg8
 ouhDBs8pKfTH5d3UkZTjg6+uwhPeIxxO/GF28vSgDzDpxqkOhmC3yZf1OdFQUYzr6vN1
 CW2qnu7v9KyLJmn3x291Fog1ptwnQfa7oLMcyAURitg6jq08wQRTrgDOiJDhwUlOuvvp
 AOxfQHK0rJid3VUsGtrMepoZYJWLIFpWNZ74B/oE9vbFalmF+xMWkFXjzqw7rg3T6slJ
 mGBg==
X-Gm-Message-State: AGi0PubfwuUNQCAj5bnz/QcenVYL2CdDPyBo5m3a9aGTrUPH1gKhdbAd
 1N/iJ2DR2qA/gBAwUdSwNG/EWmt6HHmI0KN6u2ht9wsxK17INGcNrHf3wqiBrL1H+voOr/uJ5Go
 upsEdV1BfGb6M7n8=
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr23523422wmh.175.1586871060655; 
 Tue, 14 Apr 2020 06:31:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypLviEloVTS1cRcyC6vYEbzQ4KMafGY7ljn+PIpkM/EA0pUQsfi5Ks+nCt7hSSsjIbmhL666ZQ==
X-Received: by 2002:a1c:ed1a:: with SMTP id l26mr23523395wmh.175.1586871060392; 
 Tue, 14 Apr 2020 06:31:00 -0700 (PDT)
Received: from x1w.redhat.com (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id q8sm18307453wmg.22.2020.04.14.06.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2020 06:30:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 01/12] Revert "prevent crash when executing
 guest-file-read with large count"
Date: Tue, 14 Apr 2020 15:30:41 +0200
Message-Id: <20200414133052.13712-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414133052.13712-1-philmd@redhat.com>
References: <20200414133052.13712-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Fabien Chouteau <chouteau@adacore.com>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As noted by Daniel Berrang=C3=A9 in [*], the fix from commit 807e2b6fce
which replaced malloc() by try_malloc() is not enough, the process
can still run out of memory a few line later:

 346     buf =3D g_try_malloc0(count + 1);
 347     if (!buf) {
 348         error_setg(errp,
 349                    "failed to allocate sufficient memory "
 350                    "to complete the requested service");
 351         return NULL;
 352     }
 353     is_ok =3D ReadFile(fh, buf, count, &read_count, NULL);
 354     if (!is_ok) {
 355         error_setg_win32(errp, GetLastError(), "failed to read file");
 356         slog("guest-file-read failed, handle %" PRId64, handle);
 357     } else {
 358         buf[read_count] =3D 0;
 359         read_data =3D g_new0(GuestFileRead, 1);
                         ^^^^^^

Instead we are going to put a low hard limit on 'count' in the next
commits. This reverts commit 807e2b6fce022707418bc8f61c069d91c613b3d2.

[*] https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg03471.html

Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 qga/commands-win32.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index b49920e201..46cea7d1d9 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -343,13 +343,7 @@ GuestFileRead *qmp_guest_file_read(int64_t handle, boo=
l has_count,
     }
=20
     fh =3D gfh->fh;
-    buf =3D g_try_malloc0(count + 1);
-    if (!buf) {
-        error_setg(errp,
-                   "failed to allocate sufficient memory "
-                   "to complete the requested service");
-        return NULL;
-    }
+    buf =3D g_malloc0(count + 1);
     is_ok =3D ReadFile(fh, buf, count, &read_count, NULL);
     if (!is_ok) {
         error_setg_win32(errp, GetLastError(), "failed to read file");
--=20
2.21.1


