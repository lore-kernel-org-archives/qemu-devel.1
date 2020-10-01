Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0914C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4011E208C7
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 16:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5opxusZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4011E208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO15A-0002e7-3W
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 12:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO0ig-0003hC-GF
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:42:10 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131]:32892)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kO0ie-0004Ao-ED
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 11:42:10 -0400
Received: by mail-lf1-x131.google.com with SMTP id 77so7162954lfj.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=q2IsAy/dX/jXDCaeyoskRGd89eYqek5dSGcmTDMbW08=;
 b=H5opxusZP4QrprXV2Kv/dQM8v5tVVBYWwh182JSuej8kJ8eN5bahjVE7R2utC6ZAJV
 wow2rW8Seo56fmthKvBYHHpsdEojXK3HzTndLf0fqFhmRAHEaIi10nNyU104iP7dobsr
 2SS0jjjaeJjAAsI8cGkaCyw/y5J28FldCygkCaOw6LHUFBVxCz98AhsI/bvA1i+a5/kz
 02XQqXTKfPh3CESkXxM9GVZ5bc53uoxyTUpccsqb9EAbZQcDeQ9WlBAyLC69p/viQ8Fl
 7OtW0UQjr0LznE8goDou6G/PUzuADn4zX6DmhVSzpOQ/gvHJxqysR3PDAlZ/h58kny2z
 JdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=q2IsAy/dX/jXDCaeyoskRGd89eYqek5dSGcmTDMbW08=;
 b=Pm3k4GTMZD0DXehHG8C56Z3eObI3Af0Vwjzp0D64KHGNc10kelGgKK72Er+SbM1QvS
 7EbX4O3bG7/p2+xBWweitUyCVTrdM5Vc17HZAOVuIdNXRBNeavpKbKpTbe4lYsKreBvx
 lNp1ZTgBNqFdkhS5IGTZsAH1B3jbZFZevL63pclVCFjvDHrqe8N7O+vlLtK20rO/p3bV
 QP+19sRgvf1jnxu7efUhZN9azOEijyQW3Xfam05+UmsjmmGVOQh2YY09QZEFk67fCM75
 tMRbeWsIGV25k6ZuASu/Zg3hu91k6Qc160GJLQSrANRMQcr7Ubep19XkqbHKQyRciwbb
 tJ6w==
X-Gm-Message-State: AOAM531bw7W8rn6kDki4qPMvvBzt1iJAPbZtVidcl6/ew9WZ6MxT7+Ix
 cBGA7IGrt8LUwVVaKy0QPooA3SL6ZybPvlg7G/Y=
X-Google-Smtp-Source: ABdhPJzCQE5ji2e+WPkXJ6dnmNL1wT3TjES360pnfOsv7Ybbh6u1ba3XXGMwLr3+C1zZ7ydn8OQUez3oOYAoSXfEnww=
X-Received: by 2002:a19:9141:: with SMTP id y1mr2621314lfj.554.1601566926593; 
 Thu, 01 Oct 2020 08:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200930195850.278104-1-pbonzini@redhat.com>
 <CAFEAcA_8zHiTGZQBzun=aSAD-kX7wp4S7RVwPGK2SmR4HuO0Tg@mail.gmail.com>
