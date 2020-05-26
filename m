Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47006C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 109472073B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 12:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kL5OJMQ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109472073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdYrc-0001Od-9W
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 08:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdYqb-0000XP-Ga
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:38:21 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:33387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jdYqa-0004dO-BV
 for qemu-devel@nongnu.org; Tue, 26 May 2020 08:38:20 -0400
Received: by mail-lj1-x243.google.com with SMTP id w10so24324372ljo.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 05:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=XYx7UjCajHofiSOYMQKI82/+O7rs8+l8B//egoPR/SI=;
 b=kL5OJMQ+FEGaP2EKSuUHPdsXuPtqYPM4rOhqee0aYrNCUBCqD2d3hhsMQeH2mn58ik
 zGxxYjUIoHIxtLU+/ySYfAGDal22fX5XdUTpb5Yadx7J61kagop3S+o/E3JVWqzO/BJr
 UY30lSbr/p3jnxtDcH4lanRjDMucQEFnX4sXt7KSE8x7VCqb/yp7qw+1Bhf0rnKwEQPn
 Vj3Tvh2RzsdMvG6W4obAzoR0UpUOb4beN+3RuZrDDFATR9EGgmHoyeO/xyWj4VrdAQd/
 SVqebWKrsN16wg7WYLpRLB6tkFELcuwgBiazLMDAk6U4DHu8U2U0dKbYwKjprvmJdROU
 qvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=XYx7UjCajHofiSOYMQKI82/+O7rs8+l8B//egoPR/SI=;
 b=QgFNrnTNfiLAZlrFF5+Z6IAJ23TzujuXXBq9ZS43FN0kdCgmD6k7i8QlQ4CXuKb4J8
 7x118ibDHliTJ9YXB6A+zX5Pnr6VXrBO+QSztVpTS6U+i44MGL8v9i9nVb5StEjnDgFS
 GF1/CnmA05etonz26BVqC1ReMSlxGxtJlhtJTXg/3XuE3mE8wz3CX/3UFK5f2uhE2w1d
 DjlvM3e9FQHHD+pLrAp2BbS4tQxRdaCillV7XoWvTyXN1Sa0HCEpUTFi5VScL6cLlyZM
 T9J2aAvuh8wF+NmymVbHFq+rt6NScWQnK+gTVu0muaIqUHngWOfXTloFHPxg2jtct7br
 gPqA==
X-Gm-Message-State: AOAM533ANDPgUvEkbqDx8TmWRfMYC3Yzx1IUJsLZJ4vstGC6uqhx6JGP
 o9AAvx+QyVjfPWK1N9Zc0JCJfFj6vREg53pO0V5Q1g==
X-Google-Smtp-Source: ABdhPJyEw/LKGxse2O4BSrO8Qjw71GfGZElMan5I8uW4ALXM5mTWvW3e/kYARn7liFZxIsZuW8Fjvm+UY0uLfJAfjLs=
X-Received: by 2002:a2e:9bcc:: with SMTP id w12mr564351ljj.9.1590496697828;
 Tue, 26 May 2020 05:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-2-robert.foley@linaro.org>
 <cc897d62-5346-ebee-3d1e-ef5df3fc9b3f@redhat.com>
In-Reply-To: <cc897d62-5346-ebee-3d1e-ef5df3fc9b3f@redhat.com>
From: Robert Foley <robert.foley@linaro.org>
Date: Tue, 26 May 2020 08:38:13 -0400
Message-ID: <CAEyhzFvdRZRoDfWPAoq2Od0K+rkBK07EHVpHJVJ=t_1K=bu9sw@mail.gmail.com>
Subject: Re: [PATCH 01/19] configure: add --enable-tsan flag + fiber
 annotations for coroutine-ucontext
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Puhov <peter.puhov@linaro.org>, "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Lingfeng Yang <lfy@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 23 May 2020 at 12:55, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Robert,
>
> On 5/22/20 6:07 PM, Robert Foley wrote:
> > From: Lingfeng Yang <lfy@google.com>
> >
> > We tried running QEMU under tsan in 2016, but tsan's lack of support fo=
r
> > longjmp-based fibers was a blocker:
<snip>
> > @@ -6277,6 +6304,14 @@ if test "$have_asan" =3D "yes"; then
> >             "Without code annotation, the report may be inferior."
> >    fi
> >  fi
> > +if test "$have_tsan" =3D "yes" ; then
> > +  if test "$have_tsan_iface_fiber" =3D "yes" ; then
> > +    QEMU_CFLAGS=3D"-fsanitize=3Dthread $QEMU_CFLAGS"
> > +    QEMU_LDFLAGS=3D"-fsanitize=3Dthread $QEMU_LDFLAGS"
> > +  else
> > +    echo "Cannot enable TSAN due to missing fiber annotation interface=
."
>
> I tried your series and there were no changes anywhere, then I looked at
> how TSan work, started to debug, to finally realize my build was not
> using TSan (clang8). Please use to something such:
>
>      if test "$tsan" =3D "yes" ; then
>         error_exit "Cannot enable TSAN due to missing fiber" \
>                    "annotation interface."
>      fi

This is a good point.  Will make these changes.

Thanks & Regards,
-Rob

