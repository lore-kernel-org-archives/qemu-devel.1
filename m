Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8D5C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:52:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E21820866
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrhdHIoO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E21820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8PSE-0000Zf-IJ
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k8PR9-00089A-3Q
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:51:35 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1k8PR6-00049A-Ui
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:51:34 -0400
Received: by mail-oi1-x241.google.com with SMTP id l204so21220651oib.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 07:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V5ql+c4aPit03IhaGdZ07yHY0PmRvZHMWMUTbPdXgVc=;
 b=ZrhdHIoOQ4TqgtyNhwjh5JzNvTFqCU+9gJI0I5gv+JFELwTKUyahiYU3x5op1Pgp+i
 IiOw4lRH4No3fjJbGtLGLkUq+iv+zaa7tAyJCOavDTaipl+2Zn+u56yRikMZPjwhcrsV
 fP95lC22O7vFYDTj/MxtpCg0+bNTQs7DylfzgG7vRIdR00eIhhcppsG2X09zSOePmq+m
 2jDEz0B51BGddIodlPJfnye3tkBVon74uMpaLAIYebJlDveKaUiuRGx4SnwDtoInM77+
 yqCqEy2LdvYo6bJp8kxVwIwIlnS1Cy+LabJloIgbknyoZ8oj9Cg93iepdpJb9kkxuo/u
 IGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V5ql+c4aPit03IhaGdZ07yHY0PmRvZHMWMUTbPdXgVc=;
 b=UL3y6HH2MW2RlXFyg9hot6BYenfc523JRBzflXaGRQA68KFmAoj5HzMG8xM4CHZ9UC
 SddatAdAQdAAoKRp0QyLyu8jNzRO+7Ulbv+9KQvCen7ADvi4ji/9S/KMunS/UmlTklIK
 ICTRTv4St/lMb51qZUl6GOHz+HdavMGkypMFEGgS/sfQcYTqIp/H50cZ+flEzh93vWFK
 FHNo7S+w6xEc0jJEo5ugB8q7S0TbGbEquKuQvhzH+Z2AC/bHqIF7A4Hsxx9fv5Ru7d5f
 oRLRYvRCgDcKtRkGKAVVKOJjnfoL+VYIhPlPArlo6b/X3SJY7YvuAL4CJ6rEIP/2iR4p
 ZnFQ==
X-Gm-Message-State: AOAM53184tSP4ZZS/0wOEVB0FEODT2kAiyTy79E46kVO0d2QJgxEx81k
 piyXKS+UD5wmjNLPd8b/kGOspkz/QW8/wVX3ZS4=
X-Google-Smtp-Source: ABdhPJynLW6S2FcCBig/ZKqQ1LlTtmqyz0vGWhqY6WzDi1m/t5svypfBjn5NmEmDjLw0EM34KMS7oqbWx0IEhh4orKg=
X-Received: by 2002:aca:fd46:: with SMTP id b67mr3362889oii.150.1597848691394; 
 Wed, 19 Aug 2020 07:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200819141533.66354-1-liq3ea@163.com>
 <baabaa94-e4bf-3578-2f78-624704eb29c4@redhat.com>
In-Reply-To: <baabaa94-e4bf-3578-2f78-624704eb29c4@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 19 Aug 2020 22:50:54 +0800
Message-ID: <CAKXe6S+Vpe5NH4j22deQLxZaX7NRFtwvGR0FhEoBPPNdK33ibQ@mail.gmail.com>
Subject: Re: [PATCH] qtest: add fuzz test case
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a7ce3705ad3c23e3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x241.google.com
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a7ce3705ad3c23e3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =E4=BA=8E2020=E5=B9=B48=E6=
=9C=8819=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:38=E5=86=99=E9=81=
=93=EF=BC=9A

> On 8/19/20 4:15 PM, Li Qiang wrote:
> > Currently the device fuzzer find a more and more issues.
> > For every fuzz case, we need not only the fixes but also
> > the coressponding test case. We can analysis the reproducer
>
> Typo "corresponding"
>

Will correct in next revision.


