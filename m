Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813DBC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0100620575
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 08:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rd45LHl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0100620575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGe4C-0006yT-06
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 04:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGe3S-0006Qm-EW
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:05:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kGe3P-0006LF-D1
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 04:05:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id z4so10546368wrr.4
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 01:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=Ti0ccMiZBH6WSmU0p9CQpx5A4tGyH+hVnSwHNJ4BVSY=;
 b=rd45LHl6wrc11OlVQMuJtN2CTaR6F9Cw/cI5+U2NnkOP/Kq5jzdmTDShVEv+pnNV6S
 CxRq+rlu0Ibyxe/2oLoLKBbEucEelV+AE4+EomIlIHaY3G03LzpT3clcEhYcvfJoCj/Q
 9Mb1z5W3Ab/NPAI9PQiCASvvpXqPQcW4NIl766hvgm02taBHprv6xuQpLungYfUgi4vb
 rIOcjnpNf8yHmfZENB9Nbis/DBVLc4uh8t5Reeci0CzcByf8nBHhwJ044k78o9fHR9CC
 7Citp5z8AC2N5+T5/gZ0YjTkzy9jKhGpRu+ZZAWxHemOR9VgcpWgQyxmW4sRfk29adn4
 krZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=Ti0ccMiZBH6WSmU0p9CQpx5A4tGyH+hVnSwHNJ4BVSY=;
 b=dY9hIaZUwr3V+FWQpmf9fLJ4MhgoOQ4dp0F9//KKBUNcmsu2ThPHh2r68i7EuKL/5W
 kUGNv9crMjaTB1xCNZXQ0kfAojTidLEjGmsbYNEnDZBYVwBxvYwouEjEkITcdaC6UQnW
 hJmaOnciOCl82JZFlNarizepvIJERuW2ewxsOoOavSW/YKdkFlByzJOMf+0upP1qH8Wd
 hSAlW9cKKh9snr07SvVH5ulT0oWo4MswdHDBC74nYuqOwW+YsfPhs2NV/sp4OkOKUnu/
 lBAzB8H7oTOquZYvntLSr1NRV2cMr/0y0pL9rylzXBCy6OtvCGmIOUnXZe5y+TZwdsrm
 iuXg==
X-Gm-Message-State: AOAM531ue/YNSMZGgz3XN5OfHm9p2XDu2/D1vN87R96GgMHM9koQj8gw
 1hc+rknH8wv9Hfx9FWF9/VV2YA==
X-Google-Smtp-Source: ABdhPJxlDbjjOGoSknu2bIxA+1VP0gg8dk/dUfiL7b1y/t94hHxJsIMTjZg3YoI4h39+12gViRKeQw==
X-Received: by 2002:a5d:518b:: with SMTP id k11mr741468wrv.369.1599811505386; 
 Fri, 11 Sep 2020 01:05:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id x2sm2963014wrl.13.2020.09.11.01.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 01:05:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8A3FC1FF7E;
 Fri, 11 Sep 2020 09:05:03 +0100 (BST)
References: <20200910131504.11341-1-alex.bennee@linaro.org>
 <20200910131504.11341-7-alex.bennee@linaro.org>
 <CAFEAcA9E6sGNGn6aYy8DxCVZDYeot9EjRvKLEQ2CzAxUkGyBzg@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 06/10] configure: don't enable ppc64abi32-linux-user by
 default
