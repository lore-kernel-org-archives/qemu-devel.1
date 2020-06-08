Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8125C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:36:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C48A20760
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 10:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8HlaCn3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C48A20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiF8j-0005LT-OV
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 06:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jiF7s-0004UW-8Z
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:35:32 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37556)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jiF7q-0002Ah-Ov
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 06:35:31 -0400
Received: by mail-wm1-x343.google.com with SMTP id y20so8239979wmi.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 03:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=q4M7boh3LuhyL/1j0mme0osBY6oZFo59k4tPDdirTps=;
 b=o8HlaCn3SHQn2CPBoWK24Ssr/uu2+xmqq4DEzZL/2QVuSCGjNs7KaUy5Cr6v+DDZs1
 Y1JcLA5Tgo13nb727KyyAkmns+AYtE1j/IvPsFro3yXJBaV5N7CDWVAUXdLrK3ttkUD6
 N8EAU4l//45ytoDTKR35/IDXPxQEpmxFByy+4CC5b114MVTEuMoRxOufeOg9EjfI+00h
 hEnsAh5T/PZNz9wEUBftlGKaU/aCHLRefy9IyUYI+BuV/agGD23c36930aN2anBnaaFk
 DWYifKOHnUn1R6sGxfQtVFuF2vUS4uW/ln/3JpfIogTpdhl/kpfgfUOYg/wV/tzQ6MdD
 8tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q4M7boh3LuhyL/1j0mme0osBY6oZFo59k4tPDdirTps=;
 b=bcNSwW+Zaemu1pMFukjbRsJ6hKBK2dShnvGM9ZTnmBff7SIJd3/EFzby+GhFfhungx
 +Q4yszuOYX8zfbe8x524vjFrR+DGV0eRa7jl9WyGLxJPp9mvqP3AblzAtwn2QNBCaOHe
 6e3LPoPuPe2NQ/NVXOxTJvlILTBjZavHbEicLiEO2JH7urujtRd++bkrZAAZFZ9WQj4u
 CEloQ1JNWB8gxgPpuKTEyrZPnSgNRWTHjdVN7a0n1C1g2KJ4amXZWa3U+zE0IQPUAD8j
 cGESaaLP2TpDY7F/0un6RzcK2mZjMP1vheg+VfvlDCKsoO26cH/wrTprFFeBFSdaM9XV
 GbYg==
X-Gm-Message-State: AOAM532w5MJu1Y7NZMHVnz40jn7WF93BSSqS9FgTB7rWxx4tPJDta3Or
 +UFXCDhMmVfLgN3+UE6+PB6H3yyZ1pajEiHBDQk=
X-Google-Smtp-Source: ABdhPJwESdtgetNUWyls/6Y4yuSsS0fZvY1wYaW4zszCUEsRt2VHUfij5IXtDFLvk5yCx6gXuXERkGj2hSQhbj7q9+Y=
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr15206992wma.36.1591612529340; 
 Mon, 08 Jun 2020 03:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200604034513.75103-1-richard.henderson@linaro.org>
 <87bllx4igz.fsf@linaro.org> <535cf85f-96d7-0e98-c69e-c09b976bc251@linaro.org>
 <CAFEAcA88+W6PR2K5rmov7fM9+vyCuWW9u3mxg=61B1r9kYQT2g@mail.gmail.com>
 <5aafc164-a4e7-d3be-8922-5f98d767a97d@redhat.com>
In-Reply-To: <5aafc164-a4e7-d3be-8922-5f98d767a97d@redhat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Mon, 8 Jun 2020 12:35:00 +0200
Message-ID: <CAHiYmc4oZiCKaVEzOehofDeb2eN0mFxCdS79aGbKfvzwYH_Xjg@mail.gmail.com>
Subject: Re: [PATCH] configure: Disable -Wtautological-type-limit-compare
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=B5=D1=82, 5. =D1=98=D1=83=D0=BD 2020. =D1=83 20:28 Eric Blake <eb=
lake@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> On 6/5/20 1:09 PM, Peter Maydell wrote:
>
> > If there's an ordering requirement here we should make it clearer,
> > or somebody is going to do the obvious "tidying up" at some point
> > in the future.
> >
> > Perhaps this whole set of lines should be rearranged, something like:
> >
> > # Enable these warnings if the compiler supports them:
> > warn_flags=3D"-Wold-style-declaration -Wold-style-definition -Wtype-lim=
its"
> > warn_flags=3D"-Wformat-security -Wformat-y2k -Winit-self
> > -Wignored-qualifiers $warn_flags"
> > warn_flags=3D"-Wno-missing-include-dirs -Wempty-body -Wnested-externs $=
warn_flags"
> > warn_flags=3D"-Wendif-labels -Wexpansion-to-defined $warn_flags"
> > # Now disable sub-types of warning we don't want but which are
> > # enabled by some of the warning flags we do want; these must come
> > # later in the compiler command line than the enabling warning options.
> > nowarn_flags=3D"-Wno-missing-include-dirs -Wno-shift-negative-value"
> > nowarn_flags=3D"-Wno-initializer-overrides $nowarn_flags"
> > nowarn_flags=3D"-Wno-string-plus-int -Wno-typedef-redefinition $nowarn_=
flags"
> > warn_flags=3D"$warn_flags $nowarn_flags"
> >
> > (is there a nicer shell idiom for creating a variable that's
> > a long string of stuff without having over-long lines?)
>
> You could always do:
>
> # Append $2 into the variable named $1, with space separation
> add_to () {
>      eval $1=3D\${$1:+\"\$$1 \"}\$2
> }
>
> add_to warn_flags -Wold-style-declaration
> add_to warn_flags -Wold-style-definition
> add_to warn_flags -Wtype-limits
> ...
> add_to nowarn_flags -Wno-string-plus-int
> add_to nowarn_flags -Wno-typedef-redefinition
> warn_flags=3D"$warn_flags $nowarn_flags"
>

I support the ideas outlined above by Peter and Eric.

Especially I like "one line per flag" approach, implicitly introduced by Er=
ic.

This is a very good opportunity to bring some order and beauty into
this, frankly, ugly piece of code.

Thanks
Aleksandar

> >
> > It's also tempting to pull the handful of warning related
> > options currently set directly in QEMU_CFLAGS (-Wall, etc) into
> > this same set of variables.
> >
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

