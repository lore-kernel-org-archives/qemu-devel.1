Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D831FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:46:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96BC22253D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 19:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMoRKfvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BC22253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuiQq-0003gI-KR
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 14:46:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iui2T-00013z-Va
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:21:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iui2R-0003kc-Rt
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:21:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46660
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iui2R-0003j6-KP
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 14:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579807270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gl5RNu6yyw11ayEQeyqK5kFL6cIxYZN5aBVwSqGclHw=;
 b=EMoRKfvpRWssx9vP64ecZ1tSccDhfDTX4Kud6gRMGUGY1yDrbpPHRilzLr+MixTxuwO8Vn
 eAgUzUyAZzzUAJ3nE1ZUDtTv3I7INHWA7nymy597GVkMPMsM94j+ni93++2D/5maIssiDJ
 u1K8DO5J+6rgbHiwmcHwrgRWdknLJN4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-i7muSeAiORaWVDaVimjrvA-1; Thu, 23 Jan 2020 14:21:07 -0500
Received: by mail-ed1-f70.google.com with SMTP id w3so2947833edt.23
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 11:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gl5RNu6yyw11ayEQeyqK5kFL6cIxYZN5aBVwSqGclHw=;
 b=KF1xGUVSLKn+nPJDnkGwEJIGNDo8/RoCVy4QyQ2yx+Wdy9LqwIort4dONknX41X+20
 uj13E86iKDTZ5nnmey1e4+v1bswNBVOPTbCg5cm6UJ5xnq5bWpcrPyYPiXPmgqlRhnOd
 +T+g1mYcZ+jhIPCDHUTq64j3tlPVkyHxhp/mS2A7aAzRAgIvnR9EHLaGfskxTIOv1FPj
 vskbECGgsQjmeQlwSYQpPoUGvrKw5mFidMTGOLO206Q5kLuyhJo5nno9o1DUKT5pWdzG
 TEUUOf5afeq6yBgNijUca/DoDm/4xNwTRQt8X7tqnXgfzsX4BhdqaWd5O0GjBr2Rcrep
 jteQ==
X-Gm-Message-State: APjAAAWmsSNh8GHzPrpN0geeV6OUWvXUT+hh3r2Ex/FY0ZJTouB8sK7P
 BIOb5aR2LC09NoP+j1KR27ZcDzz9OdlIRnCgiBRa70Du8Q+bdEsM5mrC4RlPIQOhadt6qbqpVTZ
 F4pmUc2RDCsLOZpl/0h2ipYmk9WRX664=
X-Received: by 2002:a50:c04e:: with SMTP id u14mr8200069edd.193.1579807266310; 
 Thu, 23 Jan 2020 11:21:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxo78mwAr8lPLCzf4F01epdDhh5A7YHrwT2NIGF8uJRU/l5BrKvQoKVGUC6HvKjZivfp9DzyAWlk3lWwYtno3I=
X-Received: by 2002:a50:c04e:: with SMTP id u14mr8200051edd.193.1579807265920; 
 Thu, 23 Jan 2020 11:21:05 -0800 (PST)
MIME-Version: 1.0
References: <1579787449-27599-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA8R5yDfAYYraeBStD_Oh7G60QSgUaw_JVdqC=C8y4n0Jw@mail.gmail.com>
In-Reply-To: <CAFEAcA8R5yDfAYYraeBStD_Oh7G60QSgUaw_JVdqC=C8y4n0Jw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Jan 2020 20:20:53 +0100
Message-ID: <CABgObfZF7D+MgxXMDbrqZQpOb6WaOiKFaLSUv9U+3Ufb0GGKMw@mail.gmail.com>
Subject: Re: [PULL v2 00/59] Misc (x86 and QOM) patches for 2020-01-23
To: Peter Maydell <peter.maydell@linaro.org>
X-MC-Unique: i7muSeAiORaWVDaVimjrvA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e63154059cd38a53"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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

--000000000000e63154059cd38a53
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 23 gen 2020, 19:43 Peter Maydell <peter.maydell@linaro.org> ha
scritto:

