Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B23C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:20:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 271F42075D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 00:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tvpjd1ch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 271F42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDzTB-0007ph-Ct
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 20:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDzR6-0005qb-DF
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 20:18:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24852)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDzR4-00060N-6G
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 20:18:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599178713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LPNKyVtCXQT6DgxvvLeAVIzEFuFXJyPntxNBe5zDd2M=;
 b=Tvpjd1chVX7cQXbLr1VTrak7iCHOZHKhYPmkrk/ncKXGzPOXpuMzGaaWe/j7k7UIjJB6hA
 At42TNa1T1PYD1EO7th6f609XRFAOM8LhghK2x0OHeeMBuclya9v0xoZQuyLoI7cNOXcck
 xmvYwiZgwG0vQYJFeC+G+S095KBC3O8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-WCj8Iso7NJOfVNJhgqwZfw-1; Thu, 03 Sep 2020 20:18:30 -0400
X-MC-Unique: WCj8Iso7NJOfVNJhgqwZfw-1
Received: by mail-ej1-f72.google.com with SMTP id md9so1551472ejb.8
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 17:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LPNKyVtCXQT6DgxvvLeAVIzEFuFXJyPntxNBe5zDd2M=;
 b=F6JOeWAyUhg0i4ZtsABxUO9ol0BPI6NpUezt2K+q1TpD14gWLWruTpljNeyes/Z9XR
 hQMYFMLCVnpfELZCxVeeutdQub+iKTYYsabregOsDtHGiE3wj5CNXeOWf4cfFa4KkmV1
 VjVxc3p/qFcr4Vs3NPFtI0A6ldgMK9MAW76J78b1dZiafzcp38AvtbwA4R7aDLtDRbAd
 UVn8xNyGdEMxH1KnHar73j/sWc+ZaD6yWiLzY15V+ZntDTt1GXGM9DniZ2U7/JQZqRfD
 keclxw/gCwqBYj5EIHBNx8KYxSMAtlAoqXlUUTem0gaHZ/wWBgvbmc+fS7dpWCi+HOfy
 DhFw==
X-Gm-Message-State: AOAM530jZTgGzNHtlO9gMSuIxALZqw/+R1NZxCwNA+N0Gi6qcO3SRyyI
 QW6BV2qoZU9ZbgF0i4oOPdr+MrlYqV1ydGj7VLw62jNTdrXrcGbBK1Ew9DUOsmYID2czluLK8Ge
 4UHgyTP155OiqiyPwGUugUJ9g0QGx8kQ=
X-Received: by 2002:a17:906:3495:: with SMTP id
 g21mr4655250ejb.121.1599178709634; 
 Thu, 03 Sep 2020 17:18:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzo1S6pLP007bigQEri292tmsxgUL5xFqJjioeTmc3lLv+Uk1CnBNFV/0v6JTN59KvvAeg+/jZWXS0bUGyu70Y=
X-Received: by 2002:a17:906:3495:: with SMTP id
 g21mr4655240ejb.121.1599178709386; 
 Thu, 03 Sep 2020 17:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200903220622.504-1-luoyonggang@gmail.com>
In-Reply-To: <20200903220622.504-1-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 4 Sep 2020 02:18:18 +0200
Message-ID: <CABgObfb8xOr6JstG0MLTwqeNZJXDC7LiecrFQje9VbwZD96Mvg@mail.gmail.com>
Subject: Re: [PATCH] configure: the error info not consistence with option.
To: Yonggang Luo <luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e7e39605ae71cee8"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 20:18:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e7e39605ae71cee8
Content-Type: text/plain; charset="UTF-8"

>
>  test "$vhost_net_user" = "" && vhost_net_user=$vhost_user
>  if test "$vhost_net_user" = "yes" && test "$vhost_user" = "no"; then
> -  error_exit "--enable-vhost-net-user requires --enable-vhost-user"
> +  error_exit "--enable-vhost-net requires --enable-vhost-user"
>  fi
>

This change seems wrong.

Paolo

 test "$vhost_crypto" = "" && vhost_crypto=$vhost_user
>  if test "$vhost_crypto" = "yes" && test "$vhost_user" = "no"; then
> --
> 2.28.0.windows.1
>
>

--000000000000e7e39605ae71cee8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">=C2=A0test &quot;$vhost_net_user&quot; =3D &quot;&quot; &amp;&amp; vh=
ost_net_user=3D$vhost_user<br>
=C2=A0if test &quot;$vhost_net_user&quot; =3D &quot;yes&quot; &amp;&amp; te=
st &quot;$vhost_user&quot; =3D &quot;no&quot;; then<br>
-=C2=A0 error_exit &quot;--enable-vhost-net-user requires --enable-vhost-us=
er&quot;<br>
+=C2=A0 error_exit &quot;--enable-vhost-net requires --enable-vhost-user&qu=
ot;<br>
=C2=A0fi<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">This change seems wrong.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cl=
ass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0test &quot;$vhost_crypto&quot; =3D &quot;&quot; &amp;&amp; vhost_cryp=
to=3D$vhost_user<br>
=C2=A0if test &quot;$vhost_crypto&quot; =3D &quot;yes&quot; &amp;&amp; test=
 &quot;$vhost_user&quot; =3D &quot;no&quot;; then<br>
-- <br>
2.28.0.windows.1<br>
<br>
</blockquote></div></div></div>

--000000000000e7e39605ae71cee8--


