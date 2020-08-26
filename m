Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2E0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:32:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99C592078A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaz8E46n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C592078A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxPp-0000es-TM
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:32:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxOg-000864-Oc
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:31:35 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:41836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kAxOe-0006iX-3N
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:31:33 -0400
Received: by mail-lj1-x242.google.com with SMTP id f26so2837359ljc.8
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=TpuWHVAc6AA5VHN50YO9Tfj7f6nKFhp2vFpSMpJc8xw=;
 b=kaz8E46noFVQxsWdVdgiJlGwNx8D97eA319QnJfYveTd2IUJjyuApbogmhTpN+9xkW
 vAWTBQUdNPZe2i3zhYL01VKcPy5XDGZvbp8GnInIV2ae900+nFaOi3KgbUfC8jipv+NZ
 x7ioxFqj2OclMEM2p9hNuoBbR7NGmp3RfT1wHy3qc/y0SHGILRlSA++iDYQqTaxiK0M9
 ZSglsHg2CzsLZ0WqYvwCnJFP8rZcXVYsalYcHw/0Q3UYiKc912/zDSyDAU5BOhbzh5nt
 bBXkLn0/gsCXHn9JwjhmE8ZJ2VJrQPpRt7K4fz2vmL0y3aSv2o2+5FS/IMrzncvnuVst
 ApCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=TpuWHVAc6AA5VHN50YO9Tfj7f6nKFhp2vFpSMpJc8xw=;
 b=WRGsRohYrKMq5DmryiyCjoEHex43BRKyvwZ1jPXShqtBAPhDGs6vqWa2C+n3nTLUtR
 wLNfZjpvEWejt+AAFHPCC7rUKvOI17N53+hTY4GoxLh7O3xcn2c7U/fR6XZKHXH0G5/G
 h/1PpQHBKnSe3Ntaj/FidLwTSjhXCJyjbbKe3sZqiXgG2ygtxt9crGL2cK1XyfNaZAbS
 bjPNZyvf2FpK7MTCckudHYc0e/ImBMetyWn+Of2LmYLTxMeO53V8ziWk+8eIyS/EASbU
 dvoVmY6HLIOqpM4SQ2DQHFm5Kt3pbMhxc03YgSbnI8+R9Jgp5fHBQDrW1N3Y9shmVadf
 e6nA==
X-Gm-Message-State: AOAM532d14y/Y4jBHuwkEgk9/di3CgNDKbtcoifeJWNcYWwbUAsiywq0
 xsBK/atJ5gEXH/OoUsE8h15TTTsnTxjRaAo4v7Q=
X-Google-Smtp-Source: ABdhPJxXrZK1X7ELc1tm8ClL9B3196n6V5cj7NBldOBjJpcNA41deU6ag9/rno201Pd7XDGKwzbxK0x8dxb60rOOCfM=
X-Received: by 2002:a2e:9a8e:: with SMTP id p14mr6832758lji.300.1598455890186; 
 Wed, 26 Aug 2020 08:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200826151006.80-1-luoyonggang@gmail.com>
 <CABgObfYdjLouNp8ZvqHmB-xsOJdUgxv3zJL4A1GKuWggh7fnbA@mail.gmail.com>
In-Reply-To: <CABgObfYdjLouNp8ZvqHmB-xsOJdUgxv3zJL4A1GKuWggh7fnbA@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 26 Aug 2020 23:31:11 +0800
Message-ID: <CAE2XoE-JKpqQj7H3wMt0+WNTBR1JS6ZyiLOhqOYkaVj5Zzgp5A@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000086160a05adc983aa"
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000086160a05adc983aa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I can tell you build.ninja can contains $: symbol, that's the escape for
Ninja,
when ninjatool parse it, it will convert $: -> :, so that's not a problem.
This is part of the build.ninja on my computer

