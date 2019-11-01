Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1933ACA9EC9
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D431F2067D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtIEuVoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D431F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQSGu-0001I1-UT
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 04:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52355)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSFx-0000h4-Ra
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSFw-0005I8-LR
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:26:05 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43739)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQSFw-0005BU-FM
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:26:04 -0400
Received: by mail-ot1-x342.google.com with SMTP id b19so7738172otq.10
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sbeKhEjQCX+T18ZQtx1UfiIxbNkhOWlH/7+HDAJnBtA=;
 b=xtIEuVoGLlX3GhEYev9F5T1M4u9orpchY60p8++2qmASwIzBy32vRiTKkfiIyOXAnr
 6JXIXxJW2K9dr1jG5uhu5CeeyH0Pghs3QY2tEv9YxR202TN58vKVJBAqMFPYjU1DrFf6
 3qAXhLBhWQYwuHojSFEfxbRZxz0fkOE7tYFhLb19jHUIj9ANOzTa0HjurQKNrbVcCeSI
 ntv1JYLUHu0wTx3ySXdY9eZkBxq6cJc3WfCuAXI1O/ALoGc2c6BBStdVUoxMVBOr26+R
 8d6G6CLnsiwBHSQ2QT1jmcI/XL2UlB62yK2/V3Pc3UydfAw2CWAG0lnU0wOcFattr3T6
 p0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sbeKhEjQCX+T18ZQtx1UfiIxbNkhOWlH/7+HDAJnBtA=;
 b=mizwN0cktM+WPmyCpGxjuI1fjxIk6GU+syNAr+hFJ4adEqoJ0kIhlm8Flq3JbJJe6D
 LIxLphdtMg/Xx1D3JPvPGeN/oJ868u++lkognmslW1mjuF9SfxdEhmszmjHrYwyU2j2b
 CMlzMk/fFG+Ygkr8iMJqGFToFMKL28Com+6e+QufKkbSZso02opTWafdfG5REJtO6TBx
 9Kfx5DGnpoHfWbf1/gB5wKyHcQIGbVnVqYPJ1phuEw3J6lyrldE5/EKcdav81vv4d6fw
 yXw9pVoJZ7MUdP8S2hH5I9alRqnMeeZTH4uRTn34N9to6QdlsX+gYWTQCqCPIOLdPoYA
 zLBQ==
X-Gm-Message-State: APjAAAUDax2y6J4UyUJnGhBQuQFcWFLGHe9mQ454YGzhzr+s5W7aZdtI
 TfVBkTqHAONAfOz+eqMRitRuCMfMQh6wQcogfOMsXg==
X-Google-Smtp-Source: APXvYqxdYlyLPkoT6RrYP/ZhgdvkrhVEOjOF9/wPt/nN+pYH5KXXO8peRdpvn24XG7kSGkXnnR+6qaa+4O9JBNAkEVw=
X-Received: by 2002:a05:6830:1b71:: with SMTP id
 d17mr7830338ote.232.1572596762929; 
 Fri, 01 Nov 2019 01:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20191031040830.18800-1-edgar.iglesias@xilinx.com>
In-Reply-To: <20191031040830.18800-1-edgar.iglesias@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Nov 2019 08:25:49 +0000
Message-ID: <CAFEAcA9HJR+YDrfDYvH02vn1sofuhFt0=Avs1XDfJnHr3rcwOg@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] hw/arm/boot: Rebuild hflags when modifying
 CPUState at boot
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 31 Oct 2019 at 04:08, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
>
> I'm seeing asserts with missmatching hflags when doing direct boots
> on versal. This patch fixes the problem for me, rebuilding hflags
> after boot code modifes the state.
>
> Cheers,
> Edgar
>
> Edgar E. Iglesias (1):
>   hw/arm/boot: Rebuild hflags when modifying CPUState at boot
>
>  hw/arm/boot.c | 1 +
>  1 file changed, 1 insertion(+)
>


Applied to target-arm.next, thanks.

-- PMM

