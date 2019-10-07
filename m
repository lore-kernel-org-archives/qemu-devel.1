Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27991C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 07:14:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6986222D0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 07:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JfjdcI4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6986222D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHNDT-0000rA-5N
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 03:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iHNCn-0000LY-6e
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iHNCl-00053S-NR
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:13:17 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41522)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iHNCl-00053B-Gg
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 03:13:15 -0400
Received: by mail-oi1-x241.google.com with SMTP id w65so10763361oiw.8
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 00:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=+cDoZmdWN7eC+SMg9gFPQQ8n/k1X6cZIUIUJrtTSytI=;
 b=JfjdcI4SSOTmBs91LjweappeBbqtqQrcp8kMhh9aneVhKzWX5ZXpMRB4oZjcFganxt
 r6DW8UMRq2VriEy5Wz7l/1yuNm0zT00awyxglHJh4uBRUWM2+b/mfztfAeaKttsodaas
 b+dcOzCXeOthRYNQ9aMwAP/7jzaj9L3tFJOy+PPh+9zdM6djeJmwJA4dKhc+enGZ9mBO
 g2+rKY1PzNg20svkbmq6KcN4ReVNeWuteHfSNe8u8w89/h+WfQ9ryiUjNw7rCFPbE4mV
 eGvuZbUOE4RNc38JEdSWcUyL1WTF/XJRYUSxx/5DvRr9TbFZ3hqUGDBl9bS/Y6ux0JMC
 lKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=+cDoZmdWN7eC+SMg9gFPQQ8n/k1X6cZIUIUJrtTSytI=;
 b=jsFVYhNNl+0gmIkOk8RsYDiF1zRwlUVYMJ1b3Zufy3uoa7u2esx5JSYcghu845Fg3a
 gIGAPVEGlAOaZsyUXEb2amvkFmmJT/wZX3jfEkUth8PtVQqCnZ9neusJ8zVSqeHqg2HO
 o+ZQdLTs832yaqeDIATiogOaUJRYGpSQP+QmAcSidRHm9OtysTjRr728ROC+dRrOK+sD
 PcFEwP/0rE8AnIfw3w6zi+epFfnpuQkmzNOlWv6FP9evqxle77zioDVsIdxnyx7G9LM7
 6ChOr+fhKCk7JLPiyd92DoaIUMNJ7EACIh0d7rquQs60RdlV12XqiVLpXh1F28fSfX2N
 emMQ==
X-Gm-Message-State: APjAAAVjyIHbmZB+5B81TNJMkA1GodokC57FlPAPimXj6xuKMT/T4QdR
 VTeVjFa6vYmM5cUJpUeaKCBGZ2kH/AXJ1IhRjK0=
X-Google-Smtp-Source: APXvYqzs+Kw24QBnS/v2JiVvyt+wgd/r++5eTWjZTHNC6ws3uLwS7Wldp+GwKdjRePP0aGXndIbvzQGHSCshmyeCuCE=
X-Received: by 2002:aca:f002:: with SMTP id o2mr17292988oih.62.1570432393936; 
 Mon, 07 Oct 2019 00:13:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:340a:0:0:0:0:0 with HTTP;
 Mon, 7 Oct 2019 00:13:13 -0700 (PDT)
In-Reply-To: <462372733.5727265.1570429730233.JavaMail.zimbra@redhat.com>
References: <1570035113-56848-1-git-send-email-pbonzini@redhat.com>
 <1570035113-56848-13-git-send-email-pbonzini@redhat.com>
 <CAFEAcA--sjm+ejLLdaQtsVC4u4adA9p+QDSJ2QKQ2hSBLt=oDw@mail.gmail.com>
 <88f324b0-65a1-1a7b-b663-27415ae11cb2@redhat.com>
 <462372733.5727265.1570429730233.JavaMail.zimbra@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 7 Oct 2019 09:13:13 +0200
Message-ID: <CAL1e-=i_o11WQCf3qaE=qKyZmf+yoLegxVFbBpPrNYuE3Jawow@mail.gmail.com>
Subject: Re: [PULL 12/30] Makefile: Remove generated files when doing
 'distclean'
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000fc04a905944cc8d9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000fc04a905944cc8d9
Content-Type: text/plain; charset="UTF-8"

On Monday, October 7, 2019, Thomas Huth <thuth@redhat.com> wrote:

> ----- Original Message -----
> > From: "Paolo Bonzini" <pbonzini@redhat.com>
> > To: "Peter Maydell" <peter.maydell@linaro.org>
> > Cc: "QEMU Developers" <qemu-devel@nongnu.org>, "Thomas Huth" <
> thuth@redhat.com>
> > Sent: Friday, October 4, 2019 6:48:47 PM
> > Subject: Re: [PULL 12/30] Makefile: Remove generated files when doing
> 'distclean'
> >
> > On 04/10/19 14:20, Peter Maydell wrote:
> > > On Wed, 2 Oct 2019 at 18:07, Paolo Bonzini <pbonzini@redhat.com>
> wrote:
> > >>
> > >> From: Thomas Huth <thuth@redhat.com>
> > >>
> > >> When running "make distclean" we currently leave a lot of generated
> > >> files in the build directory. Fix that.
> > >>
> > >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > >> Reviewed-by: John Snow <jsnow@redhat.com>
> > >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > >> ---
> > >
> > >> diff --git a/tests/Makefile.include b/tests/Makefile.include
> > >> index 3543451..48b52da 100644
> > >> --- a/tests/Makefile.include
> > >> +++ b/tests/Makefile.include
> > >> @@ -1176,11 +1176,21 @@ check: check-block check-qapi-schema
> check-unit
> > >> check-softfloat check-qtest chec
> > >>  check-clean:
> > >>         rm -rf $(check-unit-y) tests/*.o $(QEMU_IOTESTS_HELPERS-y)
> > >>         rm -rf $(sort $(foreach target,$(SYSEMU_TARGET_LIST),
> > >>         $(check-qtest-$(target)-y)) $(check-qtest-generic-y))
> > >> -       rm -f tests/test-qapi-gen-timestamp
> > >>         rm -rf $(TESTS_VENV_DIR) $(TESTS_RESULTS_DIR)
> > >> +       rm -f tests/qemu-iotests/common.env tests/qemu-iotests/check.*
> > >> +       rm -f tests/test-qapi-gen-timestamp tests/qht-bench$(EXESUF) \
> > >> +               tests/fp/fp-test tests/fp/*.out
> tests/qapi-schema/*.test.*
> > >>
> > >>  clean: check-clean
> > >
> > > Hi; this change breaks the sequence
> > >  'make clean; make; make check'
> > >
> > > because now 'make clean' removes tests/qemu-iotests/common.env.
> > > But this file is created by 'configure', not by 'make', so if there's
> > > no other reason why 'make' needs to re-run configure then we get
> > > to the 'make check' stage with the file not existing, and then
> > > when we try to run the iotests they fail with:
> > >
> > > ./check: line 60:
> > > /home/petmay01/linaro/qemu-for-merges/build/alldbg/tests/
> qemu-iotests/common.env:
> > > No such file or directory
> > > check: failed to source common.env (make sure the qemu-iotests are run
> > > from tests/qemu-iotests in the build tree)
> > > /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:1102:
> > > recipe for target 'check-tests/check-block.sh' failed
> >
> > I've dropped this patch and will send v3 that adds back the VMX patches.
>
> Thanks, and I will rework the patch to only remove that file during "make
> distclean",
> and not already during "make clean".
>
>  Thomas
>
>
The commit message says that it affects "make distclean". It does not
mention "make clean", while the change obviously affects "make clean" too.
It looks to me that the commit message was misleading. It would be good if
the new version of the patch has clearer (not misleading) commit message,
specifying what exactly is affected by the change. Or, alteratively, this
patch could be split into several ones.

Thanks,
Aleksandar

--000000000000fc04a905944cc8d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Monday, October 7, 2019, Thomas Huth &lt;<a href=3D"mailto:thuth=
@redhat.com">thuth@redhat.com</a>&gt; wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">----- Original Message -----<br>
&gt; From: &quot;Paolo Bonzini&quot; &lt;<a href=3D"mailto:pbonzini@redhat.=
com">pbonzini@redhat.com</a>&gt;<br>
&gt; To: &quot;Peter Maydell&quot; &lt;<a href=3D"mailto:peter.maydell@lina=
ro.org">peter.maydell@linaro.org</a>&gt;<br>
&gt; Cc: &quot;QEMU Developers&quot; &lt;<a href=3D"mailto:qemu-devel@nongn=
u.org">qemu-devel@nongnu.org</a>&gt;, &quot;Thomas Huth&quot; &lt;<a href=
=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt;<br>
&gt; Sent: Friday, October 4, 2019 6:48:47 PM<br>
&gt; Subject: Re: [PULL 12/30] Makefile: Remove generated files when doing =
&#39;distclean&#39;<br>
&gt; <br>
&gt; On 04/10/19 14:20, Peter Maydell wrote:<br>
&gt; &gt; On Wed, 2 Oct 2019 at 18:07, Paolo Bonzini &lt;<a href=3D"mailto:=
pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; From: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thu=
th@redhat.com</a>&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; When running &quot;make distclean&quot; we currently leave a =
lot of generated<br>
&gt; &gt;&gt; files in the build directory. Fix that.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Thomas Huth &lt;<a href=3D"mailto:thuth@redhat=
.com">thuth@redhat.com</a>&gt;<br>
&gt; &gt;&gt; Reviewed-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com=
">jsnow@redhat.com</a>&gt;<br>
&gt; &gt;&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@r=
edhat.com">pbonzini@redhat.com</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt; <br>
&gt; &gt;&gt; diff --git a/tests/Makefile.include b/tests/Makefile.include<=
br>
&gt; &gt;&gt; index 3543451..48b52da 100644<br>
&gt; &gt;&gt; --- a/tests/Makefile.include<br>
&gt; &gt;&gt; +++ b/tests/Makefile.include<br>
&gt; &gt;&gt; @@ -1176,11 +1176,21 @@ check: check-block check-qapi-schema =
check-unit<br>
&gt; &gt;&gt; check-softfloat check-qtest chec<br>
&gt; &gt;&gt;=C2=A0 check-clean:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -rf $(check-unit-y) tests=
/*.o $(QEMU_IOTESTS_HELPERS-y)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -rf $(sort $(foreach targ=
et,$(SYSEMU_TARGET_LIST),<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$(check-qtest-$(target)-y)) =
$(check-qtest-generic-y))<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/test-qapi-gen-timesta=
mp<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -rf $(TESTS_VENV_DIR) $(T=
ESTS_RESULTS_DIR)<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/qemu-iotests/common.e=
nv tests/qemu-iotests/check.*<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0rm -f tests/test-qapi-gen-timesta=
mp tests/qht-bench$(EXESUF) \<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests=
/fp/fp-test tests/fp/*.out tests/qapi-schema/*.test.*<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 clean: check-clean<br>
&gt; &gt; <br>
&gt; &gt; Hi; this change breaks the sequence<br>
&gt; &gt;=C2=A0 &#39;make clean; make; make check&#39;<br>
&gt; &gt; <br>
&gt; &gt; because now &#39;make clean&#39; removes tests/qemu-iotests/commo=
n.env.<br>
&gt; &gt; But this file is created by &#39;configure&#39;, not by &#39;make=
&#39;, so if there&#39;s<br>
&gt; &gt; no other reason why &#39;make&#39; needs to re-run configure then=
 we get<br>
&gt; &gt; to the &#39;make check&#39; stage with the file not existing, and=
 then<br>
&gt; &gt; when we try to run the iotests they fail with:<br>
&gt; &gt; <br>
&gt; &gt; ./check: line 60:<br>
&gt; &gt; /home/petmay01/linaro/qemu-<wbr>for-merges/build/alldbg/tests/<wb=
r>qemu-iotests/common.env:<br>
&gt; &gt; No such file or directory<br>
&gt; &gt; check: failed to source common.env (make sure the qemu-iotests ar=
e run<br>
&gt; &gt; from tests/qemu-iotests in the build tree)<br>
&gt; &gt; /home/petmay01/linaro/qemu-<wbr>for-merges/tests/Makefile.<wbr>in=
clude:1102:<br>
&gt; &gt; recipe for target &#39;check-tests/check-block.sh&#39; failed<br>
&gt; <br>
&gt; I&#39;ve dropped this patch and will send v3 that adds back the VMX pa=
tches.<br>
<br>
Thanks, and I will rework the patch to only remove that file during &quot;m=
ake distclean&quot;,<br>
and not already during &quot;make clean&quot;.<br>
<br>
=C2=A0Thomas<br>
<br>
</blockquote><div><br></div><div>The commit message says that it affects &q=
uot;make distclean&quot;. It does not mention &quot;make clean&quot;, while=
 the change obviously affects &quot;make clean&quot; too. It looks to me th=
at the commit message was misleading. It would be good if the new version o=
f the patch has clearer (not misleading) commit message, specifying what ex=
actly is affected by the change. Or, alteratively, this patch could be spli=
t into several ones.</div><div><br></div><div>Thanks,</div><div>Aleksandar<=
br></div>

--000000000000fc04a905944cc8d9--

