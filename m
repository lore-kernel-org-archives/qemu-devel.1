Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2F9C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:21:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A26222518
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 17:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmFT4Nxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A26222518
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvOcn-0004Em-C3
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 13:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jvObj-0003Mc-PP
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:20:43 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jvObh-0004pU-UB
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 13:20:43 -0400
Received: by mail-ot1-x341.google.com with SMTP id n24so13571838otr.13
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=SdZ7o21xnC4TWgHCFMI6ThoHqDivVyL0MG3Det3EjY4=;
 b=VmFT4Nxy1ISmxIi557Pv3hdjiSy6UMcnP5YbkR29xO/slxmiwbM+hitbsDeNaqZnmq
 hZCibJJeGPF54xWVlXjUeEHixLzSEqwhBRWBxE0lmjQOmqVPi0oyiXGoS/sN0ZrLfdk1
 tFrzY7Y+V7FMHKrvUtD4TR+Sucmn+Ttn6NS+0FwUK/ypnfkdv0vLvo+iiMhmkVvBwSQt
 ERTSISoYMwEBUAZPoLPINshhpXHpWQ8kzyV+irpgXSKagrmlx7wknW5Hydlws29EXAEe
 M13nZxryfgk0s+gi4ulkJgxLihZw24FLnO8ba4uro+DJE1zd1ppxQ5bmXgMzv/5xYHDs
 7gKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=SdZ7o21xnC4TWgHCFMI6ThoHqDivVyL0MG3Det3EjY4=;
 b=AbLmT6V7aP5ZvipLfyqJNhXaWXgJ+OGV+9kFZx40y8+qfkLPQ0S+67CWBrOugFpC0+
 PxDlLU6LRUEjjm+euINAFtNzY3j+0YAxlA6H2xaFSHaAXSd3h6vGBMz2fvLtyqezSx77
 xdwC5O8TwDJi+1TYYpHG/sch5eX7U3Uf+oOnQx2YASXov9AnHBbx6nZEYuRzv2zHbicX
 V5gxXV4ccU5q9seJdfhXpMOuGelm2YevjtvsB9S5zYc1gyZz1IcAAcbRk3XPJ9BAb11f
 MBTXOg8Vlr7HH21q6Q/nyygM1qjMsGJLmzipYIQMAgg987fPxQfL5qhbwPTEBb6Lc1G9
 g0KA==
X-Gm-Message-State: AOAM531B6aLY9OoTu9CbVzIVMBJ1bm4ReoMCDTHVYEaio6GFidSZUtMD
 qZBHW61BQ2Z0MRg5qwX/SC8KkRtK2G0xupy5eBs=
X-Google-Smtp-Source: ABdhPJwoyIdMd5t13QX6+RUIZ4pspl8xV2dyABK922jOuEEXERFGv7Ji1CvkhY3kH/c865o4wmlD9DpLGtp32Wsln+I=
X-Received: by 2002:a9d:787:: with SMTP id 7mr4934216oto.333.1594747240550;
 Tue, 14 Jul 2020 10:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200714151152.54760-1-liq3ea@163.com>
 <39e02324-eaa1-1aea-96d2-fba48483b6c0@redhat.com>
In-Reply-To: <39e02324-eaa1-1aea-96d2-fba48483b6c0@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 15 Jul 2020 01:20:04 +0800
Message-ID: <CAKXe6S+6L72ZfEQg55Uaj+h_-e90s060=USEsyos5m+8g9eRZA@mail.gmail.com>
Subject: Re: [PATCH] hmp: fix memory leak in qom_composition_compare()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Li Qiang <liq3ea@163.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=
=9C=8815=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:47=E5=86=99=E9=81=
=93=EF=BC=9A
>
> On 7/14/20 5:11 PM, Li Qiang wrote:
> > While 'make chekc', I got following error:
> >
> > root@ubuntu:~/qemu# ./tests/qtest/device-introspect-test
> > /x86_64/device/introspect/list: OK
> > /x86_64/device/introspect/list-fields: OK
> > /x86_64/device/introspect/none:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D53741=3D=3DERROR: LeakSanitizer: detected memory leaks
> >
> > Direct leak of 212 byte(s) in 20 object(s) allocated from:
> >     #0 0x7f3b6319cb40 in __interceptor_malloc (/usr/lib/x86_64-linux-gn=
u/libasan.so.4+0xdeb40)
> >     #1 0x7f3b62805ab8 in g_malloc (/usr/lib/x86_64-linux-gnu/libglib-2.=
0.so.0+0x51ab8)
> >
> > SUMMARY: AddressSanitizer: 212 byte(s) leaked in 20 allocation(s).
> > tests/qtest/libqtest.c:166: kill_qemu() tried to terminate QEMU process=
 but encountered exit status 1 (expected 0)
> > Aborted (core dumped)
> >
> > This is because the 'info qom-tree' path has a memory leak and qemu
> > exit 1. The leak is in 'qom_composition_compare'. This patch fixes this=
.
> >
> > Fixes: e8c9e65816f("qom: Make "info qom-tree" show children sorted")
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  qom/qom-hmp-cmds.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> > index 9ed8bb1c9f..3547d5ba4e 100644
> > --- a/qom/qom-hmp-cmds.c
> > +++ b/qom/qom-hmp-cmds.c
> > @@ -96,8 +96,10 @@ static void print_qom_composition(Monitor *mon, Obje=
ct *obj, int indent);
> >
> >  static int qom_composition_compare(const void *a, const void *b, void =
*ignore)
> >  {
> > -    return g_strcmp0(a ? object_get_canonical_path_component(a) : NULL=
,
> > -                     b ? object_get_canonical_path_component(b) : NULL=
);
> > +    g_autofree char *t1 =3D a ? object_get_canonical_path_component(a)=
 : NULL;
> > +    g_autofree char *t2 =3D b ? object_get_canonical_path_component(b)=
 : NULL;
> > +
> > +    return g_strcmp0(t1, t2);
> >  }
> >
> >  static int insert_qom_composition_child(Object *obj, void *opaque)
> >
>
> Ah you won the race with Markus:
> https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04740.html
>

Oh interesting, I just want to  begin to write the e1000e tx bh
discussed with Jason.
But found there are some memleak issue.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>

