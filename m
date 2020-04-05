Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A720EC2BA15
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 16:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6ED20675
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 16:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8jqEUqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6ED20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jL8M3-0004bB-HH
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 12:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jL8LP-0004Bu-W4
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 12:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.qemu.devel@gmail.com>) id 1jL8LO-0001M3-In
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 12:41:59 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51454)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jL8LO-0001LN-Bf
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 12:41:58 -0400
Received: by mail-wm1-x343.google.com with SMTP id z7so12205595wmk.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2020 09:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8rRX4NUebl6MdSW2ICda+smEMgKSJytKBhnJgOF+Chg=;
 b=b8jqEUqL0zYpfIVbr+yjy/8lUxqE5NQWvc3Z/pc2w8i/5xHyOfRIU4nJ5vLcCctbvG
 on7kyJGvffscFtfi/3bMjX/4OaTJN1ZsZrB6ZGzJnGQbWdn+FcqXX/WPY1VTTlU9QQKI
 n/nl5QQWIMgZxnNXNLK2T92cSAHkXuXO6lnPQ9Fda45lCndsVCLHlta0MlT3LGLqbJ+3
 Srgzl6f8Ke0wyReOofCljpsQxEnD04jeCERQjcpIliRD+GCTPWfBfPZhD2DhHjyWwC8B
 HJf0L3uuyTF2qIoHP3GbsUCG3i3MVZlPxkYeRRyfJL6sqOA6wbLTuQIb66tYjEbdnAzE
 Yp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8rRX4NUebl6MdSW2ICda+smEMgKSJytKBhnJgOF+Chg=;
 b=K630CfCIic9gpu/4IGQa5/yEt91V3SjsI26Yq8HfdMfvpmTXGXfFqPXATgKxrsn1MO
 r/Xgs5k56Wr/MiSCWALzeQjVYdOLMp2ezQlmG6EqYcG8dPmxTAKHNWF/3UQQyIShE36Z
 vx4rCS3K6RWvTELhjOOXHqLvPISbYoRdS3pry6mERCrbvj/eXa4TqrFxNqtTnw2llX7T
 CQqdH+Eh1e1JJJLXlN5IcNrt8VloIOte0QI5LpuT3agf4S0hBM8uTl2R1Qlr6ndi4A8M
 3C26KW1cCF1l2w8YaAdPM0JGJSUQqaTlPRHrX9+u+fMhj32n6RKgFuTH58rseR9EQ991
 9rdw==
X-Gm-Message-State: AGi0PuYDRO8yLdXAgx7JvcHxvsCEZ1SmympC6ULCMpWdQW/AF0xF70jM
 1DYONUx6XD72VH7ETFqyiKVNLiv+5SPiRS4bn+g=
X-Google-Smtp-Source: APiQypJ1GCYij/k2S5TY5vBtxTT72Q/SIEJp/72TgqCNDYssop4Of77yIjRQ+YXgKlhz4uQGbJ9yPGZ8cUQ1R+2/RE8=
X-Received: by 2002:a7b:c051:: with SMTP id u17mr17683886wmc.129.1586104916518; 
 Sun, 05 Apr 2020 09:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200403135306.665493-1-berrange@redhat.com>
 <CAFEAcA_CSiw4ojYHVD6S73O-iRuXt6gTS=3VdAO545q8ye0+Ww@mail.gmail.com>
In-Reply-To: <CAFEAcA_CSiw4ojYHVD6S73O-iRuXt6gTS=3VdAO545q8ye0+Ww@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 5 Apr 2020 18:41:35 +0200
Message-ID: <CAHiYmc7V1AS2=Pz2nT80S2BhZ8fCB6vWRfPAB4zDvdnO0J-T=Q@mail.gmail.com>
Subject: Re: [PATCH v4 for-5.0] configure: warn if not using a separate build
 directory
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000202b1c05a28dd4d8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Liviu Ionescu <ilg@livius.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000202b1c05a28dd4d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

16:39 Ned, 05.04.2020. Peter Maydell <peter.maydell@linaro.org> =D1=98=D0=
=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Fri, 3 Apr 2020 at 14:53, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
>
wrote:
> >
> > Running configure directly from the source directory is a build
> > configuration that will go away in future. It is also not currently
> > covered by any automated testing. Display a deprecation warning if
> > the user attempts to use an in-srcdir build setup, so that they are
> > aware that they're building QEMU in an undesirable manner.
> >
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > ---
>
> > +if test "$in_srcdir" =3D "yes"; then
> > +    echo
> > +    echo "WARNING: SUPPORT FOR BUILDING IN THE SOURCE DIR IS
DEPRECATED"
> > +    echo
> > +    echo "Support for running the 'configure' script directly from the=
"
> > +    echo "source directory is deprecated. In-tree builds are not
covered"
> > +    echo "by automated testing and thus may not correctly build QEMU."
> > +    echo "Users are recommended to use a separate build directory:"
> > +    echo
> > +    echo "  $ mkdir build"
> > +    echo "  $ cd build"
> > +    echo "  $ ../configure"
> > +    echo "  $ make"
> > +    echo
> > +fi
>
> So here's my stab at some text here; I'm aiming at nudging users
> towards out-of-tree builds if they were simply not thinking about
> it, but not actively marking them as 'deprecated', since it sounded
> to me like we were planning to keep at least the basic
> 'configure+make+make install' sequence of commands working.
>
> echo "NOTE: we recommend against building in the source directory"
> echo
> echo "You've run the 'configure' script directly from the source"
> echo "directory. This will work, but we recommend using a separate"
> echo "build directory, especially if you plan to work with the QEMU"
> echo "sources rather than just building it once. You can switch to"
> echo "a separate build directory like this:"
> [instructions go here]
>

