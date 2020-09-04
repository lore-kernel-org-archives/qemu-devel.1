Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F5C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C31206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 04:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9s/qi0O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C31206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE2zq-0000Z6-VY
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 00:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kE2o6-0007fQ-IE
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 23:54:34 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:36755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kE2o4-0005gN-Kh
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 23:54:34 -0400
Received: by mail-lj1-x235.google.com with SMTP id t23so6311477ljc.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 20:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=xVOo1tNfQCHLsg5vHnI156ZyqSCR8GXsnsXDsW4Q1cg=;
 b=U9s/qi0OP4cT3pzR7K4quV3BAtF6avNcbQz35CnvIa1Bvy2RrVtxQHtHzdD6EaVURK
 UAWcZs76bb6YNLzq4fXBry+scs8INiEMVCozC4WuZjBoH9dz8MqrIu2n8EFdRvlGa41p
 Tj+okK5eGT9kIuJL20eoQ/5Qjg7v/eS+18UT54MG82uvlycWmYns0SRBUYlS3I9ZJOdI
 1XV8vHhFNJx+MAVql3/SMjEk78sujkQOrCpo3B7Tis0hIL+QHqV37695Bd5XMsmjS+RR
 aR7N7y9TUXhyC2tsosYjS+KeWdmO9fE//i0W8h5UXS7pOkwIqUKs0ONj4iXdrRI2ZmnD
 FdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=xVOo1tNfQCHLsg5vHnI156ZyqSCR8GXsnsXDsW4Q1cg=;
 b=XN72GLFq7I+ydHSiw6wkTo+79KYFaSC3sjGlsu73sD6pZy+jYvSHdf5QLNjlLVkg6C
 Ddt8u9EnCg6VRDtvDNK2WQ6is/CP9obnHVdIi6QLPMIx+3HQy5ZPyrRlchzICarsM10b
 aD/NQUU5hR5TXUwpEBpYzBR09ry8sQjTOIQpkVXjSVFvv195PwKruFip4hmVWdi9CBjT
 EtLdrK/ssdi6GGDwI8bgmNsFySH+Cc5nM2Op2SjdCkp64ehZ/87kUziL3plHD1QppU8g
 Jihut0FxBGSTRmGTokGs/9/qF7BTlI/D0BdQo21PKhW4rwrpgEgmJUd01cl2owYYBczb
 xU6w==
X-Gm-Message-State: AOAM530FGPMRbyrh9QBqNEuvJY5u2wGY87STak3uVYuX2jNPXAt3836l
 nt0NI5UUz2rDDC+1WlLVqnyO5uh8Tz4JxzOEXZA=
X-Google-Smtp-Source: ABdhPJxDYWqDJEayfU+ZGcGmCgnCIMIIdamBzU4KNLqSJ4v3c9toc5hYMD8iTjLMhuA/7A5fkh3PGznJoUw3sbhGKNQ=
X-Received: by 2002:a05:651c:1119:: with SMTP id
 d25mr2559129ljo.300.1599191670647; 
 Thu, 03 Sep 2020 20:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200903220622.504-1-luoyonggang@gmail.com>
 <CABgObfb8xOr6JstG0MLTwqeNZJXDC7LiecrFQje9VbwZD96Mvg@mail.gmail.com>
In-Reply-To: <CABgObfb8xOr6JstG0MLTwqeNZJXDC7LiecrFQje9VbwZD96Mvg@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 4 Sep 2020 11:54:21 +0800
Message-ID: <CAE2XoE9n3KU-bQ4SKhKCjjQVER=b4-4em3HfxCj6qYU+XkBdWw@mail.gmail.com>
Subject: Re: [PATCH] configure: the error info not consistence with option.
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000074edc105ae74d3a8"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x235.google.com
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000074edc105ae74d3a8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2020 at 8:18 AM Paolo Bonzini <pbonzini@redhat.com> wrote:

>  test "$vhost_net_user" =3D "" && vhost_net_user=3D$vhost_user
>>  if test "$vhost_net_user" =3D "yes" && test "$vhost_user" =3D "no"; the=
n
>> -  error_exit "--enable-vhost-net-user requires --enable-vhost-user"
>> +  error_exit "--enable-vhost-net requires --enable-vhost-user"
>>  fi
>>
>
> This change seems wrong.
>
I didn't found --enable-vhost-net-user option handling?
you may grep it?

>
> Paolo
>
>  test "$vhost_crypto" =3D "" && vhost_crypto=3D$vhost_user
>>  if test "$vhost_crypto" =3D "yes" && test "$vhost_user" =3D "no"; then
>> --
>> 2.28.0.windows.1
>>
>>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000074edc105ae74d3a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Sep 4, 2020 at 8:18 AM Paolo =
Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"auto"><div><div class=3D"gmail_quote"><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">=C2=A0test &quot;$vhost_net_user&quot; =3D &quot;&quot;=
 &amp;&amp; vhost_net_user=3D$vhost_user<br>
=C2=A0if test &quot;$vhost_net_user&quot; =3D &quot;yes&quot; &amp;&amp; te=
st &quot;$vhost_user&quot; =3D &quot;no&quot;; then<br>
-=C2=A0 error_exit &quot;--enable-vhost-net-user requires --enable-vhost-us=
er&quot;<br>
+=C2=A0 error_exit &quot;--enable-vhost-net requires --enable-vhost-user&qu=
ot;<br>
=C2=A0fi<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">This change seems wrong.</div></div></blockquote><div>I didn&#39;=
t found=C2=A0<span style=3D"color:rgb(80,0,80)">--enable-vhost-net-user opt=
ion handling?</span></div><div>you may grep it?=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><div dir=3D"auto"><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
=C2=A0test &quot;$vhost_crypto&quot; =3D &quot;&quot; &amp;&amp; vhost_cryp=
to=3D$vhost_user<br>
=C2=A0if test &quot;$vhost_crypto&quot; =3D &quot;yes&quot; &amp;&amp; test=
 &quot;$vhost_user&quot; =3D &quot;no&quot;; then<br>
-- <br>
2.28.0.windows.1<br>
<br>
</blockquote></div></div></div>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000074edc105ae74d3a8--

