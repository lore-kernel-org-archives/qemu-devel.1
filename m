Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E91C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DA96206A1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ladhCnYT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DA96206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptK1-00006X-U0
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 08:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jptJ8-0007Io-7j
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:54:46 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jptJ4-0001Vb-OL
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:54:44 -0400
Received: by mail-wm1-x342.google.com with SMTP id w3so3550917wmi.4
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 05:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vIZshY5JEnWgSo7J3JGOLHtT4PTBqkFxieLfQCEgAkM=;
 b=ladhCnYT5+XdkNh96NI4gpUQ7H4fP1zs1+mUUj3B9Kcn55oAnqenxdhqA5saVScmGF
 em0iN5OLyAlKu8pygzvSBvszellw7J0CrFcR5PH5cd7KYAmxZfmSwn7snEOVmkfUP0iS
 8+o7l9W9z61yn/K9JtETUzB0YIZQlBev54r/oGU8HEjVaevHFQOzXWA2XLxBkfyPCGu9
 Wyy+ZPzCuEPkjGUVJxU7PBEksAc++pMoGHZ5XerLt/tALKwK6pETBFXyf29h6JYYtnYn
 Kwn1NGM1X3zPMVdxtgaNB5fbZncFP/qNLtzKtBMdz1eHgq6+V1wf0poGu5tvb63UTZg+
 TzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vIZshY5JEnWgSo7J3JGOLHtT4PTBqkFxieLfQCEgAkM=;
 b=n2TwkBtoNCte3vkkshErqWUn5A1WtM7uwVGZLTm6MUpSlIW88jFr3lIjcFUo0l8Qvv
 6q+XMwazI5YOyLnt4ctZkh+2fnJBKeITI8xOJLUXP2dHROR4ICnUbxGH1zA3qvOoZ9QX
 6VWZfxKb6i1SfCRzeFTWleQjJOKqT3koBdo83sZGf1GMzRddBgKUS4fn+6KWGj7cZzrP
 2oJe7I7amh3LN98ZJZj4tskj9yxj8ZwG3wVU1D517RFnHloKfwcceq8yY9oRdOcbxA8v
 hwtmhTSa7PbsWzvnrTxGBQ5crkvAnGVRwEJYChgamMJIEyOlKCkVm92BSTSvAc8bCmie
 qPpA==
X-Gm-Message-State: AOAM533cvenUr4iKk0eSN3Njtign7zkma/LU3ZkqT7kGxQUa2MkMgyMQ
 qhqPAbxOlxvBgKgEyimoJFIWhA==
X-Google-Smtp-Source: ABdhPJygc7ON8mHXHUn9rpdE0Z0h3GFZ5/ajJGnahGfYA0b4fauv+ncMZhHz/aUIPt3hY+/4DXNukA==
X-Received: by 2002:a1c:a557:: with SMTP id o84mr16774553wme.42.1593435281269; 
 Mon, 29 Jun 2020 05:54:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t4sm23344458wmf.4.2020.06.29.05.54.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 05:54:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 553E61FF7E;
 Mon, 29 Jun 2020 13:54:39 +0100 (BST)
References: <20200626181357.26211-1-alex.bennee@linaro.org>
 <20200626181357.26211-27-alex.bennee@linaro.org>
 <9d44ff2f-a42a-449b-7e1a-8e006a510f6d@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 26/30] gitlab: enable check-tcg for linux-user tests
In-reply-to: <9d44ff2f-a42a-449b-7e1a-8e006a510f6d@redhat.com>
Date: Mon, 29 Jun 2020 13:54:39 +0100
Message-ID: <87k0zqrq0g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: fam@euphon.net, Laurent Vivier <lvivier@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, f4bug@amsat.org,
 cota@braap.org, qemu-arm <qemu-arm@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 26/06/2020 20.13, Alex Benn=C3=A9e wrote:
>> Switch to building in the new debian-all-test-cross image which has
>> most of the cross compilers inline.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   .gitlab-ci.yml | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index 5ae8130bd1a..17c3349dd9e 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -140,10 +140,9 @@ build-tcg-disabled:
>>   build-user:
>>     <<: *native_build_job_definition
>>     variables:
>> -    IMAGE: ubuntu2004
>> -    CONFIGURE_ARGS: --disable-system --disable-guest-agent
>> -      --disable-capstone --disable-slirp --disable-fdt
>> -    MAKE_CHECK_ARGS:  run-tcg-tests-i386-linux-user run-tcg-tests-x86_6=
4-linux-user
>> +    IMAGE: debian-all-test-cross
>> +    CONFIGURE_ARGS: --disable-tools --disable-system
>> +    MAKE_CHECK_ARGS: check-tcg
>
> The pipeline is failing for me now:
>
> https://gitlab.com/huth/qemu/-/jobs/615345144#L2654
>
> qemu-arm: /builds/huth/qemu/linux-user/elfload.c:2321: pgb_reserved_va:=20
> Assertion `addr =3D=3D test' failed.
>
> Is that a known bug already?

Yes - that's one of the problems that seems to be a unique failure on
GitLab's infrastructure.

>
>   Thomas


--=20
Alex Benn=C3=A9e

