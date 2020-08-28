Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F826C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 540D12086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 10:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fORx7jsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540D12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBbxE-0005CB-Ic
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 06:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBbwY-0004aC-5k
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBbwV-0006Ss-LA
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 06:49:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598611748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VkcH/x0VunTlD28VFjSh9qmto2cCP0cSgdg3L5Xn8OU=;
 b=fORx7jsqF4sq33mv5VndD3sg8fnyG0VRbIq/GAEUgtm0NqRzLpGXoOnsMjgUZnZID4QZuU
 EvMrpKjvVtXlnFEiF02Gs/MYRQr2HcRvZTgC/XHH+oAf/1NBd99bPyKHsXj4EoRlwKTI1A
 FNQBG57Or78PnKtBoznlVYvIGgqudAw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-F3QuEjByO9SzA8l31Gvsnw-1; Fri, 28 Aug 2020 06:49:06 -0400
X-MC-Unique: F3QuEjByO9SzA8l31Gvsnw-1
Received: by mail-ed1-f72.google.com with SMTP id l10so177103eds.18
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 03:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=VkcH/x0VunTlD28VFjSh9qmto2cCP0cSgdg3L5Xn8OU=;
 b=POzCNK8wo5uMcQy/AClR7NkmNxO4DZZJUGg+O/OsQcoescCks27tO1U8ydpAW/L8Y3
 F0CI1jRUPET6r444/Zx/c1aGqqEc+Yq8VumXUoDNUVGogEztS7OqUzHcA/GG7z9AJ96f
 IoneYrSpfDQSV0CkjlmhHWeGPGyW8SjhDhsg8ClzLw4w2Ej8hRD+VnPwXgK+e+jCofv9
 QyB/BhtL0PhLIeEAYidr57lktysA9P/7SmG6HUoiFwmL/c4ItSkZCQDOvQSp1pMXEuuV
 u57bZiaTcjdDUMjHNcKb3DKegEHz3062DrlR+x2l7g8/OLa2LIoTp7XY0xIbMPk74FZ4
 Q6bQ==
X-Gm-Message-State: AOAM531LsNjv51yipan+uKMyiiONVksU68xBA4rcfpeVrSGqOa1b4rLW
 sfvD6Ii4KpH/g3vYl4u7nfNXcNx3QEcx4W2da+n0zTczov+gtUQS5Otxn1DM/UU1GJhYLQ/HH6U
 fn3wVYgva+TSOtJtkEoz/chJFDlgQcP0=
X-Received: by 2002:a50:ee96:: with SMTP id f22mr1119050edr.243.1598611745384; 
 Fri, 28 Aug 2020 03:49:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5Kc3RYf0ggIvzh7wedrneEoVZYT/agrEz/tdbZtsG1hkattpkCTmNsYXF8yr5G9mfS3+aj/t9I10OQQvbjxY=
X-Received: by 2002:a50:ee96:: with SMTP id f22mr1119030edr.243.1598611745188; 
 Fri, 28 Aug 2020 03:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200828080845.28287-1-kraxel@redhat.com>
 <20200828080845.28287-12-kraxel@redhat.com>
In-Reply-To: <20200828080845.28287-12-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 28 Aug 2020 12:48:53 +0200
Message-ID: <CABgObfZrb0LYvk8aPAidp26awhKi1m23zuoLqu1HSYNBkpd2LQ@mail.gmail.com>
Subject: Re: [PULL 11/18] meson: Add U2F key to meson
To: Gerd Hoffmann <kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000034bfb205adedcd93"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 04:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?C=C3=A9sar_Belley?= <cesar.belley@lse.epita.fr>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000034bfb205adedcd93
Content-Type: text/plain; charset="UTF-8"

Il ven 28 ago 2020, 10:08 Gerd Hoffmann <kraxel@redhat.com> ha scritto:

>
> +u2f = dependency('u2f-emu', required: get_option('u2f'), static:
> enable_static,
> +                 include_type: 'system')
> +if u2f.found()
> +  u2f = declare_dependency(dependencies: u2f)
> +endif
>

Better:

u2f = not_found
if have_system
  u2f = dependency('u2f-emu', required: get_option('u2f'), static:
enable_static)
endif

The declare_dependency afterwards is not needed.

  +config_host_data.set('CONFIG_U2F', u2f.found())
>

Not needed is there no #ifdef CONFIG_U2F.

Paolo

--00000000000034bfb205adedcd93
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Il ven 28 ago 2020, 10:08 Gerd Hoffmann &lt;<a href=3D"mailto:=
kraxel@redhat.com">kraxel@redhat.com</a>&gt; ha scritto:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><br>
+u2f =3D dependency(&#39;u2f-emu&#39;, required: get_option(&#39;u2f&#39;),=
 static: enable_static,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0include_type=
: &#39;system&#39;)<br>
+if u2f.found()<br>
+=C2=A0 u2f =3D declare_dependency(dependencies: u2f)<br>
+endif<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">Better:</div><div dir=3D"auto"><br></div><div dir=3D"auto">u2f =3D no=
t_found</div><div dir=3D"auto">if have_system</div><div dir=3D"auto"><span =
style=3D"font-family:sans-serif">=C2=A0 u2f =3D dependency(&#39;u2f-emu&#39=
;, required: get_option(&#39;u2f&#39;), static: enable_static)</span><br></=
div><div dir=3D"auto"><span style=3D"font-family:sans-serif">endif</span></=
div><div dir=3D"auto"><span style=3D"font-family:sans-serif"><br></span></d=
iv><div dir=3D"auto"><font face=3D"sans-serif">The declare_dependency after=
wards is not needed.</font></div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=C2=A0=C2=A0+=
config_host_data.set(&#39;CONFIG_U2F&#39;, u2f.found())<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">Not needed is there =
no #ifdef CONFIG_U2F.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Pa=
olo=C2=A0</div></div>

--00000000000034bfb205adedcd93--


