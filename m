Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC698C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA212145D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="el5FdPO7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA212145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHJq-0002vl-VO
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvHIw-0001tV-VZ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:32:51 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvHIv-0001Ci-A2
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:32:50 -0400
Received: by mail-ot1-x341.google.com with SMTP id g37so12554176otb.9
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0e+kpKcx+fXiQIwnf0QSCwBgvJs/V8mSn1JQ/vGicOs=;
 b=el5FdPO7mVgm9wLgK/plXEQJ9WguK2gCwGSsYrzl2Yois7s5Ayx7kbzIE3ewaRTtg3
 4RLtmfiIySOkvFjTX0xSORRlvDXP7zzgJCIzDlbf4p+2WPCpdaIllhYgoa1YdrRFjOd3
 Bideuh8xrm9LLM+71HwxpSyhkkRuRNOa5e2q/Pwe0BgGAheLcZDtapeSFhLSlJQA8169
 mjj3cWF1b0zk8SEq/asQ0SvwdNhKNzvzvxZjvC83FtlW2aUw1+gYkZtZH7AaxZE9fnxm
 mSdOcNpwXahrDejw7tPDFIb/L6/uB3J+9XLWrYq8BdhkhE9cQYZ75vtw0DzHznBLhAyP
 w1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0e+kpKcx+fXiQIwnf0QSCwBgvJs/V8mSn1JQ/vGicOs=;
 b=YPz8CViAAS+PGMBfe5qwyEMm+0b7s280/US4ENzjYzyhhCsPylkXTYzAgzSwTo0Sfv
 XZpRmtD+jAFjiJgaIWH8dTOwDtnMMXeyDyAnHf74AICARbtuBuJo2JvbXiRAhbbjtYQC
 MF3hW9aIrAzwbzB1Io07I35AtNofTgExIi/KJZ90Ot7fgpL5l+dGVNQFfLCQQ5a/+yGi
 aapboFhUiJXhoTtcJiT4tlMJG0KV6r+ph2DxIfh87K9BYsbo4Cz5lbHP7kYpTf5HkOok
 syELi8VUMaODg4iRpgaso9M2NZZXfO1MtkELcigofMWlXDdjSpV/kc+0WajNVAGxV4QX
 3ECw==
X-Gm-Message-State: AOAM530SvTJTgr0UKf1LTN/1gzGhsqlrknZvPjRpEhRqUKo4wHyDiDz0
 05U6zyuotTRqa9rxuIQ0LkK5OZa7Pd4I/zT+4rfP2Q==
X-Google-Smtp-Source: ABdhPJwuJUIllieMSVcqwD/jkidt/yUWRVos86idGZajB5HR3qjPBTPypg39SleCUUm+ajU6EpQrSuQJ9XVVUFkwTdM=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr3236719ota.91.1594719168086; 
 Tue, 14 Jul 2020 02:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200629173821.22037-1-f4bug@amsat.org>
 <20200629173821.22037-6-f4bug@amsat.org>
 <87zh8kg8qu.fsf@dusky.pond.sub.org>
 <CAFEAcA9cajf=MKv4ZD6ivyDTrK4hWLfBP_9T2mJ6LrWjwGMFGA@mail.gmail.com>
 <87pn8y8tkb.fsf@dusky.pond.sub.org>
In-Reply-To: <87pn8y8tkb.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jul 2020 10:32:37 +0100
Message-ID: <CAFEAcA-o5S3UAW4vBc1oygJPt-JmL5Kt0AkHi0_=UAp5Bjg=Hw@mail.gmail.com>
Subject: Re: [PATCH 5/5] hw/i2c: Document the I2C qdev helpers
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Corey Minyard <cminyard@mvista.com>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Jan Kiszka <jan.kiszka@web.de>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 at 08:06, Markus Armbruster <armbru@redhat.com> wrote:
> Since you felt a need for a more elaborate ssi_realize_and_unref() doc
> comment, you should probably propose a patch for
> qdev_realize_and_unref()'s doc comment :)

Yes, that's part of
https://patchew.org/QEMU/20200711142425.16283-1-peter.maydell@linaro.org/20200711142425.16283-2-peter.maydell@linaro.org/

thanks
-- PMM

