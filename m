Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E344BC2BB55
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0FCF2076E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 16:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lT6GNFB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0FCF2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLrSG-0007S2-Ro
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 12:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54299)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jLrPk-00058w-ER
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jLrPj-0007qG-AC
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:49:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35772)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jLrPj-0007oa-05
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 12:49:27 -0400
Received: by mail-wr1-x444.google.com with SMTP id g3so4718710wrx.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 09:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=LdpF01ktrNUfZW4bVeaysVbrsuqT8gEeZIMiG7KygtU=;
 b=lT6GNFB+0qlp4uWHTTT5gG8sk52dw7X6PrAxjS1dHrR1su8sPE2DUqn+MK1CY5dnK3
 uOqCMDZnyt9Lgw92ghndJPLH+Bczz0L/n0gdV21k11E1qL67BHbdTPHM5bjQhzFJAOxO
 3TO6tGAfHtW/wplruaiDSZBS+rxju9C9LDXUuxGNGCtTe/zJa/D+QlkaeNcprIYvT2Ei
 yLuhmzM9i7SMk/T4MXahQt5CNMRtILjr7DkbUJNWfsnQx67cALaEJzYriAvEUFPtH4iv
 w71CmP2ZmEs/2Gyq2PA/pSXDgKsAfXi9uFbL0nS5xvp39Fg8oQ0tCpRSfx/2ZBh0zZnh
 WcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=LdpF01ktrNUfZW4bVeaysVbrsuqT8gEeZIMiG7KygtU=;
 b=aeaJ58S7BVx/gjDBMvZokPYT/77Y8l02bbRVGDtP/FoX0mzynXg8Q9Y85A6dZRpmqJ
 zjFCBwrqLjTi68yIglsX+Lsjn6qK2lLTZL1AFoIsIOt3EH2+rQYGRJ18hStdYX2f0LJf
 ICAE0AJQK/FVM5S3izr6FUra5XVw5al62P7yhv+BvO70vqM7JMGXtUsHMae9m0IIz2nb
 FgUbKNogB+hqsUO0yw5gTx5Te3QOMS2W0ee4N7RTUHbRhxmy70BPZ6O7WNg0J8tdvqr+
 EXynR8JdpSp8QWlHrhYASua+tMpFsaZdIbcdAVj2ZDheiKLoDL4TyuzK+tPcE3Dr+/Ct
 r1wg==
X-Gm-Message-State: AGi0PuawffJOYLimmyMsEL7VRSkECcgyjIgUymfSNtDneG40oRw/4GSy
 YLTWSqtOW5d7xRqQ/mosvP+qAg==
X-Google-Smtp-Source: APiQypK+g4N2NgGRBo+5MXt0qvZbnzM8f2wTKzYpnzAZRYe1/VNutaTkP8hBCvJNUwqz3xRD6ci16Q==
X-Received: by 2002:a5d:6104:: with SMTP id v4mr3946856wrt.213.1586278165565; 
 Tue, 07 Apr 2020 09:49:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n6sm32934401wrp.30.2020.04.07.09.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2020 09:49:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3E16D1FF7E;
 Tue,  7 Apr 2020 17:49:23 +0100 (BST)
References: <20200407140746.8041-1-pbonzini@redhat.com>
 <20200407140746.8041-2-pbonzini@redhat.com>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/5] atomics: convert to reStructuredText
In-reply-to: <20200407140746.8041-2-pbonzini@redhat.com>
Date: Tue, 07 Apr 2020 17:49:23 +0100
Message-ID: <87ftdf9r70.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fangying1@huawei.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> No attempts to fix or update the text; these are left for the next
> patch in the series.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

