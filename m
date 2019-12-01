Return-Path: <SRS0=Jz4r=ZX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2132C432C0
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 17:28:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5F0F20718
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2019 17:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwJmrY0y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F0F20718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibT1V-0004Ga-Qu
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 12:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47293)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ibT0k-0003ZS-EV
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 12:27:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1ibT0j-0006Qi-GS
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 12:27:54 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38579)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1ibT0j-0006QL-AN
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 12:27:53 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so7589796wmi.3
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 09:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ldCN5WNJpyARxnoHIsh6Rn/DV0tWyiX5XfcuiSBTd5A=;
 b=cwJmrY0yJ0cg/67Ui28AIdt0Bczi5dLnZxrdqBgpWpDdargVLsTz/mUB7yCChm+fZ2
 /5ouK/7WMvnwrkNX2fG8mY1zs5eL1c8GLWeT+ehVbtkumskp7n4c0rY5SCVly0wWFIgT
 42XyGEY2XqbMNorCWMyr8POKy1xUhLHIZrF5H+cGhf/R4hvgHnYsdHpMUtwkR6PVhGVB
 Tz3091dnn/qCdIqSC5cBY8DCl95obSbQXYYpCaCp89FJ54TwrucM2EqfE+fxCSJWW5Z/
 y6fr2hQLYPlUi5Wk8gJd8ahpbcBFJfbaPpLpLmIi2IBF0pZveNNfFd6jr3ZlHbK9MaGm
 fuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ldCN5WNJpyARxnoHIsh6Rn/DV0tWyiX5XfcuiSBTd5A=;
 b=QqrLm6l9CN+Qx5+vp+jFEYZ1IuMkqC6VUVb+0wckovq1Dw5FixXLoMWJXfxay6S6Vm
 zzKpJFBc6cDiC/zTli9diLtkTpnJu19VkRPV1lZUY0OIwWhvWeh0ZpXkW9bpnW7XUy8e
 2Q3qePw2SIdB2ZDfgpPx8nNf08S3m+qWffJ6be/LfOnR+Iae61Buz66+SGf3Pzb7joS0
 xop5hDW+7recS+J9ifxOyBSAXzPoS+3y6KW9P+upjvKxHAhBqF1QvABC2c22vmruIFAS
 f0pEngh5NnOmheav/Dh5Lhlj24d8h6WDtcoB46aa1U+Md0sW3lOdbp75pJA/rmOH/Z4E
 BzZg==
X-Gm-Message-State: APjAAAXFfdQAH+42br+qG7vzWkEJeoaDVTxET/2Qs+M96nlOKRfUhHML
 P3bnWLk8PL0wXrbk7aMYVuShwUVZ4LcdyKjODpo=
X-Google-Smtp-Source: APXvYqzvLkQ1FHF0Wq8fSvXfiPY4V4b6uDo+jO/bzxSWeBzUjbF1lpOEa1X8Yqx5ZQ9nhhG32FHcxMvWIOcsjNDOjVc=
X-Received: by 2002:a7b:c190:: with SMTP id y16mr10268029wmi.107.1575221272158; 
 Sun, 01 Dec 2019 09:27:52 -0800 (PST)
MIME-Version: 1.0
References: <20191120152442.26657-1-marcandre.lureau@redhat.com>
 <CAJ+F1CLV_JRhXX=tB7ZXYxa1En4LzYgJr+7egKzVRNBOLY2nSA@mail.gmail.com>
 <CAFEAcA82wRy0U-DzPr64s5QiKo6XmZM96O88c4-AY4zP926GPw@mail.gmail.com>
In-Reply-To: <CAFEAcA82wRy0U-DzPr64s5QiKo6XmZM96O88c4-AY4zP926GPw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 1 Dec 2019 21:27:21 +0400
Message-ID: <CAJ+F1CKwZJnJMFzc4Z1zsY3dZAsXL1SLaXYu8y0G7=u319DWDg@mail.gmail.com>
Subject: Re: [PATCH v4 00/37] Clean-ups: qom-ify serial and remove
 QDEV_PROP_PTR
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Sun, Dec 1, 2019 at 9:18 PM Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> On Sun, 1 Dec 2019 at 10:19, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> >
> > - "serial: register vmsd with DeviceClass"
> >
> > This is standard qdev-ification, however it breaks backward migration,
> > but that's just how qdev_set_legacy_instance_id() works.
>
> I don't understand this part. Surely the whole point
> of setting a legacy instance ID is exactly to preserve
> migration compatibility? If it doesn't do that then what
> does setting legacy ID value do?
>

It works in old->new direction only, because new code can match the
legacy instance id.

But when going from new->old, the legacy instance id is lost, as it
uses new 0-based instance_id.

This is just the way we have done so far, but I wish to be corrected
if I am wrong.

See the commit description for a bit more details.


--=20
Marc-Andr=C3=A9 Lureau

