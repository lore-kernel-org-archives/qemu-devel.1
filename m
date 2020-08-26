Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D44C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:09:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605DE206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JC4yuX66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605DE206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kArQr-0000Av-DM
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kArQ9-0008B8-OZ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:08:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57496
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kArQ7-0004fF-5V
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598432917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qxl9vlCwiiTOgAfPIuFWwCHrZ9zaueF8xCwIbAevxJc=;
 b=JC4yuX66uDZ4Dvycej9mIODzRQ2p1kUVWBHEEcypSNJKJH6zi+bccI/HM08IRmxSkLJwRW
 Spt1m+jjepm940+XOqRX8hKxyDv3cIqkoNttOe42Oa10eKcPwpFKBceZxJrmUzJ5L5WCX3
 qtdW2p6bDokoLQcvJ1vJE+ujoDEB+g8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-ROSypqrpMBSgGLC2dJMqyA-1; Wed, 26 Aug 2020 05:08:33 -0400
X-MC-Unique: ROSypqrpMBSgGLC2dJMqyA-1
Received: by mail-ej1-f69.google.com with SMTP id fy10so666353ejb.9
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 02:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qxl9vlCwiiTOgAfPIuFWwCHrZ9zaueF8xCwIbAevxJc=;
 b=AuFlfJsEPpLfw6Fig3Mss1s4+UUOx40n/jc+P/oxtE6VMN96gVSvt5XMKlo814lDfc
 eKJnVXTyEAJcsJOrzS4txPWCSvZmd5ykKOyyWhyTLqgjT7Vqrr77PuDKinZJUeXRgm8W
 TWQzW4uw7ae+WPa7LQAayV06Nf5Wysr0mGk+F8GGU+D+BlmiASd8pjMnAug3clEzlkKM
 eI13aBC2+64Z7fz+d49A4TLrPb2mfDU14k1AzTTCwoOfIaawKqp+pmx5mNF5PEs4xtuE
 eq8pq/jPD95ZVKXaqnxAwx8xh3llWEIidsQa1k78drhgl/e6O3MTCu/dwKp5fYMx2XR3
 Po5w==
X-Gm-Message-State: AOAM530bW2O9UiuymSDI5cLBjj/tqgd8YVpavla4Tf0rcqC+k0HfzsgP
 T92gUpkxERVT6kxWsiGfavqyYv+ePQV7poLDN9Xhn6gSb1WhXrJRKbpYaJPHZfPyEC7NpzCO7WW
 xbMPPRvfHEUaZBct98/rUHDFRh8dlOwQ=
X-Received: by 2002:a17:906:130a:: with SMTP id
 w10mr46576ejb.106.1598432912519; 
 Wed, 26 Aug 2020 02:08:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzW9yakzvdwK6CVDJtE6n7tRdtzgK67p8vtnsnouVoPVh+NzoJPhJ4SK/qGa3rgHuxuVcZbza6CbdlyrNVaNw=
X-Received: by 2002:a17:906:130a:: with SMTP id
 w10mr46564ejb.106.1598432912320; 
 Wed, 26 Aug 2020 02:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <40710b94-094f-f91a-6ddb-94e51199a8c3@vivier.eu>
 <20200826084442.GH168515@redhat.com>
 <cabd3284-bca8-07ff-e0bc-22ba41df7298@vivier.eu>
In-Reply-To: <cabd3284-bca8-07ff-e0bc-22ba41df7298@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Aug 2020 11:08:20 +0200
Message-ID: <CABgObfbHtkmp0C5nN+kyAr2a80eRO3LRYa9=MwVqME0O6XMHWQ@mail.gmail.com>
Subject: Re: linux-user static build broken
To: Laurent Vivier <laurent@vivier.eu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000efc70805adc4293a"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 03:56:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.958,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000efc70805adc4293a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

$ORIGIN is a special literal used by ld.so. It's probably fixed by the same
patch that was posted for msys.

Paolo

Il mer 26 ago 2020, 10:51 Laurent Vivier <laurent@vivier.eu> ha scritto:

