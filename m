Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0162FC55179
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 135612220B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1YmshXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 135612220B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYPN3-0003hM-Qz
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 04:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYPLF-0002ak-Gl; Fri, 30 Oct 2020 04:00:57 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:39053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYPL5-0006jx-KT; Fri, 30 Oct 2020 04:00:57 -0400
Received: by mail-ed1-x541.google.com with SMTP id g25so4835414edm.6;
 Fri, 30 Oct 2020 01:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U1K8KyovCyPjr0KO5SLxyHMBmxgiHKo7LDpZ8J0whKo=;
 b=G1YmshXIBH8mzDvLhFe+DTC647CaQzSETnEItZkn57lcU3snIM/OjVhigW/Cn/e8zz
 j8EwC0XWNunktDcA79Avn42ybGmEt6FgiDpCDNFhi+6Jb7WsVpX6aRzPpM+aeGhqlGmk
 3xsTBix3dTXUY2P/JNSYUNNdy/6xjGr20EamgeKozUG3KkB9ERUncoDIUnq4PeLAdiya
 5XFja1aTu5TnVLUkDEUSKlVTpAh1ZfyGY2PC7lmL/m5/zqby4bPJa5dpmNpZm0MMdM68
 ocuyUA6WTj+M1wX4j+W3FlAi7iFGBumH+VGgkabtW1CdFIV9h1zqO9HB2tSS05WWKkZL
 7Xxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U1K8KyovCyPjr0KO5SLxyHMBmxgiHKo7LDpZ8J0whKo=;
 b=DDTxXkIcEyah0yiGlmVKovbUR+1FBYFjODi9Yko1qc9FSu3RmZ3lS7JXKECB086UfC
 9MQagB5aJVKpukhsTZQRVAMBBnkUiK/b3YzYbDvWRcrDbQd4tX0RGALa1uEAyVp2TbBh
 dlGxERdHE+FaIQtBsz9RMpZNobL2zHtWp/KIRD4P1Y/PbN+xa6bQtPVRkWZJiDQoawDI
 MQjgh2C5SNtg4kDwlP8Mf10jHTW2PJkHauSaQ3BotVSCHN6cfNJQ2P5+69cqa1uuDWTL
 5YlG7R1w1pTc/VmHY7q2Mtbab1xtff+d37WJBe3khrAWObr/9C8nvOVsC2xQEKEaRiDM
 jUvg==
X-Gm-Message-State: AOAM5339BSvnpiPNy+A8wUdUYRc7LSOkFmYppqBPYUcPYwF1I9+IMwCA
 hlccooeaLaHaKPCJB/fFPex+7+X/eSI/Ym4JEmU=
X-Google-Smtp-Source: ABdhPJwldWxgVzojJ2G+wCzdSa+ydcni6sTFO8YXAJ0AMt4lgwTXprP4ov/q4RixmJbJH0Rqv8xKNOwZgnEcn3WEInY=
X-Received: by 2002:a05:6402:195:: with SMTP id
 r21mr980115edv.164.1604044845119; 
 Fri, 30 Oct 2020 01:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-13-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-13-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 12:00:33 +0400
Message-ID: <CAJ+F1CK6qoCW1L8Bdo2eFV2-O62QxW3+Q3+htxUdv5wzGeRZ4g@mail.gmail.com>
Subject: Re: [PATCH 12/36] qdev: Make error_set_from_qdev_prop_error() get
 Object* argument
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000327f2f05b2decb74"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x541.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Qemu-s390x list <qemu-s390x@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000327f2f05b2decb74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:16 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Make the code more generic and not specific to TYPE_DEVICE.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

What about dropping _qdev from the function name too?

Also, I am not sure it's a well designed function.. I would rather have 3
different helper functions than dispatching with an errno... Might be worth
a TODO note :)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

--000000000000327f2f05b2decb74
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:16 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Ma=
ke the code more generic and not specific to TYPE_DEVICE.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>What about dropping _qdev from the function name too?</div><div><br><=
/div><div>Also, I am not sure it&#39;s a well designed function.. I would r=
ather have 3 different helper functions than dispatching with an errno... M=
ight be worth a TODO note :)<br></div><div><br></div><div>Reviewed-by: Marc=
-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">marca=
ndre.lureau@redhat.com</a>&gt; </div></div><br clear=3D"all"><br>-- <br><di=
v dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></d=
iv>

--000000000000327f2f05b2decb74--

