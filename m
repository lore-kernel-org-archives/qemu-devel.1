Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A6AC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:10:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2612F25586
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 16:10:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NA15Qhk4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2612F25586
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpwMr-0003Oz-91
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 12:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jpwI2-0006Ec-PH
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:05:51 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jpwHy-000158-1s
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 12:05:50 -0400
Received: by mail-oi1-x243.google.com with SMTP id r8so14816483oij.5
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 09:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wWDNWnjzspp0IiikPiabIV3kE/NWWN8M5Wv6eCazJuM=;
 b=NA15Qhk4GwUHEeuioCooN1k8XwkS5FyNkwe0sSeoB8num0eI1R0mYng9DfO9ZvdBBc
 qMNIGky1N5ESaAXdqEPWj8Q2WQbPdVr428NPYfnkgcbh2GbEfFVW1m11XDqg7OMJz9r/
 X74ec1OYP4ghZzrgLWIC8l5wcxz3L9X89O1pXTGW1NPkTnpSiYHWpLJtCFcHmwSozaHH
 FK1pe5Sv0LhJXcDyZ5lktF+k8RU8SB4tqbr6PqwWU56QGO6mUrH0+lcd5UtZk06R96Rh
 qhdVxmdDslXrb9O4wPNKbtNFze9fmSp20ZBsTTMDmUsuGBK/1uCU5SEDA6+3XLhm/54O
 S1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wWDNWnjzspp0IiikPiabIV3kE/NWWN8M5Wv6eCazJuM=;
 b=HTHRQIgZzN3qI3cEDfcejwLb5lkD+XRljfJjw63KkXU2bFgLjbedcq/Z51yqHPq4dn
 aU0hpiwRwbvCGmwMesWl0feA1B9Nb3iuKPOFQOMVZiApM2CzTcmwgMO1W59lK+F/bBps
 iORXZnJ/lmA5nRQwWheykxQlNhtnzNT9lu++wy2G65KVBXxBWTI/SWCC7FV+1w+lbVSj
 FbqG6/KGbnkFs++ZU6ImT0buWJWvGMVPD3g/JYmOAbSAFfK8TgDogLq+dSI+AwrI4qZd
 uhpXwdg7WdcZjh4JcVI+zwZ+333KcxxY6pS+xyB9xEEQGk9sVJrAG85tVIQJttpva2sL
 FbsQ==
X-Gm-Message-State: AOAM532uZGa0dl6H9V3aLvBP+WAFmHm3DgcgHr8xkbF2x1QQ51tereVi
 u2WhoQIaXHHImVARmXQqYNqKxDSvDBoo3/p5wzo=
X-Google-Smtp-Source: ABdhPJwwGYy+hcBf96CQhm3X9AJJOP+KK2LyUUuI+sOwCABO1LFdww0i/v/uXQvYmQDBkrz+WHKUsjA7hOzx60mjFFo=
X-Received: by 2002:aca:494d:: with SMTP id w74mr6963822oia.97.1593446744817; 
 Mon, 29 Jun 2020 09:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-6-ppandit@redhat.com>
 <CAKXe6SKBYpdouoN=C_NZawLOnDMYjDU2X3c2CsCv7X7rPym1Rg@mail.gmail.com>
 <nycvar.YSQ.7.77.849.2006291718520.92950@xnncv>
 <f76bf4c5-7b6a-8ee2-b46f-9799f879ef16@redhat.com>
In-Reply-To: <f76bf4c5-7b6a-8ee2-b46f-9799f879ef16@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 30 Jun 2020 00:05:08 +0800
Message-ID: <CAKXe6SKBZpraQLgQRUP0YyipCQ_hgQ+djOXv9e2yG6nyKXvkww@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] nvram: add nrf51_soc flash read method
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=8829=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8811:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On 29/06/20 13:55, P J P wrote:
> > |
> > | I prefer here just 'qemu_log_mask(LOG_UNIMP, "%s not implemented\n",
> > | __func__);' as other patches does.
> >
> > Earlier patch v1 did that. It was suggested to return ldl_le_p(), as th=
at's a
> > valid return IIUC, instead of a zero(0), in case flash_read() is called=
.
> >
> > Thanks so much for the reviews. I'll send a revised series with due upd=
ates.
>
> I think abort() is preferable (while LOG_UNIMP is wrong as it implies
> there is something to do that QEMU is not doing).
>

Oh, here the UNIMP I understand as it will not be implemented, not the
thing 'should do but not do now'.

If. we use. abort(), the guest also. can trigger this abort(crash).
Though there is also other places we use this I think it is not very good.

In fact I would like to silent ignore(callback do nothing) if the
developer doesn't provide callback at the beginning.
But there are some cases we use LOG_UNIMP:
-->https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D158b659451


Thanks,
Li Qiang


> Paolo
>

