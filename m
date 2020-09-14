Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DC5C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 19:18:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC154208E4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 19:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3pItE1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC154208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHtzX-00086v-Q5
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 15:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45090)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHtyb-0006tq-Tl
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 15:17:21 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:42823)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHtya-0004Zs-2D
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 15:17:21 -0400
Received: by mail-ej1-x643.google.com with SMTP id q13so1514021ejo.9
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 12:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vyfALNZRlrEMFnI/NQpsUoeKv/0J316ttWedOl1I+8c=;
 b=g3pItE1Qc+5HPqS1Q7bRjX9rkkraOx/doMUmuCUBpg3q78hKWiRuilJoveVsc/o02g
 cG1FiNF5b/JxL/K5sFrea5wVfO10aESLpC2pLqbDQMIjsLhKeYRot0aFweXq7Q0SV2lB
 FGtyZHVDMpRDSWi7pKIdbwtu/cHxni75ZlQA2FAulhwoXPw3ZffBCM6kD3rorrNHHfDy
 fv2H6gRE+70mXwmLK9qu699mkTOBz7PDCwtSsQIxeGHn6Ktbmfs9RrKybtNTJBuzGQlJ
 qPA1rY4qhEcHQ6z20VC7v2UDbOn5KxFXGU88HEKQoniUI9gDbHEdCInVkgOzVEyAMDMd
 TS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vyfALNZRlrEMFnI/NQpsUoeKv/0J316ttWedOl1I+8c=;
 b=KKnfLfs2CdQlb9dGHATJyDd6eFmQQfA7uuZ4s6HUwmmlNZGzdLipnqSiUAJjW8sndF
 D2+9gHcALCmjSIpr+dGs1Uhm/oxdmuZY17qu2YWxsGSPzPyYDMx9/qylC0lkkSlLAk/P
 y+1u33vzQR/+LgtIkpxdrkzkpTjpZY/srhDQyB9gQ1t/PExTkmog9nGN2aHHasKZ1xPA
 r6vLxcGBrw9MKyh4bnkJvMd7dgdeA7FkJ1buNNjbNjD5KRbuete3Qy0UEpvLn/O6QKkS
 lojfwMBilneWFehoEIas/gxxTG4x3f8tdK+O8iVyDgsm2vPIo/ZNBYH2RAhhCpLuce7H
 4Z0w==
X-Gm-Message-State: AOAM530oRkvDkikNCSep+DJIHHOetFuUPcAML67cMcJ/MH6mpzrHfTKa
 UgGEd1PJuHaybYH3oar5HA1CbKQKgb9/eV6U0sevVg==
X-Google-Smtp-Source: ABdhPJwOaKDLpQ4afoiTUtp9sWtKiWyD9WoT5K7WiOSWPNK2sNjdUwTehe267MtVwhoc1QLpQzfSzyZNWkPNFcsGt0w=
X-Received: by 2002:a17:906:d936:: with SMTP id
 rn22mr16419679ejb.4.1600111038355; 
 Mon, 14 Sep 2020 12:17:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200914150716.10501-1-alex.bennee@linaro.org>
 <20200914150716.10501-4-alex.bennee@linaro.org>
In-Reply-To: <20200914150716.10501-4-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Sep 2020 20:17:06 +0100
Message-ID: <CAFEAcA9dCDfFTNsxYR2fpVfQYiNd6T-iLpQyfQAWayo2Mc0buA@mail.gmail.com>
Subject: Re: [PATCH v1 3/6] configure: also skip deprecated targets with
 target-list-exclude
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 14 Sep 2020 at 16:27, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Now the user has to make an even more deliberate decision to
> enable a deprecated target rather than getting it as a side effect of
> using --target-exclude-list.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  configure | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/configure b/configure
> index e365a90cc133..50052378e417 100755
> --- a/configure
> +++ b/configure
> @@ -1722,9 +1722,15 @@ if [ "$bsd_user" =3D "yes" ]; then
>      mak_wilds=3D"${mak_wilds} $source_path/default-configs/*-bsd-user.ma=
k"
>  fi
>
> -if test -z "$target_list_exclude" -a -z "$target_list"; then
> -    # if the user doesn't specify anything lets skip deprecating stuff
> -    target_list_exclude=3Dppc64abi32-linux-user
> +# If the user doesn't explicitly specify a deprecated target we will
> +# skip it.
> +if test -z "$target_list"; then
> +    deprecated_targets_list=3Dppc64abi32-linux-user

If you put this variable setting outside the if...

> +    if test -z "$target_list_exclude"; then
> +        target_list_exclude=3D"$deprecated_targets_list"
> +    else
> +        target_list_exclude=3D"$target_list_exclude,$deprecated_targets_=
list"
> +    fi
>  fi
>
>  exclude_list=3D$(echo "$target_list_exclude" | sed -e 's/,/ /g')

then later on once we've parsed the exclude list and set
default_target_list we can say something like (untested!)

for dep_target in $(echo "$deprecated_targets_list" | sed -e 's/,/ /g'); do
    for target in $default_target_list; do
        if "$dep_target" =3D "target"; then
            add_to deprecated_features $target
            break
        fi
    done
done

and then the only thing necessary to add another deprecated target
will be to add it to the variable (ie we can just delete the
add_to line your patch 2 puts in as we don't need to modify
that code at all any more).

(Side note: I just followed the code we have currently for
doing the "is the target in the exclude list" but this
seems tremendously clunky given we're really just trying
to ask "is string X in set Y"...)

thanks
-- PMM

