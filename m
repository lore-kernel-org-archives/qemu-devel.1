Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE49C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:50:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4533C20738
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 19:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkUM3wX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4533C20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXUz7-0007Qw-4L
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 15:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXUxr-0006c5-5F
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:49:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43921)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXUxo-0007Z4-8L
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 15:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603828138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=udbo6b6WFzZ62xJ15e1jz3azeYI5w0Imb/jhf+IdXIw=;
 b=BkUM3wX12KHULqUKZoVEjfoJMRSCUdMzgqPuhfhGiGeQhacLd3aZU+7d8hCyftn/6dfs2Z
 hIQ7LqBriNH9Y/zlkA+jMLPs74qsJYEkqb4D/qkHSqIkFwtWKbaYg91xVIG3WB86G6mVuI
 7JkslS7hMjZYOsqBJOk0aHoqBK/RmcY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-rlu6R3AuNiipUjRoX-Z3Wg-1; Tue, 27 Oct 2020 15:48:55 -0400
X-MC-Unique: rlu6R3AuNiipUjRoX-Z3Wg-1
Received: by mail-qv1-f71.google.com with SMTP id v4so1560334qvr.19
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 12:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=udbo6b6WFzZ62xJ15e1jz3azeYI5w0Imb/jhf+IdXIw=;
 b=Kr4pK1ZeI5xB/wjp+sfovfAqtjv8bJeVSBPeQv7nsfF1j75hMz7HqVXlEQ/1/NU/p3
 ExuFZ+YIcDT5fM+Xe/X2QY4lyp9iH+DTM3sLWwhYCvSWeLJP3uUcyn3nLtmE2d/Il/DR
 hqOAgfSUF4LfPzOwIsKY9mvhYbxR0ah+Po1bP1EJa2WG0UYD/+Ulo6AU/2X8BmO2Xr7d
 e4B+QrFEArwTDh2QmI/0g2le98NQnEZDwuQ5yzkwtS0Aw9G9KDwf/uxC2tG7rUMAAU0X
 JDEhefXT8enECh7LxuMkLxGwPTy2VTJ4Ky/yf1vihOseEhWzc22MmKZXLDyCy512asb4
 Xpmg==
X-Gm-Message-State: AOAM531vUI/IwTJYsJRIEFJanaG1+QBkr7DiVQ82nhiv6d2M3MRvK5a7
 Pyn/KgLM1QO/b1ymUNW3ufZAD4xbkWdVnZNem6XchC4l2EGGJ4srsz3hqFHdgkK6kH+YaNLU8pk
 Oq6P9AA25xaIfcZ5D6SPKqRjdOG7m3fg=
X-Received: by 2002:a05:620a:998:: with SMTP id
 x24mr3481181qkx.160.1603828135043; 
 Tue, 27 Oct 2020 12:48:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzRLjWNoF2sg3hLucYzo67sdyYADoyci6eqt0URteBGIkpWahOXabwmXZ5UBvPIMAq9WGyGMHtm7OxBOE9Ym4=
X-Received: by 2002:a05:620a:998:: with SMTP id
 x24mr3481164qkx.160.1603828134746; 
 Tue, 27 Oct 2020 12:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201012203343.1105018-1-pbonzini@redhat.com>
 <20201012203343.1105018-32-pbonzini@redhat.com>
 <c55d660e-e650-6470-f14c-acba6a085e74@redhat.com>
In-Reply-To: <c55d660e-e650-6470-f14c-acba6a085e74@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 27 Oct 2020 20:48:41 +0100
Message-ID: <CABgObfbqeTtpmZSNEHPLFbA8Er4SxTR13qfS5uY4KndC4ox5zg@mail.gmail.com>
Subject: Re: [PULL 31/38] device-core: use RCU for list of children of a bus
To: Eric Blake <eblake@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000040bafd05b2ac560a"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000040bafd05b2ac560a
Content-Type: text/plain; charset="UTF-8"

Maxim has already posted a fix for the test, Kevin should pull it.

Paolo

Il mar 27 ott 2020, 20:34 Eric Blake <eblake@redhat.com> ha scritto:

