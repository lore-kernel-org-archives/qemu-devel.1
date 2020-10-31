Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4A7C55179
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 07:39:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A575D21534
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 07:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie+Ap2ih"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A575D21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46876 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYlTp-0002kb-N5
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 03:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYlTC-0002J4-VW
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 03:38:38 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:34302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYlTA-0004jQ-Of
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 03:38:38 -0400
Received: by mail-ej1-x62a.google.com with SMTP id o9so9610178ejg.1
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2020 00:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RWs0KcdqDjIEXbYSE3T98Qc0iCvIIYu+0MhvjyKgA7Q=;
 b=ie+Ap2ihK1Ny39FkURxozjikS0FvQkvvSi7I0gVEizYlr7JtEo/EI9WXhPgThrElyi
 0J+23lJFAxpxhYN0eTtcAyybjggtFbfcTD3XycmWIei9avT4c5LllwQMZXDU6p7b2Cf0
 q2UJPbGelZtpfQyB8OIGCeZd+JcLL33m+MwSARjRzO1tYtWr9vsoSRIZOAjudVnjSyzB
 jjgEfDOWTnHBCIXfOHHcgZBl6dUMBlOlVepa9mGXTnuFyeJipIn44cGpQM2DvtrJwDXc
 HB4PyYB5DXXFBLW+fF7etAY9oNf8Qt1G1s91pg8xrnt4DbF0fwFiHEg6kPvSzj1H1ue7
 Qw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RWs0KcdqDjIEXbYSE3T98Qc0iCvIIYu+0MhvjyKgA7Q=;
 b=Odgt90o+0awIms5pN2orKjy/gW+ew/cxGBMBKNItLdWz6qpt17aBBv8JytlphRIpSK
 Nn+r3suQNw+Y9c4F5FWwQ1RNVEu3X1dUhNau2psVMyhpm4mYSRTX5M9udrDXQLhNHY1G
 MmscwmaSHwu45TFxbXzvi4852HzXZHrsE6ivWi+wQXV5/sMRaJM2EPUuVmVMn/ozorVl
 iq8K9Az3o8nTx7NIfCoxBkloWqqzlbZvqFkaOpm5qsd8vNKGjqoLD7szhqfqUAmLhLDy
 qpq4/7tdll8RhRSOZqHE4J5tneJffFnk6TP42T92ZoG+WDaRKEYWZ/xvxUE8zuO+HOwn
 +6dA==
X-Gm-Message-State: AOAM532Jui90UPFq5LeoZEx1cAe1ioQxZPwNFScepUnS1a65JXEycmgc
 sb4H3bUjeoyyZoGHjBMXI+nOX6sCP9q33yMUbnk=
X-Google-Smtp-Source: ABdhPJzG9evaRN4+yWJ5RXp0AZkpuCmqpiQN6765Z1HHV1aHOfDJKvYTKx4OnNtdCppg2fb2NKFcwkCmaMlyt3QVSzc=
X-Received: by 2002:a17:906:2798:: with SMTP id
 j24mr6029558ejc.109.1604129915167; 
 Sat, 31 Oct 2020 00:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-33-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-33-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 31 Oct 2020 11:38:23 +0400
Message-ID: <CAJ+F1C+PbuHUQEARQeZ7Ecegwqy1C5ccT0gRq9qL4NDGANiZ=g@mail.gmail.com>
Subject: Re: [PATCH 32/36] qdev: Move base property types to
 qom/property-types.c
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000c4698505b2f2994d"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x62a.google.com
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

--000000000000c4698505b2f2994d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:26 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> Move all property types from qdev-properties.c to
> qom/property-types.c.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000c4698505b2f2994d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:26 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Mo=
ve all property types from qdev-properties.c to<br>
qom/property-types.c.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><div> <br></div>=
</div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lur=
eau<br></div></div>

--000000000000c4698505b2f2994d--

