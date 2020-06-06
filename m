Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE47CC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 12:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1509206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 12:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8omzr/o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1509206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhY71-0007bY-Sw
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 08:39:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jhY5v-00075q-DT
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 08:38:39 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:35487)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sameid@google.com>) id 1jhY5u-0001CR-0G
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 08:38:39 -0400
Received: by mail-qv1-xf44.google.com with SMTP id j7so6118988qvp.2
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2020 05:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PFstviHirXSBopAWpw5abR/A0+6XMKUCKhz/PuENjnI=;
 b=k8omzr/o25WO1GL8CVqNKtRZMxs7eYNAkcDADs2HsNgP1SJw9saOEencoRh+gHCQr9
 zQIGZwmF/KEgRAk1IjNUsjR7dzKTjpGW6+DkhVCpeVj8taq1IzcKbsYWhzCbpin5AmJY
 7Hz2S09+YA0MGNlYAP7jOZ3SPR1TUt6uphGEf70H+LMtMd8AzpgzAGQD0iUdLWLqHDBU
 7Rj0fxZmr1ikwlQDu8IaVo8BasvGUOuzqti0xuBvVLXnV2hCidcC/VJWNddbcDQKmfbC
 1XlCM9Db1ZYKifY1B+KEpnvrH4rvLxoFCGZwGS/bYsQi1dO0SwdySqx5wAeUmOZ3A+XE
 y9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PFstviHirXSBopAWpw5abR/A0+6XMKUCKhz/PuENjnI=;
 b=mUngez2XBsZ4nAmQTmApr9iU+AAvOo3XTjqRDQEGbszxklOQ0YsdytqY5K6b8aFL+r
 29M6RXG4nIIRlmmZrYNOT+JjVpvnG/0R7HN7cKNdratejr0NO9P55zIoGH7ys9vI0m1T
 n/P7aSjts0aNHsD3j7dQ/h767bEtJLyOPNJYw5lXPMXjxAbmr24QtjnjexqB3s6OEgqa
 S3b0H9RzIO6dz1t23QDTxS1tQ+DHJKZO0/6lpDexgE368Se3t52uNmycaJ3AQ1FgPNqj
 Vg5nHvIvJPBQjdlmRq6/H+HIPgGdO9yAgOx7KSBOljwh0ZkS3m7cAGdQZ8qfJ8m41Ic5
 U0yQ==
X-Gm-Message-State: AOAM530SaUI7qiu8OepBO5dhzPBwtIqbVNJjBDUyQYFlRYn9mRk5mHaQ
 CqieLoO7gAPsMAPn3wd54gO1eoR15gqYr/ypYTDiWQ==
X-Google-Smtp-Source: ABdhPJyLqsMGQrq6zf0EEi5T6ZKOS7DvcqJquTPn1WTraoZRpTecPXpGZj39J58BafAbC7SEfBBWfgfaoAm8fk4YSLE=
X-Received: by 2002:ad4:556b:: with SMTP id w11mr13835394qvy.171.1591447115187; 
 Sat, 06 Jun 2020 05:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200528101039.24600-7-thuth@redhat.com>
 <20200606100632.26442-1-sameid@google.com>
 <87mu5gct2j.fsf@linaro.org>
In-Reply-To: <87mu5gct2j.fsf@linaro.org>
From: Sam Eiderman <sameid@google.com>
Date: Sat, 6 Jun 2020 15:38:24 +0300
Message-ID: <CAFr6bUnBLLdBK3Pxohynp6vp7qykbb_tNwq5-V6zu8B-vUUb+w@mail.gmail.com>
Subject: Re: gitlab-ci: Do not use the standard container images from gitlab
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, crosa@redhat.com, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 qemu-devel@nongnu.org, wainersm@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f44;
 envelope-from=sameid@google.com; helo=mail-qv1-xf44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for the link

I do believe that the correct approach for me is to rename
BITS_PER_LONG to __BITS_PER_LONG (I just added a sed command in my
Dockerfile) and move on with my particular usage, however I am just
wondering whether dropping debian10/ubuntu20 in the official qemu ci/
pipeline until it's fixed is the correct approach instead of keep
failing it until the error resolves, in a way we want to always know
on which OSs the compilation fails for visibility, no?

Thanks again!


On Sat, Jun 6, 2020 at 2:49 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> Sam Eiderman <sameid@google.com> writes:
>
> > Hi,
> >
> > I am using debian 10 container to compile qemu too.
> >
> > I think that what happens here is that
> >
> >   /usr/include/linux/swab.h
> >
> > Uses BITS_PER_LONG instead of __BITS_PER_LONG which is actually defined=
 before
> > in qemu at:
>
> That is indeed the error - we are just waiting for Debian to update
> linux-libc-dev with the fix to the kernel headers:
>
>   https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D960271
>
> >
> >   include/qemu/bitops.h:#define BITS_PER_LONG           (sizeof (unsign=
ed long) * BITS_PER_BYTE)
> >
> > which injects this definition into the linux swab.h header.
> >
> > By changing BITS_PER_LONG to __BITS_PER_LONG in the linux headers, I ma=
naged to
> > successfully compile qemu.
> >
> > A different approach would be to move the linux header includes
> > (#include <linux/cdrom.h>) in file-posix.c above all other includes - w=
hich in
> > some way makes more sense (since we probaly don't want qemu defines to =
control
> > linux headers) but it requires a more complex refactoring.
>
>
> --
> Alex Benn=C3=A9e

