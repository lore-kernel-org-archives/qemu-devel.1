Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF7FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:20:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9671120674
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 20:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2aQnve4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9671120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4vf-0006lp-SA
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 16:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv4uz-0006DR-UH
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:19:17 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jv4uy-0000Xv-Hk
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 16:19:17 -0400
Received: by mail-wr1-x443.google.com with SMTP id q5so18219058wru.6
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vjtxLVqD0MRcucs8+s4ZwTq3aQoZ+w+YFApHQhr7qu4=;
 b=F2aQnve49p0RWhjxd64ifch/r3hkgLOC9N9/NJwdghImwYYMfeRnX2nvPJ/PUwNKTH
 iSS9XjvGf6wWLSN/j/5sOIwy7GUFVGMHF/Ju4Uf+0UoS818AMg5EyrBzjb/ZDfT3PFlm
 sUE45TE49R3K7qjzW2s2o/vGGMISAD/bkg2xg5FIKBK+kftChGqUPgiLeEN95NbUqgco
 8cOHrUCvgyBN74NeJoOUHr5NV/5m3CknpzSiDyvlYt3oV7772Nq/SxVo0qq1DoutTtix
 r8Q+4TH6YfIG9+2tHSBIy/qMFdLnGACxTW3kmtT+AWi7p9NmT/14fBCOpn6Dv34B8hDL
 wmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vjtxLVqD0MRcucs8+s4ZwTq3aQoZ+w+YFApHQhr7qu4=;
 b=sSFB/7LvPZiYlPrrGs3syklnyzBy9bvhdATNekONYzPXlm/IIE5ACAglGmZy8TGgrK
 nS7wkn7S8Iq3st9QT1F09o5npFzWbgCEIM/RMvgQFwf0BdDi7ZCeD6pAHUazElzrbpkA
 pDlx3yKzRrTJNQGzyuCa2gsJwhlC3i0PYxYaOzpraQJ2O74Hagfd0UVM//BvT2h2tyUt
 DAyjz1RKAjWKkjj5aW57BCS8fsML6Y5va9hgVY4pjP3E33nFpEzxUdkNHt4Xy0qzcpm2
 6RmqJNEnsA4aT3TX6Or56DpLyBkn3Fqxn0BARnsd4HW8inJdq4KKo/rb3hqkm/XLA8my
 PV1g==
X-Gm-Message-State: AOAM531ypquxxylOzUk6NT/0FhJ/C8KMkrCPVB/uw2YuIyWd9pJQ7nQu
 XE9upbm0Ajc4Fp6gNqW6VuXLkkB8k4I=
X-Google-Smtp-Source: ABdhPJxKLr9nPL2fsYFu2OXV+GZmR8dM3YARX67JIcher2rAV0qPOXJ+mOh54siNde0LRF4XG8024g==
X-Received: by 2002:adf:94a1:: with SMTP id 30mr1183442wrr.37.1594671553911;
 Mon, 13 Jul 2020 13:19:13 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id q7sm25990813wrs.27.2020.07.13.13.19.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 13:19:13 -0700 (PDT)
Subject: Re: [PATCH] gitlab-ci/containers: Add missing wildcard where we
 should look for changes
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
References: <20200713182235.30379-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dab4b887-d114-0c73-1abe-43c34018c502@amsat.org>
Date: Mon, 13 Jul 2020 22:19:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713182235.30379-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 8:22 PM, Thomas Huth wrote:
> The tests/docker/* wildcard seems to only match the files that are directly
> in the tests/docker folder - but changes to the files in the directory
> tests/docker/dockerfiles are currently ignored. Seems like we need a
> separate entry to match the files in that folder. With this wildcard added,
> the stages now get re-run successfully when something in the dockerfiles
> has been changed.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .gitlab-ci.d/containers.yml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
> index f3c0ca4d61..8c89efeb6d 100644
> --- a/.gitlab-ci.d/containers.yml
> +++ b/.gitlab-ci.d/containers.yml
> @@ -24,6 +24,7 @@
>      - changes:
>        - .gitlab-ci.d/containers.yml
>        - tests/docker/*

The test-* and common.rc are used outside, maybe we can
amend:

-        - tests/docker/*
+        - tests/docker/Makefile.include
+        - tests/docker/docker.py

Anyway,
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +      - tests/docker/dockerfiles/*
>      - if: '$CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH'
>      - if: '$CI_COMMIT_REF_NAME == "testing/next"'
>  
> 


