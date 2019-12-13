Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13719C2D0C9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924AD2465A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IrntwNBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924AD2465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifsFW-0007Jz-ST
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 16:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ifsEp-0006tU-VT
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 16:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ifsEo-000303-MB
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 16:12:39 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:45550)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ifsEo-0002xQ-Ge
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 16:12:38 -0500
Received: by mail-oi1-x231.google.com with SMTP id v10so1885858oiv.12
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2019 13:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5w0ChjojtBXEdgjarQfmok1s37IRkPKwN0axGhDM0RY=;
 b=IrntwNBa2V0mMJVsIS8fqHIbMwhZxAttnqBaetxlryLZ2LHbP+NRmiyZu7m0Ihjoh0
 /SWXv0bOu57eDaGKVihBcPd4SA+xvrm+hiGJPyVyTC5GK7vdm05C0kmxW0uPENIQNudR
 Kxml8V1Wyel+5KGMNjRHBzpp73lKICOk29zG9rC5/DkI4LuRbi2g5qg0TN1oq9A04WXG
 wj4x/jMPOP0pKQXNcCPggMihd00FIbdwbzPZ6Iruie6kiif5e7d88Ibh9TMOXc2XUrZc
 V3qvW/PpMpnVXsA0aBpZcQJneAHNyfwM7XT6CI/ods83IPk+eT8oiS7YAxyfJel2QChh
 O5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5w0ChjojtBXEdgjarQfmok1s37IRkPKwN0axGhDM0RY=;
 b=F10fsHaXO5cUk2lOUoTEIeWRn5foytOQn6hugLgGWSflvIeNPwULqo2VDJvkkSnDkj
 88ISpO2vzyVKPAJT44gRyWqbnvY/J3uiRLVNnhknzDFxOBhzhXKaAT36lvmM2daHm13h
 yAK5GnN6KhXr+Q4giYkLE6WD1jGv8gttwmH4ylfHnEA0umosND6frnYOIsEvYkZzcu4H
 pd058IDaAG9p5Hchz/jEV2xnqgglAaY6xywv24NWDB/qWinfC9cKNPYhYPRSBLU2lCzG
 XnoQ0BjUZn5qHX0ygl8KoiU2WGCzIgJz7VYqTdMtn44+t/+RAQuECA04cy9VotQvcymr
 GnJQ==
X-Gm-Message-State: APjAAAWLm0YUBELVh3a+4GNWUgG2rlj4LQiBm/rdbsA4Pn4AwC+Nf/Nx
 XvSi+IQlJlSYDRe7GG+k6TdlXmxCQpB3wISOYnwRKA==
X-Google-Smtp-Source: APXvYqxjUx5O9x/vQ4U3p1/b1sSv37mUSAX0pZn8zaTTQ+LgbE3jDgI3V58S4VKq8Oscx4KvfW2F7PXOF8hTLQ7neeg=
X-Received: by 2002:aca:f5cc:: with SMTP id t195mr7998752oih.163.1576271557497; 
 Fri, 13 Dec 2019 13:12:37 -0800 (PST)
MIME-Version: 1.0
References: <20191213161851.24687-1-cohuck@redhat.com>
In-Reply-To: <20191213161851.24687-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Dec 2019 21:12:18 +0000
Message-ID: <CAFEAcA8O=ezHAQKKr9zrA0M_TE-FbnHmict5K8_+5v64BDoTxA@mail.gmail.com>
Subject: Re: [PULL 00/16] first s390x update for 5.0
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Dec 2019 at 16:19, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit b0ca999a43a22b38158a222233d3f5881648bb4f:
>
>   Update version for v4.2.0 release (2019-12-12 16:45:57 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20191213
>
> for you to fetch changes up to b147562019dd845a224cde7a37c219f9848d1b8d:
>
>   qga: fence guest-set-time if hwclock not available (2019-12-13 12:16:50 +0100)
>
> ----------------------------------------------------------------
> First s390x update for 5.0:
> - compat machines (also for other architectures)
> - cleanups and fixes in reset handling
> - fence off guest-set-time, as we have no hwclock
> - fix some misuses of the error API
> - further cleanups
>
> ----------------------------------------------------------------
>

Hi -- this has conflicts. Most of them I could probably fix up,
but this one in particular:

diff --cc hw/s390x/s390-virtio-ccw.c
index cb5fe4c84d,e0e28139a2..0000000000
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@@ -645,9 -658,10 +658,13 @@@ static void ccw_machine_4_2_instance_op

  static void ccw_machine_4_2_class_options(MachineClass *mc)
  {
++<<<<<<< HEAD
++=======
+     ccw_machine_5_0_class_options(mc);
++>>>>>>> remotes/cohuck/tags/s390x-20191213
      compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
  }
- DEFINE_CCW_MACHINE(4_2, "4.2", true);
+ DEFINE_CCW_MACHINE(4_2, "4.2", false);

  static void ccw_machine_4_1_instance_options(MachineState *machine)
  {


I don't know whether we want the 'true' or 'false' version...

Could you rebase and resend, please?

thanks
-- PMM

