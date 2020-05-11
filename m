Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D0CC38A2A
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 00:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C905208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 00:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE4Ckfo3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C905208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXvw9-0008ST-KD
	for qemu-devel@archiver.kernel.org; Sun, 10 May 2020 20:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jXvvF-0007fQ-Ud; Sun, 10 May 2020 20:03:53 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:33520)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jXvvE-00020t-W6; Sun, 10 May 2020 20:03:53 -0400
Received: by mail-io1-xd41.google.com with SMTP id k18so7757768ion.0;
 Sun, 10 May 2020 17:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Uv/X3iiOLnYG9v+VxWYmpj3ltl/9g7O73FepiAxM5NI=;
 b=FE4Ckfo3He5aL3NnPMXjHlVGr9dAjJWTJk0NGEucYggBOROsgLl56jfuhvumS1a2Ph
 Fajf3k9vIA0Q3EEYpEWO9y5mytU0D6se8fo7fjY3P4UxtUBhdsQ2AxZQvF6HAbR2hltC
 dZQryRgwzb4tXdn0RCy1PZCkovP9RPr5K9aJ7vUGh+dIlVm2LkroplgfsoHJ7VcnZWDo
 2jBlzyHBqcHGlNIWYvdFlcaHoTZS72FEd4G3TqU40zQ0nTLauAdlR/yWeBEcxgaZAm/y
 g37l99Fctwtb9VU9im+Y+Ck/fppiUAIotQZoHvHC3bPyvQHO6RNM2VwT6Gc/bm3y6YAt
 2S7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Uv/X3iiOLnYG9v+VxWYmpj3ltl/9g7O73FepiAxM5NI=;
 b=TldUqD92JAGivFuuNCYCDi8N+n3hoyHKy1NfhlwiQiujAl2wCKqZbYWtsIXP4oF5uL
 tDon6a8Bp8o069zkZUYaEnuckAdweJBOaZSW7NiSetp+EjNg7IDol5F5HgcLF2XraccR
 Q97fy1M1akEdOjh3yIE37kpDVbUgLguzMJUI/irdvFEsmsy+VfoYn5B7UscJ6KYV9Xat
 V50R+NKJCyOQ13RV6TzJ3GNMZw8udH9TlPwfPuMXNQ6cwsadcVdjwX9FK7FyFeMz0IIe
 +0PAY1lmvWUgoI9LLmDXXW/ou25lS0jnMlW36GnW+V8UnNaBXB3DWfdAtsGlzA9eaMwR
 engQ==
X-Gm-Message-State: AGi0PuYV5m21EULGdvWBLc6TpWQr5S48N8kTKHi5urRFjoEkhPsk9gUd
 f65Vz4VlNU8caMW2zAmFynBOYTVvc2IKB7Wbp58=
X-Google-Smtp-Source: APiQypJ7CRXGeDTQlVoidEaOvEQHID4ijFJYXzbYUFvojOqtTNGu2GrK9GqhzSF8VtH2+WjED07eJMb3SDvCx4HBIFY=
X-Received: by 2002:a05:6602:5c9:: with SMTP id
 w9mr2499853iox.207.1589155430427; 
 Sun, 10 May 2020 17:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588252861.git.dimastep@yandex-team.ru>
 <d25241eb1fe7a55fc7dbe63ecedb4f1adf407837.1588252862.git.dimastep@yandex-team.ru>
 <CAFubqFsvn+wNm-rAU1sLBic6J70-ZP_UT4xMDcvGeZ9TarYdjw@mail.gmail.com>
 <20200507153530.GA6808@dimastep-nix>
In-Reply-To: <20200507153530.GA6808@dimastep-nix>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Sun, 10 May 2020 20:03:39 -0400
Message-ID: <CAFubqFv_ZPXPBrZpQ=JU69BjJmRK4ePGd2ATtf0rpEUmXNVsKA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] vhost: add device started check in migration set
 log
To: Dima Stepanov <dimastep@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd41.google.com
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
Cc: fam@euphon.net, kwolf@redhat.com, stefanha@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, raphael.norwitz@nutanix.com,
 arei.gonglei@huawei.com, fengli@smartx.com, yc-core@yandex-team.ru,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 7, 2020 at 11:35 AM Dima Stepanov <dimastep@yandex-team.ru> wro=
te:
>
> What do you think?
>

Apologies - I tripped over the if (dev->started && r < 0) check.
Never-mind my point with race conditions and failing migrations.

Rather than modifying vhost_dev_set_log(), it may be clearer to put a
check after vhost_dev_log_resize()? Something like:

--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -829,11 +829,22 @@ static int vhost_migration_log(MemoryListener
*listener, int enable)
         vhost_log_put(dev, false);
     } else {
         vhost_dev_log_resize(dev, vhost_get_log_size(dev));
+        /*
+         * A device can be stopped because of backend disconnect inside
+         * vhost_dev_log_resize(). In this case we should mark logging
+         * enabled and return without attempting to set the backend
+         * logging state.
+         */
+        if (!dev->started) {
+            goto out_success;
+        }
         r =3D vhost_dev_set_log(dev, true);
         if (r < 0) {
             return r;
         }
     }
+
+out_success:
     dev->log_enabled =3D enable;
     return 0;
 }

This seems harmless enough to me, and I see how it fixes your
particular crash, but I would still prefer we worked towards a more
robust solution. In particular I think we could handle this inside
vhost-user-blk if we let the device state persist between connections
(i.e. call vhost_dev_cleanup() inside vhost_user_blk_connect() before
vhost_dev_init() on reconnect). This should also fix some of the
crashes Li Feng has hit, and probably others which haven=E2=80=99t been
reported yet. What do you think?

If that=E2=80=99s unworkable I guess we will need to add these vhost level
checks. In that case I would still prefer we add a =E2=80=9Cdisconnected=E2=
=80=9D flag
in struct vhost_dev struct, and make sure it isn=E2=80=99t cleared by
vhost_dev_cleanup(). That way we don=E2=80=99t conflate stopping a device w=
ith
backend disconnect at the vhost level and potentially regress behavior
for other device types.

