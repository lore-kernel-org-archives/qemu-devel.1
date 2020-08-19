Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C17CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 19:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111CB207BB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 19:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3KI5FWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111CB207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Tp2-0002UX-9j
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 15:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8To6-00022d-5L
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 15:31:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38325
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k8To3-0001Ek-Fv
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 15:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597865489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OYKEO60TWPRCVnMkUEZHKJbtqby5xrjAvH2bYr4AcD0=;
 b=W3KI5FWbYHgMkHv2We8GBAPyQETcUufeKZAFToSPWLOJTiRaDlNVXG+mauhfXaljJKNMMq
 eAc3ZQ1tO9ZjECTAJUblZ93y+xt+g9O4hHMswN/eZai20QMaNAajKIm27Kja1MQylkTv4H
 iF04KpYbHBB+oE9+mdrFSptertS7PcM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-XbohW95POYWdPPkR5_jfEg-1; Wed, 19 Aug 2020 15:31:25 -0400
X-MC-Unique: XbohW95POYWdPPkR5_jfEg-1
Received: by mail-ed1-f71.google.com with SMTP id c3so9659594edm.7
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 12:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OYKEO60TWPRCVnMkUEZHKJbtqby5xrjAvH2bYr4AcD0=;
 b=uL35jdTxZeMyTcEGywt41tbYxSG0NUbX0WfRmZ/tx1b2ASB4noeodkTtnzQth1OOj5
 EqnQzS67C9envZzERhTLkAfcddPW4t+scPyXT1l2v5wyQr+8+gO4uWxNG3UCjEStZ1kT
 iyx3g9v7wgA2YI7A7iM+umNnMawc8QuqoeRaNQPC6Cx2vrWv+OHXnQxBPMhAHWodsYBj
 xeacnN1gRKVJlfpOoCwU+PAafvdwePRWJWKH3RbTPk6J/5Wzqk8gXm2HDmpQZP1537kq
 kGCw/7WOggnxBRDNZbRt9s0o/MVxkckLaDJ7sB0SwS+dwp73fRcF5oJXWew0VLBZuYGs
 SzfQ==
X-Gm-Message-State: AOAM531rlnYW32PdSZTCmBC8NP6tKaZqrLG5KU37IjnQ+0AkJfApdxqu
 dzU4XYgdaHYHj2NBiTpXYGVLQqiIYC6ih1/l621hW+FnKn5FFVh6gqiTO5z+z4Gcof7mzuY0CXK
 9HmYqgXfjNb1w86iH9FbvXzop3bS3z+k=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr27561660ejw.71.1597865484649; 
 Wed, 19 Aug 2020 12:31:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSPwZz8/ud7bY/jWy+ZGe5s0AtpZhnSL+2z7KEUcCD7sCCv93NpcGwyxhA1Q/exldnozgb/QvXcoE9+V+BuLo=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr27561645ejw.71.1597865484412; 
 Wed, 19 Aug 2020 12:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200819143525.2175-1-pbonzini@redhat.com>
 <CAFEAcA_8VJecDyK8FR0ty=pknmo+Hc5s0OFj+-Y1Ah-OJ01FDQ@mail.gmail.com>
 <CAFEAcA9jt21RHiu1eqAzK_PJAj9i6Ej27jT2=gfjSRZVjJsDKw@mail.gmail.com>
 <CAFEAcA_1rtOJjs40MCNmJHmyaXG9ObFsdmyr1mb7FnieRBWO7g@mail.gmail.com>
In-Reply-To: <CAFEAcA_1rtOJjs40MCNmJHmyaXG9ObFsdmyr1mb7FnieRBWO7g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Aug 2020 21:31:12 +0200
Message-ID: <CABgObfbJg-zXXN=pf9JMqAGOKz_W67JFe50ruYSc7Vg_EjboNA@mail.gmail.com>
Subject: Re: [PULL v6 000/150] Meson-based build system
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000099063305ad400ce7"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000099063305ad400ce7
Content-Type: text/plain; charset="UTF-8"

I can certainly add symlinks (that would be broken until make completes)
but moving the build outputs is not possible since there's no recursive
make anymore.

Paolo

