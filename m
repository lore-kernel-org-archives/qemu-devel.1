Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7A3C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:12:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A831A2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhRMeT9/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A831A2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6zA-0006rJ-OJ
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX6KM-0008E9-IY
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:30:38 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46062)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kX6KK-0001l3-S9
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:30:38 -0400
Received: by mail-wr1-x442.google.com with SMTP id e17so13589450wru.12
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=SNdU8kKNFFCSgO/9eS5WVKPwIXigJdJpkGv6EcEhSQM=;
 b=NhRMeT9/Qx2XmS/2O3IyAILV61OIvcqCQOfr158eIPcI1KRLVyelZ/ON6wkn9v24jV
 fZrLinTJ7asYlBtzPnh4bi+iENjBsmhryR7NqdJsesOqErOALtXSGY0S5FV9RqkgS12q
 Z/RsmSsWYy3l5qnbcriky4AFks1hqgYLMtHWVdf9MzrdPpGW8CYecsgkxiT6ti6cEuOW
 cEMEr/VoMULljbPiT6aMeUDlnKnxB6RwjaWpCcyHIojDS57OFtk0aaEZNPS9TCe6UFNM
 cG4FcpVHvseY1SEpjtFXQIWbP7F4g/Nyc4zzXYrR1880NRM6fDIHn5+yg6r5RWyPH8/d
 7dhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=SNdU8kKNFFCSgO/9eS5WVKPwIXigJdJpkGv6EcEhSQM=;
 b=JWu45U/55XU7DBwDXLnH9XnOVQOK2R+lZzvSot1gWH4Yj7H3dn7DSG4gTHklESvq6F
 lbKIRUCtlBW3uRRLd01aHFd2iV3z3iiwS+m8eDYVDzhM1oMZu7zPrjYuFXzyVC8VfvO/
 pYVNuhxH9PydbTkOsmGEua/KozHHLNqcpVT8elhfFFOBMvW6dsY6yTgwLD3Iv7IB8F5o
 ckYx7lVdKIR16ywMWMmcAlYXsNtIV4Dew8x1oRCIcAeRW4mat3j+nQpJe2fnUJRvZsGO
 fg/tHrrqMpBhvuaWog5iDGU5EwAWbX9SwV7rd+t+pjS/BUEjKScRFRLbObf/+ptg6M2D
 9r7w==
X-Gm-Message-State: AOAM531e6lbCEL4w82Ew27XzZMuP6YaYKfNUhIFeDvaShxYqTjGi0xwF
 NmprpF6kH32kqwyPrflngZfa7A==
X-Google-Smtp-Source: ABdhPJw1Cxsp/lddTy0bi0APkcW6gm5g6qGRt0IswIrCytiQzhLjYRgOs2sQYDOf5+eS/naC/VKRFg==
X-Received: by 2002:adf:dd09:: with SMTP id a9mr17659828wrm.208.1603733435411; 
 Mon, 26 Oct 2020 10:30:35 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v6sm20330945wmj.6.2020.10.26.10.30.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 10:30:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BB5031FF7E;
 Mon, 26 Oct 2020 17:30:33 +0000 (GMT)
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-15-pbonzini@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 14/15] sparc: remove bios_name
In-reply-to: <20201026143028.3034018-15-pbonzini@redhat.com>
Date: Mon, 26 Oct 2020 17:30:33 +0000
Message-ID: <87d014gaiu.fsf@linaro.org>
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
Cc: philmd@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

