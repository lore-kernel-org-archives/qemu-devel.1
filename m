Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD46C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB1B20716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ktY1pVW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB1B20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDjLH-0004Oi-00
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:07:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjKb-0003uU-6C; Thu, 03 Sep 2020 03:06:49 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:45656)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDjKW-0007r1-9l; Thu, 03 Sep 2020 03:06:48 -0400
Received: by mail-lf1-x144.google.com with SMTP id z17so1234715lfi.12;
 Thu, 03 Sep 2020 00:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=IRJBFmxxI/Ox7JOY/rkcm4dGcmTs5AsByqiHgRDO52A=;
 b=ktY1pVW+VIJD2MD9EfIaLbj36ioNaII1ypi8svn2lOHnbJ0ZnNr7bfNYXzAlkA9neU
 z5xUwYG6KE0pNJC/1x5NH8nHsX4PzWJmrwdEyIuqiHw0gcgbGU2vTuZ0lzauLFfgkazB
 VorYa9cri4SE8aWoRr3/Y4IuG7U8CsOajO1Sr39HVSulcv42wdtHFMKHLW4HyC/evQR/
 hwttW8WeNd22JoNT1UYmqXWaJKFAv2GpTzZI51EeeXgo/5ABPVGATFo7Zyhz1Y5DhiIb
 PPZTa6lQUeTcnZXu9LUNppLYQ3W9QAX2yp0gB2rJH2NE4bLGpzeubCiuRbCn/OvSFcn/
 SXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=IRJBFmxxI/Ox7JOY/rkcm4dGcmTs5AsByqiHgRDO52A=;
 b=JpugsK4jbzZBgq8owRHolK7DlNKy7JdShh6qleWWfdNksX5QgX81SZFfOkRhJcAyo6
 2Tp7S9qzwoM0spJwCL5qs1jf/z4cRBrD0PnWUtXuY3rF2r7c+A6gELLTH33+SlSYLEwB
 RI34hD75V4TltbpwU9YiuE0DAempoV2mNj9uoxXcOeDLd4dnH7Ilmn1Z8MmQD+HdbaR4
 65dYaLVGcgKRAWfPhpUMZS9K0TzlrXJsgYJaTjUoVUCCZVxwDl6qJzIB4hQD1zpNBHgu
 JVgf5rpJGQf2I7MmZSOLhmUGgPa5/8fZIH16uazL5KmtuOP6JsCgAOzhfB4MzesDL0lP
 hq2g==
X-Gm-Message-State: AOAM530j5kBWsCzoAJ80DkRR7ny2+cGlG65AvivtyVLx+OnJWbpHGgUa
 TZ3jfs4bYppLc2jdFRc8S0t9l8Iao2o/ewHkC54=
X-Google-Smtp-Source: ABdhPJyngG+lRX3nDvSNz/aEQDhpr9XJHtMAojseIhYjz6BHCsOs5esyKVQ0ZgAed0ksM30EDofzscCsVINRROyhB5E=
X-Received: by 2002:a19:41c8:: with SMTP id o191mr511298lfa.176.1599116801670; 
 Thu, 03 Sep 2020 00:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200825103850.119911-1-berrange@redhat.com>
 <20200825103850.119911-4-berrange@redhat.com>
 <CAE2XoE_8E0gYBnPn9GtB94zQ4Rr+ihOi1gvw4mvnNj5CRxv6DA@mail.gmail.com>
 <7d2408f0-a0c3-ab1a-b836-90938cbe6f7b@redhat.com>
In-Reply-To: <7d2408f0-a0c3-ab1a-b836-90938cbe6f7b@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 15:06:30 +0800
Message-ID: <CAE2XoE9z5ZKf-eRJ0OVJJ55MZmehZ6F55Zhm=uUWqczNEoA1JA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] nbd: disable signals and forking on Windows builds
To: Eric Blake <eblake@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000eb026705ae636488"
Received-SPF: pass client-ip=2a00:1450:4864:20::144;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x144.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000eb026705ae636488
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2020 at 7:29 AM Eric Blake <eblake@redhat.com> wrote:

> On 9/2/20 5:07 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:
> > On Tue, Aug 25, 2020 at 6:40 PM Daniel P. Berrang=C3=A9 <berrange@redha=
t.com>
> > wrote:
> >
> >> Disabling these parts are sufficient to get the qemu-nbd program
> >> compiling in a Windows build.
> >>
> >> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >> ---
> >>   meson.build | 7 ++-----
> >>   qemu-nbd.c  | 5 +++++
> >>   2 files changed, 7 insertions(+), 5 deletions(-)
>
> >> +++ b/qemu-nbd.c
> >> @@ -899,6 +899,7 @@ int main(int argc, char **argv)
> >>   #endif
> >>
> >>       if ((device && !verbose) || fork_process) {
> >> +#ifndef WIN32
> >>           int stderr_fd[2];
> >>           pid_t pid;
> >>           int ret;
> >> @@ -962,6 +963,10 @@ int main(int argc, char **argv)
> >>                */
> >>               exit(errors);
> >>           }
> >> +#else /* WIN32 */
> >> +        error_report("Unable to fork into background on Windows
> hosts");
> >> +        exit(EXIT_FAILURE);
> >> +#endif /* WIN32 */
> >>       }
> >>
> > May us replace fork with alternative such as spawn?
>
> You're certainly welcome to propose a patch along those lines, if
> spawning a task is a common Windows counterpart to the Unix notion of
> forking off a daemon.  But even requiring qemu-nbd to run in the
> foreground is already an improvement over what we had previously, so any
> change to use spawn will be a separate series, and will not hold up this
>
Yes, of cause.

> one.
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000eb026705ae636488
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 3, 2020 at 7:29 AM Eric B=
lake &lt;<a href=3D"mailto:eblake@redhat.com">eblake@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 9/2/20 5:=
07 PM, =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) wrote:<br>
&gt; On Tue, Aug 25, 2020 at 6:40 PM Daniel P. Berrang=C3=A9 &lt;<a href=3D=
"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<=
br>
&gt; wrote:<br>
&gt; <br>
&gt;&gt; Disabling these parts are sufficient to get the qemu-nbd program<b=
r>
&gt;&gt; compiling in a Windows build.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berra=
nge@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0meson.build | 7 ++-----<br>
&gt;&gt;=C2=A0 =C2=A0qemu-nbd.c=C2=A0 | 5 +++++<br>
&gt;&gt;=C2=A0 =C2=A02 files changed, 7 insertions(+), 5 deletions(-)<br>
<br>
&gt;&gt; +++ b/qemu-nbd.c<br>
&gt;&gt; @@ -899,6 +899,7 @@ int main(int argc, char **argv)<br>
&gt;&gt;=C2=A0 =C2=A0#endif<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((device &amp;&amp; !verbose) || fork=
_process) {<br>
&gt;&gt; +#ifndef WIN32<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int stderr_fd[2];<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pid_t pid;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
&gt;&gt; @@ -962,6 +963,10 @@ int main(int argc, char **argv)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit(errors)=
;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; +#else /* WIN32 */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report(&quot;Unable to fork int=
o background on Windows hosts&quot;);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt;&gt; +#endif /* WIN32 */<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt; May us replace fork with alternative such as spawn?<br>
<br>
You&#39;re certainly welcome to propose a patch along those lines, if <br>
spawning a task is a common Windows counterpart to the Unix notion of <br>
forking off a daemon.=C2=A0 But even requiring qemu-nbd to run in the <br>
foreground is already an improvement over what we had previously, so any <b=
r>
change to use spawn will be a separate series, and will not hold up this <b=
r></blockquote><div>Yes, of cause.=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
one.<br>
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3226<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer" target=
=3D"_blank">qemu.org</a> | <a href=3D"http://libvirt.org" rel=3D"noreferrer=
" target=3D"_blank">libvirt.org</a><br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000eb026705ae636488--

