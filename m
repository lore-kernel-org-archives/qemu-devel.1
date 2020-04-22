Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CB2C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:11:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDE12077D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:11:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDE12077D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRG6D-0000Xd-Ci
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50590)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jRG4z-0006Qi-2L
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jRG4w-0001Lb-N8
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:10:19 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:28425 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jRG4w-0001E9-4s
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:10:18 -0400
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
 by postfix.smtp2.imsva2 (Postfix) with ESMTPS id B51DA786A
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 16:10:08 +0200 (CEST)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 766405A05B
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 16:10:08 +0200 (CEST)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5D0405A067
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 16:10:08 +0200 (CEST)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
 by imsva2.lgp.ehu.es (Postfix) with ESMTPS
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 16:10:08 +0200 (CEST)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com
 [209.85.166.178]) by smtp2 (Postfix) with ESMTPSA id 20A86786A
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 16:10:07 +0200 (CEST)
Received: by mail-il1-f178.google.com with SMTP id t12so1979960ile.9
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 07:10:07 -0700 (PDT)
X-Gm-Message-State: AGi0PuYYJa3oMSas6sTND1Rbkd6WTtu17H09MpeX0aIq4L3wQU1D3FL3
 jAi6Jf/9EApvIgQ/8aRsrbCtHmHciqFERwV3uw==
X-Google-Smtp-Source: APiQypKZwXBeu7/7FSQ8Kx+ikyTV9YYyMp8x9g5KJkGvh6lyFQ13EbvBwj7opSh4ml86BHw8l/BoAynCiQF5XjowJLY=
X-Received: by 2002:a92:4a11:: with SMTP id m17mr25697389ilf.125.1587564606648; 
 Wed, 22 Apr 2020 07:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200309190110.GA31@669c1c222ef4>
In-Reply-To: <20200309190110.GA31@669c1c222ef4>
From: Unai Martinez Corral <unai.martinezcorral@ehu.eus>
Date: Wed, 22 Apr 2020 16:09:55 +0200
X-Gmail-Original-Message-ID: <CAGZZdDGC=iMzU61c01pAc3s=7m1x_pMoLhCWYZjRbhWTUh_mVQ@mail.gmail.com>
Message-ID: <CAGZZdDGC=iMzU61c01pAc3s=7m1x_pMoLhCWYZjRbhWTUh_mVQ@mail.gmail.com>
Subject: Re: [PATCH v10 0/10] qemu-binfmt-conf.sh
To: =?UTF-8?Q?Unai_Mart=C3=ADnez_Corral?= <unai.martinezcorral@ehu.eus>
Content-Type: multipart/alternative; boundary="0000000000006ff99505a3e1b095"
X-Greylist: ACL 192 matched, not delayed by milter-greylist-4.6.2 (smtp2
 [10.0.100.76]); Wed, 22 Apr 2020 16:10:08 +0200 (CEST)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25372.000
X-TM-AS-Result: No--14.456-7.0-31-10
X-imss-scan-details: No--14.456-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25372.000
X-TMASE-Result: 10--14.456000-10.000000
X-TMASE-MatchedRID: QaEEGqyHmzGgBUTSh64wSSnjDVPUYtjj7euC4HkicftJqBAKh+jZlxlK
 ij+pdw5jEpEeINQNSwoKcKXSCIuKCZkroZMnoDef5Qo03mEdwAGOz/LLJUcaHs8DuAI4aSPIhGz
 G3wY/cLfX2ShWG+0/HgiTaqhm0PakKTXyPkeuRzWkvaQteDAtwjh4aiF3uCM2Q5TpvuefFlbv6F
 j2Xtj47BslYB8FoBoPYZmVzHZLJkOc/9pZkfoowWo/fCejPesrtvjn5WNmIymBg28VlCpesQVM9
 kPsaYx4cYtEjWFsw1Gqip2P6LkJlN6mdwOBRvHdggra2NOo2i3naaW2UTafyGJGTIGsciLK2VC1
 QWKKKPqz6Hv+vbt8wZ/1E0FCiPKnpljg/F9ExYTB6S7ffS3ea27BSyDZmAnxoIQ2gxbMUIfIeAQ
 ugZMNBOgRT1AWDrqIukYDZ80I8WgkVm0IjglhHYVMtEwAWsdcXs5nqGvDCfOFWqzbguZvSIYMM3
 r3suSeX2P70OPfEVBtu21XpQLmylUOzfoovIJKdfk9ZxDdshYXaMhZSeVFDDs61woVLQQE8LoCm
 5O9DPPL+jAsMSmcUfjDlA9c5qydUuluVE/y9/RoUArKobkzYiPx0viUmdeuyaqtcUsWOxbW6RH7
 zrNXXOLzNWBegCW21WdIO+NJS/n52SN33UuAAKiYnCRZ5YNfz1YRopIey+9QraqT74UQxgU1sPb
 nZ/IiFhpRR80FcqBgfP3Y2AC5zL1T/UAncWTUj7uV0Vrl0STRlOrL6hHfGHD1UQdjqlRhRsYH1W
 Tcu8Ar+h4+kNbHnw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp2.imsva2 [10.0.100.76]);
 Wed, 22 Apr 2020 16:10:08 +0200 (CEST)
