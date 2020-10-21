Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A76C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2B92224E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 17:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mxhig2gV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2B92224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVHgz-0006q1-KZ
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 13:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44726)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVHft-0005co-89
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:13:21 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVHfr-0002wh-Mg
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 13:13:20 -0400
Received: by mail-wm1-x342.google.com with SMTP id k18so3406148wmj.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 10:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PhuciOTxGzyt42NozTpQG7KL1ETjDSYk2QrBi6IxQio=;
 b=mxhig2gVDmSghykOAO6fmLdZDLQ0prvd8aB88BZmbhFd0C5+DSCGDdnQ+tyDNIC1bQ
 b2aUaxSRtpBIDaWx3MAJvFH62ditaGRbNZTqr8Jc3ZChqgWGXMAfRn8HpFtxzHHTKaEV
 mJoyLROwchNIoVd8uyiC+UnDjtNRZAw7ullQxN+EIFbfcesIoYJ86G47UFKUXdej6XS3
 rJ3Y2GDAHtHgo5SCv7AuK8eOlyGuTNpRbJFIJuJmk46vXTSsuExi4wQdAK9rPoB4V0fU
 NdFUvCVBoBkuTNFRs11gAURWWUiC1Q301jpGH+9sqAXweJNVsOY+PFbtvsRrEFj7KCi0
 9dEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PhuciOTxGzyt42NozTpQG7KL1ETjDSYk2QrBi6IxQio=;
 b=HdpIxE9v7V0oxHMOCTXEdNpwxdWdGZGUMPogxFbVlQdFi5KmZS1t8/zZ+pZHdPPC/3
 64fnqhMLWek+1eiG7rPUwTDWpJQC37+FPPyOXuXuXSNe0w3WBI/qcWXlmnhUTTIIYqzJ
 iYDpfPA5Hv6egRuLmz7maPNcoSHhJ42fGcKF5+KK9xONvc+Uby8TH1rYCLHCexulbimE
 q8gusg/WSQ0HoqhUCRYh2eJKrl3/l0Cw9WOFSZdDi71q3axaIN8cJc+LSgr2/1Mh4bbY
 uO00tN5WEOmGD1psZudBdWqeA0DiqkU73kubN7J07kioNLzRXF6SEI2owaNjS5srCHzD
 R9YA==
X-Gm-Message-State: AOAM5338WLOV1SXeZM4PbDpK+4NeFURK1F7iiN6iA4xwfFLDWdnAo3DQ
 J4+pGpYANfhCBPJqHWSDi/8sBw==
X-Google-Smtp-Source: ABdhPJynZaxaRYvb+QFD8rJiFC372JjQKr7Bh4BMeQq++asSMSHZLiXh/vbqHm1Z54jGmD9cuAkcqw==
X-Received: by 2002:a1c:7708:: with SMTP id t8mr4596357wmi.6.1603300398257;
 Wed, 21 Oct 2020 10:13:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l6sm5104894wrt.7.2020.10.21.10.13.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 10:13:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6F3D81FF7E;
 Wed, 21 Oct 2020 18:13:16 +0100 (BST)
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
 <20201021045149.1582203-2-richard.henderson@linaro.org>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH 01/15] qemu/int128: Add int128_or
In-reply-to: <20201021045149.1582203-2-richard.henderson@linaro.org>
Date: Wed, 21 Oct 2020 18:13:16 +0100
Message-ID: <87zh4fv6xf.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

