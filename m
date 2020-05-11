Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A29C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A348B2075E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9RjR2lG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A348B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYBNt-0003xU-O7
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYBMo-0002f6-I5
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:33:22 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:34843)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jYBMn-0007HJ-D6
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:33:22 -0400
Received: by mail-lf1-x144.google.com with SMTP id x73so8064265lfa.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 09:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fHGeN+d4UU7Im0dX+ueJk82YhWcBNirec264Uw+ZR+c=;
 b=y9RjR2lGohOkl4P5QyVLkeD1MYsWCf8XLMLEaZic2OQghx6ayWJhPSxX6jNcE3/d5G
 TWyIyRp4IAXNoNxi3eygjh6iVpi88eEVh1zW/Sw5/unFSgMPzJ4U1MvnDhyYVYvB+O1O
 xw5DfGwcTrge4tvgheWkJStRs2zNB229OmsK+s/vOLJ7STtb02jPh5mmivaAFx643RL1
 WRkL8JQX2Y0QQMd2qB8V8h0JG3V94K+PyM/U3lUkC+YgcJWd6d/vdc3X+R4Vgs3wkLrn
 glL5Q0gnaGriL9pRq05qXpWv0OqcsnhdVKrmSdo8t9xFzstv2pQj2tUcE51IHXwDf/N5
 ZUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fHGeN+d4UU7Im0dX+ueJk82YhWcBNirec264Uw+ZR+c=;
 b=n3agzz90KjaUjvYfPEx2RwU5erDhNbD5v3az2cAmyvz8q/KnAa+UhN7hzEUU+ptQII
 cWCsyYiHIVSBaYSNjNIcvrZRSvBmqG9ZCBeBIn70cFmkFga6CqG5MsLSiLpcVAy53J4J
 5Hba71sS5k+OKg7Pc0Ct2FpdR5aHLB3mgWymOFFel0PCNBCs/Z+oLC9YvHhyK8ZPPt1G
 nDc3SWpuMzP9n//mNw4CFF7ZZTeQ7aKs43Zqp6dhdcU07cCvr6La1nOyBoF2z6jYPOss
 ULFwvHAUJ6qAi+I13nBmxIkE77gR+xScn4haDVo/XaCqB8pK+JUojwankaoXWu5vLD9p
 OMdA==
X-Gm-Message-State: AOAM53395YWVyZ9dbrKCL1Qn81wFBtmGhxaGn1t8/6EL/+5O0BUuBrGV
 71J7QOKHQU66N+K9dhwqzIYvwna2Tg6Aqw/OLERcBA==
X-Google-Smtp-Source: ABdhPJzRPf/1DnyvBXNgFuPnz1XbSh974vRucZswEMMeDq7Ce8uNG/Fd8gAtiETFL1lQHD1DK0f8tri/f7UOydrQJKc=
X-Received: by 2002:a19:4f1b:: with SMTP id d27mr11664578lfb.81.1589214794912; 
 Mon, 11 May 2020 09:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200326193156.4322-1-robert.foley@linaro.org>
 <20200326193156.4322-3-robert.foley@linaro.org> <87r1vqfrxv.fsf@linaro.org>
In-Reply-To: <87r1vqfrxv.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Mon, 11 May 2020 12:33:08 -0400
Message-ID: <CAEyhzFs_J-RChW9ntpOaA+e-pAgtJHK80Bg9qeQ9mpM=wmD9gg@mail.gmail.com>
Subject: Re: [PATCH v8 02/74] cpu: rename cpu->work_mutex to cpu->lock
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=robert.foley@linaro.org; helo=mail-lf1-x144.google.com
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
Cc: Peter Puhov <peter.puhov@linaro.org>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 11 May 2020 at 10:48, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> Hmm while bisecting to find another problem I found this commit:
>
>   /home/alex/lsrc/qemu.git/hw/core/cpu.c: In function =E2=80=98cpu_common=
_finalize=E2=80=99:
>   /home/alex/lsrc/qemu.git/hw/core/cpu.c:383:27: error: incompatible type=
 for argument 1 of =E2=80=98qemu_mutex_destroy=E2=80=99
>        qemu_mutex_destroy(cpu->lock);
>                           ~~~^~~~~~
>   In file included from /home/alex/lsrc/qemu.git/include/hw/core/cpu.h:31=
,
>                    from /home/alex/lsrc/qemu.git/hw/core/cpu.c:23:
>   /home/alex/lsrc/qemu.git/include/qemu/thread.h:26:36: note: expected =
=E2=80=98QemuMutex *=E2=80=99 {aka =E2=80=98struct QemuMutex *=E2=80=99} bu=
t argument is of type =E2=80=98QemuMutex=E2=80=99 {aka =E2=80=98struct Qemu=
Mutex=E2=80=99}
>    void qemu_mutex_destroy(QemuMutex *mutex);
>                            ~~~~~~~~~~~^~~~~
>   make: *** [/home/alex/lsrc/qemu.git/rules.mak:69: hw/core/cpu.o] Error =
1
>
> which works fine in the final product so I suspect something has slipped
> between commits somewhere.

I agree, looks like something is off with the intermediate commits.
Thanks for noticing it !  Will fix it.

Thanks,
-Rob