```
build version.rc_version.o: CUSTOM_COMMAND_DEP ../qemu.org/version.rc |
C$:/CI-Tools/msys64/mingw64/bin/x86_64-w64-mingw32-windres.EXE ../
qemu.org/pc-bios/qemu-nsis.ico
 DEPFILE =3D "version.rc_version.o.d"
 DEPFILE_UNQUOTED =3D version.rc_version.o.d
 COMMAND =3D "C:/CI-Tools/msys64/mingw64/bin/x86_64-w64-mingw32-windres.EXE=
"
"-I./." "-I../qemu.org/." "../qemu.org/version.rc" "version.rc_version.o"
"--preprocessor-arg=3D-MD" "--preprocessor-arg=3D-MQversion.rc_version.o"
"--preprocessor-arg=3D-MFversion.rc_version.o.d"
 description =3D Generating$ Windows$ resource$ for$ file$ 'version.rc'$
with$ a$ custom$ command
```

On Wed, Aug 26, 2020 at 11:28 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Wed, Aug 26, 2020 at 5:12 PM <luoyonggang@gmail.com> wrote:
> >
> > From: Yonggang Luo <luoyonggang@gmail.com>
> >
> > SIMPLE_PATH_RE should match the full path token.
> > Or the $ and : contained in path would not matched if the path are star=
t
> with C:/ and E:/
>
> I don't understand this, SIMPLE_PATH_RE is used with re.match which
> only matches at the beginning of the string. Can you send me your
> build.ninja file offlist?
>
> Thanks,
>
> Paolo
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000086160a05adc983aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I can tell you build.ninja can contains $: symbol, that&#3=
9;s the escape for Ninja,<div>when ninjatool parse it, it will convert $: -=
&gt; :, so that&#39;s not a problem.</div><div>This is part of the build.ni=
nja on my computer</div><div><br></div><div>```</div><div>build version.rc_=
version.o: CUSTOM_COMMAND_DEP ../<a href=3D"http://qemu.org/version.rc">qem=
u.org/version.rc</a> | C$:/CI-Tools/msys64/mingw64/bin/x86_64-w64-mingw32-w=
indres.EXE ../<a href=3D"http://qemu.org/pc-bios/qemu-nsis.ico">qemu.org/pc=
-bios/qemu-nsis.ico</a><br>=C2=A0DEPFILE =3D &quot;version.rc_version.o.d&q=
uot;<br>=C2=A0DEPFILE_UNQUOTED =3D version.rc_version.o.d<br>=C2=A0COMMAND =
=3D &quot;C:/CI-Tools/msys64/mingw64/bin/x86_64-w64-mingw32-windres.EXE&quo=
t; &quot;-I./.&quot; &quot;-I../<a href=3D"http://qemu.org/">qemu.org/</a>.=
&quot; &quot;../<a href=3D"http://qemu.org/version.rc">qemu.org/version.rc<=
/a>&quot; &quot;version.rc_version.o&quot; &quot;--preprocessor-arg=3D-MD&q=
uot; &quot;--preprocessor-arg=3D-MQversion.rc_version.o&quot; &quot;--prepr=
ocessor-arg=3D-MFversion.rc_version.o.d&quot;<br>=C2=A0description =3D Gene=
rating$ Windows$ resource$ for$ file$ &#39;version.rc&#39;$ with$ a$ custom=
$ command<br></div><div>```</div></div><br><div class=3D"gmail_quote"><div =
dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 26, 2020 at 11:28 PM Paolo Bon=
zini &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, =
Aug 26, 2020 at 5:12 PM &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=
=3D"_blank">luoyonggang@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=
=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt;<br>
&gt; SIMPLE_PATH_RE should match the full path token.<br>
&gt; Or the $ and : contained in path would not matched if the path are sta=
rt with C:/ and E:/<br>
<br>
I don&#39;t understand this, SIMPLE_PATH_RE is used with re.match which<br>
only matches at the beginning of the string. Can you send me your<br>
build.ninja file offlist?<br>
<br>
Thanks,<br>
<br>
Paolo<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div>

--00000000000086160a05adc983aa--