Received-SPF: pass client-ip=158.227.0.66;
 envelope-from=unai.martinezcorral@ehu.eus; helo=smtp.ehu.eus
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 10:10:08
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 158.227.0.66
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
Reply-To: unai.martinezcorral@ehu.eus
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000006ff99505a3e1b095
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'd like to request this patchset to be kept on hold. As discussed in
https://github.com/dbhi/qus/issues/4, the current "family-based" logic of
'qemu-binfmt-conf.sh' does not work for aarch64-only hosts. It is assumed
that all aarch64 hosts can natively execute arm or armhf binaries. However,
this is not true anymore. Some high end devices, such as ThunderX or
ThunderX2, are 64-bit only.

It was tested that splitting family 'arm' to 'arm' and 'arm64' does work:
https://github.com/umarcor/qemu/commit/699f972f665bb6dfd05e1c89ff83adb9834a=
1bb2.
However, such solution breaks backwards compatibility and it will register
unnecessary interpreters on hosts which do support both 32-bit and 64-bit.
Hence, I'd like to add some option for users to tell that a host is 64-bit
only. Alternatively, we might have an automatic test to detect it. I'd be
glad to hear any suggestion.

Regards

Unai

El lun., 9 mar. 2020 a las 20:01, Unai Martinez-Corral
(<unai.martinezcorral@ehui.eus>) escribi=C3=B3:

