Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14262C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 22:07:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E752082E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 22:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDz3Jz8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E752082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz6LX-0005QJ-R8
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 17:07:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iz6Kn-0004he-Sh
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 17:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iz6Kk-0006eE-It
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 17:06:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21281
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iz6Kj-0006c0-H4
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 17:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580853972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0YiEa8m8vIastrQuCMZZMuhVlMlLXqmhdpwlLbNjUFo=;
 b=CDz3Jz8sUwo1eoKmXoIwlRPJbSF+7mID7OaFvwH9gf02khBIrXySdH3ghm/zxdRF2iJEj6
 B6fiSbzNJYl7zUGSGCzb6Bf4b0CLNAboyFnLu5ydF8G0cPgNUwNSe5mSPX/LyzYaF1IhZA
 rqyYMsutERBGWFdLW/xfFHJmvKcZBcw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-DHiXtlK4MVuHwdafm2Z4Ig-1; Tue, 04 Feb 2020 17:06:09 -0500
Received: by mail-ed1-f69.google.com with SMTP id s20so94516edy.23
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 14:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eZ2OpUPvQbrMmxk0kcqH4ilF5rZbGntGN+8c58EGjVo=;
 b=tYoPXePM8sjxZOSdf6lowAc4YmEQCsb4Smg0i7rBChawfbl2tjBduTbTnVQh8g948L
 PvNdDSnYYbuklplMNrTIBg/tXH9bqMv1XaHc8Shf5zkGNClbYgOYpcEXhOlY95+zK/tm
 VZYdN346hzCq2zLJKTedGdbp8IMslMj21dZ9uiwIuJQq487RN7wzJHcM1YPDzwk0uvYP
 H0kI2lC4ig3nZC+WqmBimAvlmuv0aJMww325a8+jWjfNh7ZrgXINPr6+2e4JKLEWT7I/
 CGyr8Y6DAR4wev9EkG4rrLlWgM5kO6tuW6jPvXa7ZNFmeOYLhVeu4LvK4L+XZHtEMgKx
 d2Qw==
X-Gm-Message-State: APjAAAXx2RW7gwNIDz5XTJ9Nb+0Gg6SeeDcJv4ENTpmsdHgt1gHfMnNs
 G/+PWdM4yAY/gYEnhZej78rhD+Bwk8YPvcU/TxXGAKmeyUx8vpjfipoEUn8cwhdJ0uVTIqTVyYx
 bVrYL0/BkA07X0QDOgPOWmZw6u4Oni78=
X-Received: by 2002:a17:906:82cb:: with SMTP id
 a11mr28652346ejy.206.1580853968664; 
 Tue, 04 Feb 2020 14:06:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqzb880SL0fXL/TQvatrobeGtOcdggFoTXsskHUAI40BHFQAb/DapqP00xcODZCP/mgOiBCZfMjbXzS5m1mvtRQ=
X-Received: by 2002:a17:906:82cb:: with SMTP id
 a11mr28652325ejy.206.1580853968353; 
 Tue, 04 Feb 2020 14:06:08 -0800 (PST)
MIME-Version: 1.0
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <20200204160830.02afbd2e@redhat.com> <20200204163909.5ce2cb2a@redhat.com>
In-Reply-To: <20200204163909.5ce2cb2a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Feb 2020 23:05:55 +0100
Message-ID: <CABgObfZuzA7qNxp4KbaGJ4oVT1YX+1KLL=cZgCKa9sWSV2tFeQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/80] refactor main RAM allocation to use hostmem
 backend
To: Igor Mammedov <imammedo@redhat.com>
X-MC-Unique: DHiXtlK4MVuHwdafm2Z4Ig-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000039d73e059dc73f7e"
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000039d73e059dc73f7e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure! I probably won't send a pull request for a week or so though.

Paolo

Il mar 4 feb 2020, 16:39 Igor Mammedov <imammedo@redhat.com> ha scritto:

> On Tue, 4 Feb 2020 16:08:30 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
>
> > On Fri, 31 Jan 2020 16:08:30 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >
> > Paolo,
>
> forgot to add address to CC
>
> >
> > could you take a look at patches 1-7, 73,75-78 and
> > if series looks to be in acceptable shape, merge it via your tree
> >
> > > v4:
> [...]
>
>

--00000000000039d73e059dc73f7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Sure! I probably won&#39;t send a pull request for a week=
 or so though.<div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il m=
ar 4 feb 2020, 16:39 Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.co=
m">imammedo@redhat.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">On Tue, 4 Feb 2020 16:08:30 +0100<br>
Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">imammedo@redhat.com</a>&gt; wrote:<br>
<br>
&gt; On Fri, 31 Jan 2020 16:08:30 +0100<br>
&gt; Igor Mammedov &lt;<a href=3D"mailto:imammedo@redhat.com" target=3D"_bl=
ank" rel=3D"noreferrer">imammedo@redhat.com</a>&gt; wrote:<br>
&gt; <br>
&gt; Paolo,<br>
<br>
forgot to add address to CC<br>
<br>
&gt; <br>
&gt; could you take a look at patches 1-7, 73,75-78 and<br>
&gt; if series looks to be in acceptable shape, merge it via your tree<br>
&gt; <br>
&gt; &gt; v4:<br>
[...]<br>
<br>
</blockquote></div>

--00000000000039d73e059dc73f7e--


