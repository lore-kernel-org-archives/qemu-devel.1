Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66667C00A89
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:50:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A6822203
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 07:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlHVWBig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A6822203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYPB8-00051f-He
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 03:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP6K-00016e-RF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:45:32 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633]:33492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYP6J-0001GL-5S
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 03:45:32 -0400
Received: by mail-ej1-x633.google.com with SMTP id 7so7323870ejm.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AJYao3d5t9V6FwJONLYgavYjWbh/IYAq1pqQIhUVZqo=;
 b=JlHVWBigwDINytY1F012oVoM6kqAjmSnE9FBK6pK3xMv//xOA9Ia2xvb+2cx0Qb4Oo
 2DyE7vLEblTdjnUAcSLnQF9lyADXSGe8B9op4rPH2yRCdAO9F5UOOcS+H33g+vFVnU8w
 5fJzQyedtqF3t4PxBR+GHLsChvmvr+P3TLYq70efBqdm4h/MQzUsfeMVtZOuu0CtdhQT
 QLUgPz6UOuymcvnTX3Fs1CkyWaamove5LJsoKxrLljh8gcKL4sYNXpiXPRTNPjXc7Sd0
 foubQK+gGyxSSQng7uSlEU1fQ8D9v12lv4Njs7cX0TDd2r0amfSZyUj1ABSY0oR/BBpV
 XCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AJYao3d5t9V6FwJONLYgavYjWbh/IYAq1pqQIhUVZqo=;
 b=oi6tqq0I0/k8nrgak+BZL5NKa1jGk2HdUXj9ZHJtwGtgdufN6yf6f6ufm8VEycRWG1
 KZauX3P1LNnBj2fdb5piiO4dPXkaqQmTQ3djVPE8EpzOqD2XPZWb7oCus2sMuEjnADSm
 hUroYkS6GCGP0QdMX4OoDeleM6gPOaEUBoISAifEuEyfNtKNdaVyA1KHidMOTvWhHDHP
 T3XDs8HaEf6BADOM/m6aes2egR5VUsURG0QaTcaOFOtCEMt22dglCNV2VgrIGzBLfgoC
 t5vKNXK4R+amMXojoC9Ch9ip/udKmgDmrelGwTgPCQSXpgF3iMDPlIDxQEk5NuWsll1T
 jEuQ==
X-Gm-Message-State: AOAM532Nf7LbkS/LMhI3tgm7tkAmkaA4FVyPGNOkyF6QRCE5Plo/NWyh
 MxbRJ30yLRp7weX5Y8JI0cBgQo3GaytOjY3JzpA=
X-Google-Smtp-Source: ABdhPJxPAxUlAmvEF5o35Tnw0K/ze96fytvoU211/oUge33IY0lHB22TFV0jPmnRPyc73C+Qxpw4p2QtoDt+5t82mfo=
X-Received: by 2002:a17:906:1a11:: with SMTP id
 i17mr1158626ejf.381.1604043929722; 
 Fri, 30 Oct 2020 00:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-9-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-9-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 11:45:16 +0400
Message-ID: <CAJ+F1CJz9W0jYYgWdXMK-P9ykqqLb+hvnfokfLkrROsct9CezQ@mail.gmail.com>
Subject: Re: [PATCH 08/36] qdev: Make bit_prop_set() get Object* argument
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a2a48b05b2de9485"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x633.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a2a48b05b2de9485
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:11 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Make the code more generic and not specific to TYPE_DEVICE.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=20
Marc-Andr=C3=A9 Lureau

--000000000000a2a48b05b2de9485
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:11 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" target=3D"_blank">eha=
bkost@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Make the code more generic and not specific to TYPE_DEVICE.=
<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;</di=
v><br clear=3D"all"></div><br>-- <br><div dir=3D"ltr">Marc-Andr=C3=A9 Lurea=
u<br></div></div>

--000000000000a2a48b05b2de9485--

