Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5A5C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:21:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B952921473
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 11:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHKcbk/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B952921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQVV3-0005dt-Mf
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 07:21:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hQVUE-00054l-5N
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hQVUD-0001Aq-8b
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:20:46 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hQVUC-00019i-WA
	for qemu-devel@nongnu.org; Tue, 14 May 2019 07:20:45 -0400
Received: by mail-wr1-x443.google.com with SMTP id c5so18721005wrs.11
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=bgBMpTCMNLCK26Kqndnd3AJ1Ok3A71IDOIWMZ79Wr14=;
	b=KHKcbk/huhRfzzGi6p1A5LfQ6wLBy9GL68iflwe2M4qMXw+m2lHYqrK8bECI+G36dG
	A/OJYYjHlDLzwvKK55aZDJ079bM+nEXz7ryAEE1h+j22NKIGM8kG4mTApB+2C3zu33Jg
	Wb2Z+bDTmRr9boC0+ZAxdgtXQ5QXF2Wqh5S6L69Cxjsy/4e3iCIeCujKFlHZXX7zlcsv
	hf39M/PAKDku0skl4WssWF8H+sQmcNWMW8lw6W48QJcso1nafQ6pbUIa/rs2ZBiNj6f9
	DDLJLZHQnmUORE0Gl4oEr6gDhpzhqVDld/EArA+TsjlwYcZaNdCuOCdbXRi6mDxR2ypt
	gyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=bgBMpTCMNLCK26Kqndnd3AJ1Ok3A71IDOIWMZ79Wr14=;
	b=U3PK6cat0fOJHux5fsERPKvrsUkgGa/QZiRb035sWHKGySUOpL/beB5Dnw57as7z1b
	qcOmyhy12kRhF9X7aIKlL0lJ9TLB1OIDLvK35TQkJYr9lHGp8PywEk/dFV2dwTguimiD
	yxTjvxCmWHuUtEbBuvbz8qyFW94TvX3opqF4OcOs5gaiTmq8OJpHqLfpqacaT2Uu/rZE
	NmbMAYQkA+fgtCMXfy6B526Ec42is6pj+NNS8lA69zLF3FiRaKCnWyqnQfxk1XcW3GXB
	g5uDuZLS81wCumfZk/oyDgn/b8qvbzG5FQcwoejICFx9PcVuIH6FgBE4xZCIMEmEI0xb
	W+dw==
X-Gm-Message-State: APjAAAU+dAOOrsM2c5LDt6PCjBeG8BLjaMG7IwGyVi6xyOYT/jlIQ36v
	Qq81ImbxgyDhJ1bqqrgXRsRxubT+6rkt82GrZ8w=
X-Google-Smtp-Source: APXvYqyObUjl1R6Ji/528axfrk0oBmDFh5CiaaWg0GCIypON9omBr5jyqwuTKrLzB7N/lcmfP4D0bkZxJpD/7AaFPTk=
X-Received: by 2002:adf:b641:: with SMTP id i1mr21149350wre.288.1557832843514; 
	Tue, 14 May 2019 04:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190513184433.21038-1-marcandre.lureau@redhat.com>
	<20190513184433.21038-2-marcandre.lureau@redhat.com>
	<20190514053747.os6lwvzwhe2ojsuu@sirius.home.kraxel.org>
In-Reply-To: <20190514053747.os6lwvzwhe2ojsuu@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 14 May 2019 13:20:31 +0200
Message-ID: <CAJ+F1CLO2Wn1kJYrR5DYcyOXnM1e0JToZ7CJruhWbYEbWbeRHg@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v7 1/8] vhost-user: add
 vhost_user_gpu_set_socket()
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Tue, May 14, 2019 at 7:38 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > +VhostUserGpuCursorUpdate
> > +^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > ++-----+-------+-------+--------+
> > +| pos | hot_x | hot_y | cursor |
> > ++-----+-------+-------+--------+
> > +
> > +:pos: a ``VhostUserGpuCursorPos``, the cursor location
> > +
> > +:hot_x/hot_y: ``u32``, the cursor hot location
> > +
> > +:cursor: ``[u32; 64 * 64]``, 64x64 RGBA cursor data
>
> Should clarify here what exactly RGBA is. (PIXMAN_a8r8g8b8 I guess).

ok

>
> > +VhostUserGpuUpdate
> > +^^^^^^^^^^^^^^^^^^
> > +
> > ++------------+---+---+---+---+------+
> > +| scanout-id | x | y | w | h | data |
> > ++------------+---+---+---+---+------+
> > +
> > +:scanout-id: ``u32``, the scanout content to update
> > +
> > +:x/y/w/h: ``u32``, region of the update
> > +
> > +:data: RGBA data (the size is computed based on the region size, and
> > +       the request type)
>
> Likewise.  Also: alpha channel for the framebuffer?

It is actually PIXMAN_x8r8g8b8, fixed

>
> > +C structure
> > +-----------
> > +
> > +In QEMU the vhost-user-gpu message is implemented with the following s=
truct:
> > +
> > +.. code:: c
> > +
> > +  typedef struct VhostUserGpuMsg {
> > +      uint32_t request; /* VhostUserGpuRequest */
> > +      uint32_t flags;
> > +      uint32_t size; /* the following payload size */
>
> uint32_t padding;
>
> > +      union {
> > +          VhostUserGpuCursorPos cursor_pos;
> > +          VhostUserGpuCursorUpdate cursor_update;
> > +          VhostUserGpuScanout scanout;
> > +          VhostUserGpuUpdate update;
> > +          VhostUserGpuDMABUFScanout dmabuf_scanout;
> > +          struct virtio_gpu_resp_display_info display_info;
> > +          uint64_t u64;
>
> ... so this 64bit value will be aligned.

vhost-user didn't bother. Should we?


--=20
Marc-Andr=C3=A9 Lureau