> Hi,
>
> This series reworks qemu-binfmt-conf.sh:
>
> * Argument <CPU> from option '--systemd' is generalized to <TARGETS>, and
> it is
>   accepted for any mode (default, debian or systemd). It can be a single
> target
>   arch or a list of them.
> * Option '-r|--clear' is added, which allows to remove an already
> registered
>   target interpreter or a list of them. The implementation is functional
> but
>   partial. Please, see the corresponding commit.
> * Option '-t|--test' is added, which allows to execute the CHECK accordin=
g
>   to the provided arguments, but no interpreter is configured.
> * Support to set options through environment variables: QEMU_TARGETS,
> QEMU_PATH,
>   QEMU_SUFFIX, QEMU_PERSISTENT, QEMU_CREDENTIAL, QEMU_CLEAR and QEMU_TEST=
.
>
> The following changes are not backward compatible:
>
> * Option '--persistent' no longer requires/accepts an argument.
> * Option '--credential' no longer requires/accepts an argument.
> * Option '--systemd' no longer requires/accepts an argument.
> * Option '--qemu-path' is renamed to '--path'.
> * Option '--qemu-suffix' is renamed to '--suffix'.
>
> The functionality of all of them is untouched. Changes are related to
> syntax only.
>
> v10
>
> * Split style related commit
>
> v9
>
> * Make style coherent with the dominant pattern
>
> v8:
>
> * Fix typos and address review comments
>
> v7:
>
> * Check that a interpreter exists before trying to remove it.
>
> v6:
>
> * Don't need to use "find".
> * Put the ";;" at the same position.
> * Set BINFMT_CLEAR to ':', to allow --test to work with --clear.
> * Do not show DEBIANDIR and SYSTEMDDIR in the Env-variable column.
>
> Based on:
>
> * [PATCH v5 0/10] qemu-binfmt-conf.sh
>    * should have been [PATCH v5 0/9] qemu-binfmt-conf.sh
> * [PATCH v4 0/10] qemu-binfmt-conf.sh
> * [PATCH v3 0/10] qemu-binfmt-conf.sh
> * [PATCH v2] qemu-binfmt-conf.sh: add CPUS, add --reset, make -p and -c
> boolean (no arg)
> * [PATCH] qemu-binfmt-conf.sh: add CPUS, add --reset, make -p and -c
> boolean (no arg)
> * scripts/qemu-binfmt-conf.sh: allow clearing of entries
>
> Regards
>
> Unai Martinez-Corral (10):
>       qemu-binfmt-conf.sh: enforce style consistency
>       qemu-binfmt-conf.sh: enforce safe tests
>       qemu-binfmt-conf.sh: make opts -p and -c boolean
>       qemu-binfmt-conf.sh: add QEMU_CREDENTIAL and QEMU_PERSISTENT
>       qemu-binfmt-conf.sh: use the same presentation format as for qemu-*
>       qemu-binfmt-conf.sh: remove 'qemu' prefix from cli options
>       qemu-binfmt-conf.sh: honour QEMU_PATH and/or QEMU_SUFFIX
>       qemu-binfmt-conf.sh: generalize <CPU> to positional TARGETS
>       qemu-binfmt-conf.sh: add option --clear
>       qemu-binfmt-conf.sh: add --test
>
> scripts/qemu-binfmt-conf.sh | 221
> 1 file changed, 138 insertions(+), 83 deletions(-i)
>

--0000000000006ff99505a3e1b095
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br></div>I&#39;d like to request th=
is patchset to be kept on hold. As discussed in <a href=3D"https://github.c=
om/dbhi/qus/issues/4">https://github.com/dbhi/qus/issues/4</a>, the current=
 &quot;family-based&quot; logic of &#39;qemu-binfmt-conf.sh&#39; does not w=
ork for aarch64-only hosts. It is assumed that all aarch64 hosts can native=
ly execute arm or armhf binaries. However, this is not true anymore. Some h=
igh end devices, such as ThunderX or ThunderX2, are 64-bit only.<br><br></d=
iv>It was tested that splitting family &#39;arm&#39; to &#39;arm&#39; and &=
#39;arm64&#39; does work: <a href=3D"https://github.com/umarcor/qemu/commit=
/699f972f665bb6dfd05e1c89ff83adb9834a1bb2">https://github.com/umarcor/qemu/=
commit/699f972f665bb6dfd05e1c89ff83adb9834a1bb2</a>. However, such solution=
 breaks backwards compatibility and it will register unnecessary interprete=
rs on hosts which do support both 32-bit and 64-bit. Hence, I&#39;d like to=
 add some option for users to tell that a host is 64-bit only. Alternativel=
