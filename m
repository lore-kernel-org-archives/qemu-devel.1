Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617BDC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CBE1214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="adfuX2Dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CBE1214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0568-0004t0-9o
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:59:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j04qE-0001Qj-3s
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j04qC-00013l-ND
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:42:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57038
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j04qC-00012w-Hy
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:42:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581086564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a6wstnYggFDTQy1hhorhhZGeyX9qdlf+LsuxkG8B6K8=;
 b=adfuX2DgBri6Yvx+MLpUXSLZ4L/3olvOTITalhTqa/3QAiGYN9Vr/dpfxWBFZAJrdDNjUS
 b+uugqegVU7zMTqzB/hsTCCoRSULrAUC9+EmmIw5dLEf3f4faydkrBOzCxJQoAyzUTs7qS
 p00R1q+MYaukQcb/C7nM/YCscQgmAe0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-TDI8NA5bMdmFlnCvimnKcQ-1; Fri, 07 Feb 2020 09:42:41 -0500
Received: by mail-ed1-f69.google.com with SMTP id g11so2008941edu.10
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bi2HBmaKh2r3NXLb4eOfK9MgVgQk+n+9d8Mig9OH72o=;
 b=tbwj3mDS63S3gCR+WRFeStqVBucqXAXKxjlcGc4QIzIBsuvU0W53qXNxcgkky2joJq
 6Ho4FhKNwg22UZTVP8kboco98CIzuF3XIOFaPhUBVIVh2YAdPRLUv4qcRI2GhYHySPgf
 Zxg5LXUv/wbQSbkF/vxGULcLyp3Y7gh4YgTDya5mUi14KVokeyCnrPkNDpplY44g4Iy4
 08QRje75TIWinsESlkHoWmySNoJgj9dYlCivv6Lo5hUev6+elEp0aqBm75L2GIkZnFTO
 XvgWgXgglLGYhE8pxtBd2laXqPxWNCq1xhzqxA+NksbelykuxgRXtX+k+BorrYDA9aBj
 IEYw==
X-Gm-Message-State: APjAAAV/7T5Rfj4BCLxrUiP2dRzN+/kM1Xc5CDnvQQKgB+vELJ6aHpFR
 TFo1c8NDyrgSi78wVu9NRyrQ8tWgv6tJpD64f+HMTtbJmFIVnHNdSNliGqKA3S3ZGvCIYdGb9+E
 /rcnwoPHsm0UwXmpFhGfjoRc5wL+pnQE=
X-Received: by 2002:aa7:cfcc:: with SMTP id r12mr8183197edy.57.1581086560066; 
 Fri, 07 Feb 2020 06:42:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwYmdp17CwhpTix6muFNe2l/HiPkUDK2ZyQhH2o6gIcXscL0zZOk++7cLUiJi5Y57c4Wu+qV/CHp0F9fQfhRo8=
X-Received: by 2002:aa7:cfcc:: with SMTP id r12mr8183178edy.57.1581086559792; 
 Fri, 07 Feb 2020 06:42:39 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA--P9FLM4qBxf23sLuv5Tz4HRgj7ONC7ODxnfZiLph9TA@mail.gmail.com>
 <2e70328b-5b7b-9e9d-8dfa-2af5c8e2fb28@redhat.com>
In-Reply-To: <2e70328b-5b7b-9e9d-8dfa-2af5c8e2fb28@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Feb 2020 15:42:27 +0100
Message-ID: <CABgObfbYT0fg_D=xAoVAWKA3waLgOv7Zg=Ysh3gKqzbvunr5wA@mail.gmail.com>
Subject: Re: should we have a new 'tools' manual?
To: Eric Blake <eblake@redhat.com>
X-MC-Unique: TDI8NA5bMdmFlnCvimnKcQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000c18b7b059dfd66cb"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000c18b7b059dfd66cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 7 feb 2020, 15:32 Eric Blake <eblake@redhat.com> ha scritto:

> But when I spent a mere 30 minutes seeing
> what it would take, I quickly learned that there is enough arcane
> Makefile magic going on in building from subdirectories that it wasn't
> worth my time to figure out how, especially if all that magic gets
> rewritten anyway during Paolo's conversion to meson.
>

Heh, maybe that could be a convincing example. It should be pure code
movement.


> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>

--000000000000c18b7b059dfd66cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 7 feb 2020, 15:32 Eric Blake &lt;<a href=3D"mai=
lto:eblake@redhat.com">eblake@redhat.com</a>&gt; ha scritto:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">But when I spent a mere 30 minutes seeing <br>
what it would take, I quickly learned that there is enough arcane <br>
Makefile magic going on in building from subdirectories that it wasn&#39;t =
<br>
worth my time to figure out how, especially if all that magic gets <br>
rewritten anyway during Paolo&#39;s conversion to meson.<br></blockquote></=
div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Heh, maybe that cou=
ld be a convincing example. It should be pure code movement.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
-- <br>
Eric Blake, Principal Software Engineer<br>
Red Hat, Inc.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+1-919-301-3226<br>
Virtualization:=C2=A0 <a href=3D"http://qemu.org" rel=3D"noreferrer norefer=
rer" target=3D"_blank">qemu.org</a> | <a href=3D"http://libvirt.org" rel=3D=
"noreferrer noreferrer" target=3D"_blank">libvirt.org</a><br>
<br>
</blockquote></div></div></div>

--000000000000c18b7b059dfd66cb--