> On Thu, 23 Jan 2020 at 16:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit
> 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40:
> >
> >   Merge remote-tracking branch
> 'remotes/philmd-gitlab/tags/edk2-next-20200121' into staging (2020-01-21
> 15:29:25 +0000)
> >
> > are available in the git repository at:
> >
> >
> >   git://github.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to f7bb7a3f1e8f4f854208785eead0d807ad8a688c=
:
> >
> >   tests: fix test-qga on macosx (2020-01-23 14:34:49 +0100)
> >
> > ----------------------------------------------------------------
> > * Register qdev properties as class properties (Marc-Andr=C3=A9)
> > * Cleanups (Philippe)
> > * virtio-scsi fix (Pan Nengyuan)
> > * Tweak Skylake-v3 model id (Kashyap)
> > * x86 UCODE_REV support and nested live migration fix (myself)
> > * Advisory mode for pvpanic (Zhenwei)
> >
> > ----------------------------------------------------------------
>
> When I try to build-test this merge, the clang sanitizer
> build seems to fail whenever it tries to link anything:
> (configure args '--cc=3Dclang' '--cxx=3Dclang++' '--enable-gtk'
> '--extra-cflags=3D-fsanitize=3Dundefined  -fno-sanitize=3Dshift-base -Wer=
ror')
>

That's intended, you need to add -fsanitize=3Dundefined to --extra-ldflags =
as
well now. I can change that back, but then I am not sure what one would use
--extra-ldflags for.

Paolo



>   LINK    tests/qemu-iotests/socket_scm_helper
> tests/qemu-iotests/socket_scm_helper.o: In function `send_fd':
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:53:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
> tests/qemu-iotests/socket_scm_helper.o: In function `main':
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:111:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:116:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
> tests/qemu-iotests/socket_scm_helper.o: In function `send_fd':
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:56:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
> tests/qemu-iotests/socket_scm_helper.o: In function `main':
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:121:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:121:
> undefined reference to `__ubsan_handle_nonnull_arg'
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:106:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:123:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
> tests/qemu-iotests/socket_scm_helper.o: In function `get_fd_num':
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:68:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:69:
> undefined reference to `__ubsan_handle_nonnull_arg'
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:70:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:77:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:77:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
>
> /home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helpe=
r.c:73:
> undefined reference to `__ubsan_handle_type_mismatch_v1'
> clang: error: linker command failed with exit code 1 (use -v to see
> invocation)
>
> I suspect the configure patches that try to clean up cflags
> are the cause here.
>
> thanks
> -- PMM
>
>

--000000000000e63154059cd38a53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 23 gen 2020, 19:43 Peter Maydell &lt;<a href=3D=
"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On Thu, 23 Jan 2020 at 16:45, P=
aolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" r=
el=3D"noreferrer">pbonzini@redhat.com</a>&gt; wrote:<br>
&gt;<br>
&gt; The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde=
0dd40:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0Merge remote-tracking branch &#39;remotes/philmd-gitlab/ta=
gs/edk2-next-20200121&#39; into staging (2020-01-21 15:29:25 +0000)<br>
&gt;<br>
&gt; are available in the git repository at:<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0git://<a href=3D"http://github.com/bonzini/qemu.git" rel=
=3D"noreferrer noreferrer" target=3D"_blank">github.com/bonzini/qemu.git</a=
> tags/for-upstream<br>
&gt;<br>
&gt; for you to fetch changes up to f7bb7a3f1e8f4f854208785eead0d807ad8a688=
c:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0tests: fix test-qga on macosx (2020-01-23 14:34:49 +0100)<=
br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
&gt; * Register qdev properties as class properties (Marc-Andr=C3=A9)<br>
&gt; * Cleanups (Philippe)<br>
&gt; * virtio-scsi fix (Pan Nengyuan)<br>
&gt; * Tweak Skylake-v3 model id (Kashyap)<br>
&gt; * x86 UCODE_REV support and nested live migration fix (myself)<br>
&gt; * Advisory mode for pvpanic (Zhenwei)<br>
&gt;<br>
&gt; ----------------------------------------------------------------<br>
<br>
When I try to build-test this merge, the clang sanitizer<br>
build seems to fail whenever it tries to link anything:<br>
(configure args &#39;--cc=3Dclang&#39; &#39;--cxx=3Dclang++&#39; &#39;--ena=
ble-gtk&#39;<br>
&#39;--extra-cflags=3D-fsanitize=3Dundefined=C2=A0 -fno-sanitize=3Dshift-ba=
se -Werror&#39;)<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">That&#39;s intended, you need to add -fsanitize=3Dundefined=
 to --extra-ldflags as well now. I can change that back, but then I am not =
sure what one would use --extra-ldflags for.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
=C2=A0 LINK=C2=A0 =C2=A0 tests/qemu-iotests/socket_scm_helper<br>
tests/qemu-iotests/socket_scm_helper.o: In function `send_fd&#39;:<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:53:<br>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
tests/qemu-iotests/socket_scm_helper.o: In function `main&#39;:<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:111:<br>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:116:<br>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
tests/qemu-iotests/socket_scm_helper.o: In function `send_fd&#39;:<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:56:<br>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
tests/qemu-iotests/socket_scm_helper.o: In function `main&#39;:<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:121:<br>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:121:<br>
undefined reference to `__ubsan_handle_nonnull_arg&#39;<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:106:<br>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:123:<br>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
tests/qemu-iotests/socket_scm_helper.o: In function `get_fd_num&#39;:<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:68:<br>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:69:<br>
undefined reference to `__ubsan_handle_nonnull_arg&#39;<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:70:<br>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:77:<br>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:77:<br>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
/home/petmay01/linaro/qemu-for-merges/tests/qemu-iotests/socket_scm_helper.=
c:73:<br>
undefined reference to `__ubsan_handle_type_mismatch_v1&#39;<br>
clang: error: linker command failed with exit code 1 (use -v to see invocat=
ion)<br>
<br>
I suspect the configure patches that try to clean up cflags<br>
are the cause here.<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--000000000000e63154059cd38a53--


