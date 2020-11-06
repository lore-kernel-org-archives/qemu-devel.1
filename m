Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB08DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113332151B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 16:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ozK9xX4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113332151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb4s8-0006B6-LE
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 11:45:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kb4rA-0005jp-2t
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:44:56 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kb4r8-0003kX-Ds
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 11:44:55 -0500
Received: by mail-wr1-x443.google.com with SMTP id b8so2004928wrn.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 08:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=pzdhmpHLxCbNButs8xZDieujmX3CdFPF7nBVMTBOo9s=;
 b=ozK9xX4cU1AflfQG9jhokCX6UrvxSpwm8SvtYtOVv1HPAbru6FdX8Lcj2q6ZmRTZeA
 FqTCkjYVV1cMAwQerJUWlrG1zg4P26myjAVWb3qKS1Gb6kj1sdc4NGU/DtfLccw/nVmk
 1zrMbeZBxPkAjIpO3U15tc1Hmz3nr/QumUC00RvaEOBDdgAHMyN+KWHvJJqvwosTLlPN
 4+sMtsLfxUq/WeTTzvBiNeztIrzfOtoxdnneDJM5yF3miI4eCf93XoARRXlFINbd0CGW
 F7pNoYOTvbASmWs23lJ3LtdxLgOB/ux5mLNMtgMBiNca4NCcWGGTRA5NnTz2a9NZF6hk
 OgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pzdhmpHLxCbNButs8xZDieujmX3CdFPF7nBVMTBOo9s=;
 b=Dy4NcuXxrU3EIFWjq2/oZTGns7wA1hFiz6F0PPuvCI9DZv/IZRq1J7Bv4s7KpSu0Pm
 ckC5Ec5FeGxVj95lIW5Jp5Ev8+SGiWqZQDaZ7nFxlVfvn7AS3ZRTWZL6ebjDc2rp2g1i
 0VxwOdOoNpOghgpITbyBtv/wBRvseaFmO0HHWfHwAteNvXK3spuMMjtVZ+JAAAxSsY8P
 h2mtCvOsrwccTDhPvCxEvvmZQ0iTutdKKoUJsHH9/qrn8O4z5iTdO5fHj2kOw9U9p9pd
 qYNZ1+aD/kpA/5LJxwX6xGlZOyZ7+pj4dgd0fSAipvPzZ27PrSxV3c7u2lYUD4IyAbBU
 Djjg==
X-Gm-Message-State: AOAM531x0dEyFVYUgJt/kuGBhaxOEnrlhVPlAbltQ7rSvshUpItp6sSZ
 eWAtQEl/NtqSHIrpF2vV3uWajsvs6rrGfg==
X-Google-Smtp-Source: ABdhPJwyvqwNu1LspXICz1gERRCRSE2O3Ue/aDBp8neDtDvCUawSJryPvDPncr+o1iLy5GotYqsf+A==
X-Received: by 2002:adf:fb0f:: with SMTP id c15mr3479128wrr.86.1604681091600; 
 Fri, 06 Nov 2020 08:44:51 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t74sm3163939wmt.8.2020.11.06.08.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2020 08:44:50 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1ED5C1FF7E;
 Fri,  6 Nov 2020 16:44:48 +0000 (GMT)
References: <1604669964-27222-1-git-send-email-kwankhede@nvidia.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH 1/1] Change the order of g_free(info) and tracepoint
In-reply-to: <1604669964-27222-1-git-send-email-kwankhede@nvidia.com>
Date: Fri, 06 Nov 2020 16:44:48 +0000
Message-ID: <87v9eia0zj.fsf@linaro.org>
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
Cc: mcrossley@nvidia.com, alex.williamson@redhat.com, cjia@nvidia.com,
 dnigam@nvidia.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Kirti Wankhede <kwankhede@nvidia.com> writes:

> Fixes Coverity issue:
> CID 1436126:  Memory - illegal accesses  (USE_AFTER_FREE)
>
> Fixes: a9e271ec9b36 ("vfio: Add migration region initialization and final=
ize
> function")
>
> Signed-off-by: Kirti Wankhede <kwankhede@nvidia.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