>
> > for every case and find what happened in where and write
> > a beautiful test case. However the raw data of reproducer is not
> > friendly to analysis. It will take a very long time, even far more
> > than the fixes itself. So let's create a new file to hold all of
> > the fuzz test cases and just use the raw data to act as the test
> > case. This way nobody will be afraid of writing a test case for
> > the fuzz reproducer.
>
> Ahaha nice :)
>
> >
> > This patch adds the issue LP#1878263 test case.
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  tests/qtest/Makefile.include |  2 ++
> >  tests/qtest/fuzz-test.c      | 45 ++++++++++++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >  create mode 100644 tests/qtest/fuzz-test.c
> >
> > diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.includ=
e
> > index b0204e44f2..ff460179c5 100644
> > --- a/tests/qtest/Makefile.include
> > +++ b/tests/qtest/Makefile.include
> > @@ -7,6 +7,7 @@ check-qtest-generic-y +=3D machine-none-test
> >  check-qtest-generic-y +=3D qmp-test
> >  check-qtest-generic-y +=3D qmp-cmd-test
> >  check-qtest-generic-y +=3D qom-test
> > +check-qtest-generic-y +=3D fuzz-test
>
> Maybe name that fuzzed-reproducers-test?
>

This maybe be more understandable.


>
> >  check-qtest-generic-$(CONFIG_MODULES) +=3D modules-test
> >  check-qtest-generic-y +=3D test-hmp
> >
> > @@ -272,6 +273,7 @@ tests/qtest/m25p80-test$(EXESUF):
> tests/qtest/m25p80-test.o
> >  tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o
> $(libqos-pc-obj-y)
> >  tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-pc-obj-=
y)
> >  tests/qtest/fw_cfg-test$(EXESUF): tests/qtest/fw_cfg-test.o
> $(libqos-pc-obj-y)
> > +tests/qtest/fuzz-test$(EXESUF): tests/qtest/fuzz-test.o
> $(libqos-pc-obj-y)
> >  tests/qtest/rtl8139-test$(EXESUF): tests/qtest/rtl8139-test.o
> $(libqos-pc-obj-y)
> >  tests/qtest/pnv-xscom-test$(EXESUF): tests/qtest/pnv-xscom-test.o
> >  tests/qtest/wdt_ib700-test$(EXESUF): tests/qtest/wdt_ib700-test.o
> > diff --git a/tests/qtest/fuzz-test.c b/tests/qtest/fuzz-test.c
> > new file mode 100644
> > index 0000000000..695c6dffb9
> > --- /dev/null
> > +++ b/tests/qtest/fuzz-test.c
> > @@ -0,0 +1,45 @@
> > +/*
> > + * QTest testcase for fuzz case
> > + *
> > + * Copyright (c) 2020 Li Qiang <liq3ea@gmail.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "libqtest.h"
> > +
> > +/*
> > + * This used to trigger the assert in scsi_dma_complete
> > + * https://bugs.launchpad.net/qemu/+bug/1878263
> > + */
> > +static void test_megasas_zero_iov_cnt(void)
>
> I'd name it test_lp1878263_megasas_zero_iov_cnt()
>

This seems better.


> or lp1878263_megasas_zero_iov_cnt().



>
> > +{
> > +    QTestState *s;
> > +
> > +    s =3D qtest_init("-nographic -monitor none -serial none "
> > +                   "-M q35 -device megasas -device scsi-cd,drive=3Dnul=
l0 "
> > +                   "-blockdev
> driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull0");
> > +    qtest_outl(s, 0xcf8, 0x80001818);
> > +    qtest_outl(s, 0xcfc, 0xc101);
> > +    qtest_outl(s, 0xcf8, 0x8000181c);
> > +    qtest_outl(s, 0xcf8, 0x80001804);
> > +    qtest_outw(s, 0xcfc, 0x7);
> > +    qtest_outl(s, 0xcf8, 0x8000186a);
> > +    qtest_writeb(s, 0x14, 0xfe);
> > +    qtest_writeb(s, 0x0, 0x02);
> > +    qtest_outb(s, 0xc1c0, 0x17);
> > +    qtest_quit(s);
>
> Actually all the test body could be generated...

Alex, can you have a look at that?
>
> > +}
> > +
> > +int main(int argc, char **argv)
> > +{
> > +    g_test_init(&argc, &argv, NULL);
> > +
> > +    qtest_add_func("fuzz/megasas_zero_iov_cnt",
> test_megasas_zero_iov_cnt);
> > +
> > +    return g_test_run();
>
> The problem is now the test suite will fail because this test is not
> fixed.
>
>
Yes, as Paolo queued my patch to solve this:
-->https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg03712.html

I think this patch should go Paolo's tree.

Thanks,
Li Qiang


> Good idea btw :)
>
> > +}
> >
>
>