y, we might have an automatic test to detect it. I&#39;d be glad to hear an=
y suggestion.<br><br></div><div>Regards</div><div><br></div><div>Unai<br></=
div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">El lun., 9 mar. 2020 a las 20:01, Unai Martinez-Corral (&lt;unai.martin=
ezcorral@ehui.eus&gt;) escribi=C3=B3:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">Hi,<br>
<br>
This series reworks qemu-binfmt-conf.sh:<br>
<br>
* Argument &lt;CPU&gt; from option &#39;--systemd&#39; is generalized to &l=
t;TARGETS&gt;, and it is<br>
=C2=A0 accepted for any mode (default, debian or systemd). It can be a sing=
le target<br>
=C2=A0 arch or a list of them.<br>
* Option &#39;-r|--clear&#39; is added, which allows to remove an already r=
egistered<br>
=C2=A0 target interpreter or a list of them. The implementation is function=
al but<br>
=C2=A0 partial. Please, see the corresponding commit.<br>
* Option &#39;-t|--test&#39; is added, which allows to execute the CHECK ac=
cording<br>
=C2=A0 to the provided arguments, but no interpreter is configured.<br>
* Support to set options through environment variables: QEMU_TARGETS, QEMU_=
PATH,<br>
=C2=A0 QEMU_SUFFIX, QEMU_PERSISTENT, QEMU_CREDENTIAL, QEMU_CLEAR and QEMU_T=
EST.<br>
<br>
The following changes are not backward compatible:<br>
<br>
* Option &#39;--persistent&#39; no longer requires/accepts an argument.<br>
* Option &#39;--credential&#39; no longer requires/accepts an argument.<br>
* Option &#39;--systemd&#39; no longer requires/accepts an argument.<br>
* Option &#39;--qemu-path&#39; is renamed to &#39;--path&#39;.<br>
* Option &#39;--qemu-suffix&#39; is renamed to &#39;--suffix&#39;.<br>
<br>
The functionality of all of them is untouched. Changes are related to synta=
x only.<br>
<br>
v10<br>
<br>
* Split style related commit<br>
<br>
v9<br>
<br>
* Make style coherent with the dominant pattern<br>
<br>
v8:<br>
<br>
* Fix typos and address review comments<br>
<br>
v7:<br>
<br>
* Check that a interpreter exists before trying to remove it.<br>
<br>
v6:<br>
<br>
* Don&#39;t need to use &quot;find&quot;.<br>
* Put the &quot;;;&quot; at the same position.<br>
* Set BINFMT_CLEAR to &#39;:&#39;, to allow --test to work with --clear.<br=
>
* Do not show DEBIANDIR and SYSTEMDDIR in the Env-variable column.<br>
<br>
Based on:<br>
<br>
* [PATCH v5 0/10] qemu-binfmt-conf.sh<br>
=C2=A0 =C2=A0* should have been [PATCH v5 0/9] qemu-binfmt-conf.sh<br>
* [PATCH v4 0/10] qemu-binfmt-conf.sh<br>
* [PATCH v3 0/10] qemu-binfmt-conf.sh<br>
* [PATCH v2] qemu-binfmt-conf.sh: add CPUS, add --reset, make -p and -c boo=
lean (no arg)<br>
* [PATCH] qemu-binfmt-conf.sh: add CPUS, add --reset, make -p and -c boolea=
n (no arg)<br>
* scripts/qemu-binfmt-conf.sh: allow clearing of entries<br>
<br>
Regards<br>
<br>
Unai Martinez-Corral (10):<br>
=C2=A0 =C2=A0 =C2=A0 qemu-binfmt-conf.sh: enforce style consistency<br>
=C2=A0 =C2=A0 =C2=A0 qemu-binfmt-conf.sh: enforce safe tests<br>
=C2=A0 =C2=A0 =C2=A0 qemu-binfmt-conf.sh: make opts -p and -c boolean<br>
=C2=A0 =C2=A0 =C2=A0 qemu-binfmt-conf.sh: add QEMU_CREDENTIAL and QEMU_PERS=
ISTENT<br>
=C2=A0 =C2=A0 =C2=A0 qemu-binfmt-conf.sh: use the same presentation format =
as for qemu-*<br>
=C2=A0 =C2=A0 =C2=A0 qemu-binfmt-conf.sh: remove &#39;qemu&#39; prefix from=
 cli options<br>
=C2=A0 =C2=A0 =C2=A0 qemu-binfmt-conf.sh: honour QEMU_PATH and/or QEMU_SUFF=
IX<br>
=C2=A0 =C2=A0 =C2=A0 qemu-binfmt-conf.sh: generalize &lt;CPU&gt; to positio=
nal TARGETS<br>
=C2=A0 =C2=A0 =C2=A0 qemu-binfmt-conf.sh: add option --clear<br>
=C2=A0 =C2=A0 =C2=A0 qemu-binfmt-conf.sh: add --test<br>
<br>
scripts/qemu-binfmt-conf.sh | 221<br>
1 file changed, 138 insertions(+), 83 deletions(-i)<br>
</blockquote></div>

--0000000000006ff99505a3e1b095--


