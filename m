Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D193DC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F4420872
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 13:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnmwGCn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F4420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJGGl-0005ft-3W
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 09:17:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42858)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kJGEg-0004HQ-5L; Fri, 18 Sep 2020 09:15:34 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1kJGEe-0000jW-4o; Fri, 18 Sep 2020 09:15:33 -0400
Received: by mail-oi1-x241.google.com with SMTP id u126so6901821oif.13;
 Fri, 18 Sep 2020 06:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kbv90g/EGvJlo0gZF94zV9oH3RJjA6HGGwk777Orl6A=;
 b=HnmwGCn00KgZGVMBxjcdvyx9hK0VzLYpQAoxrhezSrSHu08IeMWD0iVSwneSu8JrPZ
 Xf1YLXoiANoM3Ub5GwClVVS0A8qDxQgn3rL6Mny7Le2QF7X7NHf7OaYhPYvA/G8hv40G
 bahDlgHyrc3mBjogo1cgdCGXqnyF8MTLMo/eJRgW3OWC/vKBzyyOc8cSTRs00KtTQxnh
 AzD5RN8TGQUpJEycNyejElbrHGOOJRume/RBgps1RSuoDXr6GFXnQXgWfKv6sgEQXx7B
 LMea9U6AXK1S6jdC1Xw+sjlNJXLQstv4f9X6rEChCnfW4s/f+sI3jEp6DLOfuvC8aqrm
 sFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kbv90g/EGvJlo0gZF94zV9oH3RJjA6HGGwk777Orl6A=;
 b=CaMTaPkATndImDJpCJQq1SOs1ednGBfkhGl7edTnPycBmw1RVuHsLUtQJ6uD/mCgvA
 FBIHPb3fJga6Az/lwRJZ7bcgyDYz+rp70sw1/UJNakRaQZFNuhKAoJh/y1ODfO/y35kp
 kP3tXMNCctVR8gAikX2M/Kv5tegbVq3HvwfhvNvP1gB+FGWUK8kotoXQ03goAHLDW2vn
 s7cUp4lzrnHyf37U/qzcOW3lQwShS0l9ZOSZqrAc1upMEffIuJqVhMuhD674k6CC8p3a
 yjqev2dNQVm/+uSdB6NsJ51iuDjcDJmsMScpraGiOaDi7pq1Agv/BpqIZv7rsa3/xZIN
 9+Mg==
X-Gm-Message-State: AOAM533UL41Aq8x5ewmEEannwtlnuMboILLkdjw5r245wHEENCxqJTAX
 Q+TYAbn14iXzuTCGj5AtupT9u6PLezOHV5b0SL8=
X-Google-Smtp-Source: ABdhPJxtREF18AlxtVKMTGX4XkS0GLNVTLQ+w7oGv21DnbKL9RHN55wO7g8PvOTRFuxqGo4kSGjpr8a/BREija5rqk4=
X-Received: by 2002:aca:904:: with SMTP id 4mr9644458oij.97.1600434930240;
 Fri, 18 Sep 2020 06:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200903183138.2161977-1-ppandit@redhat.com>
 <CAKXe6SLv1HX5_ty2SP5F_MkVKYO-tz5fNOKhpqZr0mH_ePypSA@mail.gmail.com>
 <nycvar.YSQ.7.78.906.2009181427350.10832@xnncv>
In-Reply-To: <nycvar.YSQ.7.78.906.2009181427350.10832@xnncv>
From: Li Qiang <liq3ea@gmail.com>
Date: Fri, 18 Sep 2020 21:14:54 +0800
Message-ID: <CAKXe6SL6BFErCqk+AJt2iQiQsCN_EvHJCur=Y8J1yz7F_c8t4A@mail.gmail.com>
Subject: Re: [PATCH v2] hw/ide: check null block before _cancel_dma_sync
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Ruhr-University <bugs-syssec@rub.de>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8818=E6=97=A5=E5=
=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:26=E5=86=99=E9=81=93=EF=BC=9A
>
> +-- On Fri, 18 Sep 2020, Li Qiang wrote --+
> | Update v2: use an assert() call
> |   ->https://lists.nongnu.org/archive/html/qemu-devel/2020-08/msg08336.h=
tml
> ...
> | I think it is better to defer this check to 'ide_cancel_dma_sync'.
> | 'ide_cancel_dma_sync' is also called by 'cmd_device_reset' and all of t=
he
> | handlers of 'ide_cmd_table' will check whether the 's->blk' is NULL in =
the
> | beginning of 'ide_exec_cmd'.
> |
> | So I think it is reasonable to check 's->blk' at the begining of
> | 'ide_cancel_dma_sync'.
>
> * Yes, earlier patch v1 above does the same.
>
> * From Peter's reply in another thread of similar issue I gather, issue i=
s
>   setting 'blk' to NULL, even erroneously. So (blk =3D=3D NULL) check sho=
uld be
>   done where 'blk' is set to null, rather than where it is dereferenced.
>

I don't find anywhere set the 'blk' to NULL.
I think this NULL deference is caused by following:

In 'pci_ide_create_devs' we call 'ide_create_drive', in the latter
function it will create the 's->blk'.
However it is not for every IDEBus.

IDEBus[0]: ifs[2]
IDEBus[1]: ifs[2]

The 'ide_create_drive' will only initialize the 'IDEBus[0].ifs[0]' and
'IDEBus[1].ifs[0]' from the reproducer command line.
So the 'IDEBus[0].ifs[1]' and 'IDEBus[1].ifs[1]' s blk will be NULL.

In 'ide_ioport_write' the guest can set 'bus->unit' to 0 or 1 by issue
'ATA_IOPORT_WR_DEVICE_HEAD'. So this case the guest
can set the active ifs. If the guest set this to 1.

Then in 'idebus_active_if' will return 'IDEBus.ifs[1]' and thus the
's->blk' will be NULL.

So from your (Peter's) saying, we need to check the value in
'ATA_IOPORT_WR_DEVICE_HEAD' handler. To say if the guest
set a valid 'bus->unit'. This can also work I think.

As we the 'ide_exec_cmd' and other functions in 'hw/ide/core.c' check
the 's->blk' directly. I think we just check it in
'ide_cancel_dma_sync' is enough and also this is more consistent with
the other functions. 'ide_cancel_dma_sync' is
also called by 'cmd_device_reset' which is one of the 'ide_cmd_table' handl=
er.


BTW, where is the Peter's email saying this, just want to learn something, =
:).

Thanks,
Li Qiang


> * At the dereference point, assert(3) is good.
>
>
> Thank you.
> --
> Prasad J Pandit / Red Hat Product Security Team
> 8685 545E B54C 486B C6EB 271E E285 8B5A F050 DE8D
>

