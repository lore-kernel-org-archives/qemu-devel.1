Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F362C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:03:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E240923750
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxUqkzUZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E240923750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqcz-0000JL-5C
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpqba-0007lp-7a
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:01:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpqbU-0004Ry-Rr
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:01:34 -0400
Received: by mail-wr1-x441.google.com with SMTP id z13so15902050wrw.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aoBK+BJVe9wvWi/7RDXVuw89eEJspNnoPe1B6yw7WL8=;
 b=oxUqkzUZ2oPINVrBoaM67onnntqbhIBP2hXTjxcdL3x5CRWBjd8ljnDrZdoLBoju3q
 ITOwFkhxAsPlIXeEWnqh+PNU2YQG84Un7xvbQjWPswh13bKNyPbjJbCLJKg/a53Uf5Hp
 nX9lC6A8mUc1doFFV0A8ESw8D545eIFRMEvY9ydUVJLfsI7cp6MlL3VTp6+DILYXHmXk
 0oXeZDnaGwWF6/VbDL9TnSLGkQBjQpN/pAq5QE72R+rWcO5XIN6dQmmgBXhOE/L5MgSc
 kOMdfFs52nC9Uz1iBOr5RD99W6O8OyCxKI9d0BQO4rTToQgzFBT/SZtQ/HV/hoSZQ+Yk
 PzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aoBK+BJVe9wvWi/7RDXVuw89eEJspNnoPe1B6yw7WL8=;
 b=R53qsqRJ+Q6yBiCg/RKFfGSW0hkMbvNYrh4QqJ9VXgZSwDXIlHWN1/7pPerNgc78Rc
 bmnsnW/RkbkzfHjh/mfMugnpg48+haJA4ejk8pcpl/gqRjz1Mo86CBh41sXC94YOODho
 +egYy2VstqGmZJ9l6pvRDYD9I2gRD7IrByxnBVydiUaF42grETtruixKsLgvN/22hj0V
 IaQm7J+NFR+z+k4tvXTsmCYIeBMhyQK0BTHhMbmSeGb6q3a55WohM4egE4SJjGV8sXZj
 KRIhGudGJxHtPI+Fkz+XU3XwbxicVN2vr1NDMH4DSP48/hRpPMj3eXdqtD/VCYZXbem8
 7ObQ==
X-Gm-Message-State: AOAM532QzuXPumi8zs29pmUW01kOejRsoiojXb7QP+A3qZ8KRjggw/2o
 JEWeWMaeNAXWYXlkOZXLy7E=
X-Google-Smtp-Source: ABdhPJzkXkYDzrpwecd52S1GR075lq7aPzbgEQXcR4Iw+U3E3gVkFMBq9E+//COEJkFIgpinUj0g5w==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr17533507wrq.38.1593424888683; 
 Mon, 29 Jun 2020 03:01:28 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id z17sm8879646wmc.3.2020.06.29.03.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 03:01:28 -0700 (PDT)
Subject: Re: [PATCH v3 29/30] gitlab: limit re-builds of the containers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200626181357.26211-1-alex.bennee@linaro.org>
 <20200626181357.26211-30-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5c887586-37b7-6645-ca19-98862218f76d@amsat.org>
Date: Mon, 29 Jun 2020 12:01:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200626181357.26211-30-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, richard.henderson@linaro.org, cota@braap.org,
 berrange@redhat.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 8:13 PM, Alex Bennée wrote:
> Most of the time we are just rebuilding the same things. We can skip
> this although currently there is no mechanism for picking up new
> distro releases.
> 
> Rather than try to be too fine grained allow any change to trigger all
> the images being rebuilt.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  .gitlab-ci.d/containers.yml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
> index 20b2fb1de5d..f56aa44f711 100644
> --- a/.gitlab-ci.d/containers.yml
> +++ b/.gitlab-ci.d/containers.yml
> @@ -19,6 +19,10 @@
>      - docker push "$TAG"
>    after_script:
>      - docker logout
> +  only:
> +    changes:
> +      - .gitlab-ci.d/containers.yml
> +      - tests/docker/*
>  
>  amd64-centos7-container:
>    <<: *container_job_definition
> 