Peter's version is far more superior to Daniel's.

I'd better not discuss the reasons, not wanting to waste my time and
other's time.

For Peter's version:

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

> thanks
> -- PMM
>

--000000000000202b1c05a28dd4d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr"></p>
<p dir=3D"ltr">16:39 Ned, 05.04.2020. Peter Maydell &lt;<a href=3D"mailto:p=
eter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; =D1=98=D0=B5 =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:<br>
&gt;<br>
&gt; On Fri, 3 Apr 2020 at 14:53, Daniel P. Berrang=C3=A9 &lt;<a href=3D"ma=
ilto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; Running configure directly from the source directory is a build<b=
r>
&gt; &gt; configuration that will go away in future. It is also not current=
ly<br>
&gt; &gt; covered by any automated testing. Display a deprecation warning i=
f<br>
&gt; &gt; the user attempts to use an in-srcdir build setup, so that they a=
re<br>
&gt; &gt; aware that they&#39;re building QEMU in an undesirable manner.<br=
>
&gt; &gt;<br>
&gt; &gt; Reviewed-by: Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com">=
eblake@redhat.com</a>&gt;<br>
&gt; &gt; Reviewed-by: Markus Armbruster &lt;<a href=3D"mailto:armbru@redha=
t.com">armbru@redhat.com</a>&gt;<br>
&gt; &gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:ph=
ilmd@redhat.com">philmd@redhat.com</a>&gt;<br>
&gt; &gt; Tested-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:phil=
md@redhat.com">philmd@redhat.com</a>&gt;<br>
&gt; &gt; Signed-off-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com">berrange@redhat.com</a>&gt;<br>
&gt; &gt; ---<br>
&gt;<br>
&gt; &gt; +if test &quot;$in_srcdir&quot; =3D &quot;yes&quot;; then<br>
&gt; &gt; +=C2=A0 =C2=A0 echo<br>
&gt; &gt; +=C2=A0 =C2=A0 echo &quot;WARNING: SUPPORT FOR BUILDING IN THE SO=
URCE DIR IS DEPRECATED&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 echo<br>
&gt; &gt; +=C2=A0 =C2=A0 echo &quot;Support for running the &#39;configure&=
#39; script directly from the&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 echo &quot;source directory is deprecated. In-tree=
 builds are not covered&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 echo &quot;by automated testing and thus may not c=
orrectly build QEMU.&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 echo &quot;Users are recommended to use a separate=
 build directory:&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 echo<br>
&gt; &gt; +=C2=A0 =C2=A0 echo &quot;=C2=A0 $ mkdir build&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 echo &quot;=C2=A0 $ cd build&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 echo &quot;=C2=A0 $ ../configure&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 echo &quot;=C2=A0 $ make&quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 echo<br>
&gt; &gt; +fi<br>
&gt;<br>
&gt; So here&#39;s my stab at some text here; I&#39;m aiming at nudging use=
rs<br>
&gt; towards out-of-tree builds if they were simply not thinking about<br>
&gt; it, but not actively marking them as &#39;deprecated&#39;, since it so=
unded<br>
&gt; to me like we were planning to keep at least the basic<br>
&gt; &#39;configure+make+make install&#39; sequence of commands working.<br=
>
&gt;<br>
&gt; echo &quot;NOTE: we recommend against building in the source directory=
&quot;<br>
&gt; echo<br>
&gt; echo &quot;You&#39;ve run the &#39;configure&#39; script directly from=
 the source&quot;<br>
&gt; echo &quot;directory. This will work, but we recommend using a separat=
e&quot;<br>
&gt; echo &quot;build directory, especially if you plan to work with the QE=
MU&quot;<br>
&gt; echo &quot;sources rather than just building it once. You can switch t=
o&quot;<br>
&gt; echo &quot;a separate build directory like this:&quot;<br>
&gt; [instructions go here]<br>
&gt;</p>
<p dir=3D"ltr">Peter&#39;s version is far more superior to Daniel&#39;s.</p=
>
<p dir=3D"ltr">I&#39;d better not discuss the reasons, not wanting to waste=
 my time and other&#39;s time.</p>
<p dir=3D"ltr">For Peter&#39;s version:</p>
<p dir=3D"ltr">Reviewed-by: Aleksandar Markovic &lt;<a href=3D"mailto:aleks=
andar.qemu.devel@gmail.com">aleksandar.qemu.devel@gmail.com</a>&gt;<br></p>
<p dir=3D"ltr">&gt; thanks<br>
&gt; -- PMM<br>
&gt;<br>
</p>

--000000000000202b1c05a28dd4d8--

