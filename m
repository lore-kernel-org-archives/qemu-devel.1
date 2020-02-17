Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE30DC35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:06:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A1220679
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 10:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ve/8sB2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A1220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3dIa-0004oY-M6
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 05:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <falhumai96@gmail.com>) id 1j3dHr-0003xc-Ht
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:06:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <falhumai96@gmail.com>) id 1j3dHp-0002hL-SW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:05:59 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536]:42862)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <falhumai96@gmail.com>)
 id 1j3dHp-0002gD-J1
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 05:05:57 -0500
Received: by mail-ed1-x536.google.com with SMTP id e10so19962298edv.9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 02:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mk70QBx+BdykuhPhlerSEclVckmmCZShCXzhSyz/GZA=;
 b=ve/8sB2c72PzisDm25ctrTDXUZNqGEwu8in/hqE9Nkl6K/GIFlZ+ZPZFhQ7ijInNPu
 6YTrhaj3vRhMRp46O3Z0tgpd1LLs8c4At8bKSjNtnn0bM/zSl6E5GFpdvyVcgEMeW4K9
 9+G2yozR7VSSAj1BZ6unSQvBI+lekbnY71qNQ0vpKY5uq2jZ/uj4KFwXBzwnwfaYnNWT
 hsxo0QW5+ijD8r88PHlokymaIisTqMsKeTIpnlg9ks1ITMCSlDxISp9mTFqWVFjt78hT
 3FT2TpYPDlqzUvrmAJEmMA/LhhceHjSr/hH1K+9NnECa3qSc7jnFGjy1SfLV7jaoK54M
 9dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mk70QBx+BdykuhPhlerSEclVckmmCZShCXzhSyz/GZA=;
 b=qa99bCndrMbB8chNgEtKyLEMTobbfHbMR30Xy05eDj0vzUNP8hKRA8haovOTWN3mh9
 a75tknSxZkmeiNZvrH3ZwcQRuT9Kqo6SzJq/jcQXgpLsphmK0juOuXkObxDs03nKusqP
 5GWmNhJxGvuim0BcpFiQrMvIfvX76kQQ/IH8J5Qy5fFWFPs429UcEFAVke9TS/w8a+Nr
 WBiLuNM4WBIVSE2iCYfkjjN/LcMDdfjWkhN47P1dLPOxEal508ESOowtX+RrH1qW/t4t
 xfVYcIHaGYWADvsdBDKEWF1TP96CjTdg/i8aISO5s+9Pfws/Fzhm649J70VccgTsZcoc
 b+1g==
X-Gm-Message-State: APjAAAUfTA6uQndWW6j+tT3s8M9Sy4QL+ul7lMPoSiNwFt1t0ypSH70G
 MJkSiPuo+qlm6pfDwXIDfbD1Wp/5zf93jsAM95g=
X-Google-Smtp-Source: APXvYqwVCbK9JNvfevtWv/fmXOWEj8lXd6mBbdEVr6hAm9YUCniLbqc0oR5I1QTCamWZUdZTcOB5SZsXtQGLzv1pOb0=
X-Received: by 2002:a05:6402:1a41:: with SMTP id
 bf1mr13801444edb.150.1581933956041; 
 Mon, 17 Feb 2020 02:05:56 -0800 (PST)
MIME-Version: 1.0
References: <CAMx8kb2aJ2OOHx6GG9qmXOoSXdQrzQ9+fsK=JR7pM-bJA4QOzg@mail.gmail.com>
 <87mu9knnhn.fsf@dusky.pond.sub.org>
 <968ea798-aedc-7bb3-e2ed-ee8fe9c0aeab@redhat.com>
In-Reply-To: <968ea798-aedc-7bb3-e2ed-ee8fe9c0aeab@redhat.com>
From: Faisal Al-Humaimidi <falhumai96@gmail.com>
Date: Mon, 17 Feb 2020 02:05:45 -0800
Message-ID: <CAMx8kb2jHAGngXuR_WmGtpP0mtQUkWxMWmP7TD=nbMnnKCY_wA@mail.gmail.com>
Subject: Re: QEMU Sockets Networking Backend Multicast Networking Fix
To: Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000082104f059ec2b3c9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::536
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
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000082104f059ec2b3c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jason,

But, the local address is not meant to be added to the group, rather we
listen to it, hence we bind to the local address. The multicast group is a
higher layer that would be requested to join to by the listening host.
Here's a similar example in multicasting that demonstrates this idea in
Python: https://pymotw.com/2/socket/multicast.html.


Regards,
Faisal Al-Humaimidi

