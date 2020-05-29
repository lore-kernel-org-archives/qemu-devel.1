Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C257FC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87CEC20776
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 10:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgsTzKSZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87CEC20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jecVm-0007sK-HV
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 06:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jecVA-0007Se-1b
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:44:36 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:37658)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jecV8-0007sF-Vr
 for qemu-devel@nongnu.org; Fri, 29 May 2020 06:44:35 -0400
Received: by mail-oi1-x230.google.com with SMTP id m67so2174859oif.4
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 03:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9pa/3nNbtEOCI1DyW3SNF00dq+gwAbwrJk+6M3Yuho0=;
 b=IgsTzKSZKVlqx4albGcGxkfUfdrmfDStGFDHgPv5NRXintlzklIq7QOxljn/1F5GQr
 OZhfy59pTypXiI/DHM1WkWGk7koaX5MTW1CxN3kN1TUHDxVBfKje/FzguCXsJdC0agnQ
 gkKjyU09Liig+kKSw7cW8G3SUUGL9LyHrjU/njwvnbNgZ8Qw9KTWbj0MzSrM3f9+SW7y
 OkfK4SiwKVCb7CV64TbZQlySpUMpA+659vn69tUQc2UPkV+v5kJ3fni+4EVWJr5wWdZw
 Ht+foWLzoykYDWUVwTBOtBiipAJ5DfE+QMQPqQynANzzEChYO6ieY8FBf/GIev+mAF5z
 L1aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9pa/3nNbtEOCI1DyW3SNF00dq+gwAbwrJk+6M3Yuho0=;
 b=hjxpa/JfFvtibz95zgRAGGLlDMeDfQEyviYZ76/t8kJewLcyclErzxLCP8BF1WQSwP
 /VvwCmz2pQfIsCB+05zTPSL79cgYKA52ZjQiHeiVlYZN7uHYOUrXEoM9Gmo8cx2gWe3j
 a00z/brFab79dEsX605jmtuIk4xsptKqqzSgMAymii2xu4vWOQcks0DmOCYTXNgFoL3l
 58n++lNxAnziNSNOJEsYzi4RXNCQQcOFJe4f+hvk5oFJ9rVdz3rzWj1QmtWkTg0seuEt
 n6E8iSO+Vg5X2J3xDIKU90ulQXG6WQ0ug0fiWfnsr0TWPXXgmk8V+nU9CdxTrOK42KXk
 yCEw==
X-Gm-Message-State: AOAM531OIujZqM2dFX9OZjmxtcEl96k1Pcom1FlW9jx5cu8ZWacm/wjV
 plmLL/0AX041z93mEL7KwrG6d5rH9p9EKBEphVFZyQ==
X-Google-Smtp-Source: ABdhPJxiRyWQhiIRomj9AYRh3hAJDKy8e4JdhgWmPCuIthvh6XxZupowd/H9zNZ+yv8x81NZB/VH0XyzDSk3qhYgwVU=
X-Received: by 2002:a54:469a:: with SMTP id k26mr5216764oic.163.1590749073374; 
 Fri, 29 May 2020 03:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200528181849.1823820-1-eblake@redhat.com>
 <9311ff39-d237-4d14-cc73-b4e38b7e40c1@virtuozzo.com>
In-Reply-To: <9311ff39-d237-4d14-cc73-b4e38b7e40c1@virtuozzo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2020 11:44:22 +0100
Message-ID: <CAFEAcA-mkwfFm-ne-pavX0t+3rroXu6Gxm7iNKW1=g=+0-SaHw@mail.gmail.com>
Subject: Re: [PULL v3 00/11] bitmaps patches for 2020-05-26
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x230.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 29 May 2020 at 06:53, Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
>
> Hi!
>
> Strange thing with your pull requests: I receive only small part of them.=
. I thought it's my problem of receiving part, but now I've checked that in=
 mailing list archive there are same only two emails: 00/11 and 08/11 https=
://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08061.html

The convention when resending a pullreq which has had to
be respun with a minor fixup is to send only the coverletter
and any significantly changed patches, on the basis that there's
no need to spam the list with the whole set of emails again.
You can see that for v1 the whole set was sent:
https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg07419.html

thanks
-- PMM

