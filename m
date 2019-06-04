Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201D3C04AB5
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 01:42:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE0442184C
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 01:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aG8YA80r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE0442184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43636 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXyTK-0002m6-Ru
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 21:42:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hXySS-0002PU-6R
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 21:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hXySR-00069m-46
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 21:41:48 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:42685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hXySQ-00065h-Qs
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 21:41:47 -0400
Received: by mail-qt1-x844.google.com with SMTP id s15so11890687qtk.9
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 18:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=AXPxIj9gAyr4JNcxPY+aslM7lYJ49ackIR8Pyl+pQls=;
	b=aG8YA80rWUJxlCiMOfMuIFs557paaztQB++HBhcQIbLoKhRqe6RBmCaf5D9PtB+2Qw
	m7ZTZHIJl1XnRvj8yJMxOyuKs2Bt8lmUZct7bjs8UN60bjQD76CKBPoH8zyeynfqoBRm
	JlD9c/ge4SYxBhWHuht74QILuol/7IDDJGzuO4wDzLdCWc4l4IVw54iKkzdiA86ka/d4
	xAAR3z4Ij5sSZ9AOG63wxJCTLKLN3tRHbrAnfJRSvxC+lf/W3WJC+068oxxBWa2w1C7L
	eWQUQqSbCjDnplUOGAWe68IkLS5yNLy8PQMl3z9d3jQHkf5RKDYajgvPOLXUCZdYuwOt
	+25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=AXPxIj9gAyr4JNcxPY+aslM7lYJ49ackIR8Pyl+pQls=;
	b=i34ZOldxMyBKU/FRsik1KW9+Q2vJBIpP5acUQAj/zKkutgINdWzyiXuUBcc3qZO31k
	coVVx8kFHTvuaDQ83ZxnSXCicCbIOauKkkM2gUYweRncoBh9khbkzrnS+YlMmhXuvyJF
	l1WGJK0N+5YE9Ge2qPXgTQDKX4hsAAPGs4V44gxfrj+wuFIiiErV/s7WTbK0w6OYTRTt
	rBhcSeyeeV24tvtj3Bl917Cv7zKMEJKCdlhePJTP4Njs6W64TGKVHiaTctHZokYq0Pxs
	LnMWoYpXUHg6QCgMYje7saR5l3LOUGBlew02b8MIehZ/hDed0Pxo+ImjeTStuoIixYhR
	CgNg==
X-Gm-Message-State: APjAAAW3c2ftz+jerPOSo+iRJHTVWbc46Sa8zgKMQGdiDh0y+xBdygLK
	G6RE9/VqbX2CEARmk9iNjToJilqZz42oSyq+GeQ=
X-Google-Smtp-Source: APXvYqz11POk0RovWHYWbwT1Dyxz4NUfdkrK1+0Ht1uBJAEgmzD1gFX8ps8QN1IYqwD7yWOx2K5XbTzFWECLO27KOUg=
X-Received: by 2002:a0c:b59c:: with SMTP id g28mr24727505qve.171.1559612505297;
	Mon, 03 Jun 2019 18:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190529070955.25565-1-xieyongji@baidu.com>
	<20190529070955.25565-2-xieyongji@baidu.com>
	<20190603185318.659015e0@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190603185318.659015e0@bahia.lab.toulouse-stg.fr.ibm.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Tue, 4 Jun 2019 09:41:34 +0800
Message-ID: <CAONzpcZ6JaG3bY1D6T+ruQ-Go84dkcPCbBFO2_+Er_GAuDAmLA@mail.gmail.com>
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH 1/5] virtio: Set "start_on_kick" on
 virtio_set_features()
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

On Tue, 4 Jun 2019 at 00:53, Greg Kurz <groug@kaod.org> wrote:
>
> On Wed, 29 May 2019 15:09:51 +0800
> elohimes@gmail.com wrote:
>
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > The guest feature is not set correctly on virtio_reset() and
> > virtio_init(). So we should not use it to set "start_on_kick" at that
> > point. This patch set "start_on_kick" on virtio_set_features() instead.
> >
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > ---
>
> Maybe add a Fixes: badaf79cfdbd3 ?
>

Will add it in v2. Thanks for review.

Thanks,
Yongji

