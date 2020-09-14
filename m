Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF09C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA22C2192A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNhGfl6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA22C2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHjoQ-0005YD-Ty
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHjhv-0006oG-3C; Mon, 14 Sep 2020 04:19:27 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:37503)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kHjhs-0001EY-Gs; Mon, 14 Sep 2020 04:19:26 -0400
Received: by mail-lj1-x242.google.com with SMTP id n25so17845878ljj.4;
 Mon, 14 Sep 2020 01:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=2idPZSzmbFPEhVtb5XvxCEwyWC8kLOm9nmIVZu8BppU=;
 b=DNhGfl6c9mZQ3IRJh0LA4d4A3zEbQ33bBF5ga/KQpZJs9JwfQsNBRHr4/ts80Oajsz
 F7OwANMi7BEjyYmlM4KNCSxTnnNjQmjEv6EApuTrOqrCHO5pfUJIMnDpqeupxc5KQ3np
 lFEmMXz4GKBAMtkftUGiIc1jXwOUl5nTjwBcdRJCRq8/si30lNMqK5689aaCupaPq8Yw
 4B669IoamO9qFGo0bFtyOY+pJJx8bfUYnr07CKqL6y64oO4jS3pr8cUjwNpp4hR14byL
 t7FwG0LTNqx40rpi2oCINfbrT5dDMjW94gehHDwvp/lL7TQTwIAWG/8jzp9SNTN1Flhx
 9o4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=2idPZSzmbFPEhVtb5XvxCEwyWC8kLOm9nmIVZu8BppU=;
 b=sOu5rWnX8KhlMwwkZu7T08AACVY3PqY3IWVIfulsZRWdfPMujmA4R0BLvj8t5CTAqs
 pDUUiObZm+f2RXUxLa/Nxgh5w3VkVZEzV3aIcH/ghWvobECYDa2gnue+vxK43TMz+KiO
 xjXWfOEBcT1Kv4rJ9DVQIe3zAlZu7bLsYtdGktGfOm+KtCI2lIv7V8Otg4gq+YFfj1E5
 TkXIGeMRCBC3EDN4r7ke9W1o6tW/z+FpinD1mswOm1Su93zvBjouzxHFksrdz7F6SjXa
 TCQaetTlUVha3iTmJutn3EguupcE61SeaZVpnuTtxjzSrcPduatL17iMSqGy5XJs6Uxj
 2IqQ==
X-Gm-Message-State: AOAM530SDqH+hqL+xLa5irLgkb4fRWlSSDj5jzIJ/7/KQ6NQ7Jw1fUYH
 JH5G958OUCK42eJFxfuaYNtC1d0anvhxz/HbYlQ=
X-Google-Smtp-Source: ABdhPJwYJQkfywFGYRWebw10gYCyBW2qricwmTnJ4mdrtAD2Sr+t2uEgrk8xFRVrw07rmGrM0hYLFkvInWkbNjmGsp8=
X-Received: by 2002:a2e:86d3:: with SMTP id n19mr5057501ljj.368.1600071562182; 
 Mon, 14 Sep 2020 01:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200912224431.1428-1-luoyonggang@gmail.com>
 <20200912224431.1428-14-luoyonggang@gmail.com>
 <119be52f-fc8b-dd37-e3d6-04a13109c845@redhat.com>
