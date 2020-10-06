Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADBBC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3030A20782
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="BRws0E7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3030A20782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPljL-00018h-VF
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kPlh3-0000If-0J
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:03:48 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40514)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kPlgw-0003T4-TK
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:03:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id j2so13154438wrx.7
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0dOfzX32JLtYCpSjl+PAdO0+oMtq0QO59fa82APC2Gc=;
 b=BRws0E7EszWZZkc3qZj0/+U2xSdNtKI7oTTrTdYwc7qh879blvGsgc7w1K9s643pdE
 wNlU4ykJ7I1flqxCMl7pT4j9NA2AeZBG4nB1PoxKh1gTdHtPaL77r/n2v6Wbz8jJ5go7
 3nTjl5MD86MHcKXdqCGhQc165Dy6JVIRQdVbqM+A9DpKlcL9Li3Cz526ZWO4B4eiLVg5
 qTtvChPAcKfBgoDRjku6U1oc5ih3hXIUI0UP62OuBS9AhzOv4Ba+yMBK3C9egqFdCxqC
 oCIT8prhrqYzGqkXNMWLK2AtxXBnoHoENwpgljBDQZHqILsrxfYNN6i1lta6NS9qQHgY
 zQGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0dOfzX32JLtYCpSjl+PAdO0+oMtq0QO59fa82APC2Gc=;
 b=nJuDU7vKU0TkbFaZkS0V1JjldzRRul1/T0cple+M0QPS67EnsQXMnjmOeXMGteJVnk
 0bkNxJVqKRE858u9bUekDqNI5GRE0buTcz7aKLxaMAbiEm55lXyZzEVF8IJLOKUVHEF0
 Ove1rA46ac477obtfrnbk0oLjTw0kXadfBrEw5d82M372FK6Ocwn2SshKuIYpAMowvkG
 m4JyeLGn3D7pRWbtQElzO32hWCt4R0mqg158/bT7JDUbJfu20sgCGydV7gjw85P30kS/
 qjgizeYfSFFxt1Vv5zHjQjW/B3ecqle4LEjC7iR/zCDhur9s8/Hn7vqMBDTKYi0LSXLR
 17kw==
X-Gm-Message-State: AOAM532ucF++Xfxh7CKKFkFqk31ooYAEnG7cpsblDZxjhkaLkFDHeGKC
 pzOy4eOOGl6jOxseF/c8GbRaIAN20WkPi5iwf3C0gQ==
X-Google-Smtp-Source: ABdhPJyVeIUBeQp5SmRbyCIp7fHCLW1GMhqkDj4Qsbi3wzV33y00my/vsqUYTeTvEQ12xdTJYRSqtD6kUGzFSAU+3R4=
X-Received: by 2002:adf:c5d0:: with SMTP id v16mr4509897wrg.76.1601985816730; 
 Tue, 06 Oct 2020 05:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201004180443.2035359-1-f4bug@amsat.org>
 <20201004180443.2035359-10-f4bug@amsat.org>
 <623FB9A5-9A36-4231-BA92-8744A8934B3B@nutanix.com>
In-Reply-To: <623FB9A5-9A36-4231-BA92-8744A8934B3B@nutanix.com>
From: Ani Sinha <ani@anisinha.ca>
Date: Tue, 6 Oct 2020 17:33:25 +0530
Message-ID: <CAARzgwwncKzGZhWjj+Fz0==UfCpoGuBdrq+WcRYwdotHN04Btg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/21] contrib/gitdm: Add Nutanix to the domain map
To: Prerna Saxena <prerna.saxena@nutanix.com>
Content-Type: multipart/alternative; boundary="0000000000008abfc405b0ff63b1"
Received-SPF: none client-ip=2a00:1450:4864:20::442;
 envelope-from=ani@anisinha.ca; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Turschmid <peter.turschm@nutanix.com>,
 Swapnil Ingle <swapnil.ingle@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jonathan Davies <jond@nutanix.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000008abfc405b0ff63b1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2020 at 16:28 Prerna Saxena <prerna.saxena@nutanix.com>
wrote:

