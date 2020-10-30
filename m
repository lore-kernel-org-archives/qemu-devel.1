Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF44AC55178
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 426602222C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 08:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJIwxNay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 426602222C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYPTk-0007Vv-98
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 04:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYPQh-0005Ke-JF
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:06:35 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:34286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kYPQf-0000KP-UE
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 04:06:35 -0400
Received: by mail-ej1-x62c.google.com with SMTP id o9so5270020ejg.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 01:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QE2A7DTGQUoUj8rij+aZkhoCdqGpNk5vOjLcWCWdy2E=;
 b=EJIwxNayEA6X0M7lXwDfEJ2zvIATLz+2LWdo9l/9VhrzPwtqTxlAfuFIwA2X6SUvZ5
 XUEvtAVPExBi6KVtL9AYV2PvzQr77Gi5Jq+bnHnrfEQjg7nQBX6qOI+YffdmsNkaJIf2
 UlR/Ay2uyTQCWUh/+N951TfV95hLO0j/07SeZ/akqB6TJ4jY7anpR7tkIkwwFtlFbqPY
 bVE3/dw40i70Mn2T13Gi6M4YnBlmPxcUS9OjDP2pc/ORsw9Dh2N/UUde2c5pr6lBwJ3D
 +tEcWGj5tRVR3xDgyrTIv3yyYgQa6kT2zHDCWENMpLG1oBxnqMIE8nQw+lePSfi+ma+E
 /+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QE2A7DTGQUoUj8rij+aZkhoCdqGpNk5vOjLcWCWdy2E=;
 b=nuPWVprFC9d+bOQ4SecuFULZTuAivqFe/6yqRhZBMbPLCj/KjMXvfzaBaY/tPFcwIY
 d7r5GDHovy7ipI0hFAcMUe6KFoW68fzBNq7tNYCQ2cnvjrF9uIGxNbcyn2vhMJD5u3wP
 IhAKh9E8dnSBTNDY6nVtiNmwI9LruwNhn2AVOWNkY3gptMRRal5xQD9+yks3zTBQ8Y1q
 5l0X6jWixLufIj785WmYxvwdPQvON1aPamNS93rQ+Ldh6M24VCvSE0uWoiwo99OJLQlk
 kd7oitdfpym9ugSSRcP6rNp3OfYtgJnVyPnNFz5XPKOt8fo//nlAwTRaOi33H0Nycfvj
 Ixpg==
X-Gm-Message-State: AOAM5308aBPMdjDCySymZe+BK7Mj5SWAHVfEdzVSYcDZzVmrJsZPDWNZ
 vUg1SyL3iLDKaIXLLf2i2npX6bh+KuL8+88Cuno=
X-Google-Smtp-Source: ABdhPJxFwyQgVCqNWQZsl2Tc1/tdze4CePUXtICt3TRDM5OYD+MbONC8ngfq554X+vrYfQtKhCQFoBd7bqDB4/MatPA=
X-Received: by 2002:a17:906:1a11:: with SMTP id
 i17mr1216845ejf.381.1604045192610; 
 Fri, 30 Oct 2020 01:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201029220246.472693-1-ehabkost@redhat.com>
 <20201029220246.472693-14-ehabkost@redhat.com>
In-Reply-To: <20201029220246.472693-14-ehabkost@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 30 Oct 2020 12:06:18 +0400
Message-ID: <CAJ+F1CJY4xu--+hmCgVBdXyrcxG45s5fVy==2Em+MgvELRN34Q@mail.gmail.com>
Subject: Re: [PATCH 13/36] qdev: Wrap getters and setters in separate helpers
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e8cadf05b2dedf45"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ej1-x62c.google.com
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

--000000000000e8cadf05b2dedf45
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2020 at 2:11 AM Eduardo Habkost <ehabkost@redhat.com> wrote=
:

> We'll add extra code to the qdev property getters and setters, so
> add wrapper functions where additional actions can be performed.
>
> The new functions have a "static_prop_" prefix instead of "qdev_"
> because the code will eventually be moved outside
> qdev-properties.c, to common QOM code.
>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



--=20
Marc-Andr=C3=A9 Lureau

--000000000000e8cadf05b2dedf45
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 30, 2020 at 2:11 AM Eduar=
do Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com">ehabkost@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">We=
&#39;ll add extra code to the qdev property getters and setters, so<br>
add wrapper functions where additional actions can be performed.<br>
<br>
The new functions have a &quot;static_prop_&quot; prefix instead of &quot;q=
dev_&quot;<br>
because the code will eventually be moved outside<br>
qdev-properties.c, to common QOM code.<br>
<br>
Signed-off-by: Eduardo Habkost &lt;<a href=3D"mailto:ehabkost@redhat.com" t=
arget=3D"_blank">ehabkost@redhat.com</a>&gt;<br></blockquote><div><br></div=
><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.l=
ureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;=C2=
=A0=C2=A0 <br></div><br></div><br clear=3D"all"><br>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--000000000000e8cadf05b2dedf45--

