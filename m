Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E21C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:09:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFA6620829
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KiNcCt4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA6620829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6w0-0003Hw-0v
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX6Ja-0006ug-4M
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:29:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42830)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX6JY-0001YE-IV
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:29:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id j7so13572507wrt.9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=BfPtaKJyW4ck6EQodbzUJt8ki3ZLhjBVdDnTJBnp8SQ=;
 b=KiNcCt4j60ouQsWUxDiBO/TVpFv31b9DqFA4ERcg19k00hO5YfcjrfF00fMK4ExTuc
 7Tjc2W15HBI+aDYA23mD4t4RbkTgIF51XewOJ3SGe/Ss8EsC7Equ6FAWsPMoDmWnDVBH
 meI/agsF/Lfbq/xNo0wndA2F1sFPdKV6fReQpQiVB9gQLS8mAqpImbIFV+GG7IBved9k
 yTEhRuE5QnUtmthxpMIJRUhoBAxqV6qX5goziRzPz9Dt6Gxg+CUYwzxk3Bp67pk1/lg0
 HKhcRpPWYbQzbO694qSIA6O/Nt9mkTfhtpO01NK2Eg7l3S7h7J/OezdI3g00CaRVp0wy
 VyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=BfPtaKJyW4ck6EQodbzUJt8ki3ZLhjBVdDnTJBnp8SQ=;
 b=uJTibg88ihoaLm5VU7ta2Q1aIj2afIk3EUxmepH+AxlJWfs/DH/zkdu9wzHOjlrAP/
 jNuQ0M6Zutj7Anx6CC+EgeuP4ea46rbbfymGmTJUro18HluVJF+bYlKSAjL+CdQcdzvp
 ntwxA5GnY08DexyhbVGjLrgIWpZNtn2zxzgN/mRvQCf+ghEnIikdMLr7rwOpI/pJ+9Ww
 LcmXdlIIh9gKOV4qPxnVSivjPolfuq8rlznYyyPQcOtESTIoMBzfi/9g7HCXrWHi5olB
 Q3jesiiZzYMbLdYK4tnNMiOpxvw3zLzRmf5pKg6S4bHlk3KJNMEkuip77SN7kdfNt9Ey
 vZZg==
X-Gm-Message-State: AOAM530C0x0THr48IVV40AqYS9kUKfLj/tcLKawT9adBKNkWl3OG5tY2
 BNYPIaFoEfWYKMC6xcG8U9gpeqQwVkxBlQ==
X-Google-Smtp-Source: ABdhPJyUhs6CcQO+a0JaUc+adUBB+57NOmAtRLJ3CyDtZs/UbEQG1e1Ua9iAdn+rkq7EpGCD62qUgQ==
X-Received: by 2002:a05:6000:4c:: with SMTP id
 k12mr18258575wrx.278.1603733385997; 
 Mon, 26 Oct 2020 10:29:45 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d2sm23031859wrq.34.2020.10.26.10.29.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 10:29:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2CAC21FF7E;
 Mon, 26 Oct 2020 17:29:44 +0000 (GMT)
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-14-pbonzini@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 13/15] sh4: remove bios_name
In-reply-to: <20201026143028.3034018-14-pbonzini@redhat.com>
Date: Mon, 26 Oct 2020 17:29:44 +0000
Message-ID: <87ft60gak7.fsf@linaro.org>
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
<snip>

--=20
Alex Benn=C3=A9e