> On 10/12/20 3:33 PM, Paolo Bonzini wrote:
> > From: Maxim Levitsky <mlevitsk@redhat.com>
> >
> > This fixes the race between device emulation code that tries to find
> > a child device to dispatch the request to (e.g a scsi disk),
> > and hotplug of a new device to that bus.
> >
> > Note that this doesn't convert all the readers of the list
> > but only these that might go over that list without BQL held.
> >
> > This is a very small first step to make this code thread safe.
> >
> > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Message-Id: <20200913160259.32145-5-mlevitsk@redhat.com>
> > [Use RCU_READ_LOCK_GUARD in more places, adjust testcase now that
> >  the delay in DEVICE_DELETED due to RCU is more consistent. - Paolo]
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Message-Id: <20201006123904.610658-9-mlevitsk@redhat.com>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Git bisect lands on this commit as the reason that iotest 240 is failing:
>
> --- /home/eblake/qemu-tmp2/tests/qemu-iotests/240.out   2020-10-23
> 10:47:02.268392745 -0500
> +++ /home/eblake/qemu-tmp2/build/tests/qemu-iotests/240.out.bad
> 2020-10-27 14:27:38.417188285 -0500
> @@ -10,10 +10,10 @@
>  {"return": {}}
>  {"return": {}}
>  {"return": {}}
> +{"error": {"class": "GenericError", "desc": "Duplicate ID 'scsi-hd0'
> for device"}}
> +{"error": {"class": "DeviceNotFound", "desc": "Device 'scsi-hd0' not
> found"}}
>  {"return": {}}
> -{"return": {}}
> -{"return": {}}
> -{"return": {}}
> +{"error": {"class": "GenericError", "desc": "Node hd0 is in use"}}
>  {"return": {}}
>
>  === Attach two SCSI disks using the same block device and the same
> iothread ===
> @@ -29,7 +29,7 @@
>  {"return": {}}
>  {"return": {}}
>  {"return": {}}
> -{"return": {}}
> +{"error": {"class": "GenericError", "desc": "Node hd0 is in use"}}
>  {"return": {}}
>
>  === Attach two SCSI disks using the same block device but different
> iothreads ===
> @@ -45,8 +45,8 @@
>  {"return": {}}
>  {"error": {"class": "GenericError", "desc": "Cannot change iothread of
> active block backend"}}
>  {"return": {}}
> -{"return": {}}
> -{"return": {}}
> +{"error": {"class": "GenericError", "desc": "Cannot change iothread of
> active block backend"}}
> +{"error": {"class": "DeviceNotFound", "desc": "Device 'scsi-hd1' not
> found"}}
>  {"return": {}}
>  {"return": {}}
>  {"return": {}}
> Failures: 240
> Failed 1 of 1 iotests
>
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--00000000000040bafd05b2ac560a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Maxim has already posted a fix for the test, Kevin should=
 pull it.<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 27=
 ott 2020, 20:34 Eric Blake &lt;<a href=3D"mailto:eblake@redhat.com">eblake=
@redhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On =
10/12/20 3:33 PM, Paolo Bonzini wrote:<br>
&gt; From: Maxim Levitsky &lt;<a href=3D"mailto:mlevitsk@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">mlevitsk@redhat.com</a>&gt;<br>
&gt; <br>
&gt; This fixes the race between device emulation code that tries to find<b=
r>
&gt; a child device to dispatch the request to (e.g a scsi disk),<br>
&gt; and hotplug of a new device to that bus.<br>
&gt; <br>
&gt; Note that this doesn&#39;t convert all the readers of the list<br>
&gt; but only these that might go over that list without BQL held.<br>
&gt; <br>
&gt; This is a very small first step to make this code thread safe.<br>
&gt; <br>
&gt; Suggested-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com"=
 target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Maxim Levitsky &lt;<a href=3D"mailto:mlevitsk@redhat.co=
m" target=3D"_blank" rel=3D"noreferrer">mlevitsk@redhat.com</a>&gt;<br>
&gt; Reviewed-by: Stefan Hajnoczi &lt;<a href=3D"mailto:stefanha@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a>&gt;<br>
&gt; Message-Id: &lt;<a href=3D"mailto:20200913160259.32145-5-mlevitsk@redh=
at.com" target=3D"_blank" rel=3D"noreferrer">20200913160259.32145-5-mlevits=
k@redhat.com</a>&gt;<br>
&gt; [Use RCU_READ_LOCK_GUARD in more places, adjust testcase now that<br>
&gt;=C2=A0 the delay in DEVICE_DELETED due to RCU is more consistent. - Pao=
lo]<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; Message-Id: &lt;<a href=3D"mailto:20201006123904.610658-9-mlevitsk@red=
hat.com" target=3D"_blank" rel=3D"noreferrer">20201006123904.610658-9-mlevi=
tsk@redhat.com</a>&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
<br>
Git bisect lands on this commit as the reason that iotest 240 is failing:<b=
r>
<br>
--- /home/eblake/qemu-tmp2/tests/qemu-iotests/240.out=C2=A0 =C2=A02020-10-2=
3<br>
10:47:02.268392745 -0500<br>
+++ /home/eblake/qemu-tmp2/build/tests/qemu-iotests/240.out.bad<br>
2020-10-27 14:27:38.417188285 -0500<br>
@@ -10,10 +10,10 @@<br>
=C2=A0{&quot;return&quot;: {}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
+{&quot;error&quot;: {&quot;class&quot;: &quot;GenericError&quot;, &quot;de=
sc&quot;: &quot;Duplicate ID &#39;scsi-hd0&#39;<br>
for device&quot;}}<br>
+{&quot;error&quot;: {&quot;class&quot;: &quot;DeviceNotFound&quot;, &quot;=
desc&quot;: &quot;Device &#39;scsi-hd0&#39; not<br>
found&quot;}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
-{&quot;return&quot;: {}}<br>
-{&quot;return&quot;: {}}<br>
-{&quot;return&quot;: {}}<br>
+{&quot;error&quot;: {&quot;class&quot;: &quot;GenericError&quot;, &quot;de=
sc&quot;: &quot;Node hd0 is in use&quot;}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
<br>
=C2=A0=3D=3D=3D Attach two SCSI disks using the same block device and the s=
ame<br>
iothread =3D=3D=3D<br>
@@ -29,7 +29,7 @@<br>
=C2=A0{&quot;return&quot;: {}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
-{&quot;return&quot;: {}}<br>
+{&quot;error&quot;: {&quot;class&quot;: &quot;GenericError&quot;, &quot;de=
sc&quot;: &quot;Node hd0 is in use&quot;}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
<br>
=C2=A0=3D=3D=3D Attach two SCSI disks using the same block device but diffe=
rent<br>
iothreads =3D=3D=3D<br>
@@ -45,8 +45,8 @@<br>
=C2=A0{&quot;return&quot;: {}}<br>
=C2=A0{&quot;error&quot;: {&quot;class&quot;: &quot;GenericError&quot;, &qu=
ot;desc&quot;: &quot;Cannot change iothread of<br>
active block backend&quot;}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
-{&quot;return&quot;: {}}<br>
-{&quot;return&quot;: {}}<br>
+{&quot;error&quot;: {&quot;class&quot;: &quot;GenericError&quot;, &quot;de=
sc&quot;: &quot;Cannot change iothread of<br>
active block backend&quot;}}<br>
+{&quot;error&quot;: {&quot;class&quot;: &quot;DeviceNotFound&quot;, &quot;=
desc&quot;: &quot;Device &#39;scsi-hd1&#39; not<br>
found&quot;}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
=C2=A0{&quot;return&quot;: {}}<br>
Failures: 240<br>
Failed 1 of 1 iotests<br>
<br>
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3226<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer norefer=
rer" target=3D"_blank">qemu.org</a> | <a href=3D"http://libvirt.org" rel=3D=
"noreferrer noreferrer" target=3D"_blank">libvirt.org</a><br>
<br>
</blockquote></div>

--00000000000040bafd05b2ac560a--


