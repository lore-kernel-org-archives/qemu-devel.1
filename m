Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CEAC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F168E23D38
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IxdeIJou"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F168E23D38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptMV-0002RB-9Q
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 08:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jptLg-0001x7-BY
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:57:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jptLe-00025r-AV
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:57:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id b6so16419869wrs.11
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=o+wV428n/xOj2UW9zJu7ce9MjV5cQMnBDEnNRBoDavk=;
 b=IxdeIJou8KWJQFGO3PiywEwp1pi4vfz8OmCSp1TOcbO3fM2QNJ3GJKuQgw9DJJtpxu
 3BC/3RHRrMSAqQc1Uh/WT20ri+ADwohuykno009x/s5Yh8NssqSSsMiaNWzuiQrdmzw+
 /UzqLUag2N6m+hxihdJCNEbu9eg3YValKaZgMo0Y6yXim9SMspp5k5sqEkOtUlZlE/H5
 6OCSBNZbkYwb5O4sQ9/GFP3Bw9zgrD8v7i76mBQkGEzJPGOr0OzX67rAlOAqRrfw+uvC
 7WXtg3CZjxJLcxg3qhkvhILLDAGvn/h9QHnS0fwhe8s891DZ2JXEURD7l8QNMtehUEKF
 1iZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=o+wV428n/xOj2UW9zJu7ce9MjV5cQMnBDEnNRBoDavk=;
 b=GPHBuTMTO8SIIHVEqV+IntJC44eSRfmzfYcPzRUilQ9vFBeJDMVf9Nq7qScH0nax3/
 v6LsM1QO5eEo7eyIkPPY95aNL9pvC3foS7dCeZRWWFZEQ6PQ7wr+kv1X/p8uJ62ukV1Y
 FAyD/d4SfIouSFhMyOjuxtJRGo6qGUFYY/W1JOY8etNJcfxT9qwraNZyKgy0ZF0sUZ7y
 2whS5DFNLw+0CROQH+EtPOEzq1bvhWDjmWUbFWGEQP09iz7cMOdRvc83KsMk1JlCYYHM
 KAvhA0yaPajB6uCuNEJtHmPQ8YSaS+fwv31J9P0X6khpZXbCscQ6UyIsw60W/HT3M2sv
 4d5w==
X-Gm-Message-State: AOAM532OAUdnGI3HDlL5EgOCM+g1begH7UnbgVFkeuMoZUQHIKbEhGBh
 5OznZ0Qv2vElduJhsQ8cZM16wQ==
X-Google-Smtp-Source: ABdhPJyo9WycoCKwVOBCis4QqKjkiwwW6I3e9hFI83XkCPGxjjfAz12Oz2ka+zB1A2JqxHkKsoNj8Q==
X-Received: by 2002:adf:eecf:: with SMTP id a15mr16966952wrp.83.1593435439689; 
 Mon, 29 Jun 2020 05:57:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 104sm49781291wrl.25.2020.06.29.05.57.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 05:57:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AB7391FF7E;
 Mon, 29 Jun 2020 13:57:17 +0100 (BST)
References: <20200626181357.26211-1-alex.bennee@linaro.org>
 <20200626181357.26211-29-alex.bennee@linaro.org>
 <a2cf0d51-adca-db86-8af1-a3ac280f9a50@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 28/30] gitlab: split build-disabled into two phases
In-reply-to: <a2cf0d51-adca-db86-8af1-a3ac280f9a50@redhat.com>
Date: Mon, 29 Jun 2020 13:57:17 +0100
Message-ID: <87eepyrpw2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 f4bug@amsat.org, cota@braap.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 26/06/2020 20.13, Alex Benn=C3=A9e wrote:
>> As we run check-qtest in "SLOW" mode this can timeout so split into
>> two jobs.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   .gitlab-ci.yml | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index eb5b335c1e9..c6f1addc2f3 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -110,7 +110,7 @@ check:system-fedora-alt:
>>       IMAGE: fedora
>>       MAKE_CHECK_ARGS: check-acceptance
>>=20=20=20
>> -build-disabled:
>> +build:system-fedora-disabled:
>>     <<: *native_build_job_definition
>>     variables:
>>       IMAGE: fedora
>> @@ -121,6 +121,17 @@ build-disabled:
>>         --disable-qom-cast-debug --disable-spice --disable-vhost-vsock
>>         --disable-vhost-net --disable-vhost-crypto --disable-vhost-user
>>       TARGETS: i386-softmmu ppc64-softmmu mips64-softmmu i386-linux-user
>> +  artifacts:
>> +    paths:
>> +      - build
>> +
>> +qtest:system-fedora-disabled:
>> +  <<: *native_test_job_definition
>> +  needs:
>> +    - job: build:system-fedora-disabled
>> +      artifacts: true
>> +  variables:
>> +    IMAGE: fedora
>>       MAKE_CHECK_ARGS: check-qtest SPEED=3Dslow
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> I still wonder why the test got slower in the recent weeks ... and maybe=
=20
> we should also change the target list now that the test runs in a=20
> separate stage? ... well, I guess that's also something for later ...

s390x acceptance tests seem to be running a lot slower than they did on
Travis. I can't believe it's just a difference in core speed of the VM.


--=20
Alex Benn=C3=A9e