On Mon., Feb. 17, 2020, 1:54 a.m. Jason Wang, <jasowang@redhat.com> wrote:

>
> On 2020/2/15 =E4=B8=8B=E5=8D=886:39, Markus Armbruster wrote:
> > Jason, please have a look.
> >
> > Faisal Al-Humaimidi <falhumai96@gmail.com> writes:
> >
> >> Hello QEMU developers,
> >>
> >> I have noticed a bug in the `mcast` option of the `socket` networking
> >> backend, where I simply cannot join a multicast group (tested in
> Windows 10
> >> with QEMU 4.2.0 release). I have found a fix to the problem. The probl=
em
> >> was mainly due to the fact that QEMU was binding to the multicast
> address,
> >> and not the local address or the default INADDR_ANY (0.0.0.0) if no
> local
> >> address is used.
> >>
> >> Here's the patch text (as well as attached with this email), that
> outlines
> >> my fix:
> >>
> >> ```
> >> diff -uarN qemu-4.2.0.original/net/socket.c
> qemu-4.2.0.modified/net/socket.c
> >> --- qemu-4.2.0.original/net/socket.c 2019-12-12 10:20:48.000000000 -08=
00
> >> +++ qemu-4.2.0.modified/net/socket.c 2020-02-14 10:30:16.395973453 -08=
00
> >> @@ -253,6 +253,15 @@
> >>           goto fail;
> >>       }
> >>
> >> +    /* Preserve the multicast address, and bind to a non-multicast
> group
> >> (e.g. a
> >> +     * local address).
> >> +     */
> >> +    struct in_addr group_addr =3D mcastaddr->sin_addr;
> >> +    if (localaddr) {
> >> +        mcastaddr->sin_addr =3D *localaddr;
> >> +    } else {
> >> +        mcastaddr->sin_addr.s_addr =3D htonl(INADDR_ANY);
> >> +    }
> >>       ret =3D bind(fd, (struct sockaddr *)mcastaddr, sizeof(*mcastaddr=
));
>
>
> This looks wrong, AFAIK the local address should be added through
> IP_ADD_MEMBERSHIP which is already handled in this function I believe.
>
> Thanks
>
>
> >>       if (ret < 0) {
> >>           error_setg_errno(errp, errno, "can't bind ip=3D%s to socket"=
,
> >> @@ -260,7 +269,10 @@
> >>           goto fail;
> >>       }
> >>
> >> -    /* Add host to multicast group */
> >> +    /* Restore the multicast address. */
> >> +    mcastaddr->sin_addr =3D group_addr;
> >> +
> >> +    /* Add host to multicast group. */
> >>       imr.imr_multiaddr =3D mcastaddr->sin_addr;
> >>       if (localaddr) {
> >>           imr.imr_interface =3D *localaddr;
> >> @@ -277,7 +289,7 @@
> >>           goto fail;
> >>       }
> >>
> >> -    /* Force mcast msgs to loopback (eg. several QEMUs in same host *=
/
> >> +    /* Force mcast msgs to loopback (eg. several QEMUs in same host).
> */
> >>       loop =3D 1;
> >>       ret =3D qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_LOOP,
> >>                             &loop, sizeof(loop));
> >> @@ -287,7 +299,7 @@
> >>           goto fail;
> >>       }
> >>
> >> -    /* If a bind address is given, only send packets from that addres=
s
> */
> >> +    /* If a bind address is given, only send packets from that
> address. */
> >>       if (localaddr !=3D NULL) {
> >>           ret =3D qemu_setsockopt(fd, IPPROTO_IP, IP_MULTICAST_IF,
> >>                                 localaddr, sizeof(*localaddr));
> >> ```
> >>
> >> Regards,
> >> Faisal Al-Humaimidi
> >
>
>

