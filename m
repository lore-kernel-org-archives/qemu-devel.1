Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E70FC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:11:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B928B2065E
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5aNYZOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B928B2065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4Yk-0007qr-9b
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG4Y5-0007LY-SP; Wed, 09 Sep 2020 14:10:25 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:44017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG4Y3-00033b-Hr; Wed, 09 Sep 2020 14:10:25 -0400
Received: by mail-lj1-x241.google.com with SMTP id u4so4738865ljd.10;
 Wed, 09 Sep 2020 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=CHYOyXn6QbOn3nSMQE6dsSz+4OMMF/TLy4WVRXEF14U=;
 b=r5aNYZOCq0RrXiekuCANFcK23KgRPtJBHloW3hWK36vpKxce0e0vF4b3KQgqtmnsrq
 hJbyQdgnncDdt5OsAQA8sBXcnS+x80tffO7VsxpnWdS7/pr8eZYESXZVWwa/Dp0+1lUB
 fhVW2ADERt0UimdpwzvI1mI4y8/kP7ztWYjT/hE1iZo07Fa8+enkiYjqDB/0PKIhAy8Z
 QxlqTRXJP8O9blZOC2dDi7wxays4qXqi3/Ne/j8spPQHsKCIQU95bXAEDaBooM56b1b8
 QnfMLm6qBx4qBonFKAjNbyrc8s1pHGGabGLErG+00D/Vbv1WkmY/ES8d5DeB7CvMbpVQ
 +f9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=CHYOyXn6QbOn3nSMQE6dsSz+4OMMF/TLy4WVRXEF14U=;
 b=lZpMarWR10G3OBFYoF+BSDAL0YE+ZXbmwzIU+F7Q2I1LCrOCaPlsDwcRNLVn5DSx79
 vyEHvJOrgqSZZaKmmiVuPtArWnxcQp14rJpxWfT0ZmSRiEoh5sEMfAfF9CFFwkwonlDX
 DmzOOiUQDgRDzczQynCq7NMgGex25ywPhz5vhPonbljp5VQ/I3K5FEDkyOn3+eGIkvaB
 hKgxMl5L4Nj1nEXbAPnYyIRT9kgP80bXAEyk42YsOmuz+RANqsa2YJqIfENsFEPBWREa
 7thICsU+m8izFsrHQVq1Mzj7tZRHgLAmhXj4nOXAcg4GgZNUW+VRShzOmYL8VUwyKX2y
 fX+A==
X-Gm-Message-State: AOAM532OhEsMDhc52QmM5HP2F2+eIlbaKbvr029n+XDbiuq8pDIIVUQw
 R9wzFEA2DywLFEITaPPT2YMypFV4wTYnEg32DAg=
X-Google-Smtp-Source: ABdhPJwJ26yAuwAjv6vU/4lFTyY/ty/NRHOAvKISFvToIb582rv6zwuTNldUdgP1iy1GtAz4+girxRU5PSEIrrihIpI=
X-Received: by 2002:a05:651c:1119:: with SMTP id
 d25mr2280695ljo.300.1599675020943; 
 Wed, 09 Sep 2020 11:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200909094617.1582-1-luoyonggang@gmail.com>
 <20200909094617.1582-6-luoyonggang@gmail.com>
 <20200909125233.GW1011023@redhat.com>
