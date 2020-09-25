Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A753C4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:32:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D491206C3
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBHo+ttn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D491206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLtRu-0003HR-C8
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kLtQI-0002Mx-OR
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:30:26 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136]:44628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kLtQ7-0005jJ-0X
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:30:23 -0400
Received: by mail-lf1-x136.google.com with SMTP id d15so4013019lfq.11
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 12:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=bdRi0nTcZwSDZ30P5aCLH5kxQb59pnpqwySg1IGsk/A=;
 b=lBHo+ttnWk8FZMKuT9xtRxUU6O7Rkvu+ssKGQkALEJaDLeofmCMJyV1gqZ9w7Xe+vc
 /Ll7RClOfbG/c7e7awYm7FCj2Ndek4N/pSfAOLtFCkPy8w9tcehKWj3PpsoTWYcdHOwI
 QTHBxJvkU7E3BneMbrpS5Ee5LcHsA8NrR/0RU513dFmq8gKLa5lGjYGlQmo9Q/+w095V
 HXccq5+b+fS3PegiFFYjY7QRcxI4hHfmMSK9NYAL/CjwllG0lgLStdkQDRoeUWYvJRWU
 hO6tWBrRSzKxhlpWWvMkR7lOeGUsCoRKiZR/EkugswHtcDbKwikYFeF6sPRBiQ+fWIxG
 X5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=bdRi0nTcZwSDZ30P5aCLH5kxQb59pnpqwySg1IGsk/A=;
 b=pfo8uQ0Lnzfdo4guGUB1vdNVUVIwIN8cWOS+mYYr+F3G2Z4VQ5r8cRFyRUT3UvAs6z
 2LzW4kw/ZoRugu1+jAL+zYuNvkc+gc/qcbkpK592hDSFrNEZr9gIb++9v4qmlNyyhzOb
 H/4UOkwPdYWn61lXeMFaxe4tQkS6fr4/O699qWXl1W6Xd7SwnwFptWyylmD+S/ZQ77hU
 UrjuZ8hjNrBzuw5G9/kFAvlLQWFDAMAvK6FnOzcsG5RlFkSO9Ms6JkL9Wfk95hu4g9QL
 eq8Rf3rEEVz40a0i5FeUrxTY0JAfU+Kyhbf4YlQF1f0UXHqF2ZoTO9/wPpjs4+4byy7Z
 +gCg==
X-Gm-Message-State: AOAM530oD2YXBbEk/8U9FaABG3H+gKTJgO6ECdc8Y0SfFn3wpjGnDmoJ
 NDVxnb6rf6KIvhrMUlk1XPMH/i68tVkDXSoqxG4=
X-Google-Smtp-Source: ABdhPJx50qYgFZ6ObQIAIAfSLG4PeqWStwFD9BDxo3ZVC/iYqnYDVzS8ds1Fgtjgm5jAeKBWgLOTlJHRVbTeNm2Ay28=
X-Received: by 2002:a19:a407:: with SMTP id q7mr105876lfc.377.1601062212652;
 Fri, 25 Sep 2020 12:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-PpsaqJOfEq0iUSkH6N8skkqFAY+2QkSbnENiszA0xQg@mail.gmail.com>
 <a50bc12c-7aa1-19a3-c39e-02328aeaca38@redhat.com>
 <CAE2XoE9F5_gGsiFutW99mbPUbUb2rmG+2+9pEDKrhvu9QRwYvw@mail.gmail.com>
 <a808929b-f93c-f68d-da4e-02133b4fcb54@redhat.com>
In-Reply-To: <a808929b-f93c-f68d-da4e-02133b4fcb54@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sat, 26 Sep 2020 03:30:01 +0800
Message-ID: <CAE2XoE_Qe9MBSJ_UAduLWX5xjBbj5Jqype-XT9Uh7muLbEeZLA@mail.gmail.com>
Subject: Re: I wanna fixes plugin on windows, any suggestion
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000072d2e905b0285872"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x136.google.com
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
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000072d2e905b0285872
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 26, 2020 at 3:25 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/09/20 21:23, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > That's what I am tring to fixes? what does  one import library per
> > emulator, can we do this like NodeJS does?
> >  NodeJS have NAPI support across platform. They create a windows .lib
from
> > node.exe
>
> You'd have to create a .lib for qemu-system-aarch64.exe, one for
> qemu-system-arm.exe, etc.  On Linux the same plugin will work for all
> emulators.
>
OK, this made the things clear, the possible solution is to using function
pointer to expose
all Plugin-API functions
> Paolo
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000072d2e905b0285872
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Sat, Sep 26, 2020 at 3:25 AM Paolo Bonzini &lt;=
<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; On 25/09/20 21:23, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo)=
 wrote:<br>&gt; &gt; That&#39;s what I am tring to fixes? what does =C2=A0o=
ne import library per<br>&gt; &gt; emulator, can we do this like NodeJS doe=
s?<br>&gt; &gt; =C2=A0NodeJS have NAPI support across platform. They create=
 a windows .lib from<br>&gt; &gt; node.exe<br>&gt;<br>&gt; You&#39;d have t=
o create a .lib for qemu-system-aarch64.exe, one for<br>&gt; qemu-system-ar=
m.exe, etc.=C2=A0 On Linux the same plugin will work for all<br>&gt; emulat=
ors.<br>&gt;<div>OK, this made the things clear, the possible solution is t=
o using function pointer to expose</div><div>all Plugin-API functions<br>&g=
t; Paolo<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=
=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0=
 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--00000000000072d2e905b0285872--