In-Reply-To: <119be52f-fc8b-dd37-e3d6-04a13109c845@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 14 Sep 2020 16:19:12 +0800
Message-ID: <CAE2XoE-Qi1aZhq09QEswq-NFYRYWV+ZM4YZz=pGCynMd5Ova8Q@mail.gmail.com>
Subject: Re: [PATCH v8 13/27] tests: Enable crypto tests under msys2/mingw
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001445cb05af41b180"
Received-SPF: pass client-ip=2a00:1450:4864:20::242;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x242.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Qemu-block <qemu-block@nongnu.org>,
 Stefan Weil <sw@weilnetz.de>, Xie Changlong <xiechanglong.d@gmail.com>,
 Peter Lieven <pl@kamp.de>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001445cb05af41b180
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 3:23 PM Thomas Huth <thuth@redhat.com> wrote:
>
> On 13/09/2020 00.44, Yonggang Luo wrote:
> > Fixes following tests on msys2/mingw
> >       'test-crypto-tlscredsx509': ['crypto-tls-x509-helpers.c',
'pkix_asn1_tab.c',
> >                                    tasn1, crypto],
> >       'test-crypto-tlssession': ['crypto-tls-x509-helpers.c',
'pkix_asn1_tab.c', 'crypto-tls-psk-helpers.c',
> >                                  tasn1, crypto],
> >       'test-io-channel-tls': ['io-channel-helpers.c',
'crypto-tls-x509-helpers.c', 'pkix_asn1_tab.c',
> >                               tasn1, io, crypto]}
> > These tests are failure with:
> > ERROR test-crypto-tlscredsx509 - missing test plan
> > ERROR test-crypto-tlssession - missing test plan
> > ERROR test-io-channel-tls - missing test plan
> >
> > Because on win32 those test case are all disabled in the header
> >
> > Add qemu_socket_pair for cross platform support, convert file system
> > handling functions to glib
> > Add qemu_link function instead posix only link function.
> > Use send ad recv from qemu that convert Windows Socks error
> > to errno properly.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> [...]
> > +static int __stream_socketpair(struct addrinfo* addr_info, int
sock[2]){
> > +    SOCKET listener, client, server;
> > +    int opt =3D 1;
> > +
> > +    listener =3D server =3D client =3D INVALID_SOCKET;
> > +    listener =3D socket(addr_info->ai_family, addr_info->ai_socktype,
addr_info->ai_protocol);
> > +    if (INVALID_SOCKET =3D=3D listener)
> > +        goto fail;
> > +
> > +    setsockopt(listener, SOL_SOCKET, SO_REUSEADDR,(const char*)&opt,
sizeof(opt));
> > +
> > +    if(SOCKET_ERROR =3D=3D bind(listener, addr_info->ai_addr,
addr_info->ai_addrlen))
> > +        goto fail;
> > +
> > +    if (SOCKET_ERROR =3D=3D getsockname(listener, addr_info->ai_addr,
(int*)&addr_info->ai_addrlen))
> > +        goto fail;
> > +
> > +    if(SOCKET_ERROR =3D=3D listen(listener, 5))
> > +        goto fail;
> > +
> > +    client =3D socket(addr_info->ai_family, addr_info->ai_socktype,
addr_info->ai_protocol);
> > +
> > +    if (INVALID_SOCKET =3D=3D client)
> > +        goto fail;
> > +
> > +    if (SOCKET_ERROR =3D=3D
connect(client,addr_info->ai_addr,addr_info->ai_addrlen))
> > +        goto fail;
> > +
> > +    server =3D accept(listener, 0, 0);
> > +
> > +    if (INVALID_SOCKET =3D=3D server)
> > +        goto fail;
> > +
> > +    closesocket(listener);
> > +
> > +    sock[0] =3D client;
> > +    sock[1] =3D server;
> > +
> > +    return 0;
> > +fail:
> > +    if(INVALID_SOCKET!=3Dlistener)
> > +        closesocket(listener);
> > +    if (INVALID_SOCKET!=3Dclient)
> > +        closesocket(client);
> > +    return -1;
> > +}
> > +
> > +static int __dgram_socketpair(struct addrinfo* addr_info, int sock[2])
> > +{
> > +    SOCKET client, server;
> > +    struct addrinfo addr, *result =3D NULL;
> > +    const char* address;
> > +    int opt =3D 1;
> > +
> > +    server =3D client =3D INVALID_SOCKET;
> > +
> > +    server =3D socket(addr_info->ai_family, addr_info->ai_socktype,
addr_info->ai_protocol);
> > +    if (INVALID_SOCKET =3D=3D server)
> > +        goto fail;
> > +
> > +    setsockopt(server, SOL_SOCKET,SO_REUSEADDR, (const char*)&opt,
sizeof(opt));
> > +
> > +    if(SOCKET_ERROR =3D=3D bind(server, addr_info->ai_addr,
addr_info->ai_addrlen))
> > +        goto fail;
> > +
> > +    if (SOCKET_ERROR =3D=3D getsockname(server, addr_info->ai_addr,
(int*)&addr_info->ai_addrlen))
> > +        goto fail;
> > +
> > +    client =3D socket(addr_info->ai_family, addr_info->ai_socktype,
addr_info->ai_protocol);
> > +    if (INVALID_SOCKET =3D=3D client)
> > +        goto fail;
> > +
> > +    memset(&addr,0,sizeof(addr));
> > +    addr.ai_family =3D addr_info->ai_family;
> > +    addr.ai_socktype =3D addr_info->ai_socktype;
> > +    addr.ai_protocol =3D addr_info->ai_protocol;
> > +
> > +    if (AF_INET6=3D=3Daddr.ai_family)
> > +        address =3D "0:0:0:0:0:0:0:1";
> > +    else
> > +        address =3D "127.0.0.1";
> > +
> > +    if (getaddrinfo(address, "0", &addr, &result))
> > +        goto fail;
> > +
> > +    setsockopt(client,SOL_SOCKET,SO_REUSEADDR,(const char*)&opt,
sizeof(opt));
> > +    if(SOCKET_ERROR =3D=3D bind(client, result->ai_addr,
result->ai_addrlen))
> > +        goto fail;
> > +
> > +    if (SOCKET_ERROR =3D=3D getsockname(client, result->ai_addr,
(int*)&result->ai_addrlen))
> > +        goto fail;
> > +
> > +    if (SOCKET_ERROR =3D=3D connect(server, result->ai_addr,
result->ai_addrlen))
> > +        goto fail;
> > +
> > +    if (SOCKET_ERROR =3D=3D connect(client, addr_info->ai_addr,
addr_info->ai_addrlen))
> > +        goto fail;
> > +
> > +    freeaddrinfo(result);
> > +    sock[0] =3D client;
> > +    sock[1] =3D server;
> > +    return 0;
> > +
> > +fail:
> > +    if (INVALID_SOCKET!=3Dclient)
> > +        closesocket(client);
> > +    if (INVALID_SOCKET!=3Dserver)
> > +        closesocket(server);
> > +    if (result)
> > +        freeaddrinfo(result);
> > +    return -1;
> > +}
> > +
> > +int qemu_socketpair(int family, int type, int protocol,int recv[2]){
> > +    const char* address;
> > +    struct addrinfo addr_info,*p_addrinfo;
> > +    int result =3D -1;
> > +
> > +    if (family =3D=3D AF_UNIX)
> > +    {
> > +        family =3D AF_INET;
> > +    }
> > +
> > +    memset(&addr_info, 0, sizeof(addr_info));
> > +    addr_info.ai_family =3D family;
> > +    addr_info.ai_socktype =3D type;
> > +    addr_info.ai_protocol =3D protocol;
> > +    if (AF_INET6=3D=3Dfamily)
> > +        address =3D "0:0:0:0:0:0:0:1";
> > +    else
> > +        address =3D "127.0.0.1";
> > +
> > +    if (0 =3D=3D getaddrinfo(address, "0", &addr_info, &p_addrinfo)){
> > +        if (SOCK_STREAM =3D=3D type)
> > +            result =3D __stream_socketpair(p_addrinfo, recv);
> > +        else if(SOCK_DGRAM =3D=3D type)
> > +            result =3D __dgram_socketpair(p_addrinfo, recv);
> > +        freeaddrinfo(p_addrinfo);
> > +    }
> > +    return result;
> > +}
>
> Where do you've got this code from? It seems like this has been taken
> from a 3rd party source? E.g.:
>
>  https://blog.csdn.net/wufuhuai/article/details/79761889
>
> What's the license of this new code? ... please clarify such details in
The original code have no license information, neither copyleft nor
copyright, what's your suggestion
or rewrite it?

