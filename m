Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2399EC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2EC7221E5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 19:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkO66epm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EC7221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLt5h-0006aX-OX
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 15:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLt4B-0005JK-W9
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kLt49-00036g-9z
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 15:07:35 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601060841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=05s7vREPxy+iiTjJoJP9Cf3LiNXpMDitsP0WcgJ8jvQ=;
 b=dkO66epmn8yV2J/SBB1rAFcxULqzUNkhuSh2WKH/YnarGz6GJSiCmEF3XsixuKe4JtqZDt
 0Ezr6jXDTrQ3EMOB99ZIgYBODzPjL7blf0hEa9hfmr4wjd1M2XGCQjgjN9/0Ua/DXdBY+S
 tvdngM8T4lESmxpkOjDpqLj1f/hhsPw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-BHlWFKHdPw6edyYbzsiV5Q-1; Fri, 25 Sep 2020 15:07:15 -0400
X-MC-Unique: BHlWFKHdPw6edyYbzsiV5Q-1
Received: by mail-ej1-f71.google.com with SMTP id f17so1386986ejq.5
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 12:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=05s7vREPxy+iiTjJoJP9Cf3LiNXpMDitsP0WcgJ8jvQ=;
 b=MhGL/QtglXXoTACUpDEjaEnO8O9TpVRwl7ezaNtQtNGg3kE8OuKAqESPp3Eo0Q5u3I
 ITjuuLFtmV7NRTCMugw0Dl+Z9bt8Ih4gOCwemmwMxrMgZox41o+O/J/4U4eTWHjExLBM
 WgHf+VSCDnXcboJNCodjXwBzmzsIEQSbY9r1Py2fO9x+YCCPo+tiFHNA7n2XydfWK0cn
 U4Q85z110b7/UT7XUQo3C2Gj3Y1CDQbWkYiNkE76kpQyztfcTTxQnHpQX4MspivSbb9p
 O6YCwZCgTgFRGfMxgI1lAnrVhirZiYQ0xR3TGkQ+nxT10obBRzXagMSbZCCUqVzUbGS+
 QnvA==
X-Gm-Message-State: AOAM530jZWDoRfqde9zRzQXHq5/02SJlYYOAek+KX2P1Y7w2j5ufHTG1
 v+MXa0GMnn4l9T0RE0wK0ms4HP7IQ3O/72M/MXC/D4AYqSsg/Ygn2St9XvETzZb+lHFKtw/OHEy
 3+QPuF3MuTkEsafZRm6JZ+0NaTmNcUBw=
X-Received: by 2002:a05:6402:10c6:: with SMTP id
 p6mr2969621edu.76.1601060834381; 
 Fri, 25 Sep 2020 12:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykzpYcPz2IvrvrvQQExu52in7534aDzcaiKmI8Tw7MTPDLbr+Og9NKZUnp9UtWg/Cq8TdEL4KOyOmxg+BqoDQ=
X-Received: by 2002:a05:6402:10c6:: with SMTP id
 p6mr2969607edu.76.1601060834163; 
 Fri, 25 Sep 2020 12:07:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200925130630.1922528-1-pbonzini@redhat.com>
 <CAFEAcA_-cNmt-sY3nqnGkpUqET86M6-82rf-Uv3QkwCR14kYsw@mail.gmail.com>
