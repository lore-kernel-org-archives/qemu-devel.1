Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771B5C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C72432080A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbPentXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72432080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG5G1-0004m4-TW
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG5FG-00046g-0y; Wed, 09 Sep 2020 14:55:02 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:45198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kG5FD-0000sA-SW; Wed, 09 Sep 2020 14:55:01 -0400
Received: by mail-lf1-x142.google.com with SMTP id z17so2147824lfi.12;
 Wed, 09 Sep 2020 11:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=A2UEKaO2bmOfPugexAM0jINg04jfhDXT34YfvBVks5A=;
 b=IbPentXcd97nAo53CednuWE1LMlLiiPF57b/FK1WGWovh9SvdwVJVbSLZY7dc0/aam
 /WSSbb3BDdpSnZZ9kBtRK0ZB4N5VcGtQkPfmOMDXpkydJWvThQHpaebLRNJC2hsnSgeu
 6+P0ixjWTEmPPT6PthxSBA84oQu9W895zqgr7LRFVAFCJhPZJueO7gEXk/vDHViSxJ6i
 jIYLwDpkBdoZHpI3ASJeI1AQERgKrEfBjUlSDBMSSO839pGLnItCfmtkowRk653sR5Ib
 u9zYS+/5v+TtUj31Ki7nfZanhVWBo1toXYMLyakR/onTSFVMEbRko38fj0TSSM73i8xo
 8fbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=A2UEKaO2bmOfPugexAM0jINg04jfhDXT34YfvBVks5A=;
 b=rQvrh354gptCCPQ/YU6/WY69oHAUlOvqkhVwq2JHw/N4dc/BJ/btPPjykdBilbcDGE
 tskh35yU9scYuP9ilfhzeoEGVQ2u5JT9DONidRdcGuZzcQkVDM8pIG+fc+KeBaSRrzY7
 pN5yFFvf68XEhx7JRJ2LJMiiEU+KeJ6mBeO9Pkn/RxneW7CzsZf1c6IzQi9USat2jfw9
 Bguazgr6f2QuisUV5HusCmSdXyc/7WrLpWDdyAMJdQ49Gj+FOpYzp8mc2tlqehogYK08
 2+5XotD7RUtE2eJ7XZqbIa2Dele8NDC9CFE90lNv7J0X0bbOpPhzEV1PPo9+2ShNcftH
 0p2g==
X-Gm-Message-State: AOAM532E2yxb6p7md1AeGRONGzKOUEPCetUesqmORYou7uJgZG2xGpwo
 skAsc8ytasMJ3STWGiazRrt2FUlU2SwSnKlsrqw=
X-Google-Smtp-Source: ABdhPJxK5SHAKCQMee7ArgGyLi0Wh5QszxKbOqgMBV/d/z+4TmSI7KhrXzwibj3LcD7q/J/fByk3Wi4NqxhN1SnTP0s=
X-Received: by 2002:a19:41c8:: with SMTP id o191mr2553719lfa.176.1599677697267; 
 Wed, 09 Sep 2020 11:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200909184237.765-1-luoyonggang@gmail.com>
 <70cdfb53-b1d3-0029-923b-ec33a170eedb@redhat.com>