--00000000000082104f059ec2b3c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Hello Jason,</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">But, the local address is not meant to be added to the group, r=
ather we listen to it, hence we bind to the local address. The multicast gr=
oup is a higher layer that would be requested to join to by the listening h=
ost. Here&#39;s a similar example in multicasting that demonstrates this id=
ea in Python:=C2=A0<a href=3D"https://pymotw.com/2/socket/multicast.html">h=
ttps://pymotw.com/2/socket/multicast.html</a>.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards,</div><div dir=
=3D"auto">Faisal Al-Humaimidi<br><br><div class=3D"gmail_quote" dir=3D"auto=
"><div dir=3D"ltr" class=3D"gmail_attr">On Mon., Feb. 17, 2020, 1:54 a.m. J=
ason Wang, &lt;<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
On 2020/2/15 =E4=B8=8B=E5=8D=886:39, Markus Armbruster wrote:<br>
&gt; Jason, please have a look.<br>
&gt;<br>
&gt; Faisal Al-Humaimidi &lt;<a href=3D"mailto:falhumai96@gmail.com" target=
=3D"_blank" rel=3D"noreferrer">falhumai96@gmail.com</a>&gt; writes:<br>
&gt;<br>
&gt;&gt; Hello QEMU developers,<br>
&gt;&gt;<br>
&gt;&gt; I have noticed a bug in the `mcast` option of the `socket` network=
ing<br>
&gt;&gt; backend, where I simply cannot join a multicast group (tested in W=
indows 10<br>
&gt;&gt; with QEMU 4.2.0 release). I have found a fix to the problem. The p=
roblem<br>
&gt;&gt; was mainly due to the fact that QEMU was binding to the multicast =
address,<br>
&gt;&gt; and not the local address or the default INADDR_ANY (0.0.0.0) if n=
o local<br>
&gt;&gt; address is used.<br>
&gt;&gt;<br>
&gt;&gt; Here&#39;s the patch text (as well as attached with this email), t=
hat outlines<br>
&gt;&gt; my fix:<br>
&gt;&gt;<br>
&gt;&gt; ```<br>
&gt;&gt; diff -uarN qemu-4.2.0.original/net/socket.c qemu-4.2.0.modified/ne=
t/socket.c<br>
&gt;&gt; --- qemu-4.2.0.original/net/socket.c 2019-12-12 10:20:48.000000000=
 -0800<br>
&gt;&gt; +++ qemu-4.2.0.modified/net/socket.c 2020-02-14 10:30:16.395973453=
 -0800<br>
&gt;&gt; @@ -253,6 +253,15 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 /* Preserve the multicast address, and bind to a no=
n-multicast group<br>
&gt;&gt; (e.g. a<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0* local address).<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0*/<br>
&gt;&gt; +=C2=A0 =C2=A0 struct in_addr group_addr =3D mcastaddr-&gt;sin_add=
r;<br>
&gt;&gt; +=C2=A0 =C2=A0 if (localaddr) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mcastaddr-&gt;sin_addr =3D *localaddr=
;<br>
&gt;&gt; +=C2=A0 =C2=A0 } else {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mcastaddr-&gt;sin_addr.s_addr =3D hto=
nl(INADDR_ANY);<br>
&gt;&gt; +=C2=A0 =C2=A0 }<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bind(fd, (struct sockaddr *)mcas=
taddr, sizeof(*mcastaddr));<br>
<br>
<br>
This looks wrong, AFAIK the local address should be added through <br>
IP_ADD_MEMBERSHIP which is already handled in this function I believe.<br>
<br>
Thanks<br>
<br>
<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret &lt; 0) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0error_setg_errno(errp, err=
no, &quot;can&#39;t bind ip=3D%s to socket&quot;,<br>
&gt;&gt; @@ -260,7 +269,10 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 /* Add host to multicast group */<br>
&gt;&gt; +=C2=A0 =C2=A0 /* Restore the multicast address. */<br>
&gt;&gt; +=C2=A0 =C2=A0 mcastaddr-&gt;sin_addr =3D group_addr;<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 /* Add host to multicast group. */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0imr.imr_multiaddr =3D mcastaddr-&gt;sin_=
addr;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (localaddr) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0imr.imr_interface =3D *loc=
aladdr;<br>
&gt;&gt; @@ -277,7 +289,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 /* Force mcast msgs to loopback (eg. several QEMUs =
in same host */<br>
&gt;&gt; +=C2=A0 =C2=A0 /* Force mcast msgs to loopback (eg. several QEMUs =
in same host). */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0loop =3D 1;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D qemu_setsockopt(fd, IPPROTO_IP, =
IP_MULTICAST_LOOP,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;loop, sizeof(loop));<br>
&gt;&gt; @@ -287,7 +299,7 @@<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto fail;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 /* If a bind address is given, only send packets fr=
om that address */<br>
&gt;&gt; +=C2=A0 =C2=A0 /* If a bind address is given, only send packets fr=
om that address. */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (localaddr !=3D NULL) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D qemu_setsockopt(fd=
, IPPROTO_IP, IP_MULTICAST_IF,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0localaddr, sizeof(*loca=
laddr));<br>
&gt;&gt; ```<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Faisal Al-Humaimidi<br>
&gt;<br>
<br>
</blockquote></div></div></div>

--00000000000082104f059ec2b3c9--

