Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA5FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3808F2063A
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mh+Xa55K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3808F2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joO3O-0001Ou-HP
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joO2o-0000oN-Cw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:19:43 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37432)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1joO2k-000113-VE
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:19:41 -0400
Received: by mail-wr1-x441.google.com with SMTP id a6so5064855wrm.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 02:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Zdn+6fSY8Y0cXyxtjmSy/QzmNO2dvDukad5EuAAqyRI=;
 b=Mh+Xa55KJwq5hX2vBE9EO6H1mOphZIIyAgvFKPVaGJOMnW+R1p7R4Wxu0WMEhuAFR1
 bRoaCuaToKPTmzm42I38w8cyCQ2vfGTiiA3T8U+guJbPItEo0R4ZOB2i+BFx7I6f0lV1
 fas1DAlfaPb9jbInIYYUCNPEggU4cNUXLfWOt7VVnoBK4S1r0ZOFQrb0kgrvIMGy5iG0
 zZwSyUdQ4n8oBH7iG0NnOw2mYlmy4gZcwjoC4PFnI1udw9g2s8xnxqK89Rb3PjOUpFJI
 wpkoPox5Ak1ohk5fdxHqURaLNJjzNpxGC/Bgi61CuUlNrvT95uuXM11TwS7XI17WT/IK
 v+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Zdn+6fSY8Y0cXyxtjmSy/QzmNO2dvDukad5EuAAqyRI=;
 b=SwwCpMTIET8gIn4d9rCWpojUnazosNcSQOEQn2fnBNaexn6q+p3lWQrAI8U1oeybPh
 scinjbO7edONdIEoyusZJT/h1lo8iYpzJCkg8D8Kdks3Ttpjk/9rzXv+N3HhNRImj3KK
 k5DqA1uwiUSd1FGchCXDM2bJHtY824AkZusuFKOyXrQFTvNkIe/hX2NwmQpUyV1cbEpK
 ldfAhLuMM+hdN7IE16/TyMBPPkjgDdjbUcWkbIQU1TU5vkOMqUYxWQ9HthjCfmCecyev
 SftEtI8oswIT3GfOtyXHmz18/0Nqeofse5AQsqyEpIo0rCxquzX2XaUozx0IEsm/Nw7u
 4zEg==
X-Gm-Message-State: AOAM533t1d0N5eemj4ac3V2RQfI2iUQ1JQtTSZnQ5JJoNVvArJ31kt+9
 xZ+tvtVwwXtrm6tMRcHz+EZQabyJtiSHgU3xh0A=
X-Google-Smtp-Source: ABdhPJzhEnsrRYWSf/sJml5SDk5e8xHAz2vp8oFz8LqivkLy0hJcFxeQmB3j6vsLP8JXvkZi9U477GbW5b3XhDLWrio=
X-Received: by 2002:adf:8462:: with SMTP id 89mr20559948wrf.420.1593076777169; 
 Thu, 25 Jun 2020 02:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200624153142.13247-1-ahmedkhaledkaraman@gmail.com>
In-Reply-To: <20200624153142.13247-1-ahmedkhaledkaraman@gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Thu, 25 Jun 2020 11:19:24 +0200
Message-ID: <CAHiYmc4TMz-c3=4X2RiyFm5EXsJPpyekh5U-7H7Gteysi1wU_w@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add Scripts for Finding Top 25 Executed Functions
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 24. =D1=98=D1=83=D0=BD 2020. =D1=83 17:31 Ahmed Karaman
<ahmedkhaledkaraman@gmail.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> Greetings,
>
> As a part of the TCG Continous Benchmarking project for GSoC this
> year, detailed reports discussing different performance measurement
> methodologies and analysis results will be sent here on the mailing
> list.
>
> The project's first report is currently being revised and will be
> posted on the mailing list in the next few days.*

Yes, I said that for each series v2, v3, v4 must contain you must
carry the same cover letter. But I didn't mean literally the same - I
didn't mean "identical".

The cover letter should always reflect the content, and should always
be a stand-alone letter, independent on previous version, but it can
change in some details, as the series or cicrcumstance change.

So, here, you should replace:

> The project's first report is currently being revised and will be
> posted on the mailing list in the next few days.*

With:

"Report 1 was published on the mailing list on the 22nd of June:

<insert here the link to the corresponding mailing list item>
"

> A section in this report will deal with measuring the top 25 executed
> functions when running QEMU. It includes two Python scripts that
> automatically perform this task.
>
> This series adds these two scripts to a new performance directory
> created under the scripts directory. It also adds a new
> "Miscellaneous" section to the end of the MAINTAINERS file with a
> "Performance Tools and Tests" subsection.
>
> Previous version of the series:
> https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg06147.html
>
> *UPDATE: Report 1 was published on the mailing list on Monday the 22nd
> of June.
>
> Best regards,
> Ahmed Karaman
>
> v2->v3:
> - Use a clearer "Syntax" and "Example of usage" in the script comment
>   and commit message.
> - Manually specify the instructions required to run Perf instead of
>   relying on the stderr produced by Perf.
> - Use more descriptive variable names.
>

History must be a complete history, not only "diff" to the previous
version. So, for v4, you should have something like this:

v3->v4:
   <you describe here difference between v3 and v4>

v2->v3:
   <you describe here difference between v2 and v3>

v1->v2:
   <you describe here difference between v1 and v2>

Thanks,
Aleksandar

> Ahmed Karaman (3):
>   scripts/performance: Add topN_perf.py script
>   scripts/performance: Add topN_callgrind.py script
>   MAINTAINERS: Add 'Performance Tools and Tests' subsection
>
>  MAINTAINERS                           |   7 ++
>  scripts/performance/topN_callgrind.py | 139 +++++++++++++++++++++++++
>  scripts/performance/topN_perf.py      | 142 ++++++++++++++++++++++++++
>  3 files changed, 288 insertions(+)
>  create mode 100755 scripts/performance/topN_callgrind.py
>  create mode 100755 scripts/performance/topN_perf.py
>
> --
> 2.17.1
>