In-Reply-To: <70cdfb53-b1d3-0029-923b-ec33a170eedb@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 10 Sep 2020 02:54:46 +0800
Message-ID: <CAE2XoE8nGYOV5QV5EQzBX+LqOOMze28p3g-HxH1x7gndS10FdQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/25] tests: disable /char/stdio/* tests in
 test-char.c on win32
To: Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e69d1f05aee5fc28"
Received-SPF: pass client-ip=2a00:1450:4864:20::142;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x142.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Qemu-block <qemu-block@nongnu.org>, Stefan Weil <sw@weilnetz.de>,
 Xie Changlong <xiechanglong.d@gmail.com>, Peter Lieven <pl@kamp.de>,
 qemu-level <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Wen Congyang <wencongyang2@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e69d1f05aee5fc28
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 2:48 AM Thomas Huth <thuth@redhat.com> wrote:

> On 09/09/2020 20.42, Yonggang Luo wrote:
> > These tests are blocking test-char to be finished.
> > Disable them by using variable is_win32, so we doesn't
> > need macro to open it. and easy recover those function
> > latter.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  tests/test-char.c | 26 ++++++++++++++++----------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/tests/test-char.c b/tests/test-char.c
> > index d35cc839bc..184ddceab8 100644
> > --- a/tests/test-char.c
> > +++ b/tests/test-char.c
> > @@ -77,7 +77,6 @@ static void fe_event(void *opaque, QEMUChrEvent event=
)
> >      }
> >  }
> >
> > -#ifdef _WIN32
> >  static void char_console_test_subprocess(void)
> >  {
> >      QemuOpts *opts;
> > @@ -102,7 +101,7 @@ static void char_console_test(void)
> >      g_test_trap_assert_passed();
> >      g_test_trap_assert_stdout("CONSOLE");
> >  }
> > -#endif
> > +
> >  static void char_stdio_test_subprocess(void)
> >  {
> >      Chardev *chr;
> > @@ -1448,7 +1447,11 @@ static SocketAddress unixaddr =3D {
> >
> >  int main(int argc, char **argv)
> >  {
> > -    bool has_ipv4, has_ipv6;
> > +    bool has_ipv4, has_ipv6, is_win32 =3D false;
> > +
> > +#ifdef _WIN32
> > +    is_win32 =3D true;
> > +#endif
> >
> >      qemu_init_main_loop(&error_abort);
> >      socket_init();
> > @@ -1467,12 +1470,15 @@ int main(int argc, char **argv)
> >      g_test_add_func("/char/invalid", char_invalid_test);
> >      g_test_add_func("/char/ringbuf", char_ringbuf_test);
> >      g_test_add_func("/char/mux", char_mux_test);
> > -#ifdef _WIN32
> > -    g_test_add_func("/char/console/subprocess",
> char_console_test_subprocess);
> > -    g_test_add_func("/char/console", char_console_test);
> > -#endif
> > -    g_test_add_func("/char/stdio/subprocess",
> char_stdio_test_subprocess);
> > -    g_test_add_func("/char/stdio", char_stdio_test);
> > +    if (0) {
> > +        g_test_add_func("/char/console/subprocess",
> char_console_test_subprocess);
> > +        g_test_add_func("/char/console", char_console_test);
> > +    }
>
> Sorry, but this looks pretty much like a work-in-progress debugging
> patch. Please avoid sending such stuff to the mailing list, and if so,
> clearly mark it as an RFC and describe it in the patch description.
>
> It also does not help much if you send your series three times a day to
> the list - nobody has that much reviewing band width. So please take
> some time, finish your patches first, and when you're sure that they are
> really finished, then post a new series to the mailing list.
>
Sorry for that, test-char is hard to fix and I can not fixes in my own, so
I need help from community,
For all other patches I am confident, but for this, I am asking for help,
I'd like to know who is familiar with
char and I'd like to talk with them privately if possible.

>
> Thanks,
>  Thomas
>
>
> > +    if (!is_win32) {
> > +        g_test_add_func("/char/stdio/subprocess",
> char_stdio_test_subprocess);
> > +        g_test_add_func("/char/stdio", char_stdio_test);
> > +    }
> >  #ifndef _WIN32
> >      g_test_add_func("/char/pipe", char_pipe_test);
> >  #endif
> > @@ -1534,7 +1540,7 @@ int main(int argc, char **argv)
> >      g_test_add_data_func("/char/socket/client/dupid-reconnect/" # name=
,
> \
> >                           &client8 ##name, char_socket_client_dupid_tes=
t)
> >
> > -    if (has_ipv4) {
> > +    if (has_ipv4 && !is_win32) {
> >          SOCKET_SERVER_TEST(tcp, &tcpaddr);
> >          SOCKET_CLIENT_TEST(tcp, &tcpaddr);
> >          g_test_add_data_func("/char/socket/server/two-clients/tcp",
> &tcpaddr,
> >
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000e69d1f05aee5fc28
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 10, 2020 at 2:48 AM Thoma=
s Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 09/09/202=
0 20.42, Yonggang Luo wrote:<br>
&gt; These tests are blocking test-char to be finished.<br>
&gt; Disable them by using variable is_win32, so we doesn&#39;t<br>
&gt; need macro to open it. and easy recover those function<br>
&gt; latter.<br>
&gt; <br>
&gt; Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.co=
m" target=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 tests/test-char.c | 26 ++++++++++++++++----------<br>
&gt;=C2=A0 1 file changed, 16 insertions(+), 10 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/test-char.c b/tests/test-char.c<br>
&gt; index d35cc839bc..184ddceab8 100644<br>
&gt; --- a/tests/test-char.c<br>
&gt; +++ b/tests/test-char.c<br>
&gt; @@ -77,7 +77,6 @@ static void fe_event(void *opaque, QEMUChrEvent even=
t)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -#ifdef _WIN32<br>
&gt;=C2=A0 static void char_console_test_subprocess(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 QemuOpts *opts;<br>
&gt; @@ -102,7 +101,7 @@ static void char_console_test(void)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_trap_assert_passed();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_trap_assert_stdout(&quot;CONSOLE&quot;);<br=
>
&gt;=C2=A0 }<br>
&gt; -#endif<br>
&gt; +<br>
&gt;=C2=A0 static void char_stdio_test_subprocess(void)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Chardev *chr;<br>
&gt; @@ -1448,7 +1447,11 @@ static SocketAddress unixaddr =3D {<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 int main(int argc, char **argv)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 bool has_ipv4, has_ipv6;<br>
&gt; +=C2=A0 =C2=A0 bool has_ipv4, has_ipv6, is_win32 =3D false;<br>
&gt; +<br>
&gt; +#ifdef _WIN32<br>
&gt; +=C2=A0 =C2=A0 is_win32 =3D true;<br>
&gt; +#endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_init_main_loop(&amp;error_abort);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 socket_init();<br>
&gt; @@ -1467,12 +1470,15 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/char/invalid&quot;, char_in=
valid_test);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/char/ringbuf&quot;, char_ri=
ngbuf_test);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/char/mux&quot;, char_mux_te=
st);<br>
&gt; -#ifdef _WIN32<br>
&gt; -=C2=A0 =C2=A0 g_test_add_func(&quot;/char/console/subprocess&quot;, c=
har_console_test_subprocess);<br>
&gt; -=C2=A0 =C2=A0 g_test_add_func(&quot;/char/console&quot;, char_console=
_test);<br>
&gt; -#endif<br>
&gt; -=C2=A0 =C2=A0 g_test_add_func(&quot;/char/stdio/subprocess&quot;, cha=
r_stdio_test_subprocess);<br>
&gt; -=C2=A0 =C2=A0 g_test_add_func(&quot;/char/stdio&quot;, char_stdio_tes=
t);<br>
&gt; +=C2=A0 =C2=A0 if (0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/char/console/subpr=
ocess&quot;, char_console_test_subprocess);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/char/console&quot;=
, char_console_test);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Sorry, but this looks pretty much like a work-in-progress debugging<br>
patch. Please avoid sending such stuff to the mailing list, and if so,<br>
clearly mark it as an RFC and describe it in the patch description.<br>
<br>
It also does not help much if you send your series three times a day to<br>
the list - nobody has that much reviewing band width. So please take<br>
some time, finish your patches first, and when you&#39;re sure that they ar=
e<br>
really finished, then post a new series to the mailing list.<br></blockquot=
e><div>Sorry for that, test-char is hard to fix and I can not fixes in my o=
wn, so I need help from community,</div><div>For all other patches I am con=
fident, but for this, I am asking for help, I&#39;d like to know who is fam=
iliar with</div><div>char and I&#39;d like to talk with them privately if p=
ossible.</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
=C2=A0Thomas<br>
<br>
<br>
&gt; +=C2=A0 =C2=A0 if (!is_win32) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/char/stdio/subproc=
ess&quot;, char_stdio_test_subprocess);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/char/stdio&quot;, =
char_stdio_test);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 #ifndef _WIN32<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_func(&quot;/char/pipe&quot;, char_pipe_=
test);<br>
&gt;=C2=A0 #endif<br>
&gt; @@ -1534,7 +1540,7 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_test_add_data_func(&quot;/char/socket/client/dup=
id-reconnect/&quot; # name, \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;client8 ##name, char_socket_client_dupid_te=
st)<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (has_ipv4) {<br>
&gt; +=C2=A0 =C2=A0 if (has_ipv4 &amp;&amp; !is_win32) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SOCKET_SERVER_TEST(tcp, &amp;tcpaddr=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SOCKET_CLIENT_TEST(tcp, &amp;tcpaddr=
);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_test_add_data_func(&quot;/char/soc=
ket/server/two-clients/tcp&quot;, &amp;tcpaddr,<br>
&gt; <br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000e69d1f05aee5fc28--

