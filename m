Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6151C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E1CF206CA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 09:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsBo0+TO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E1CF206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYRCC-0007XE-0p
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 05:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39128)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYR9q-0006YY-6l
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:57:19 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533]:35384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYR9m-00071f-8A
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 05:57:17 -0400
Received: by mail-ed1-x533.google.com with SMTP id w25so6019696edx.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EZQyMPA/EtXcANhDC2yUvcrmLvC4fWgBHmKeLWLcv2E=;
 b=YsBo0+TOoaB/XkDd+diWc0nxDmyPeR7OUebzWs6PMvVXMn7WKVoNthJ6JMTlrpre+N
 CqzFog5cIwIv6GFgDGp09qbaH+wEBT8QSYdps5vryTNgeM87qZyk1JSzYCWcOF4R6caQ
 xdS35c+dJQPdkLAjJqwBT2pEB8DrDHR8eInDKothjFCSwkkEgkDwP8PERMltBJnIlx+r
 pLERytDgmjXzOg/mRDalGCq7mgWW2bSCV5yc5H+U7Lk6Fe6OnZ08EGKndP/VYFpuaU1r
 1uHW1D4KLYy2aR4AiVWoht45TPz7ozPklbPOtoNTINt03ZpjD1vhS3hixX4/rUTAYabO
 5BJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EZQyMPA/EtXcANhDC2yUvcrmLvC4fWgBHmKeLWLcv2E=;
 b=Y0Sr9+7Er4GAA1idpB4lssJfWaVhLcpv10+1iCyyjMchLin0BVYRHqByXTOiAT53Cr
 WtW2zRttWoH6Bf+50M2lA6veIOyKEtm58hHWJzjlgDUiZfqYSoLaCtfzqxPzV3y2yu8+
 BiCwndT7uOVf7nDVNJiHbvUbkahseoOC+NeHQ/EJ2QzXqeccdXzkH3oAhwXYQAbOC02x
 Ouqn3pgFvk+M/zFt/24UCqcvMSkxdbYZE4D7uGD9PsFkoqOZphOtIw0mnUFfoHnxV3Oi
 l7Jixukq+bQpGdWLrkqbkj0jcLR0+3h3L4bcxjEWszKAdEo8HsMn7SgcMA+Lz+HCCJaB
 MzTA==
X-Gm-Message-State: AOAM532b614KWyPFpv3b3U09f9vJPZpjXZIxTLGavC7QKGFRGpOXv/EV
 jXFXVrfNK2dpAVr8u4CEjzxh4v6QYS/TfeRE54s=
X-Google-Smtp-Source: ABdhPJzR2ZtblOBxdeFCzLNxY28NETGgwjbHsG5V/Q434u0uo9q17WWgzZnlj4xCr52XYbiiYJPZiJb/IIGlDinlf/U=
X-Received: by 2002:aa7:dd42:: with SMTP id o2mr1341547edw.53.1604051830987;
 Fri, 30 Oct 2020 02:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-18-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-18-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 13:56:59 +0400
Message-ID: <CAJ+F1CL3noqv4eLWnSuM15uVzq6uX_PwybFKxNGf_UVcHDhLBw@mail.gmail.com>
Subject: Re: [PATCH 17/36] qdev: Separate generic and device-specific property
 registration
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000096635a05b2e06bbd"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x533.google.com
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

--00000000000096635a05b2e06bbd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Oct 30, 2020 at 2:19 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> qdev_class_add_property() and qdev_property_add_static() will
> have code that's specific for device types.
>
> object_class_property_add_static(),
> object_class_add_static_props(), and object_property_add_static()
> will be generic and part of the QOM static property API.
>
> The declarations for the new functions are being added to
> qdev-properties.h, but they will be moved to a QOM header later.
>
>
Might be worth to mention that you also changed *property_add_static() to
return the ObjectProperty. Probably useful in a later patch.

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000096635a05b2e06bbd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:19 AM Edu=
ardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
qdev_class_add_property() and qdev_property_add_static() will<br>
have code that&#39;s specific for device types.<br>
<br>
object_class_property_add_static(),<br>
object_class_add_static_props(), and object_property_add_static()<br>
will be generic and part of the QOM static property API.<br>
<br>
The declarations for the new functions are being added to<br>
qdev-properties.h, but they will be moved to a QOM header later.<br>
<br></blockquote><div><br></div><div>Might be worth to mention that you als=
o changed *property_add_static() to return the ObjectProperty. Probably use=
ful in a later patch.</div></div><div class=3D"gmail_quote"><br></div><div =
class=3D"gmail_quote">Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"ma=
ilto:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div>=
<div><br></div><div>-- </div><div dir=3D"ltr" class=3D"gmail_signature">Mar=
c-Andr=C3=A9 Lureau<br></div></div>

--00000000000096635a05b2e06bbd--

