Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ECDC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D10120716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 22:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMcPR8Ms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D10120716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDy7r-0007WB-Ki
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 18:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDy76-0006sr-VL
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 18:53:52 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136]:35088)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDy75-0004Ws-98
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 18:53:52 -0400
Received: by mail-lf1-x136.google.com with SMTP id w11so2837787lfn.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 15:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=OHmspF4ygUEbZKBT9iLMTlLqW+uzsy56I3jTBJNzAlw=;
 b=SMcPR8MsTz8gy5kCMu65MHF9KIznATdpo+8TJVJkqhAtvIsLB5ZOr5/vMaAT06MEoK
 +Zv7bXOvrLD54On+qN5zx9WWRsyXjYdpCDeTIailz7yMnF64xFm4cGZ/R4jmW6D5SnlW
 7iOavFCRuImdcjl5JI0zkqIwHwkyGrkG4sxihCX8cOKR/y6WwKQJfrxacA50/hRSHqkh
 281CLEUPrbf3qPYKthC1fRGjic7i8Di2AFS2/jZ0xYfSfzGJZmv0XfXWZXbk8NEpAw7R
 3QyV6PBoMfaLXKKVDm156X9046jJWKNjtG+CiNJDxiluXfhP3GSz97zOI79IqL+qwkv/
 kEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=OHmspF4ygUEbZKBT9iLMTlLqW+uzsy56I3jTBJNzAlw=;
 b=b5ttobEvbhQ9OGeBZ0YsDZZzKmO1lSWfinGqFCW7VKYNai1Dbvgyao3rWqTClHSyz+
 TDqaLKGGTcL4Dmiy/nqbkZn9IxFmfOq5++j7kRqiSPDvUc6ORdjoZpOhvpyd1YQenAOA
 2jkBwPRPYDTiwn2wzT8lBhdvl1AsDH+BgLqFStFktXRSVF/wZfMktbZmgNgFMZHHNyea
 pv1GgFURNrWECOjn3uqHeOuhvp/umwobDzPOpJEz6exo6MMOwru2jjavd9MGFgEz/Gzy
 6L+pQ14uZQ3h4TVXNFAb3iRGAxrF2ivvZUnV38Q6hWrYImX9Be5BZbTHBheiQ6UJ3GWA
 ruAQ==
X-Gm-Message-State: AOAM530zSXwMLrFjaifuA6zmWak3OqAGnY5vGyHgmGWxcIBBwKWcAYha
 GUM73ZuFSlOUvjQlRatDrMln6fG1kNHOjFxJyFE=
X-Google-Smtp-Source: ABdhPJzkbRH2qToBnVgEObYR7tVskGDm5yae/CxPfkBGJ5OOBuOVSJqIfMoxUxna/ok+d7LXmAvXmAxbg73QsUNEpQY=
X-Received: by 2002:ac2:5541:: with SMTP id l1mr2391454lfk.89.1599173629440;
 Thu, 03 Sep 2020 15:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE_TJ2T2eN82km0pYqDiqOpsd=waH4EmCe==0k=GYpj3Xg@mail.gmail.com>
 <3d2db346-2517-f6e3-748d-79a8ae993e06@redhat.com>
In-Reply-To: <3d2db346-2517-f6e3-748d-79a8ae993e06@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 4 Sep 2020 06:53:39 +0800
Message-ID: <CAE2XoE_3Kjjk+tRz1y7rk94+vre2FSfmCGQVWNgjNW14vSNSdw@mail.gmail.com>
Subject: Re: make -i check resut for msys2
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000001df7be05ae70a01a"
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
Cc: Xie Changlong <xiechanglong.d@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 Wen Congyang <wencongyang2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000001df7be05ae70a01a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2020 at 10:33 PM Thomas Huth <thuth@redhat.com> wrote:

> On 03/09/2020 11.18, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> [...]
> >   TEST    check-unit: tests/test-replication.exe
> > **
> > ERROR:C:/work/xemu/qemu/tests/test-replication.c:136:make_temp:
> > assertion failed: (fd >=3D 0)
> > ERROR test-replication.exe - Bail out!
> > ERROR:C:/work/xemu/qemu/tests/test-replication.c:136:make_temp:
> > assertion failed: (fd >=3D 0)
>
> At least this one should be easy to fix: The test uses /tmp as
> hard-coded directory for temporary files. I think it should use
> g_get_tmp_dir() from glib to get that directory instead.
>
>  Thomas
>
> After fixes tmp path, how to fixes following error:
$ tests/test-replication.exe


# random seed: R02Sdf2e4ffc0e6fbe96624598386b538927
1..13
# Start of replication tests
# Start of primary tests
Unexpected error in bdrv_open_inherit() at ../block.c:3456:
Block protocol 'file' doesn't support the option 'locking'


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000001df7be05ae70a01a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 10:33 PM Thoma=
s Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 03/09/202=
0 11.18, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>
[...]<br>
&gt; =C2=A0 TEST =C2=A0 =C2=A0check-unit: tests/test-replication.exe<br>
&gt; **<br>
&gt; ERROR:C:/work/xemu/qemu/tests/test-replication.c:136:make_temp:<br>
&gt; assertion failed: (fd &gt;=3D 0)<br>
&gt; ERROR test-replication.exe - Bail out!<br>
&gt; ERROR:C:/work/xemu/qemu/tests/test-replication.c:136:make_temp:<br>
&gt; assertion failed: (fd &gt;=3D 0)<br>
<br>
At least this one should be easy to fix: The test uses /tmp as<br>
hard-coded directory for temporary files. I think it should use<br>
g_get_tmp_dir() from glib to get that directory instead.<br>
<br>
=C2=A0Thomas<br>
<br></blockquote><div>After fixes tmp path, how to fixes following error:</=
div>$ tests/test-replication.exe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<br># random =
seed: R02Sdf2e4ffc0e6fbe96624598386b538927<br>1..13<br># Start of replicati=
on tests<br># Start of primary tests<br>Unexpected error in bdrv_open_inher=
it() at ../block.c:3456:<br><div>Block protocol &#39;file&#39; doesn&#39;t =
support the option &#39;locking&#39;=C2=A0<br></div></div><br clear=3D"all"=
><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=
=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></d=
iv></div>

--0000000000001df7be05ae70a01a--

