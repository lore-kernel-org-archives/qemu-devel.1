Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF9CC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 20:07:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED0B21582
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 20:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y98V1p9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AED0B21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWmnU-0000k0-Se
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 16:07:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jWmms-0000K3-Qz; Thu, 07 May 2020 16:06:30 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:42200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jWmmr-0006br-TM; Thu, 07 May 2020 16:06:30 -0400
Received: by mail-il1-x144.google.com with SMTP id t12so2890756ile.9;
 Thu, 07 May 2020 13:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=UsVrLH10VrnwJQa3T0/DmLttPhHiMDiEHKItwQOxx8k=;
 b=Y98V1p9ni2qBeYG5aE9BfaNxuHD201ux5KkijNRt8ortzHfq/+ZSj6w3FjrHD+GqmI
 LgmW8WpIrn0gdy9ATMoQQxKLk3LhZBiQ9bHi6SW3/XMLfiffYd213mkKsrAgboqxtg0M
 vP2w6m3Nl5Iur8t+aZEkSfw0hMeEI5w5lGFilQtUfn1rpu60NPKe/xWwUPTcm0Ym1XTi
 VsGvx0QsgxveL14fbPFGb5FOZnz++79Mxwzp/CK46BF956Xg91aaVpnwoFQYQ4dLHAg0
 us1B81YVBoCWrmMX7RBTaZ87DkI6lrJId1KkCQNcV9CJkQ6BX6V7r23uhlAUfPqxlFO/
 nJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=UsVrLH10VrnwJQa3T0/DmLttPhHiMDiEHKItwQOxx8k=;
 b=uh+TPSWpSPqxdBLaaBJ6YThgM/2K5oJtgMgs1cCnGazuo+Ul83eiA+NAR3Vg1Vv6WO
 ShIb0DnVEFHy+dcoYh0WFCa94Pmzc6WXNb2vEzzo5v6UPROiT0mY/dLSVT7/Xgj1qCMU
 ul7gkB5pwgb684yy8/QRYzoNhw2K8xcXIL5ZIfZJG7+uTtXcdFRZnOFbihwU4zFdsAvZ
 qQwmHtFEwgXyZ+CWai0A7mEDhdLiql/4Nk9F6+9bD8+cskh5LmmAw5NZAvCc0yxxZTxF
 Iazrb8+bY3g5AA001xPmUUJe/omAJlnNpU4ou4q59g3SNsu3i0vwE3hBQq9n8pAwv05c
 3jjw==
X-Gm-Message-State: AGi0PuYTBJeWaT1IsAiINeZBKrPPYrZGBuwfF8fluNnie24ZRsV+l9/s
 /pLpB0Jab9l91crlUp+6GTlsq+kGGfkIdn7w/andQPApBfHDaA==
X-Google-Smtp-Source: APiQypJsbW+/rYVV7BOLtIm2mSe2FCSduu+zYHB37JhBZyY9htOqpUh0o1yb7XMJ1fsdv+fgcFQax2tOEd0W1j41E60=
X-Received: by 2002:a92:cb4c:: with SMTP id f12mr17225133ilq.263.1588881988086; 
 Thu, 07 May 2020 13:06:28 -0700 (PDT)
MIME-Version: 1.0
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 7 May 2020 16:06:17 -0400
Message-ID: <CAFubqFt+KVJFYCEimgdTYRiiBm9y9ZRvSshxRv0kizRcUZTkLQ@mail.gmail.com>
Subject: [PATCH] Fix erroneous double negation in conditional
To: qemu-devel@nongnu.org, mst@redhat.com, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::144;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

In vhost_migration_log() there is the following check:
    if(!!enable =3D=3D dev->log_enabled) {
        return 0;
    }

The double negative =E2=80=9C!!=E2=80=9D is unnecessary and bad coding styl=
e. This
change removes it.

Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
---
 hw/virtio/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index aff98a0..83be0c8 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -814,7 +814,7 @@ static int vhost_migration_log(MemoryListener
*listener, int enable)
     struct vhost_dev *dev =3D container_of(listener, struct vhost_dev,
                                          memory_listener);
     int r;
-    if (!!enable =3D=3D dev->log_enabled) {
+    if (enable =3D=3D dev->log_enabled) {
         return 0;
     }
     if (!dev->started) {
--
1.8.3.1