In-Reply-To: <20200909125233.GW1011023@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 10 Sep 2020 02:10:09 +0800
Message-ID: <CAE2XoE9cFN55UFNq0DzWKypkfM9EY=ZSLf1dqwo_68QoU9cv=A@mail.gmail.com>
Subject: Re: [PATCH v2 05/21] tests: disable /char/stdio/* tests in
 test-char.c on win32
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000061270c05aee55def"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_FONT_LOW_CONTRAST=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000061270c05aee55def
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2020 at 8:52 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:

> On Wed, Sep 09, 2020 at 05:46:01PM +0800, Yonggang Luo wrote:
> > These tests are blocking test-char to be finished.
> > Merge three #ifndef _WIN32
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  tests/test-char.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
>
> Regards,
> Daniel
>

https://cirrus-ci.com/task/6266195793936384?command=3Dmain#L433

test-char still failing randomly.
I'd like to disable more to make sure it's not failing

ERROR:../tests/test-char.c:103:char_console_test: stdout of child process
(/char/console/subprocess) failed to match: CONSOLE
stdout was:
ERROR test-char - Bail out!
ERROR:../tests/test-char.c:103:char_console_test: stdout of child process
(/char/console/subprocess) failed to match: CONSOLE
make: *** [Makefile.mtest:576: run-test-80] Error 1
C:\Users\ContainerAdministrator\AppData\Local\Temp\cirrus-ci-build>if 2 NEQ
0 exit /b 2

> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000061270c05aee55def
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Sep 9, 2020 at 8:52 PM Daniel=
 P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redha=
t.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">On Wed, Sep 09, 2020 at 05:46:01PM +0800, Yonggang Luo wrote:<br>
&gt; These tests are blocking test-char to be finished.<br>
&gt; Merge three #ifndef _WIN32<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/test-char.c | 8 ++++----<br>
&gt;=C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
<br>
<br>
Regards,<br>
Daniel<br></blockquote><div><br></div><div><a href=3D"https://cirrus-ci.com=
/task/6266195793936384?command=3Dmain#L433">https://cirrus-ci.com/task/6266=
195793936384?command=3Dmain#L433</a><br></div><div><br></div><div>test-char=
 still failing randomly.</div><div>I&#39;d like to disable more to make sur=
e it&#39;s not failing</div><div><br></div><div id=3D"gmail-L425" tabindex=
=3D"0" class=3D"gmail-log-line gmail-jss43" style=3D"box-sizing:border-box;=
font-family:Monaco,monospace;font-size:12px;white-space:pre-wrap;color:rgb(=
250,250,250);width:1094.03px;margin:0px;display:flex">ERROR:../tests/test-c=
har.c:103:char_console_test: stdout of child process (/char/console/subproc=
ess) failed to match: CONSOLE
</div><div id=3D"gmail-L426" tabindex=3D"0" class=3D"gmail-log-line gmail-j=
ss43" style=3D"box-sizing:border-box;font-family:Monaco,monospace;font-size=
:12px;white-space:pre-wrap;color:rgb(250,250,250);width:1094.03px;margin:0p=
x;display:flex">stdout was:
</div><div id=3D"gmail-L427" tabindex=3D"0" class=3D"gmail-log-line gmail-j=
ss43" style=3D"box-sizing:border-box;font-family:Monaco,monospace;font-size=
:12px;white-space:pre-wrap;color:rgb(250,250,250);width:1094.03px;margin:0p=
x;display:flex"></div><div id=3D"gmail-L428" tabindex=3D"0" class=3D"gmail-=
log-line gmail-jss43" style=3D"box-sizing:border-box;font-family:Monaco,mon=
ospace;font-size:12px;white-space:pre-wrap;color:rgb(250,250,250);width:109=
4.03px;margin:0px;display:flex">ERROR test-char - Bail out! ERROR:../tests/=
test-char.c:103:char_console_test: stdout of child process (/char/console/s=
ubprocess) failed to match: CONSOLE</div><div id=3D"gmail-L429" tabindex=3D=
"0" class=3D"gmail-log-line gmail-jss43" style=3D"box-sizing:border-box;fon=
t-family:Monaco,monospace;font-size:12px;white-space:pre-wrap;color:rgb(250=
,250,250);width:1094.03px;margin:0px;display:flex">make: *** [Makefile.mtes=
t:576: run-test-80] Error 1</div><div id=3D"gmail-L430" tabindex=3D"0" clas=
s=3D"gmail-log-line gmail-jss43" style=3D"box-sizing:border-box;font-family=
:Monaco,monospace;font-size:12px;white-space:pre-wrap;color:rgb(250,250,250=
);width:1094.03px;margin:0px;display:flex"></div><div><span style=3D"color:=
rgb(250,250,250);font-family:Monaco,monospace;font-size:12px;white-space:pr=
e-wrap">C:\Users\ContainerAdministrator\AppData\Local\Temp\cirrus-ci-build&=
gt;if 2 NEQ 0 exit /b 2 </span>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000061270c05aee55def--