>
>
> =EF=BB=BFOn 04/10/20, 11:35 PM, "Philippe Mathieu-Daud=C3=A9" <f4bug@amsa=
t.org> wrote:
>
>     There is a number of contributors from this domain,
>     add its own entry to the gitdm domain map.
>
>     Cc: Ani Sinha <ani.sinha@nutanix.com>
>     Cc: David Vrabel <david.vrabel@nutanix.com>
>     Cc: Felipe Franciosi <felipe@nutanix.com>
>     Cc: Jonathan Davies <jonathan.davies@nutanix.com>
>     Cc: Malcolm Crossley <malcolm@nutanix.com>
>     Cc: Mike Cui <cui@nutanix.com>
>     Cc: Peter Turschmid <peter.turschm@nutanix.com>
>     Cc: Prerna Saxena <prerna.saxena@nutanix.com>
>     Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>
>     Cc: Swapnil Ingle <swapnil.ingle@nutanix.com>
>     Cc: Ani Sinha <ani@anisinha.ca>
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>     ---
>     One Reviewed-by/Ack-by from someone from this domain
>     should be sufficient to get this patch merged.
>
>     Ani, can you confirm the ani@anisinha.ca email?
>     Should it go into 'individual contributors' instead?
>     ---
>      contrib/gitdm/domain-map        | 1 +
>      contrib/gitdm/group-map-nutanix | 2 ++
>      gitdm.config                    | 1 +
>      3 files changed, 4 insertions(+)
>      create mode 100644 contrib/gitdm/group-map-nutanix
>
>     diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
>     index 4850eab4c4..39251fd97c 100644
>     --- a/contrib/gitdm/domain-map
>     +++ b/contrib/gitdm/domain-map
>     @@ -24,6 +24,7 @@ linaro.org      Linaro
>      codesourcery.com Mentor Graphics
>      microsoft.com   Microsoft
>      nokia.com       Nokia
>     +nutanix.com     Nutanix
>      oracle.com      Oracle
>      proxmox.com     Proxmox
>      redhat.com      Red Hat
>     diff --git a/contrib/gitdm/group-map-nutanix
> b/contrib/gitdm/group-map-nutanix
>     new file mode 100644
>     index 0000000000..a3f11425b3
>     --- /dev/null
>     +++ b/contrib/gitdm/group-map-nutanix
>     @@ -0,0 +1,2 @@
>     +raphael.s.norwitz@gmail.com
>     +ani@anisinha.ca
>     diff --git a/gitdm.config b/gitdm.config
>     index c01c219078..4f821ab8ba 100644
>     --- a/gitdm.config
>     +++ b/gitdm.config
>     @@ -37,6 +37,7 @@ GroupMap contrib/gitdm/group-map-cadence Cadence
> Design Systems
>      GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
>      GroupMap contrib/gitdm/group-map-ibm IBM
>      GroupMap contrib/gitdm/group-map-janustech Janus Technologies
>     +GroupMap contrib/gitdm/group-map-nutanix Nutanix
>
>     --
>     2.26.2
>
> LGTM. Raphael is still a part of Nutanix. I see Ani has already responded
> about him not being with the company anymore, so you might want to add hi=
m
> to the individual contributors' list.


Yes thank you. I=E2=80=99ve already mentioned above that I should be added =
to
individual contributors list. Also I don=E2=80=99t think I said Raphael lef=
t
Nutanix.



>