In-reply-to: <CAFEAcA9E6sGNGn6aYy8DxCVZDYeot9EjRvKLEQ2CzAxUkGyBzg@mail.gmail.com>
Date: Fri, 11 Sep 2020 09:05:03 +0100
Message-ID: <87wo10oi1c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Da?= =?utf-8?Q?ud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Thu, 10 Sep 2020 at 14:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> The user can still enable this explicitly but they will get a warning
>> at the end of configure for their troubles. This also drops any builds
>> of ppc64abi32 from our CI tests.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> Message-Id: <20200909112742.25730-7-alex.bennee@linaro.org>
>
> I know this is in a pullreq at this point, but I just got round
> to looking at it, and it has some odd logic in it so I figured
> I'd give my review comments anyway.
>
>> +if test -z "$target_list_exclude" -a -z "$target_list"; then
>> +    # if the user doesn't specify anything lets skip deprecating stuff
>> +    target_list_exclude=3Dppc64abi32-linux-user
>
> Doesn't this have the slightly curious logic
> that if we have more than one deprecated target then
> configure with --target-list-exclude=3Dsomething-else
> will actually build more targets than configure without that
> exclude option (because it will exclude the something-else
> but stop excluding the deprecated targets)? I would have
> expected the deprecated targets to be not compiled unless
> the user explicitly enabled them. I think that would be
> something more like
>
>    deprecated_targets_list=3Dppc64abi32-linux-user
>    if test -z "$target_list"; then
>        target_list_exclude=3D"$target_list_exclude,$deprecated_targets_li=
st"
>    fi
>
> I suppose we would ideally like an "enable all including
> the deprecated stuff", and that gets messy because there's
> no way to do it except listing everything explicitly I think...

Yeah - we could make it smoother although I think the only real users of
--target-list-exclude are the CI systems and they all explicitly exclude
ppc64abi32 when they do it.

Do you want me to re-spin with those changes?

>
>> +fi
>> +
>> +exclude_list=3D$(echo "$target_list_exclude" | sed -e 's/,/ /g')
>> +for config in $mak_wilds; do
>> +    target=3D"$(basename "$config" .mak)"
>> +    exclude=3D"no"
>> +    for excl in $exclude_list; do
>> +        if test "$excl" =3D "$target"; then
>> +            exclude=3D"yes"
>> +            break;
>>          fi
>>      done
>> -fi
>> +    if test "$exclude" =3D "no"; then
>> +        default_target_list=3D"${default_target_list} $target"
>> +    fi
>> +done
>>
>>  # Enumerate public trace backends for --help output
>>  trace_backend_list=3D$(echo $(grep -le '^PUBLIC =3D True$' "$source_pat=
h"/scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))
>> @@ -7557,7 +7558,7 @@ TARGET_SYSTBL=3D""
>>  case "$target_name" in
>>    i386)
>>      mttcg=3D"yes"
>> -       gdb_xml_files=3D"i386-32bit.xml"
>> +    gdb_xml_files=3D"i386-32bit.xml"
>>      TARGET_SYSTBL_ABI=3Di386
>>      TARGET_SYSTBL=3Dsyscall_32.tbl
>>    ;;
>
> (unrelated change ;-))
>
>> @@ -7667,6 +7668,7 @@ case "$target_name" in
>>      TARGET_SYSTBL_ABI=3Dcommon,nospu,32
>>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>>      gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml p=
ower-spe.xml power-vsx.xml"
>> +    deprecated_features=3D"ppc64abi32 ${deprecated_features}"
>
> Maybe prefer
>     add_to deprecated_features ppc64abi32
>
> ?
>
>>    ;;
>>    riscv32)
>>      TARGET_BASE_ARCH=3Driscv
>
> If we just made the deprecation warning be printed by
> generic logic whenever a deprecated target ended up in
> the enabled list then it would be easier to add other deprecated
> targets to the list, as you wouldn't thae also have to find some
> other part of configure like this to set a deprecated_features variable.
>
> (I'll send a patch to add lm32-softmmu,tilegx-linux-user,unicore32-softmmu
> to the deprecated-target list later once we have the mechanism in place.)
>
>> @@ -8011,6 +8013,12 @@ fi
>>  touch ninjatool.stamp
>>  fi
>>
>> +if test -n "${deprecated_features}"; then
>> +    echo "Warning, deprecated features enabled."
>> +    echo "Please see docs/system/deprecated.rst"
>> +    echo "  features: ${deprecated_features}"
>> +fi
>> +
>>  # Save the configure command line for later reuse.
>>  cat <<EOD >config.status
>>  #!/bin/sh
>> --
>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

