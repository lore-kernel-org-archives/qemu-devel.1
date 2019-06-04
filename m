Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2256C04AB5
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 02:16:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECB1250FB
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 02:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hewHdWzf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECB1250FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43977 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXz04-0008VN-LX
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 22:16:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hXyzF-000853-UH
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 22:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hXyzE-0006eS-Ee
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 22:15:41 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:36064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hXyzD-0006Ep-Tw
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 22:15:40 -0400
Received: by mail-qk1-x744.google.com with SMTP id g18so1852423qkl.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 19:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=JLiv5abDVFbLnIY1IKuCfX1ZsuGLizQfKZM4y3KF+48=;
	b=hewHdWzf0zkVWQ1kUxQ9RI5u4+WTZqKkD6OOFuTh8epNeLJ5yg2Y0vqarsRrdglZ7Z
	UAInBgVSwe+taGsR4t1pJVD5v6h1t0/0+VocNj+CHJJL70WAdq80XWaT5enYVBMFCZ/0
	ERf/DWCsOGKnvC3i+FWtGIJ7WytaeJL4QAY1alKSWmaoc+RC/raIIzF1u/6DH9fDMv7l
	kIX3SSiRBvze2jCO/qj0s6npD+wrC5V5E0GFtqTh/zBdOgoz0sZHYQ2WFoHoanQkoEjd
	/04jtQJTZ3Vlu8f5uA0lcbUF54G29ngtah+w8B9DyqyzmTWPbfRMhSkoYBDZ6fvyGozl
	eb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=JLiv5abDVFbLnIY1IKuCfX1ZsuGLizQfKZM4y3KF+48=;
	b=iYmFR1e9QlazCBFn9XHNmh1DWMtfvYvyxIzoKrvMNDMcmprI+nOi611pqEubgcPQ3V
	6lLQ9g9efwFMv6UXo3LN5XKkkvDTfC/qIz9z3laHZonDxoocO1Rsn3P3/fH2wo2oz9X9
	r1pQc9sTdEI3CFFy/CBZllxX1wgcfAh9WEHk92XXUXJtdolonenTkDp3YaksLyde59D1
	CPssKypvZ3EZtWcbhkn6yNv3/XQ5ZJ0EkmUfGIjoSN5ZYlpEDylaiZlPlMckroXQ5G9i
	BPbyS79ZfsVFmIvw4R6+fuk+916TACpcRbCP+8d0kVaETZEDM8moLdY90cDiu95HYF0T
	OEWA==
X-Gm-Message-State: APjAAAUqQ6ePLEleRxhTav1wQXCBO2kKgjSzuBFCm0Ceq4tquVc3DPUA
	tvhoOlcm9dk9K/jH2+wZsuJUBe0kOm5l23/DETo=
X-Google-Smtp-Source: APXvYqxMVTJrOaOjX7FdEmRNOrbr/PAP5T66XjaZUElkxv+QWfGTALTzF0VdXre5UHgTbQqwX/dCv2kOm5MK9vuyDgI=
X-Received: by 2002:a37:e40a:: with SMTP id y10mr1314135qkf.303.1559614515923; 
	Mon, 03 Jun 2019 19:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190529070955.25565-1-xieyongji@baidu.com>
	<20190529070955.25565-3-xieyongji@baidu.com>
	<20190603221639.5e4ddac1@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190603221639.5e4ddac1@bahia.lab.toulouse-stg.fr.ibm.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Tue, 4 Jun 2019 10:15:04 +0800
Message-ID: <CAONzpcZrDS0XiEz7san49FQ1BT3CeHTe3k+F6Z=L-mhVTdcfzQ@mail.gmail.com>
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [PATCH 2/5] virtio: Migrate the "start_on_kick"
 flag
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel <qemu-devel@nongnu.org>, Xie Yongji <xieyongji@baidu.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Jun 2019 at 04:16, Greg Kurz <groug@kaod.org> wrote:
>
> On Wed, 29 May 2019 15:09:52 +0800
> elohimes@gmail.com wrote:
>
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > We should migrate the "start_on_kick" flag so that we
> > would not miss starting device on kicking at startup
> > after migration.
> >
>
> Hmm... IIUC "start_on_kick" means "virtio 1.0 transitional device that has
> not been started yet", ie:
>
> !vdev->started &&
> (virtio_host_has_feature(vdev, VIRTIO_F_VERSION_1) &&
>  !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1))
>
> If so, not sure why you need this extra field in the first place, but
> you probably don't need to migrate it. Just recalculate in a post load
> callback.
>

Good idea! Will recalculate this in virtio_load() in v2. Thank you.

Thanks,
Yongji