--0000000000008abfc405b0ff63b1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br></div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Oct 6, 2020 at 16:28 Prerna Saxena &lt;<a href=3D"m=
ailto:prerna.saxena@nutanix.com">prerna.saxena@nutanix.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left-width:1px;border-left-style:solid;padding-left:1ex;border-left=
-color:rgb(204,204,204)"><br>
<br>
=EF=BB=BFOn 04/10/20, 11:35 PM, &quot;Philippe Mathieu-Daud=C3=A9&quot; &lt=
;<a href=3D"mailto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&g=
t; wrote:<br>
<br>
=C2=A0 =C2=A0 There is a number of contributors from this domain,<br>
=C2=A0 =C2=A0 add its own entry to the gitdm domain map.<br>
<br>
=C2=A0 =C2=A0 Cc: Ani Sinha &lt;<a href=3D"mailto:ani.sinha@nutanix.com" ta=
rget=3D"_blank">ani.sinha@nutanix.com</a>&gt;<br>
=C2=A0 =C2=A0 Cc: David Vrabel &lt;<a href=3D"mailto:david.vrabel@nutanix.c=
om" target=3D"_blank">david.vrabel@nutanix.com</a>&gt;<br>
=C2=A0 =C2=A0 Cc: Felipe Franciosi &lt;<a href=3D"mailto:felipe@nutanix.com=
" target=3D"_blank">felipe@nutanix.com</a>&gt;<br>
=C2=A0 =C2=A0 Cc: Jonathan Davies &lt;<a href=3D"mailto:jonathan.davies@nut=
anix.com" target=3D"_blank">jonathan.davies@nutanix.com</a>&gt;<br>
=C2=A0 =C2=A0 Cc: Malcolm Crossley &lt;<a href=3D"mailto:malcolm@nutanix.co=
m" target=3D"_blank">malcolm@nutanix.com</a>&gt;<br>
=C2=A0 =C2=A0 Cc: Mike Cui &lt;<a href=3D"mailto:cui@nutanix.com" target=3D=
"_blank">cui@nutanix.com</a>&gt;<br>
=C2=A0 =C2=A0 Cc: Peter Turschmid &lt;<a href=3D"mailto:peter.turschm@nutan=
ix.com" target=3D"_blank">peter.turschm@nutanix.com</a>&gt;<br>
=C2=A0 =C2=A0 Cc: Prerna Saxena &lt;<a href=3D"mailto:prerna.saxena@nutanix=
.com" target=3D"_blank">prerna.saxena@nutanix.com</a>&gt;<br>
=C2=A0 =C2=A0 Cc: Raphael Norwitz &lt;<a href=3D"mailto:raphael.norwitz@nut=
anix.com" target=3D"_blank">raphael.norwitz@nutanix.com</a>&gt;<br>
=C2=A0 =C2=A0 Cc: Swapnil Ingle &lt;<a href=3D"mailto:swapnil.ingle@nutanix=
.com" target=3D"_blank">swapnil.ingle@nutanix.com</a>&gt;<br>
=C2=A0 =C2=A0 Cc: Ani Sinha &lt;<a href=3D"mailto:ani@anisinha.ca" target=
=3D"_blank">ani@anisinha.ca</a>&gt;<br>
=C2=A0 =C2=A0 Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mai=
lto:f4bug@amsat.org" target=3D"_blank">f4bug@amsat.org</a>&gt;<br>
=C2=A0 =C2=A0 ---<br>
=C2=A0 =C2=A0 One Reviewed-by/Ack-by from someone from this domain<br>
=C2=A0 =C2=A0 should be sufficient to get this patch merged.<br>
<br>
=C2=A0 =C2=A0 Ani, can you confirm the <a href=3D"mailto:ani@anisinha.ca" t=
arget=3D"_blank">ani@anisinha.ca</a> email?<br>
=C2=A0 =C2=A0 Should it go into &#39;individual contributors&#39; instead?<=
br>
=C2=A0 =C2=A0 ---<br>
=C2=A0 =C2=A0 =C2=A0contrib/gitdm/domain-map=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1=
 +<br>