Il mer 19 ago 2020, 21:06 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Wed, 19 Aug 2020 at 19:16, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> > Spoke too soon; "make --output-sync -C build/all-linux-static check-tcg"
> > failed with:
> >
> >   BUILD   TCG tests for mips-linux-user
> >   CHECK   debian10
> >   CHECK   debian-mips-cross
> >   BUILD   mips-linux-user guest-tests with docker qemu/debian-mips-cross
> >   RUN     TCG tests for mips-linux-user
> >   CHECK   debian10
> >   CHECK   debian-mips-cross
> >   BUILD   mips-linux-user guest-tests with docker qemu/debian-mips-cross
> >   RUN     tests for mips
> >   TEST    threadcount on mips
> > qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> > timeout: the monitored command dumped core
> > Segmentation fault
> > ../Makefile.target:153: recipe for target 'run-threadcount' failed
> > make[2]: *** [run-threadcount] Error 139
> > /home/petmay01/linaro/qemu-for-merges/tests/tcg/Makefile.qemu:76:
> > recipe for target 'run-guest-tests' failed
> > make[1]: *** [run-guest-tests] Error 2
> > /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:450:
> > recipe for target 'run-tcg-tests-mips-linux-user' failed
>
> Seems to be consistent, so not an intermittent but presumably
> an issue introduced by the meson changes.
>
> -- PMM
>
>

--00000000000099063305ad400ce7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I can certainly add symlinks (that would be broken until =
make completes) but moving the build outputs is not possible since there&#3=
9;s no recursive make anymore.<div dir=3D"auto"><br></div><div dir=3D"auto"=
>Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">Il mer 19 ago 2020, 21:06 Peter Maydell &lt;<a href=3D"mailto:p=
eter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scritto:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">On Wed, 19 Aug 2020 at 19:16, Peter Mayd=
ell &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank" rel=
=3D"noreferrer">peter.maydell@linaro.org</a>&gt; wrote:<br>
&gt; Spoke too soon; &quot;make --output-sync -C build/all-linux-static che=
ck-tcg&quot;<br>
&gt; failed with:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0BUILD=C2=A0 =C2=A0TCG tests for mips-linux-user<br>
&gt;=C2=A0 =C2=A0CHECK=C2=A0 =C2=A0debian10<br>
&gt;=C2=A0 =C2=A0CHECK=C2=A0 =C2=A0debian-mips-cross<br>
&gt;=C2=A0 =C2=A0BUILD=C2=A0 =C2=A0mips-linux-user guest-tests with docker =
qemu/debian-mips-cross<br>
&gt;=C2=A0 =C2=A0RUN=C2=A0 =C2=A0 =C2=A0TCG tests for mips-linux-user<br>
&gt;=C2=A0 =C2=A0CHECK=C2=A0 =C2=A0debian10<br>
&gt;=C2=A0 =C2=A0CHECK=C2=A0 =C2=A0debian-mips-cross<br>
&gt;=C2=A0 =C2=A0BUILD=C2=A0 =C2=A0mips-linux-user guest-tests with docker =
qemu/debian-mips-cross<br>
&gt;=C2=A0 =C2=A0RUN=C2=A0 =C2=A0 =C2=A0tests for mips<br>
&gt;=C2=A0 =C2=A0TEST=C2=A0 =C2=A0 threadcount on mips<br>
&gt; qemu: uncaught target signal 11 (Segmentation fault) - core dumped<br>
&gt; timeout: the monitored command dumped core<br>
&gt; Segmentation fault<br>
&gt; ../Makefile.target:153: recipe for target &#39;run-threadcount&#39; fa=
iled<br>
&gt; make[2]: *** [run-threadcount] Error 139<br>
&gt; /home/petmay01/linaro/qemu-for-merges/tests/tcg/Makefile.qemu:76:<br>
&gt; recipe for target &#39;run-guest-tests&#39; failed<br>
&gt; make[1]: *** [run-guest-tests] Error 2<br>
&gt; /home/petmay01/linaro/qemu-for-merges/tests/Makefile.include:450:<br>
&gt; recipe for target &#39;run-tcg-tests-mips-linux-user&#39; failed<br>
<br>
Seems to be consistent, so not an intermittent but presumably<br>
an issue introduced by the meson changes.<br>
<br>
-- PMM<br>
<br>
</blockquote></div>

--00000000000099063305ad400ce7--


