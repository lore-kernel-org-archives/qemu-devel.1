Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0245C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:47:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B6DE20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 15:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCSgR9IT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B6DE20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgVc8-0004Vg-Mw
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 11:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jgVbX-00045q-SX
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:46:59 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:41428)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jgVbX-00059g-4P
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 11:46:59 -0400
Received: by mail-lf1-x141.google.com with SMTP id u16so1616688lfl.8
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 08:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BkT2CAUSe9l015NBLQSlSQVOCcVUoHaEI/ZCw0KgYhQ=;
 b=hCSgR9ITUeByuADUwrpLWHYld6+g4zKYZWCDT5VVxJP5v1JnY92e3XzNUL548wDoRk
 uwrbDNtgdxP1OMH1KerEvLByPDINM/KhlFexxdiVrf1/ilEPhwOj72cR6DMwPWZYQFqb
 XqldFUk47O+DceeMnKmpsyMQ3bMOdfIC/90GUP+eWf39gl5t8StSFOIp5vx5/B7igrcZ
 V7RcVZ1w4EuRU6x4Y6rRVaUNRZE/RGQuhN9TVzyw0dNElVR3kbMisEZxXM6+vLZs62Yg
 3+GtO8GcwUlc+NxohHwXujydHLnCLSDG5qVDvktdQ1e7v2Yiaa1B/N86NXrSp+NLu8Zk
 xd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BkT2CAUSe9l015NBLQSlSQVOCcVUoHaEI/ZCw0KgYhQ=;
 b=ippsK3PaqFfQbm3RgvCzQZDQMOx9S0NNWoR+o+s9aT0ENteMtYdoqSdAdH5XRQgb12
 ON4B//biPGeHhDTtYZsvB6ejZPPTu9umF7+Ud2z6ZEivGALiL9SPs1OSgQYasQJh5HP+
 SlnDB4Wml9Z2vYOhAupPlveCuh1MZM1rrtZSyqor72kkVS8vggOWQWSF+L8exPSfIjrS
 QUHenEcJ2EV6bRrac6VJD4TTZGpx/0THnoI8hwRO8VTAgfQ3I0/Tu+6QCd438nUgVmGE
 H/WU1uECzmSGdIfdLmgyxIn1Ar1hhujV7PdTQr4WutJRcI43ZJT4ruUa8cHrodGNq6ym
 5PPg==
X-Gm-Message-State: AOAM53185xFfKzx5pxWH6hVdgfQBGE2ND0JLw/HPLyu5G+bI/j/mHMc6
 4/5AIyt3G2c2oHIuM5y7LfuG2PEavTWhe29EMhkBwQ==
X-Google-Smtp-Source: ABdhPJz0gQWT/EUsHaPMBMsbOUPxqgpm9l6JwAVxYQpk7JR++9GwGMP4Ua+t0BE6mSkFjt6iAyM9BRZ5ygL04CCwI3w=
X-Received: by 2002:ac2:4119:: with SMTP id b25mr77089lfi.208.1591199216750;
 Wed, 03 Jun 2020 08:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200529132341.755-1-robert.foley@linaro.org>
 <20200529132341.755-9-robert.foley@linaro.org>
 <87zh9l5idn.fsf@linaro.org>
In-Reply-To: <87zh9l5idn.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Wed, 3 Jun 2020 11:46:55 -0400
Message-ID: <CAEyhzFvz4=MZozF=t5MhMsoAfjy06Nn=PPJ4=UEOaBF1vSn2_g@mail.gmail.com>
Subject: Re: [PATCH v1 09/12] tests/docker: Added docker build support for
 TSan.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x141.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Peter Puhov <peter.puhov@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jun 2020 at 16:21, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
<snip>
> >
> >  configure_qemu()
> >  {
> > +    if test -z "$TSAN"; then
> > +        requires clang tsan
> > +        echo "Including TSan Support"
> > +        tsan_log_dir=3D"/tmp/qemu-test/build/tsan"
> > +        mkdir -p $tsan_log_dir > /dev/null || true
> > +        EXTRA_CONFIGURE_OPTS=3D"${EXTRA_CONFIGURE_OPTS} --enable-tsan =
\
> > +                             --cc=3Dclang-10 --cxx=3Dclang++-10 \
> > +                             --disable-werror --extra-cflags=3D-O0"
> > +        # detect deadlocks is false currently simply because
> > +        # TSan crashes immediately with deadlock detecter enabled.
> > +        # We have maxed out the history size to get the best chance of=
 finding
> > +        # warnings during testing.
> > +        # Note, to get tsan to fail on warning, use exitcode=3D66 belo=
w.
> > +        tsan_opts=3D"suppressions=3D/tmp/qemu-test/src/tests/tsan/supp=
ressions.tsan\
> > +                   detect_deadlocks=3Dfalse history_size=3D7\
> > +                   halt_on_error=3D0 exitcode=3D0 verbose=3D5\
> > +                   log_path=3D$tsan_log_dir/tsan_warnings.txt"
> > +        export TSAN_OPTIONS=3D"$tsan_opts"
> > +    fi
>
> ...I think it would be better to put this in it's own test (test-tsan?)
>

Makes sense, we will put this TSan code in its own separate test.
Sure, test-tsan seems like a good name for this.

Thanks & Regards,
-Rob

> --
> Alex Benn=C3=A9e

