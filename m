Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA05C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:47:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA60206C3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XGXbeomJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA60206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3eMS-0006Rf-10
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:47:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3eLp-0005wM-LD
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:46:25 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35655)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1k3eLl-0006xK-FR
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:46:25 -0400
Received: by mail-wm1-x342.google.com with SMTP id 184so9390920wmb.0
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 04:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=5W/lhfO8yTDVlTrqrJwHLrnMyx0U/10EuoeS7lzrN4M=;
 b=XGXbeomJMrOEJGNlin4RVk/pNstY3CMntui3s1yBBahy6/l6YwHNckPqHAmCDQrJEM
 faJdWa44PfpoWceYGfsBHzlfUR7kqi2w8//CWuOmqLMUMV2nt5Gd1TMKG2bNXD0uzk6L
 Rh/DPdxjBVW/YXX0fGZNDEh/iMycwIH90kn4AhWPzH1kgfUvEoCOh02o/ejNY7KuN6+e
 VYijgF9c4HuA46KKxNlozwnah5k3c1PghKW+QMvNPZzfVAb4n7zP+qSlbk1dkqkm36Uy
 JJIAXzCos6Q+dnUAuXeGU3aibIPAXiJZxBFSKvLZNKAYYrg8FbJ66XmhKGh5O80VDJ9x
 8Flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=5W/lhfO8yTDVlTrqrJwHLrnMyx0U/10EuoeS7lzrN4M=;
 b=juuxF2To9WKe1jGriRkPO2CkVkkM9w+EyfUdAf0VGr+U4yxR2OwYpX5YpkcqcBO2DQ
 WxtiGAIMcIx8lELmR3FG/tnQJhvJoB9shBxCRp7hFtq+pML6Txp1jWjuBiHnuzWkb/TG
 SJfrejmQm5k7ebGH2Rf0S3MIiTktz5YpQvzyisZtf2ctrY14a0a9spzj2oPAOHtESSJn
 WylcVaB+nWphFjSumqX9UZY8R+qjnfLdN20s4kaUeAt1ux5o5TnleP10DaAt2LfVgs6I
 KPe45eZvT+cAZ9bW7cFFmtv8oEFUNjFIwHXjXmR9NmCoSwmvUZXzbIitdCx+WuzveipW
 Nyyg==
X-Gm-Message-State: AOAM5324slwyjh4jIu2kJIt+c4se4ve/sqeIQI7CMcPyTDHwq9jRZ3jc
 p6kJaKU4wokoHv+LYvbWkWJCRw==
X-Google-Smtp-Source: ABdhPJzvwlVUda54nJt2Q84BAxXnnpX3bdLf/n3K2iTHFvpBt3aDdw1WfvH890zEfqxdsAtVgFVBRg==
X-Received: by 2002:a7b:c954:: with SMTP id i20mr8288536wml.189.1596714379564; 
 Thu, 06 Aug 2020 04:46:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j4sm6082272wmi.48.2020.08.06.04.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 04:46:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8B71B1FF7E;
 Thu,  6 Aug 2020 12:46:17 +0100 (BST)
References: <20200806104453.30393-1-peter.maydell@linaro.org>
 <20200806104453.30393-3-peter.maydell@linaro.org>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/4] target/arm: Make A32/T32 use new fpstatus_ptr() API
In-reply-to: <20200806104453.30393-3-peter.maydell@linaro.org>
Date: Thu, 06 Aug 2020 12:46:17 +0100
Message-ID: <87imdwknee.fsf@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Make A32/T32 code use the new fpstatus_ptr() API:
>  get_fpstatus_ptr(0) -> fpstatus_ptr(FPST_FPCR)
>  get_fpstatus_ptr(1) -> fpstatus_ptr(FPST_STD)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>

--=20
Alex Benn=C3=A9e