> Le 26/08/2020 =C3=A0 10:44, Daniel P. Berrang=C3=A9 a =C3=A9crit :
> > On Tue, Aug 25, 2020 at 10:36:13PM +0200, Laurent Vivier wrote:
> >> Hi,
> >>
> >> since we have switched to meson, the statically linked binaries of qem=
u
> >> linux-user are broken:
> >>
> >> cd $OBJ
> >> $SRC/configure --static --target-list=3Dm68k-linux-user
> >> make
> >> ./qemu-m68k
> >> Segmentation fault (core dumped)
> >>
> >> Program received signal SIGSEGV, Segmentation fault.
> >> 0x00007ffff7bd6833 in __dcigettext ()
> >> (gdb) bt
> >> #0  0x00007ffff7bd6833 in __dcigettext ()
> >> #1  0x00007ffff7bd5352 in __assert_fail ()
> >> #2  0x00007ffff7c4d74c in _dl_relocate_static_pie ()
> >> #3  0x00007ffff7bc713e in __libc_start_main ()
> >> #4  0x00007ffff7a0029e in _start ()
> >>
> >> If I build with --disable-pie it works again.
> >>
> >> Any idea?
> >
> > I'd suggest checking the compiler args used with v5.1.0 vs git master
> > and see if any flags related to PIE or similar changed. I already found
> > one bug wrt PIE on Windows builds this way.
> >
> > Regards,
> > Daniel
> >
>
> It's what I'm doing.
>
> There are both "--static-pie" and "--pie" on the new command line, but
> keeping only the first doesn't fix the problem.
>
> There is also a strange '-Wl,-rpath,RIGIN/' that would mean "make" is
> not using $(ORIGIN) but $ORIGIN...
>
> Thanks,
> Laurent
>
>

--000000000000efc70805adc4293a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">$ORIGIN is a special literal used by ld.so. It&#39;s prob=
ably fixed by the same patch that was posted for msys.<div dir=3D"auto"><br=
></div><div dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">Il mer 26 ago 2020, 10:51 Laurent Vivie=
r &lt;<a href=3D"mailto:laurent@vivier.eu">laurent@vivier.eu</a>&gt; ha scr=
itto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">Le 26/08/2020 =C3=A0 10:44, D=
aniel P. Berrang=C3=A9 a =C3=A9crit=C2=A0:<br>
&gt; On Tue, Aug 25, 2020 at 10:36:13PM +0200, Laurent Vivier wrote:<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; since we have switched to meson, the statically linked binaries of=
 qemu<br>
&gt;&gt; linux-user are broken:<br>
&gt;&gt;<br>
&gt;&gt; cd $OBJ<br>
&gt;&gt; $SRC/configure --static --target-list=3Dm68k-linux-user<br>
&gt;&gt; make<br>
&gt;&gt; ./qemu-m68k<br>
&gt;&gt; Segmentation fault (core dumped)<br>
&gt;&gt;<br>
&gt;&gt; Program received signal SIGSEGV, Segmentation fault.<br>
&gt;&gt; 0x00007ffff7bd6833 in __dcigettext ()<br>
&gt;&gt; (gdb) bt<br>
&gt;&gt; #0=C2=A0 0x00007ffff7bd6833 in __dcigettext ()<br>
&gt;&gt; #1=C2=A0 0x00007ffff7bd5352 in __assert_fail ()<br>
&gt;&gt; #2=C2=A0 0x00007ffff7c4d74c in _dl_relocate_static_pie ()<br>
&gt;&gt; #3=C2=A0 0x00007ffff7bc713e in __libc_start_main ()<br>
&gt;&gt; #4=C2=A0 0x00007ffff7a0029e in _start ()<br>
&gt;&gt;<br>
&gt;&gt; If I build with --disable-pie it works again.<br>
&gt;&gt;<br>
&gt;&gt; Any idea?<br>
&gt; <br>
&gt; I&#39;d suggest checking the compiler args used with v5.1.0 vs git mas=
ter<br>
&gt; and see if any flags related to PIE or similar changed. I already foun=
d<br>
&gt; one bug wrt PIE on Windows builds this way.<br>
&gt; <br>
&gt; Regards,<br>
&gt; Daniel<br>
&gt; <br>
<br>
It&#39;s what I&#39;m doing.<br>
<br>
There are both &quot;--static-pie&quot; and &quot;--pie&quot; on the new co=
mmand line, but<br>
keeping only the first doesn&#39;t fix the problem.<br>
<br>
There is also a strange &#39;-Wl,-rpath,RIGIN/&#39; that would mean &quot;m=
ake&quot; is<br>
not using $(ORIGIN) but $ORIGIN...<br>
<br>
Thanks,<br>
Laurent<br>
<br>
</blockquote></div>

--000000000000efc70805adc4293a--


