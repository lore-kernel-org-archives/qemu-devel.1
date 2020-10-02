Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E2AC4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:12:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4922074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ohOpoZC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4922074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKrg-0008IN-HH
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOKqV-0007FU-QC
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:11:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53818)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kOKqT-0002d0-Jl
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:11:35 -0400
Received: by mail-wm1-x343.google.com with SMTP id x23so1644907wmi.3
 for <qemu-devel@nongnu.org>; Fri, 02 Oct 2020 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:references:date:in-reply-to:message-id
 :user-agent:mime-version:content-transfer-encoding;
 bh=UKS7v7UaQKI4Gkmek1FFSorUfGZBX2gK84Yih77cwBE=;
 b=ohOpoZC3bR5BWaAFaOY1Hp1m2Sc/xH4JiTbbWFr6YzLhqZTmv2l+J/NlLM1VOOnLn1
 QGViFBE3MBQfrg605sVZY9WNXDiUg7KuA5K+l9GOrw3jBTMJizxVuEh/b9m7/jrB8ERs
 mYokcxaGxjLSicrPw6q0I+Bp+aM1dcTSrQiWUfbXBw4fGbQpT/HpeuAw8UkTMapye2+d
 H/mzQe9McHKcSAwRXY2vWlsJVIOzZKRpuUsRaoJU2xQr212TXRLKI5I1dGzHkCgmM4hH
 caHvJJZuZ92D3qiGfNc0/gCwfyhEPc5pWxb9H0Z+/rnOVZ2CBon/Y37KX+R1KS7sv/CD
 tykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
 :message-id:user-agent:mime-version:content-transfer-encoding;
 bh=UKS7v7UaQKI4Gkmek1FFSorUfGZBX2gK84Yih77cwBE=;
 b=FmNVm6RgZX5KVZPmZdKP2tCVg4hA92FNpsmoMCaeWvAOfzF2WXdISku1YNRWdnbcFp
 cnN6udTh+yzDSA/WArvo+nRd9tezzeQxYAj7VpULKCog1OXpQ4fidHWb+RKCOMI1dCCS
 vQTdvso1TeFXew8OVMBdiznWPlqWPdxZfSsXZtVPl5BUgwP+s+zXXnUnI8jfELcB+6rk
 C2SnDZLckFXpBeqaead5K/7x7J20H+gGZTv5behn8T4fsXv+7QBtIsq7h43uRd+eb5nU
 +HbP05pYyUFLsRst++XwLN0zZa1NRU7oIPIVCHZRp8dYtfvRunERedRo18V/fFG86My8
 djOg==
X-Gm-Message-State: AOAM5302bzH1i1khOOf1eS7qGR4iVyxIlKKFcPJ00/0lFTb8BvciUz7j
 tVSzTa086SNhcOWuBHzWxGvpA3Nt3/UgXA==
X-Google-Smtp-Source: ABdhPJxWFyIplRW7Bn4+e1dbSvPIQnJKWxU+cuzxnk1Tu/JDRHljFr/zNYlCzSo1rGZ2kBxI0CtHOg==
X-Received: by 2002:a1c:48c3:: with SMTP id v186mr3125068wma.16.1601644291352; 
 Fri, 02 Oct 2020 06:11:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e18sm1972699wra.36.2020.10.02.06.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 06:11:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2CDB11FF7E;
 Fri,  2 Oct 2020 14:11:29 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] virtiofsd: Call qemu_init_exec_dir
References: <20201002124015.44820-1-dgilbert@redhat.com>
Date: Fri, 02 Oct 2020 14:11:29 +0100
In-Reply-To: <20201002124015.44820-1-dgilbert@redhat.com> (David Alan
 Gilbert's message of "Fri, 2 Oct 2020 13:40:15 +0100")
Message-ID: <87wo08n56m.fsf@linaro.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Since fcb4f59c879 qemu_get_local_state_pathname relies on the
> init_exec_dir, and virtiofsd asserts because we never set it.
> Set it.
>
> Reported-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tools/virtiofsd/passthrough_ll.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index 0b229ebd57..cce983ca63 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -2839,6 +2839,8 @@ int main(int argc, char *argv[])
>      /* Don't mask creation mode, kernel already did that */
>      umask(0);
>=20=20
> +    qemu_init_exec_dir(argv[0]);
> +
>      pthread_mutex_init(&lo.mutex, NULL);
>      lo.inodes =3D g_hash_table_new(lo_key_hash, lo_key_equal);
>      lo.root.fd =3D -1;

--=20
Alex Benn=C3=A9e

