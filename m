Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8DAC4345A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 23:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2187020809
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 23:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7JYZ4eH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2187020809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0CZy-0002vq-DJ
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 19:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k0CYo-0001yR-5t; Mon, 27 Jul 2020 19:29:34 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34800)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1k0CYm-00072f-Nl; Mon, 27 Jul 2020 19:29:33 -0400
Received: by mail-oi1-x244.google.com with SMTP id q4so4116226oia.1;
 Mon, 27 Jul 2020 16:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=PbOFtq4EVL8HMfXcVPjsoJQLl3EKrYvQnhatQPGSjvc=;
 b=B7JYZ4eHgfBTuz1EaSA6t6CSyCUcHhmArF1fYl4FpyH8ZulBKNv+4EyCFMxMGZgHAR
 zlFHhI4wugYiLTLM5TQf9dcNAoE7rQE6zXD3VJKxP2S3Rbv/xZ9RnQiH67pltInvVqSJ
 juZ52W4TTZj7GVoIsK3YYkQjPapii6F3ONPJXAdH0lTPkCYd4ramxixdbgZu4HqEyrtd
 eqXtt5GtHizbgzs7uCXFtQTbZuG4zM6a/f7xMTjXFjfUDOw2FevmmW8Lvqb+bLwXa96C
 5nItoNhDXGmiAYzrs/fyowE7QLEtMThNqWRnJVOKCz9YBVko8eJk3oJnP2ELLYDDU8ea
 xw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=PbOFtq4EVL8HMfXcVPjsoJQLl3EKrYvQnhatQPGSjvc=;
 b=IvC+zp1zcAFdpnXn87hbybFYzw6QDzJrg8hAdEEw2WZbfdiCemR21u9iSJ2LFcqOXx
 Ha0KfZxPnfNb/trizGtGtJQTC4BAWR5jAFBsVZSh3PndXmyfxNAvyIe+QeHVr/SCSsfo
 9byNc8DF9UtAyjpngNUMCBjxqKl/XvDR85Kd92g5l986cFT0QEFb5XVdoTEJJAFQg2EL
 f9LQPlpOOTHLI/T43jUObtz2i/XKEWKDvmBkb+DECXDnhoDAKvRKg5pZAYi0bLYnVYEE
 TgDJ5yeIiK2aMcBydgvI4Zm/b3wKdCoavO6x4uooj57yn6pXUitmRnrmdQ6FNUTPmJx8
 mABg==
X-Gm-Message-State: AOAM532PKRqJjzWuujy1EBrlKn8yQAwwM4xKyxj/1mDsFOBv30wCnWGn
 h2ExSq0RZwspMMdwgfGOgQI=
X-Google-Smtp-Source: ABdhPJxPpamKcMzRygZ/mCmA1M2nFocudL69OKkIK8HFHanJJb+S5QY433SA7/8w8uD+SDrUJQeL6Q==
X-Received: by 2002:aca:c356:: with SMTP id t83mr1304220oif.25.1595892571159; 
 Mon, 27 Jul 2020 16:29:31 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id r22sm2669551ooq.37.2020.07.27.16.29.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 27 Jul 2020 16:29:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20200722044028.4059-1-thuth@redhat.com>
References: <20200722044028.4059-1-thuth@redhat.com>
Message-ID: <159589255850.31322.957505175034587602@sif>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 0/4] Allow guest-get-fsinfo also for non-PCI devices
Date: Mon, 27 Jul 2020 18:29:18 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-s390x@nongnu.org,
 =?utf-8?b?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>,
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Thomas Huth (2020-07-21 23:40:24)
> The information that can be retrieved via UDEV is also usable for non-PCI
> devices. So let's allow build_guest_fsinfo_for_real_device() on non-PCI
> devices, too. This is required to fix the bug that CCW devices show up
> without "Target" when running libvirt's "virsh domfsinfo" command (see
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1755075 for details).
> =

> v2:
>  - Use g_new0 instead of g_malloc0 (as suggested by Daniel)
>  - Init fields to -1 explicitely, not via memset (Daniel)
>  - Add the fourth patch to also fill in virtio information on s390x

Thanks, patches 2-4 applied to qga-staging tree for 5.2:
  https://github.com/mdroth/qemu/commits/qga-staging

I've sent a pull request for 5.1 with patch 1/4

> =

> Thomas Huth (4):
>   qga/qapi-schema: Document -1 for invalid PCI address fields
>   qga/commands-posix: Rework build_guest_fsinfo_for_real_device()
>     function
>   qga/commands-posix: Move the udev code from the pci to the generic
>     function
>   qga/commands-posix: Support fsinfo for non-PCI virtio devices, too
> =

>  qga/commands-posix.c | 157 ++++++++++++++++++++++++++++++-------------
>  qga/qapi-schema.json |   2 +-
>  2 files changed, 110 insertions(+), 49 deletions(-)
> =

> -- =

> 2.18.1
>=20

