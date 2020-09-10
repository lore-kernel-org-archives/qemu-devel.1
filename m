Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D566C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1098206E9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 20:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AUbfBMYh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1098206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGTGc-0003uD-HZ
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 16:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGTG1-0003Hk-9m
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 16:33:25 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:43483)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGTFz-00064J-D1
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 16:33:24 -0400
Received: by mail-ej1-x630.google.com with SMTP id o8so10658843ejb.10
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=756uFswCWvT28CT6c6OZFSD181Q6rr/qdR8Xu8qm6ZA=;
 b=AUbfBMYh49ooAVL/Lo+BgRLaSpOB6H0OSLuF+A9m4O0VIicDw0SsZvJzZQstMfBjse
 Z/FOiheH5MWMO+GHuAFpJUkKcINbDiURq8TdMNKcbhpYT6+mzLn/c3ZC16MRKWfTfBfk
 1ZOxWAPmLWj/azjQ/IqS3bBPokzSFzmw/JQadcyA8fF5Fn6f1dR6adrdMD8ZvCcJphQk
 RUl3dUJqxeXbgZHY7Hy+ICATpXkQrrJ1NxP29Psi3QfwJsbkmTIVPRh49HYLSnvTv4DP
 bBlH34osqIG1Rw+Cj6xou9Yh14MEiTFwaNpMzi4K9DuT/iQVIRdPs/bPfVuk+amq13MB
 rH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=756uFswCWvT28CT6c6OZFSD181Q6rr/qdR8Xu8qm6ZA=;
 b=cqNKLEpILtvVpZ04JzBu0SfDSXQEpWlUkn3MWy+p0DkvjjVnMauX5i5cS40l0lwy91
 M4cKt9N3mDixj4w2LbV26i/+GnFzZNqhr3EClniY/IqLaNKDsizutsJa4/4TzkPVo+Gq
 P+D92YEvQg9PrTXhYv/DfYV2IbRNY5omfpvzpxiGy/gcla90rDyY54SoUn9b8H2PltZ3
 ZZ96KFnJwVS/CfQibebSxd3D/gBDRG6Pc3b+jsYmO03TVG0qQHFq4J/Rmd7K5Q9/9idl
 edaHzKxRWs3Sq0dJiux+H9IxBWGry0qv+R1E8Wvebzu4aa2F6C73V1kVrc/t0iClwR79
 KFbw==
X-Gm-Message-State: AOAM531YSd9orfUzYP+zv9F+7oVdkSAhB3oHKMZT67I0WTQJ5ysDlro3
 hJj+DerpABEwnD/y8D2djCpRihyGKNM3dBp5supBGg==
X-Google-Smtp-Source: ABdhPJxWSdCYbamgDA+JZD02Hl55/CJ8D7y8uOlVGlWr1XM09WSO/Db880WNSZSudvFOyCDlkUBo72FxvxE2WuGSpm8=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr10812323ejb.4.1599770001755; 
 Thu, 10 Sep 2020 13:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200910131504.11341-1-alex.bennee@linaro.org>
 <20200910131504.11341-7-alex.bennee@linaro.org>
In-Reply-To: <20200910131504.11341-7-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Sep 2020 21:33:10 +0100
Message-ID: <CAFEAcA9E6sGNGn6aYy8DxCVZDYeot9EjRvKLEQ2CzAxUkGyBzg@mail.gmail.com>
Subject: Re: [PULL 06/10] configure: don't enable ppc64abi32-linux-user by
 default
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 at 14:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The user can still enable this explicitly but they will get a warning
> at the end of configure for their troubles. This also drops any builds
> of ppc64abi32 from our CI tests.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Message-Id: <20200909112742.25730-7-alex.bennee@linaro.org>

I know this is in a pullreq at this point, but I just got round
to looking at it, and it has some odd logic in it so I figured
I'd give my review comments anyway.

> +if test -z "$target_list_exclude" -a -z "$target_list"; then
> +    # if the user doesn't specify anything lets skip deprecating stuff
> +    target_list_exclude=3Dppc64abi32-linux-user

Doesn't this have the slightly curious logic
that if we have more than one deprecated target then
configure with --target-list-exclude=3Dsomething-else
will actually build more targets than configure without that
exclude option (because it will exclude the something-else
but stop excluding the deprecated targets)? I would have
expected the deprecated targets to be not compiled unless
the user explicitly enabled them. I think that would be
something more like

   deprecated_targets_list=3Dppc64abi32-linux-user
   if test -z "$target_list"; then
       target_list_exclude=3D"$target_list_exclude,$deprecated_targets_list=
"
   fi

I suppose we would ideally like an "enable all including
the deprecated stuff", and that gets messy because there's
no way to do it except listing everything explicitly I think...

> +fi
> +
> +exclude_list=3D$(echo "$target_list_exclude" | sed -e 's/,/ /g')
> +for config in $mak_wilds; do
> +    target=3D"$(basename "$config" .mak)"
> +    exclude=3D"no"
> +    for excl in $exclude_list; do
> +        if test "$excl" =3D "$target"; then
> +            exclude=3D"yes"
> +            break;
>          fi
>      done
> -fi
> +    if test "$exclude" =3D "no"; then
> +        default_target_list=3D"${default_target_list} $target"
> +    fi
> +done
>
>  # Enumerate public trace backends for --help output
>  trace_backend_list=3D$(echo $(grep -le '^PUBLIC =3D True$' "$source_path=
"/scripts/tracetool/backend/*.py | sed -e 's/^.*\/\(.*\)\.py$/\1/'))
> @@ -7557,7 +7558,7 @@ TARGET_SYSTBL=3D""
>  case "$target_name" in
>    i386)
>      mttcg=3D"yes"
> -       gdb_xml_files=3D"i386-32bit.xml"
> +    gdb_xml_files=3D"i386-32bit.xml"
>      TARGET_SYSTBL_ABI=3Di386
>      TARGET_SYSTBL=3Dsyscall_32.tbl
>    ;;

(unrelated change ;-))

> @@ -7667,6 +7668,7 @@ case "$target_name" in
>      TARGET_SYSTBL_ABI=3Dcommon,nospu,32
>      echo "TARGET_ABI32=3Dy" >> $config_target_mak
>      gdb_xml_files=3D"power64-core.xml power-fpu.xml power-altivec.xml po=
wer-spe.xml power-vsx.xml"
> +    deprecated_features=3D"ppc64abi32 ${deprecated_features}"

Maybe prefer
    add_to deprecated_features ppc64abi32

?

>    ;;
>    riscv32)
>      TARGET_BASE_ARCH=3Driscv

If we just made the deprecation warning be printed by
generic logic whenever a deprecated target ended up in
the enabled list then it would be easier to add other deprecated
targets to the list, as you wouldn't thae also have to find some
other part of configure like this to set a deprecated_features variable.

(I'll send a patch to add lm32-softmmu,tilegx-linux-user,unicore32-softmmu
to the deprecated-target list later once we have the mechanism in place.)

> @@ -8011,6 +8013,12 @@ fi
>  touch ninjatool.stamp
>  fi
>
> +if test -n "${deprecated_features}"; then
> +    echo "Warning, deprecated features enabled."
> +    echo "Please see docs/system/deprecated.rst"
> +    echo "  features: ${deprecated_features}"
> +fi
> +
>  # Save the configure command line for later reuse.
>  cat <<EOD >config.status
>  #!/bin/sh
> --

thanks
-- PMM

