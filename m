Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0368EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C530420888
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J4btI8/H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C530420888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKMX-0004Nx-0D
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeKKs-0003Yd-Fh
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:20:46 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:41220)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeKKq-0002Ad-9U
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:20:45 -0400
Received: by mail-ot1-x32a.google.com with SMTP id r24so1970075ota.8
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nYQl58xe/PoPS/VcNcf7McVuZcAURC0q0+g5HZT0T8g=;
 b=J4btI8/HiGrdmyS3YV7y7fNxAWp9ecl9nhennehJhAUXhOujspDq+ousUB2D7bNA+n
 KosKvXwDDfP8k87GvesNf+Zz7YkLkQv5PT7KlV8yB7ekUVwfWTdw9X2Dr++R4j8Kl3TP
 N9PEHBbDO2oVz2zzPg2tTLm73ez8im52qa8L2pCaS835HajngnlFavXDfLZ8jysFNVUL
 eR1LOnRhvgj1l1uJsRUer7o0fMTLnSkNi334o/DSJ8/HuClSpmp7Mjd5iXFZkTFQ3u13
 flsw/7LzOQSyOGxxI0gM3Bj3sXQKAfJhh+sZtnP7Gxw/R/mV1Le2qxXLFq2C7Ub6TFPv
 MYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nYQl58xe/PoPS/VcNcf7McVuZcAURC0q0+g5HZT0T8g=;
 b=fOS508MONwO4FYIPrpGOO3oJKRdEaW1F8qBXU92EzGISeWIrmGXnsnwCA+iZ5JCOhl
 GYRMq/s/KWJaffEV9zPRcLTovru6jHny4mJSagCPIvFkCBtksn+mqaRwc0vj0Gb0cxAr
 fxP5QaqJ+1vzbqIblHKe4OqT7A4HVUwv0jhEBc3uO3ADw9jluK5aain5IpeS80lcL07T
 L213cFPx/7a/GTiBCQJusPYfyzQAe9lL9IGsfppk1sQb8XBpBYFYamO6iIct/ZM8ddsM
 FgthGMebwtgU3jnTKwY6uBEkRlBvNHP1ZOcNsXRJqAV13C7cX66lLCqqYBqTSC3M2C8V
 oEXA==
X-Gm-Message-State: AOAM531mdbgddN4AIWPXiNhLnr6wuFbsbTBnTQkoI8xIcvpqE8YyN3SG
 43nqbq+GSd4aguGOW/v8Iz/PtDNRF4nxF5+jFQBr9Q==
X-Google-Smtp-Source: ABdhPJzlL2yzghYjC3ADGTPIThwgsoExYeDPofK0cCVfmW+9s6pnQ7UKnlqecNW5IlxYJbsawN3L9aqUQ3TWQmaaQlw=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr2514308oth.221.1590679242725;
 Thu, 28 May 2020 08:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200527145455.2550-1-alex.bennee@linaro.org>
 <CAFEAcA_LrZjBY_y3UR=fdOtDvnY=zGG-10Yeq0ZjbBc=EsvRfw@mail.gmail.com>
 <87blm83y5v.fsf@linaro.org>
 <CAFEAcA_QTkWA7eBwORWMmpcH1E5bF4A3mFtkzdstkucd-2+p3A@mail.gmail.com>
 <591d2690-c2e7-98aa-8569-5f99737c5f71@redhat.com>
In-Reply-To: <591d2690-c2e7-98aa-8569-5f99737c5f71@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2020 16:20:31 +0100
Message-ID: <CAFEAcA-EZ_c01599j+NJH1Vd0aJ4cQzwPYynx=rBZP7x_3h3jg@mail.gmail.com>
Subject: Re: [PULL 00/12] testing and plugin fixes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32a.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020 at 16:18, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> +Gerd
>
> On 5/28/20 5:09 PM, Peter Maydell wrote:
> > Yes. I see them also now on the next pullreq I'm trying to
> > process. How do I get back to an environment that doesn't
> > produce all these warnings?
>
> Maybe building back NetBSD 8.1?

Did that change not itself trigger the VM to be rebuilt ?
If not, can we make it so that updates to the images always
do trigger rebuilds, so that we can catch new warnings
that they introduce at the time rather than later?

thanks
-- PMM