In-Reply-To: <CAFEAcA_8zHiTGZQBzun=aSAD-kX7wp4S7RVwPGK2SmR4HuO0Tg@mail.gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 1 Oct 2020 23:41:56 +0800
Message-ID: <CAE2XoE9CnCKHv0Y8_nU-x6GWQo8sqfo_BYRjn0cktEU83VjT2g@mail.gmail.com>
Subject: Re: [PULL v8 00/86] Misc QEMU patches for 2020-09-24
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000be643505b09ddbb6"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x131.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000be643505b09ddbb6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2020 at 10:36 PM Peter Maydell <peter.maydell@linaro.org>
wrote:
>
> On Wed, 30 Sep 2020 at 21:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit
cbba3dc6ea3fc9aa66e9f9eb41051536e3ad7cd0:
> >
> >   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into
staging (2020-09-30 11:40:38 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 37aeb7a28ddbf52dd25dd53ae1b8391bc2287858=
:
> >
> >   hw/net/can: Correct Kconfig dependencies (2020-09-30 19:11:37 +0200)
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
> >
>
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
> for any user-visible changes.
>
> -- PMM
>
Long awating, wonderfull

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000be643505b09ddbb6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, Oct 1, 2020 at 10:36 PM Peter Maydell &lt;=
<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt=
; wrote:<br>&gt;<br>&gt; On Wed, 30 Sep 2020 at 21:04, Paolo Bonzini &lt;<a=
 href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br>=
&gt; &gt;<br>&gt; &gt; The following changes since commit cbba3dc6ea3fc9aa6=
6e9f9eb41051536e3ad7cd0:<br>&gt; &gt;<br>&gt; &gt; =C2=A0 Merge remote-trac=
king branch &#39;remotes/mst/tags/for_upstream&#39; into staging (2020-09-3=
0 11:40:38 +0100)<br>&gt; &gt;<br>&gt; &gt; are available in the Git reposi=
tory at:<br>&gt; &gt;<br>&gt; &gt; =C2=A0 <a href=3D"https://gitlab.com/bon=
zini/qemu.git">https://gitlab.com/bonzini/qemu.git</a> tags/for-upstream<br=
>&gt; &gt;<br>&gt; &gt; for you to fetch changes up to 37aeb7a28ddbf52dd25d=
d53ae1b8391bc2287858:<br>&gt; &gt;<br>&gt; &gt; =C2=A0 hw/net/can: Correct =
Kconfig dependencies (2020-09-30 19:11:37 +0200)<br>&gt; &gt;<br>&gt; &gt; =
----------------------------------------------------------------<br>&gt; &g=
t; * SCSI fix (Dmitry, Li Feng, Li Qiang)<br>&gt; &gt; * memory API fixes (=
Eduardo)<br>&gt; &gt; * removal of deprecated &#39;-numa node&#39;, &#39;cp=
u-add&#39;, &#39;-smp&#39; (Igor)<br>&gt; &gt; * ACPI fix for VMBus (Jon)<b=
r>&gt; &gt; * relocatable install (myself)<br>&gt; &gt; * always remove doc=
ker containers (myself)<br>&gt; &gt; * serial cleanups (Philippe)<br>&gt; &=
gt; * vmware cpuid leaf for tsc and apic frequency (Sunil)<br>&gt; &gt; * K=
VM_FEATURE_ASYNC_PF_INT support (Vitaly)<br>&gt; &gt; * i386 XSAVE bugfix (=
Xiaoyao)<br>&gt; &gt; * QOM developer documentation in docs/devel (Eduardo)=
<br>&gt; &gt; * new checkpatch tests (Dov)<br>&gt; &gt; * x86_64 syscall fi=
x (Douglas)<br>&gt; &gt; * interrupt-based APF fix (Vitaly)<br>&gt; &gt; * =
always create kvmclock (Vitaly)<br>&gt; &gt; * fix bios-tables-test (Eduard=
o)<br>&gt; &gt; * KVM PV features cleanup (myself)<br>&gt; &gt; * CAN FD (P=
avel)<br>&gt; &gt;<br>&gt; &gt; meson:<br>&gt; &gt; * fixes (Marc-Andr=C3=
=A9, Max, Stefan, Alexander, myself)<br>&gt; &gt; * moved libmpathpersist, =
cocoa, malloc tests (myself)<br>&gt; &gt; * support for 0.56 introspected t=
est dependencies (myself)<br>&gt; &gt;<br>&gt;<br>&gt;<br>&gt; Applied, tha=
nks.<br>&gt;<br>&gt; Please update the changelog at <a href=3D"https://wiki=
.qemu.org/ChangeLog/5.2">https://wiki.qemu.org/ChangeLog/5.2</a><br>&gt; fo=
r any user-visible changes.<br>&gt;<br>&gt; -- PMM<br>&gt;<br>Long awating,=
 wonderfull<br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=E6=AD=A4=E8=87=
=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 s=
incerely,<br>Yonggang Luo</div>

--000000000000be643505b09ddbb6--

