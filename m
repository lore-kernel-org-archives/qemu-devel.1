Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A934C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:34:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 343DE2065D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7ZZoLzQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 343DE2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw1E1-0002l3-GZ
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jw1DL-0002LT-4V
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:34:07 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44646)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jw1DJ-0001el-Dk
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:34:06 -0400
Received: by mail-ot1-x341.google.com with SMTP id 5so3763428oty.11
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 03:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BD4pP2OL6n8sUBEwRwBcHJymW4TzC0cy2bIoy4Dc2JU=;
 b=j7ZZoLzQfuGxPfKsq6nX7UndIygFOElwI5Cji7ee2oWnFEEAv33ynceWtPclO9k0Jx
 S38jGelfOlzk/YVwOhAb/rUPT26xisPc2vjz+bqb1Dc7X67QntwyZsGzFT3lKzg3DjTh
 bYgD+uDwJxyPxNu6fV0pQKjsLEa1m7ueS4ELtA3qKO2jnxD87SzV+hJkvEm5uoHqaW4F
 wtH5dcR0MKk5p3gRJ65tt8vNnYRp+nLvOWufpy6tJ53sGW8nVvuCn/wguW3ZrVhk38fX
 cf9+taLx0hOXelvg9fTMUW3rE/1RaLc8sK7BF04XiGsUKsu0Ijnnh/NXot7+xRZFdfY3
 5bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BD4pP2OL6n8sUBEwRwBcHJymW4TzC0cy2bIoy4Dc2JU=;
 b=L7wTyNQq0yPZYNu/uauBBrCFxzoySmBvLe9zBOIfLDpmHYkZY5yRmBu1YkHmdBf7fu
 pk27q7KWiMyQbOGfoh6WB1qyXejFy5Svdqu1zsrvvYkeRq+P6PwLFUu963zalGAXV4T7
 MilHxj7CHmLf6StpbedshoCK/1vDu5Et3R6Md9YmXxM2l6sq/XVMQzAkN5mmj9KQ612z
 IOPJVNgPkjNgUTGDgGoL5QpheLqJ9vz29nPeovJAScLZN6by2E8oAF/8bauYZCHWgyjv
 NAST6oxQLYyQXhjpibN/Hq3fwpCWsK7Irs5P0LRo/Ypvlrkt0vFHmaCvfokOIOzXxR5U
 KDCA==
X-Gm-Message-State: AOAM5327qkCnQLMmesnKI4utxWJmZ4HKsNxui13UMC1TlBg0hvqW0qKt
 CtqZIV6PhcFrZ3GOW5sxSXnt4y/KJviOlB2bJLY=
X-Google-Smtp-Source: ABdhPJwqkXpsD+8ctXssipv8gAwCcTjk6m5PYmKjuQKEIa4y6nCFnUaAZclUdI8e9fyS96Hp3Ymxtt5GgumxxF763yA=
X-Received: by 2002:a05:6830:15c3:: with SMTP id
 j3mr3506334otr.353.1594895644192; 
 Thu, 16 Jul 2020 03:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200715154117.15456-1-liq3ea@163.com>
 <874kq8roev.fsf@dusky.pond.sub.org>
 <CAKXe6S+CvQ1rmnWXi2_=kiCF4yG-2T3iPut=51G25qwL+oO2Pw@mail.gmail.com>
 <87blkfpz20.fsf@dusky.pond.sub.org>
In-Reply-To: <87blkfpz20.fsf@dusky.pond.sub.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 16 Jul 2020 18:33:28 +0800
Message-ID: <CAKXe6SJ5ckb=VnhQx=uO7Y6pSm6mKL87F0OX2f2+499nmiSfPQ@mail.gmail.com>
Subject: Re: [PATCH v2] tests: qmp-cmd-test: fix memory leak
To: Markus Armbruster <armbru@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Auger Eric <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8816=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=885:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Li Qiang <liq3ea@gmail.com> writes:
>
> > Markus Armbruster <armbru@redhat.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=881=
6=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=881:59=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> Li Qiang <liq3ea@163.com> writes:
> >>
> >> > Properly free each test response to avoid memory leak and separate
> >> > qtest_qmp() calls with spare lines, in a consistent manner.
> >> >
> >> > Fixes: 5b88849e7b9("tests/qmp-cmd-test: Add
> >> > qmp/object-add-failure-modes"
> >>
> >> The patch also fixes leaks introduced in 442b09b83d and 9fc719b869,
> >> actually.  At least it should, but the patch appears to be incomplete.
>
> 442b09b83d was fine, actually.
>
> 9fc719b869 wasn't, and your second patch hunk fixes it.  Please add a
> "Fixes: 9fc719b869' line to the commit message.

Hi Thomas,

Could you do this minor adjustment?
Add also add Markus's r-b tag.


>
> >> >
> >> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> >> > Signed-off-by: Li Qiang <liq3ea@163.com>
> >> > ---
> >> > Change sincve v1: add detailed commit message
> >> >
> >> > tests/qtest/qmp-cmd-test.c | 13 +++++++++++++
> >> >  1 file changed, 13 insertions(+)
> >> >
> >> > diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
> >> > index c68f99f659..f7b1aa7fdc 100644
> >> > --- a/tests/qtest/qmp-cmd-test.c
> >> > +++ b/tests/qtest/qmp-cmd-test.c
> >> > @@ -230,6 +230,8 @@ static void test_object_add_failure_modes(void)
> >>    static void test_object_add_failure_modes(void)
> >>    {
> >>        QTestState *qts;
> >>        QDict *resp;
> >>
> >>        /* attempt to create an object without props */
> >>        qts =3D qtest_init(common_args);
> >>        resp =3D qtest_qmp(qts, "{'execute': 'object-add', 'arguments':=
"
> >>                         " {'qom-type': 'memory-backend-ram', 'id': 'ra=
m1' } }");
> >>        g_assert_nonnull(resp);
> >>        qmp_assert_error_class(resp, "GenericError");
> >>
> >> Doesn't @resp leak here, too?
> >
> > No, qmp_assert_error_class will call qobject_unref(rsp) will so will no=
t leak.
>
> You're right.
>
> With the additional Fixes:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> > In fact, I think this is a inconsistent for 'qtest_qmp'.
> > I think we can apply this patch first and then change the
> > 'qmp_assert_error_class' or/and others
> > to free resp. And just let the caller of 'qtest_qmp' frees unref the rs=
p.
>
> Do you mean "not to free @resp"?

Yes, the 'qmp_assert_error_class' not free @resp.


>
> > What's your idea?
>
> Rename it to qmp_expect_error_and_unref()?

In fact I prefer qmp_assert_error_class has no reason unref @resp.
So the user of ''qtest_qmp' will has a unify processing of the @resp.
    resp =3D qtest_qmp()
    use resp
    free resp.

If we just rename to 'qmp_expect_error_and_unref'.
The user still should remember this. If not they will have UAF or mem
leak issue.

Thanks,
Li Qiang

>