=C2=A0 =C2=A0 =C2=A0contrib/gitdm/group-map-nutanix | 2 ++<br>
=C2=A0 =C2=A0 =C2=A0gitdm.config=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 +<br>
=C2=A0 =C2=A0 =C2=A03 files changed, 4 insertions(+)<br>
=C2=A0 =C2=A0 =C2=A0create mode 100644 contrib/gitdm/group-map-nutanix<br>
<br>
=C2=A0 =C2=A0 diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-=
map<br>
=C2=A0 =C2=A0 index 4850eab4c4..39251fd97c 100644<br>
=C2=A0 =C2=A0 --- a/contrib/gitdm/domain-map<br>
=C2=A0 =C2=A0 +++ b/contrib/gitdm/domain-map<br>
=C2=A0 =C2=A0 @@ -24,6 +24,7 @@ <a href=3D"http://linaro.org" rel=3D"norefe=
rrer" target=3D"_blank">linaro.org</a>=C2=A0 =C2=A0 =C2=A0 Linaro<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"http://codesourcery.com" rel=3D"noreferrer" =
target=3D"_blank">codesourcery.com</a> Mentor Graphics<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"http://microsoft.com" rel=3D"noreferrer" tar=
get=3D"_blank">microsoft.com</a>=C2=A0 =C2=A0Microsoft<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"http://nokia.com" rel=3D"noreferrer" target=
=3D"_blank">nokia.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0Nokia<br>
=C2=A0 =C2=A0 +<a href=3D"http://nutanix.com" rel=3D"noreferrer" target=3D"=
_blank">nutanix.com</a>=C2=A0 =C2=A0 =C2=A0Nutanix<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"http://oracle.com" rel=3D"noreferrer" target=
=3D"_blank">oracle.com</a>=C2=A0 =C2=A0 =C2=A0 Oracle<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"http://proxmox.com" rel=3D"noreferrer" targe=
t=3D"_blank">proxmox.com</a>=C2=A0 =C2=A0 =C2=A0Proxmox<br>
=C2=A0 =C2=A0 =C2=A0<a href=3D"http://redhat.com" rel=3D"noreferrer" target=
=3D"_blank">redhat.com</a>=C2=A0 =C2=A0 =C2=A0 Red Hat<br>
=C2=A0 =C2=A0 diff --git a/contrib/gitdm/group-map-nutanix b/contrib/gitdm/=
group-map-nutanix<br>
=C2=A0 =C2=A0 new file mode 100644<br>
=C2=A0 =C2=A0 index 0000000000..a3f11425b3<br>
=C2=A0 =C2=A0 --- /dev/null<br>
=C2=A0 =C2=A0 +++ b/contrib/gitdm/group-map-nutanix<br>
=C2=A0 =C2=A0 @@ -0,0 +1,2 @@<br>
=C2=A0 =C2=A0 +<a href=3D"mailto:raphael.s.norwitz@gmail.com" target=3D"_bl=
ank">raphael.s.norwitz@gmail.com</a><br>
=C2=A0 =C2=A0 +<a href=3D"mailto:ani@anisinha.ca" target=3D"_blank">ani@ani=
sinha.ca</a><br>
=C2=A0 =C2=A0 diff --git a/gitdm.config b/gitdm.config<br>
=C2=A0 =C2=A0 index c01c219078..4f821ab8ba 100644<br>
=C2=A0 =C2=A0 --- a/gitdm.config<br>
=C2=A0 =C2=A0 +++ b/gitdm.config<br>
=C2=A0 =C2=A0 @@ -37,6 +37,7 @@ GroupMap contrib/gitdm/group-map-cadence Ca=
dence Design Systems<br>
=C2=A0 =C2=A0 =C2=A0GroupMap contrib/gitdm/group-map-codeweavers CodeWeaver=
s<br>
=C2=A0 =C2=A0 =C2=A0GroupMap contrib/gitdm/group-map-ibm IBM<br>
=C2=A0 =C2=A0 =C2=A0GroupMap contrib/gitdm/group-map-janustech Janus Techno=
logies<br>
=C2=A0 =C2=A0 +GroupMap contrib/gitdm/group-map-nutanix Nutanix<br>
<br>
=C2=A0 =C2=A0 -- <br>
=C2=A0 =C2=A0 2.26.2<br>
<br>
LGTM. Raphael is still a part of Nutanix. I see Ani has already responded a=
bout him not being with the company anymore, so you might want to add him t=
o the individual contributors&#39; list.</blockquote><div dir=3D"auto"><br>=
</div><div dir=3D"auto">Yes thank you. I=E2=80=99ve already mentioned above=
 that I should be added to individual contributors list. Also I don=E2=80=
=99t think I said Raphael left Nutanix.=C2=A0</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padd=
ing-left:1ex;border-left-color:rgb(204,204,204)" dir=3D"auto">
<br>
</blockquote></div></div>

--0000000000008abfc405b0ff63b1--