--000000000000a7ce3705ad3c23e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">Philippe Mathieu-Daud=C3=A9 &lt;<a hr=
ef=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; =E4=BA=8E2020=E5=
=B9=B48=E6=9C=8819=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:38=E5=86=
=99=E9=81=93=EF=BC=9A<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">On 8/19/20 4:15 PM, Li Qiang wrote:<br>
&gt; Currently the device fuzzer find a more and more issues.<br>
&gt; For every fuzz case, we need not only the fixes but also<br>
&gt; the coressponding test case. We can analysis the reproducer<br>
<br>
Typo &quot;corresponding&quot;<br></blockquote><div><br></div><div>Will cor=
rect in next revision.</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
<br>
&gt; for every case and find what happened in where and write<br>
&gt; a beautiful test case. However the raw data of reproducer is not<br>
&gt; friendly to analysis. It will take a very long time, even far more<br>
&gt; than the fixes itself. So let&#39;s create a new file to hold all of<b=
r>
&gt; the fuzz test cases and just use the raw data to act as the test<br>
&gt; case. This way nobody will be afraid of writing a test case for<br>
&gt; the fuzz reproducer.<br>
<br>
Ahaha nice :)<br>
<br>
&gt; <br>
&gt; This patch adds the issue LP#1878263 test case.<br>
&gt; <br>
&gt; Signed-off-by: Li Qiang &lt;<a href=3D"mailto:liq3ea@163.com" target=
=3D"_blank">liq3ea@163.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/qtest/Makefile.include |=C2=A0 2 ++<br>
&gt;=C2=A0 tests/qtest/fuzz-test.c=C2=A0 =C2=A0 =C2=A0 | 45 +++++++++++++++=
+++++++++++++++++++++<br>
&gt;=C2=A0 2 files changed, 47 insertions(+)<br>
&gt;=C2=A0 create mode 100644 tests/qtest/fuzz-test.c<br>
&gt; <br>
&gt; diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.inclu=
de<br>
&gt; index b0204e44f2..ff460179c5 100644<br>
&gt; --- a/tests/qtest/Makefile.include<br>
&gt; +++ b/tests/qtest/Makefile.include<br>
&gt; @@ -7,6 +7,7 @@ check-qtest-generic-y +=3D machine-none-test<br>
&gt;=C2=A0 check-qtest-generic-y +=3D qmp-test<br>
&gt;=C2=A0 check-qtest-generic-y +=3D qmp-cmd-test<br>
&gt;=C2=A0 check-qtest-generic-y +=3D qom-test<br>
&gt; +check-qtest-generic-y +=3D fuzz-test<br>
<br>
Maybe name that fuzzed-reproducers-test?<br></blockquote><div><br></div><di=
v>This maybe be more understandable.</div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 check-qtest-generic-$(CONFIG_MODULES) +=3D modules-test<br>
&gt;=C2=A0 check-qtest-generic-y +=3D test-hmp<br>
&gt;=C2=A0 <br>
&gt; @@ -272,6 +273,7 @@ tests/qtest/m25p80-test$(EXESUF): tests/qtest/m25p=
80-test.o<br>
&gt;=C2=A0 tests/qtest/i440fx-test$(EXESUF): tests/qtest/i440fx-test.o $(li=
bqos-pc-obj-y)<br>
&gt;=C2=A0 tests/qtest/q35-test$(EXESUF): tests/qtest/q35-test.o $(libqos-p=
c-obj-y)<br>
&gt;=C2=A0 tests/qtest/fw_cfg-test$(EXESUF): tests/qtest/fw_cfg-test.o $(li=
bqos-pc-obj-y)<br>
&gt; +tests/qtest/fuzz-test$(EXESUF): tests/qtest/fuzz-test.o $(libqos-pc-o=
bj-y)<br>
&gt;=C2=A0 tests/qtest/rtl8139-test$(EXESUF): tests/qtest/rtl8139-test.o $(=
libqos-pc-obj-y)<br>
&gt;=C2=A0 tests/qtest/pnv-xscom-test$(EXESUF): tests/qtest/pnv-xscom-test.=
o<br>
&gt;=C2=A0 tests/qtest/wdt_ib700-test$(EXESUF): tests/qtest/wdt_ib700-test.=
o<br>
&gt; diff --git a/tests/qtest/fuzz-test.c b/tests/qtest/fuzz-test.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..695c6dffb9<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/qtest/fuzz-test.c<br>
&gt; @@ -0,0 +1,45 @@<br>
&gt; +/*<br>
&gt; + * QTest testcase for fuzz case<br>
&gt; + *<br>
&gt; + * Copyright (c) 2020 Li Qiang &lt;<a href=3D"mailto:liq3ea@gmail.com=
" target=3D"_blank">liq3ea@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This work is licensed under the terms of the GNU GPL, version 2 or=
 later.<br>
&gt; + * See the COPYING file in the top-level directory.<br>
&gt; + */<br>
&gt; +<br>
&gt; +<br>
&gt; +#include &quot;qemu/osdep.h&quot;<br>
&gt; +<br>
&gt; +#include &quot;libqtest.h&quot;<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * This used to trigger the assert in scsi_dma_complete<br>
&gt; + * <a href=3D"https://bugs.launchpad.net/qemu/+bug/1878263" rel=3D"no=
referrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug/1878263</a=
><br>
&gt; + */<br>
&gt; +static void test_megasas_zero_iov_cnt(void)<br>
<br>
I&#39;d name it test_lp1878263_megasas_zero_iov_cnt()<br></blockquote><div>=
<br></div><div>This seems better.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
or lp1878263_megasas_zero_iov_cnt().</blockquote><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 QTestState *s;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s =3D qtest_init(&quot;-nographic -monitor none -serial=
 none &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot;-M q35 -device megasas -device scsi-cd,drive=3Dnull0 &quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
&quot;-blockdev driver=3Dnull-co,read-zeroes=3Don,node-name=3Dnull0&quot;);=
<br>
&gt; +=C2=A0 =C2=A0 qtest_outl(s, 0xcf8, 0x80001818);<br>
&gt; +=C2=A0 =C2=A0 qtest_outl(s, 0xcfc, 0xc101);<br>
&gt; +=C2=A0 =C2=A0 qtest_outl(s, 0xcf8, 0x8000181c);<br>
&gt; +=C2=A0 =C2=A0 qtest_outl(s, 0xcf8, 0x80001804);<br>
&gt; +=C2=A0 =C2=A0 qtest_outw(s, 0xcfc, 0x7);<br>
&gt; +=C2=A0 =C2=A0 qtest_outl(s, 0xcf8, 0x8000186a);<br>
&gt; +=C2=A0 =C2=A0 qtest_writeb(s, 0x14, 0xfe);<br>
&gt; +=C2=A0 =C2=A0 qtest_writeb(s, 0x0, 0x02);<br>
&gt; +=C2=A0 =C2=A0 qtest_outb(s, 0xc1c0, 0x17);<br>
&gt; +=C2=A0 =C2=A0 qtest_quit(s);<br>
<br>
Actually all the test body could be generated...</blockquote><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
Alex, can you have a look at that?<br>
<br>
&gt; +}<br>
&gt; +<br>
&gt; +int main(int argc, char **argv)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 g_test_init(&amp;argc, &amp;argv, NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qtest_add_func(&quot;fuzz/megasas_zero_iov_cnt&quot;, t=
est_megasas_zero_iov_cnt);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return g_test_run();<br>
<br>
The problem is now the test suite will fail because this test is not<br>
fixed.<br>
<br></blockquote><div><br></div><div>Yes, as Paolo queued my patch to solve=
 this:</div><div>--&gt;<a href=3D"https://lists.gnu.org/archive/html/qemu-d=
evel/2020-08/msg03712.html">https://lists.gnu.org/archive/html/qemu-devel/2=
020-08/msg03712.html</a></div><div><br></div><div>I think this patch should=
 go Paolo&#39;s tree.</div><div><br></div><div>Thanks,</div><div>Li Qiang</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Good idea btw :)<br>
<br>
&gt; +}<br>
&gt; <br>
<br>
</blockquote></div></div>

--000000000000a7ce3705ad3c23e3--

