Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19A6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF3720657
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 12:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFUkILJ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF3720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb1ah-0002ay-L1
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 08:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jb1aB-0002B2-Ce
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:42:55 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jb1aA-00070f-5C
 for qemu-devel@nongnu.org; Tue, 19 May 2020 08:42:54 -0400
Received: by mail-ot1-x342.google.com with SMTP id z3so9274074otp.9
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 05:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VjRQV1lufKR7IHdURPrkX2MLgHA0dV5Ku/o5M0TbUmM=;
 b=VFUkILJ3C20R/SSBKjI3jNdZWVZrc5jksH6G45l9gKNpKxWgNX7HWHVnLI7iCrnMPr
 iHmnye5IfrPrhT9OBRAY6+cv8jkPu2ngtVaW2Zo9F6KU5nm6me+7z0cNWAeYGyTxvCyZ
 MCibICN6E3pLwt9kfP/RXET1NBW454fXRjftuNSZNvbogKgH3GQFeCgGCvB5qRYRM6Pf
 QPECn0jAjVB82OL6ZNEtRFvvOePa/nAJ00z9kzlWmGhF2fbdbo3ZyKpw3ewtJfadC2Le
 CJHgI5+W3cIHcFPblQpcrZGk0H4uXz3Bs/CAlA7gOcWluKu/P+AaKvhfc8GUoi4W2eCF
 tigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VjRQV1lufKR7IHdURPrkX2MLgHA0dV5Ku/o5M0TbUmM=;
 b=bmBORIrtQ2VCq4XS3kp0MwuhxnoP1Wz0NH94mI82TuiVA2bQ+DOdzLuVHd6TFOnlif
 8x8R1goiVUmosiF8n63jqfNsglsAkWcAH4J5YdBD8mmi2GADt0GpsqD5lOVlvXdcuCHa
 3MrP0ceDTFSpXUBdFgAfPQ/GaeGqjWhUrQn6LcW+yh8+5XWjI/aRwD6mSBXqHoErE9If
 B5FDORfMCSi39tp3SutcP9cPtvhPAb9jZMOQgUzr8jeqkmkXFgY0N5voIkqDprlToJbH
 AW2G+UtRQyJlBpw01MmMm6wPffSTDDswaii33WdgXtl6+OX4W2dtkgHIo2B6EmojDWvp
 6IYQ==
X-Gm-Message-State: AOAM530MzaWXmE8jaYdsVCX67AQZQwLImwAbMla52gcPaktBXenxl5f4
 h8juTmuQVP+API1F3q/4j8ngXxC0CS/5fPlI4mtXcg==
X-Google-Smtp-Source: ABdhPJxPoUs+NClQHSnEZuiZ+pkATbPUZnCUWPctQOf5R/i/h4sl7tCTYKkL5eDaYwSg6PRosLaOywM7wkJ1beVUwDQ=
X-Received: by 2002:a05:6830:158b:: with SMTP id
 i11mr6412129otr.135.1589892172913; 
 Tue, 19 May 2020 05:42:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200518205448.690566-1-eblake@redhat.com>
In-Reply-To: <20200518205448.690566-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 May 2020 13:42:41 +0100
Message-ID: <CAFEAcA_PtAO_Nm+ZhU5juRM3+C69JQ3GSnyt8TiVVEjgF0XXkQ@mail.gmail.com>
Subject: Re: [PULL 0/7] bitmaps patches for 2020-05-18
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 21:55, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit a28c9c8c9fc42484efe1bf5a77affe842e54e3=
8b:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/vga-20200518-pull-req=
uest' into staging (2020-05-18 16:37:09 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-bitmaps-2020-05-18
>
> for you to fetch changes up to 6660c3a69c668ff98e2a86bca0b1301648ff4b02:
>
>   qemu-img: Add bitmap sub-command (2020-05-18 15:32:56 -0500)
>
> ----------------------------------------------------------------
> bitmaps patches for 2020-05-18
>
> - update bitmaps maintainers
> - add 'qemu-img bitmap' subcommand

Hi; this fails to compile:

/home/petmay01/linaro/qemu-for-merges/qemu-img.c: In function =E2=80=98img_=
bitmap=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/qemu-img.c:4593:27: error: too
few arguments to function =E2=80=98cvtnum=E2=80=99
             granularity =3D cvtnum(optarg);
                           ^~~~~~
/home/petmay01/linaro/qemu-for-merges/qemu-img.c:510:16: note: declared her=
e
 static int64_t cvtnum(const char *name, const char *value)
                ^~~~~~


thanks
-- PMM

