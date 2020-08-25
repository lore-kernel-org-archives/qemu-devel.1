Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADDEC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:03:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D9E20782
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 16:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVFUXEzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D9E20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAbPh-00062z-9j
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 12:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAbO0-0003Jg-LG
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:01:24 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:46472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAbNx-0004EA-Qm
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 12:01:24 -0400
Received: by mail-lj1-x244.google.com with SMTP id h19so14413888ljg.13
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=XvM6Lu/hTIgCGGnvkX2N4/z9Ic+5SQi50tB72CywblM=;
 b=WVFUXEzsh7H/PpDPLbkpX6ZCefDgRGD/eVoEznzTW/Z+C2xsJWNRDaXreUaKRr5zy3
 yRPL+UC0XOaMiWviTH8bUSehcRMfp/JAM24C/y7EEy2HYLlwCDQ+8HARPurbbS1rMdSQ
 ui3XIRA/K1pnY6OVcXLYrORvI2J12qyAwcNVfKn9YXdzieYWfnAmO7w8sS36NMd4v/dL
 5TJrMqoo8MMdUZ8f748dsKnKUWCTQwCcqoeGBTtRiP9kt0ubborSBlcldZqX5BXGAAsD
 7a8O2CMDiGmvuSpnjxWuSq2DEKe4gDAqjtwaQImjEqSOI9vmxjbgH2Gzok/e3Jq10eT5
 YKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=XvM6Lu/hTIgCGGnvkX2N4/z9Ic+5SQi50tB72CywblM=;
 b=Q2GTgh6IkWDKoJceqDkAHGaqtydYMZoE/t3tiHEcrE6/MlGFXGH/+9oZ7dev6lf8a1
 oERJxQVfzGQ/IbBWaQoRHySzwR2Mrz4lagqPQY9L0haalEB7PtFJyj2QzraBQjv1BR/V
 tV1I39R3nN4VBDA7RubKucYbX40dE7FePKsj37wDcvh74KCch9P2eSikvkIfUqPNHY8g
 xtUOnTM1E6hJMdjEFX7wCMXGpDnYkPplyk4ZL4W74eifvs9ihVrlCBVfNrFQgnC5Z9xw
 U3AsjHg8EJXkbIVZiPEM9k1pzLheAOFaFSXLpWXL0Y7bOxaOQpcDjga8/sSbQcrzN3gN
 iqwA==
X-Gm-Message-State: AOAM533AdPh6TKxvmoWucyTK7uJlpFvMYZodaGGCaC/bbdsMM58ULxWl
 rbaxfmB5qvHDWLJXQRZLQ1DXp5/keKq5zLPIqSU=
X-Google-Smtp-Source: ABdhPJyI8bqOLuicivOgGdPi7V51JuAJok9YJXbtmWObM+BEpzDVcHbnhqWtOfUeFeVvmHM82hoqW9YZtUyl6QTJqaA=
X-Received: by 2002:a2e:8689:: with SMTP id l9mr5528900lji.467.1598371279198; 
 Tue, 25 Aug 2020 09:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200801224406.315875-1-rkitover@gmail.com>
 <f09f5172-a22c-d51a-7db7-a6fd880d386c@redhat.com>
 <279ec524-0cf3-bacf-b97f-86a876d980c3@redhat.com>
 <1d6a9f7b-a0a1-0870-314d-3704df87fcef@redhat.com>
 <735ee5c7-2cd5-f053-fe82-bedb22307306@redhat.com>
In-Reply-To: <735ee5c7-2cd5-f053-fe82-bedb22307306@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 26 Aug 2020 00:01:06 +0800
Message-ID: <CAE2XoE8mk5KPQ-4-FZKABv07Tp5BRwhiZ90ht9o=bG3HUAxhTw@mail.gmail.com>
Subject: Re: [PATCH] configure: Require pixman for vhost-user-gpu.
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000050ded805adb5d002"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Rafael Kitover <rkitover@gmail.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000050ded805adb5d002
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020 at 11:33 PM Thomas Huth <thuth@redhat.com> wrote:

> On 22/08/2020 22.29, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Rafael,
> >

Would these improvement can be implemented in python?
--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000050ded805adb5d002
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 25, 2020 at 11:33 PM Thom=
as Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 22/08/20=
20 22.29, Philippe Mathieu-Daud=C3=A9 wrote:<br>
&gt; Hi Rafael,<br>
&gt; </blockquote></div><div>Would these improvement can be implemented in =
python?</div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">=C2=A0 =C2=
=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=
=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div>=
</div>

--00000000000050ded805adb5d002--

