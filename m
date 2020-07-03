Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFF5C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:03:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE1E920884
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 21:03:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QX9UNZk9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE1E920884
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSqA-0001v0-7Q
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 17:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrSpC-0001Ld-6W
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 17:02:22 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:36855)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hskinnemoen@google.com>)
 id 1jrSp8-0003Oy-U7
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 17:02:21 -0400
Received: by mail-ua1-x943.google.com with SMTP id b13so10404481uav.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+Hped9QqubUh58Lz19w66OCIr+pQ3Q/OLs6O5uWZmCA=;
 b=QX9UNZk9R09C8o/m7w3Sob/GDyisU4nxH+ME8sNwNGqBfd5nP2zFxHnDfFiOCeFqar
 r6o55as3btb/qhJJbk7K9VJrVD5jOJCRXDfzms25MHe4dkQkB027Ju9z570K6QATo++D
 mZjXLAbumiNcVhZiOmjZfMNDage1Wa6sTN8WwwLYiQ8n8zuj4KVwFtYs8k8kiuqGcnrc
 zMXy1oj4uCJ3rboBeNk3AwmMOd4z/1Fr6D93ddYxGxtuRTbr96X9JL+STBqvVdYwChMH
 LSvY4Tign60wjIEuxiupMu+txse6hc51IjiOD2ldYgXwSpa9icb++Jg41JOfX9d2WN8X
 zBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+Hped9QqubUh58Lz19w66OCIr+pQ3Q/OLs6O5uWZmCA=;
 b=RuQW+WXbvvFCEwfoLGkNQGsg17Rj6an08QPuRjYKVM94P7o4UP86yo0qzplwJ++/Xk
 XO8Sf87n4NZEF0gMazMvZ6TORq5Eb9cWkivikJPmaMrSxoNNo6Vh8wa1L8gXuyuZ3i64
 a0sn1YxFkYndJjmEvMLXznHrx2+1kCUXjIk4C4qcLK5akHFX1Nk+43oG4s3VtlZJrD4g
 MLAWP0e2M4ELdEGA1JDc2Lq0KjqxzhczSHYTm4EmigouqvuHuDAV3RA2J3WgUofD5hjG
 +0S35L7OxywKYCUhlEOt2BXIg4GY8aClfxrcMvK6R4f+jiJyELKVoIbW09+gWD+m/wOQ
 BUPQ==
X-Gm-Message-State: AOAM532IA0yjoisEM2OAl5C6UogNyRbJs6/CpywpMZIdLV1GDa9MuaMV
 +fXOMUQ1ELXbRcuUGshkL8wMFXsENksKKefFm+khzA==
X-Google-Smtp-Source: ABdhPJzISEMiMO9szWme19NHuJPmlb2BhNTkCwxy2rtw9Jv70Gak3vAFleJa8kuG9n4X27gKu2WJWmvW7iPslBzYUl8=
X-Received: by 2002:ab0:29cb:: with SMTP id i11mr11584105uaq.12.1593810137656; 
 Fri, 03 Jul 2020 14:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200626235519.591734-1-hskinnemoen@google.com>
 <20200626235519.591734-13-hskinnemoen@google.com>
 <56028150-9efd-dc34-5244-2c6fa1f6b8e2@amsat.org>
In-Reply-To: <56028150-9efd-dc34-5244-2c6fa1f6b8e2@amsat.org>
From: Havard Skinnemoen <hskinnemoen@google.com>
Date: Fri, 3 Jul 2020 14:02:06 -0700
Message-ID: <CAFQmdRYrvCHPfXhj0N74dxHWEVk9SuvDLhyupzDi45TuKT=WHA@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] docs/system: Add Nuvoton machine documentation
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Joel Stanley <joel@jms.id.au>, qemu-arm <qemu-arm@nongnu.org>, 
 QEMU Developers <qemu-devel@nongnu.org>,
 IS20 Avi Fishman <Avi.Fishman@nuvoton.com>, 
 CS20 KFTing <kfting@nuvoton.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::943;
 envelope-from=hskinnemoen@google.com; helo=mail-ua1-x943.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, PDS_OTHER_BAD_TLD=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5, USER_IN_DEF_SPF_WL=-7.5 autolearn=_AUTOLEARN
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

On Fri, Jul 3, 2020 at 9:35 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 6/27/20 1:55 AM, Havard Skinnemoen wrote:
> > +The Nuvoton machines can boot from an OpenBMC firmware image, or direc=
tly into
> > +a kernel using the ``-kernel`` option. OpenBMC images for `quanta-gsj`=
 and
> > +possibly others can be downloaded from the OpenPOWER jenkins :
> > +
> > +   https://openpower.xyz/
>
> I can only see the build log, not the u-boot/kernel binaries.
> Can you point me to an example please?

This looks like the artifacts from the last successful gsj build:

https://openpower.xyz/job/run-meta-ci/distro=3Dubuntu,label=3Dbuilder,targe=
t=3Dgsj/lastSuccessfulBuild/artifact/openbmc/build/tmp/deploy/images/gsj/