In-Reply-To: <CAFEAcA_-cNmt-sY3nqnGkpUqET86M6-82rf-Uv3QkwCR14kYsw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Sep 2020 21:07:01 +0200
Message-ID: <CABgObfbqdmo4tkFHNiJen2ACmdSDAXYoGdZb7ik8nsjnmOtn+A@mail.gmail.com>
Subject: Re: [PULL v5 00/87] Misc patches for 2020-09-24
To: Peter Maydell <peter.maydell@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000048d5f505b0280683"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000048d5f505b0280683
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 25 set 2020, 20:44 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Fri, 25 Sep 2020 at 14:20, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit
> 8c1c07929feae876202ba26f07a540c5115c18cd:
> >
> >   Merge remote-tracking branch
> 'remotes/stefanha/tags/block-pull-request' into staging (2020-09-24
> 18:48:45 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to e627cc59f0ad4949c9635b72a3149c9fabc044e8=
:
> >
> >   hw/net/can: Correct Kconfig dependencies (2020-09-25 09:04:23 -0400)
> >
> > ----------------------------------------------------------------
> > * SCSI fix (Dmitry, Li Feng, Li Qiang)
> > * memory API fixes (Eduardo)
> > * removal of deprecated '-numa node', 'cpu-add', '-smp' (Igor)
> > * ACPI fix for VMBus (Jon)
> > * relocatable install (myself)
> > * always remove docker containers (myself)
> > * serial cleanups (Philippe)
> > * vmware cpuid leaf for tsc and apic frequency (Sunil)
> > * KVM_FEATURE_ASYNC_PF_INT support (Vitaly)
> > * i386 XSAVE bugfix (Xiaoyao)
> > * QOM developer documentation in docs/devel (Eduardo)
> > * new checkpatch tests (Dov)
> > * x86_64 syscall fix (Douglas)
> > * interrupt-based APF fix (Vitaly)
> > * always create kvmclock (Vitaly)
> > * fix bios-tables-test (Eduardo)
> > * KVM PV features cleanup (myself)
> > * CAN FD (Pavel)
> >
> > meson:
> > * fixes (Marc-Andr=C3=A9, Max, Stefan, Alexander, myself)
> > * moved libmpathpersist, cocoa, malloc tests (myself)
> > * support for 0.56 introspected test dependencies (myself)
>
> This passes all the tests, but generates some new warnings:
>
> In the all-linux-static build:
>
> Library rt found: YES
> Found pkg-config: /usr/bin/pkg-config (0.29.1)
> WARNING: Static library 'udev' not found for dependency 'libudev', may
> not be statically linked
> Run-time dependency libudev found: YES 237
> Library devmapper found: NO


> That looks like it's gone wrong -- if we're doing a static
> build and it can't find the static library that means the
> dependency should be a "NO", not "YES", shouldn't it ?
>

No, it's always been like that; the configure script also proceeded with
the dependency and fingers crossed. Meson warns which is the right thing to
do. I will make the test dependent on have_softmmu || have_tools (or
whatever it needs to be) so that the warning is hidden.

Thanks,

Paolo

Also, lots of these during 'make check' on the x86-64 Linux build:
>
> qemu-system-i386: warning: host doesn't support requested feature:
> CPUID.40000001H:EAX.kvm-asyncpf-int [bit 14]

--00000000000048d5f505b0280683
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 25 set 2020, 20:44 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Fri, 25 Sep 2020 at 14:20, P=
aolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" r=
el=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The following changes since commit 8c1c07929feae876202ba26f07a540c5115=
c18cd:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0Merge remote-tracking branch &#39;remotes/stefanha/tags/bl=
ock-pull-request&#39; into staging (2020-09-24 18:48:45 +0100)<br>
&gt;<br>
&gt; are available in the Git repository at:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0<a href=3D"https://gitlab.com/bonzini/qemu.git" rel=3D"nor=
eferrer noreferrer" target=3D"_blank">https://gitlab.com/bonzini/qemu.git</=
a> tags/for-upstream<br>
&gt;<br>
&gt; for you to fetch changes up to e627cc59f0ad4949c9635b72a3149c9fabc044e=
8:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0hw/net/can: Correct Kconfig dependencies (2020-09-25 09:04=
:23 -0400)<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; * SCSI fix (Dmitry, Li Feng, Li Qiang)<br>
&gt; * memory API fixes (Eduardo)<br>
&gt; * removal of deprecated &#39;-numa node&#39;, &#39;cpu-add&#39;, &#39;=
-smp&#39; (Igor)<br>
&gt; * ACPI fix for VMBus (Jon)<br>
&gt; * relocatable install (myself)<br>
&gt; * always remove docker containers (myself)<br>
&gt; * serial cleanups (Philippe)<br>
&gt; * vmware cpuid leaf for tsc and apic frequency (Sunil)<br>
&gt; * KVM_FEATURE_ASYNC_PF_INT support (Vitaly)<br>
&gt; * i386 XSAVE bugfix (Xiaoyao)<br>
&gt; * QOM developer documentation in docs/devel (Eduardo)<br>
&gt; * new checkpatch tests (Dov)<br>
&gt; * x86_64 syscall fix (Douglas)<br>
&gt; * interrupt-based APF fix (Vitaly)<br>
&gt; * always create kvmclock (Vitaly)<br>
&gt; * fix bios-tables-test (Eduardo)<br>
&gt; * KVM PV features cleanup (myself)<br>
&gt; * CAN FD (Pavel)<br>
&gt;<br>
&gt; meson:<br>
&gt; * fixes (Marc-Andr=C3=A9, Max, Stefan, Alexander, myself)<br>
&gt; * moved libmpathpersist, cocoa, malloc tests (myself)<br>
&gt; * support for 0.56 introspected test dependencies (myself)<br>
<br>
This passes all the tests, but generates some new warnings:<br>
<br>
In the all-linux-static build:<br>
<br>
Library rt found: YES<br>
Found pkg-config: /usr/bin/pkg-config (0.29.1)<br>
WARNING: Static library &#39;udev&#39; not found for dependency &#39;libude=
v&#39;, may<br>
not be statically linked<br>
Run-time dependency libudev found: YES 237<br>
Library devmapper found: NO</blockquote></div></div><div dir=3D"auto"><div =
class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
That looks like it&#39;s gone wrong -- if we&#39;re doing a static<br>
build and it can&#39;t find the static library that means the<br>
dependency should be a &quot;NO&quot;, not &quot;YES&quot;, shouldn&#39;t i=
t ?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">No, it&#39;s always been like that; the configure script also proceeded =
with the dependency and fingers crossed. Meson warns which is the right thi=
ng to do. I will make the test dependent on have_softmmu || have_tools (or =
whatever it needs to be) so that the warning is hidden.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Thanks,</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Also, lots of these=
 during &#39;make check&#39; on the x86-64 Linux build:<br>
<br>
qemu-system-i386: warning: host doesn&#39;t support requested feature:<br>
CPUID.40000001H:EAX.kvm-asyncpf-int [bit 14]</blockquote></div></div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"></div></div>

--00000000000048d5f505b0280683--


