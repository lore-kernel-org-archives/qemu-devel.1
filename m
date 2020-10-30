Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EACDC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:29:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C2EF20704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0leOUGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C2EF20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRfA-0002b5-6g
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kYRbz-0007am-SN
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:26:23 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:35260)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kYRbx-0001Eb-20
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:26:23 -0400
Received: by mail-wr1-x42d.google.com with SMTP id n15so5887279wrq.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ht7WYueNgfp0UhVkFiZol+cFg7ruSFbIxqfSH2tHy8w=;
 b=e0leOUGOHWJzi7zHF/W2SLhWtX8QcqSn/UwCVkDGdFtiYxSQo3m21UaG8XsJPG2/XQ
 Xt43U+olHddIT4ERXEs/rXiSnCQlJtjasaiuboiLuC7Kyme8TWfP3WdYPL07nvS5m6M7
 7GiOBIVWLT0A9/V19lSsmyIDXpedidaAOownLzIkluhGYY6xDfqxBqizCRQVq1mpAP6n
 80Abi5kZlzLoQnBlI7/wZ+I6TkIgFCoZWy7ezcvzZGn4mEPFfJcnOFaU05ZBhFc4u9rH
 EuvLJFNmcI8CQ880TMakKsIBgH6BrCsWI2IcCgq4XwWjjVthwLZX88aXh+J2vZ6KNGFn
 WSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Ht7WYueNgfp0UhVkFiZol+cFg7ruSFbIxqfSH2tHy8w=;
 b=SgI2ihZQjelwwPVP/UppOwGRm4ssg3v4RVfyGgC1CeP5ivTlJDUUGD3/MtWSrNgfR4
 zXv1chN6Ry+Vhl0oGvBjbDH7ElSE5eDM/5bKB8vXbEdsdnUyArzpxJvCHDpOCFsbFWGH
 5C7j13nqqBMiri7CRFjQczfcaLILkcVuHAFzbuoGbNtXIZ3GeCbmq3duj73s6COukj6q
 ACbSoXzZsUBwUeF15F8yLQZXzZxMpN9N49/+ii0GNPG3bH1zdPOoH2TaXkbjn3eynQK7
 hV3mH6xZt14LXfybzCR6BOvsyDwux6Z5UPw9e0IqZ7ozOPy34ojBmTbfU/im+xnQKKO7
 USXw==
X-Gm-Message-State: AOAM532NPaB2Lj8LIsAGOeSXu8AH1OtUMR7XY4xPz1t6/H52FYmSNp+V
 OQnlxettvOYSXuMHm4DM7mXD1w==
X-Google-Smtp-Source: ABdhPJxcLaut66Xrd6WH0apfByRTJ2hfWsTg2BRumsWI3avp4AzbixVqDZjT5SOWq9tiQJmXj0G4Vg==
X-Received: by 2002:adf:a50e:: with SMTP id i14mr2203576wrb.121.1604053579157; 
 Fri, 30 Oct 2020 03:26:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t4sm4174335wmb.20.2020.10.30.03.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 03:26:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2AC021FF7E;
 Fri, 30 Oct 2020 10:26:17 +0000 (GMT)
References: <bda4f471-8ed6-3832-29ac-279a6d3bb7cc@redhat.com>
 <20201029174114.47e2b351.cohuck@redhat.com>
 <CAKmqyKOY+5WcxUg3Rvq2t3vYWOHrHQdhcv8PkiqZX2zVMdqJ3Q@mail.gmail.com>
 <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
 <c7308133-cf29-8668-f781-6d025eb16722@redhat.com>
 <3d9b264a-5e1f-b936-8455-bafc6b89ebe5@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: John Snow <jsnow@redhat.com>
Subject: Re: Migrating to the gitlab issue tracker
In-reply-to: <3d9b264a-5e1f-b936-8455-bafc6b89ebe5@redhat.com>
Date: Fri, 30 Oct 2020 10:26:17 +0000
Message-ID: <87v9esko1i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair23@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


John Snow <jsnow@redhat.com> writes:

> On 10/29/20 3:55 PM, Thomas Huth wrote:
>> On 29/10/2020 18.12, John Snow wrote:
>>> On 10/29/20 12:49 PM, Alistair Francis wrote:
>>>> On Thu, Oct 29, 2020 at 9:41 AM Cornelia Huck <cohuck@redhat.com> wrot=
e:
>>>>>
>>>>> On Thu, 29 Oct 2020 12:01:27 -0400
>>>>> John Snow <jsnow@redhat.com> wrote:
>>>>>
>>>>>> If you're in the CC list, it's because you are listed in MAINTAINERS.
>>>>>
>>>>> <cleared the cc: list except for qemu-devel :)>
>>>>>
>>>>>>
>>>>>> Paolo's QEMU keynote this morning mentioned the possible use of the
>>>>>> Gitlab issue tracker instead of using Launchpad.
>>>>>>
>>>>>> I'm quite fond of the gitlab issue tracker, I think it works quite w=
ell
>>>>>> and it has pretty good and uncomplicated API access to it in order to
>>>>>> customize your workflow if you'd really like to.
>>>>>>
>>>>>> In experimenting with my mirror on gitlab though, I was unable to fi=
nd a
>>>>>> way to configure it to send issue tracker notifications to the email
>>>>>> list. A move to gitlab would likely mean, then:
>>>>>>
>>>>>> 1. The cessation of (automatic) issue tracker mails to the list

It would miss this feature as sometimes I get wind of things I can track
down. On the other hand there is a fair bit of list noise at the end of
a release when stuff gets closed.

>>>>>> 2. The loss of the ability to update the issue tracker by replying to
>>>>>> said emails
>>>>>> 3. Anyone listed in MAINTAINERS would be expected to have a gitlab
>>>>>> account in order to interact with the issue tracker.

Not a problem for me at least - it's just another (2FA) account.

<snip>
>> So could somebody please enable the issue tracker there, so we can give =
it a
>> try? Phil? Alex? Stefan? ...?
>>=20
>> If it works well, I can certainly help to get the links etc. in our webs=
ite
>> fixed.
>>=20
>
> Great! You are the primary bug wrangler, so if you are interested in=20
> trialing it, I am interested in helping!
>
> If we enable the bug tracker, can we please add Thomas and myself as=20
> 'Reporter' level contributors to QEMU so we can wrangle bugs?

I have enabled the issue tracker and assigned Thomas and you the first
bug.

> Info on permissions: https://docs.gitlab.com/ee/user/permissions.html
>
> There's also an old bug (2 years) about migrating Launchpad to Gitlab,=20
> but there's been no movement.
>
> https://gitlab.com/gitlab-org/gitlab/-/issues/22600
>
> If we like the results of the trial, we'll need a convincing migration=20
> strategy.

Can we extract data as a CSV from Launchpad?

--=20
Alex Benn=C3=A9e