>
> the commit description.
>
>  Thanks,
>   Thomas
>


--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000001445cb05af41b180
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Mon, Sep 14, 2020 at 3:23 PM Thomas Huth &lt;<a=
 href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br>&gt;<b=
r>&gt; On 13/09/2020 00.44, Yonggang Luo wrote:<br>&gt; &gt; Fixes followin=
g tests on msys2/mingw<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 &#39;test-crypto-t=
lscredsx509&#39;: [&#39;crypto-tls-x509-helpers.c&#39;, &#39;pkix_asn1_tab.=
c&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ta=
sn1, crypto],<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 &#39;test-crypto-tlssession=
&#39;: [&#39;crypto-tls-x509-helpers.c&#39;, &#39;pkix_asn1_tab.c&#39;, &#3=
9;crypto-tls-psk-helpers.c&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0tasn1, crypto],<br>&gt; &gt; =C2=A0 =C2=A0 =C2=A0 &#39;tes=
t-io-channel-tls&#39;: [&#39;io-channel-helpers.c&#39;, &#39;crypto-tls-x50=
9-helpers.c&#39;, &#39;pkix_asn1_tab.c&#39;,<br>&gt; &gt; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 tasn1, io, crypto]}<br>&gt; &gt; These tests are failure with=
:<br>&gt; &gt; ERROR test-crypto-tlscredsx509 - missing test plan<br>&gt; &=
gt; ERROR test-crypto-tlssession - missing test plan<br>&gt; &gt; ERROR tes=
t-io-channel-tls - missing test plan<br>&gt; &gt;<br>&gt; &gt; Because on w=
in32 those test case are all disabled in the header<br>&gt; &gt;<br>&gt; &g=
t; Add qemu_socket_pair for cross platform support, convert file system<br>=
&gt; &gt; handling functions to glib<br>&gt; &gt; Add qemu_link function in=
stead posix only link function.<br>&gt; &gt; Use send ad recv from qemu tha=
t convert Windows Socks error<br>&gt; &gt; to errno properly.<br>&gt; &gt;<=
br>&gt; &gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@=
gmail.com">luoyonggang@gmail.com</a>&gt;<br>&gt; &gt; ---<br>&gt; [...]<br>=
&gt; &gt; +static int __stream_socketpair(struct addrinfo* addr_info, int s=
ock[2]){<br>&gt; &gt; + =C2=A0 =C2=A0SOCKET listener, client, server;<br>&g=
t; &gt; + =C2=A0 =C2=A0int opt =3D 1;<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =
=C2=A0listener =3D server =3D client =3D INVALID_SOCKET;<br>&gt; &gt; + =C2=
=A0 =C2=A0listener =3D socket(addr_info-&gt;ai_family, addr_info-&gt;ai_soc=
ktype, addr_info-&gt;ai_protocol);<br>&gt; &gt; + =C2=A0 =C2=A0if (INVALID_=
SOCKET =3D=3D listener)<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail=
;<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0setsockopt(listener, SOL_SOCKE=
T, SO_REUSEADDR,(const char*)&amp;opt, sizeof(opt));<br>&gt; &gt; +<br>&gt;=
 &gt; + =C2=A0 =C2=A0if(SOCKET_ERROR =3D=3D bind(listener, addr_info-&gt;ai=
_addr, addr_info-&gt;ai_addrlen))<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto fail;<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0if (SOCKET_ERROR =
=3D=3D getsockname(listener, addr_info-&gt;ai_addr, (int*)&amp;addr_info-&g=
t;ai_addrlen))<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>&gt;=
 &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0if(SOCKET_ERROR =3D=3D listen(listener,=
 5))<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>&gt; &gt; +<br=
>&gt; &gt; + =C2=A0 =C2=A0client =3D socket(addr_info-&gt;ai_family, addr_i=
nfo-&gt;ai_socktype, addr_info-&gt;ai_protocol);<br>&gt; &gt; +<br>&gt; &gt=
; + =C2=A0 =C2=A0if (INVALID_SOCKET =3D=3D client)<br>&gt; &gt; + =C2=A0 =
=C2=A0 =C2=A0 =C2=A0goto fail;<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0i=
f (SOCKET_ERROR =3D=3D connect(client,addr_info-&gt;ai_addr,addr_info-&gt;a=
i_addrlen))<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>&gt; &g=
t; +<br>&gt; &gt; + =C2=A0 =C2=A0server =3D accept(listener, 0, 0);<br>&gt;=
 &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0if (INVALID_SOCKET =3D=3D server)<br>&g=
t; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>&gt; &gt; +<br>&gt; &gt;=
 + =C2=A0 =C2=A0closesocket(listener);<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0=
 =C2=A0sock[0] =3D client;<br>&gt; &gt; + =C2=A0 =C2=A0sock[1] =3D server;<=
br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0return 0;<br>&gt; &gt; +fail:<br=
>&gt; &gt; + =C2=A0 =C2=A0if(INVALID_SOCKET!=3Dlistener)<br>&gt; &gt; + =C2=
=A0 =C2=A0 =C2=A0 =C2=A0closesocket(listener);<br>&gt; &gt; + =C2=A0 =C2=A0=
if (INVALID_SOCKET!=3Dclient)<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0clo=
sesocket(client);<br>&gt; &gt; + =C2=A0 =C2=A0return -1;<br>&gt; &gt; +}<br=
>&gt; &gt; +<br>&gt; &gt; +static int __dgram_socketpair(struct addrinfo* a=
ddr_info, int sock[2])<br>&gt; &gt; +{<br>&gt; &gt; + =C2=A0 =C2=A0SOCKET c=
lient, server;<br>&gt; &gt; + =C2=A0 =C2=A0struct addrinfo addr, *result =
=3D NULL;<br>&gt; &gt; + =C2=A0 =C2=A0const char* address;<br>&gt; &gt; + =
=C2=A0 =C2=A0int opt =3D 1;<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0serv=
er =3D client =3D INVALID_SOCKET;<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=
=A0server =3D socket(addr_info-&gt;ai_family, addr_info-&gt;ai_socktype, ad=
dr_info-&gt;ai_protocol); <br>&gt; &gt; + =C2=A0 =C2=A0if (INVALID_SOCKET =
=3D=3D server)<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>&gt;=
 &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0setsockopt(server, SOL_SOCKET,SO_REUSEA=
DDR, (const char*)&amp;opt, sizeof(opt));<br>&gt; &gt; +<br>&gt; &gt; + =C2=
=A0 =C2=A0if(SOCKET_ERROR =3D=3D bind(server, addr_info-&gt;ai_addr, addr_i=
nfo-&gt;ai_addrlen))<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<b=
r>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0if (SOCKET_ERROR =3D=3D getsockna=
me(server, addr_info-&gt;ai_addr, (int*)&amp;addr_info-&gt;ai_addrlen))<br>=
&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>&gt; &gt; +<br>&gt; &g=
t; + =C2=A0 =C2=A0client =3D socket(addr_info-&gt;ai_family, addr_info-&gt;=
ai_socktype, addr_info-&gt;ai_protocol);<br>&gt; &gt; + =C2=A0 =C2=A0if (IN=
VALID_SOCKET =3D=3D client)<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto =
fail;<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0memset(&amp;addr,0,sizeof(=
addr));<br>&gt; &gt; + =C2=A0 =C2=A0addr.ai_family =3D addr_info-&gt;ai_fam=
ily;<br>&gt; &gt; + =C2=A0 =C2=A0addr.ai_socktype =3D addr_info-&gt;ai_sock=
type;<br>&gt; &gt; + =C2=A0 =C2=A0addr.ai_protocol =3D addr_info-&gt;ai_pro=
tocol;<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0if (AF_INET6=3D=3Daddr.ai=
_family)<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0address =3D &quot;0:0:0:=
0:0:0:0:1&quot;;<br>&gt; &gt; + =C2=A0 =C2=A0else<br>&gt; &gt; + =C2=A0 =C2=
=A0 =C2=A0 =C2=A0address =3D &quot;127.0.0.1&quot;;<br>&gt; &gt; +<br>&gt; =
&gt; + =C2=A0 =C2=A0if (getaddrinfo(address, &quot;0&quot;, &amp;addr, &amp=
;result))<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>&gt; &gt;=
 +<br>&gt; &gt; + =C2=A0 =C2=A0setsockopt(client,SOL_SOCKET,SO_REUSEADDR,(c=
onst char*)&amp;opt, sizeof(opt));<br>&gt; &gt; + =C2=A0 =C2=A0if(SOCKET_ER=
ROR =3D=3D bind(client, result-&gt;ai_addr, result-&gt;ai_addrlen))<br>&gt;=
 &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>&gt; &gt; +<br>&gt; &gt; +=
 =C2=A0 =C2=A0if (SOCKET_ERROR =3D=3D getsockname(client, result-&gt;ai_add=
r, (int*)&amp;result-&gt;ai_addrlen))<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0goto fail;<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0if (SOCKET_ERRO=
R =3D=3D connect(server, result-&gt;ai_addr, result-&gt;ai_addrlen))<br>&gt=
; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>&gt; &gt; +<br>&gt; &gt; =
+ =C2=A0 =C2=A0if (SOCKET_ERROR =3D=3D connect(client, addr_info-&gt;ai_add=
r, addr_info-&gt;ai_addrlen))<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0got=
o fail;<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0freeaddrinfo(result);<br=
>&gt; &gt; + =C2=A0 =C2=A0sock[0] =3D client;<br>&gt; &gt; + =C2=A0 =C2=A0s=
ock[1] =3D server;<br>&gt; &gt; + =C2=A0 =C2=A0return 0;<br>&gt; &gt; +<br>=
&gt; &gt; +fail:<br>&gt; &gt; + =C2=A0 =C2=A0if (INVALID_SOCKET!=3Dclient)<=
br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0closesocket(client);<br>&gt; &gt;=
 + =C2=A0 =C2=A0if (INVALID_SOCKET!=3Dserver)<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0closesocket(server);<br>&gt; &gt; + =C2=A0 =C2=A0if (result)<b=
r>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0freeaddrinfo(result);<br>&gt; &gt;=
 + =C2=A0 =C2=A0return -1;<br>&gt; &gt; +}<br>&gt; &gt; +<br>&gt; &gt; +int=
 qemu_socketpair(int family, int type, int protocol,int recv[2]){<br>&gt; &=
gt; + =C2=A0 =C2=A0const char* address;<br>&gt; &gt; + =C2=A0 =C2=A0struct =
addrinfo addr_info,*p_addrinfo;<br>&gt; &gt; + =C2=A0 =C2=A0int result =3D =
-1;<br>&gt; &gt; +<br>&gt; &gt; + =C2=A0 =C2=A0if (family =3D=3D AF_UNIX)<b=
r>&gt; &gt; + =C2=A0 =C2=A0{<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0fami=
ly =3D AF_INET;<br>&gt; &gt; + =C2=A0 =C2=A0}<br>&gt; &gt; +<br>&gt; &gt; +=
 =C2=A0 =C2=A0memset(&amp;addr_info, 0, sizeof(addr_info));<br>&gt; &gt; + =
=C2=A0 =C2=A0addr_info.ai_family =3D family;<br>&gt; &gt; + =C2=A0 =C2=A0ad=
dr_info.ai_socktype =3D type;<br>&gt; &gt; + =C2=A0 =C2=A0addr_info.ai_prot=
ocol =3D protocol;<br>&gt; &gt; + =C2=A0 =C2=A0if (AF_INET6=3D=3Dfamily)<br=
>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0address =3D &quot;0:0:0:0:0:0:0:1&q=
uot;;<br>&gt; &gt; + =C2=A0 =C2=A0else<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =
=C2=A0address =3D &quot;127.0.0.1&quot;;<br>&gt; &gt; +<br>&gt; &gt; + =C2=
=A0 =C2=A0if (0 =3D=3D getaddrinfo(address, &quot;0&quot;, &amp;addr_info, =
&amp;p_addrinfo)){<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0if (SOCK_STREA=
M =3D=3D type)<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resu=
lt =3D __stream_socketpair(p_addrinfo, recv);<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0else if(SOCK_DGRAM =3D=3D type)<br>&gt; &gt; + =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D __dgram_socketpair(p_addrinfo, recv);=
<br>&gt; &gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0freeaddrinfo(p_addrinfo);<br>&gt=
; &gt; + =C2=A0 =C2=A0}<br>&gt; &gt; + =C2=A0 =C2=A0return result;<br>&gt; =
&gt; +}<br>&gt;<br>&gt; Where do you&#39;ve got this code from? It seems li=
ke this has been taken<br>&gt; from a 3rd party source? E.g.:<br>&gt;<br>&g=
t; =C2=A0<a href=3D"https://blog.csdn.net/wufuhuai/article/details/79761889=
">https://blog.csdn.net/wufuhuai/article/details/79761889</a><br>&gt;<br>&g=
t; What&#39;s the license of this new code? ... please clarify such details=
 in<br>The original code have no license information, neither copyleft nor =
copyright, what&#39;s your suggestion<div>or rewrite it?<br>=C2=A0<br>&gt;<=
br>&gt; the commit description.<br>&gt;<br>&gt; =C2=A0Thanks,<br>&gt; =C2=
=A0 Thomas<br>&gt;<br><br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=
=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=
=A0 =C2=A0 sincerely,<br>Yonggang Luo</div></div>

--0000000000001445cb05af41b180--

