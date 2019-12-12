Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26106C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E263E21556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 20:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8BupqD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E263E21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifUjU-0002RI-2m
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 15:06:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifUig-0001R2-Uo
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:05:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifUid-0002rS-5t
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:05:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29572
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifUic-0002nW-C7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 15:05:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576181148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eZNrxuvLyGspJOoIeUrhEA+3r+/SvuVdXORWv3aeSKA=;
 b=b8BupqD+yhgkz6AoppOUeNFHZ1HBBFvBq2FT0Q6puM2vnoyeq2l310fy3oqFryzMkX5g8/
 Zye3c6oj2aV71HtAA8mfsbCLRi4SNJNahSPz5RJbPrV/ZdwopwcOwLLHhlx5E5FfVo/tM2
 meQamzl+gtG81yxhV9CKoZj4J7++1g8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-7FCHQhY2NNypaD2xFNfyDA-1; Thu, 12 Dec 2019 15:05:45 -0500
Received: by mail-ed1-f69.google.com with SMTP id a5so2110196edn.14
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 12:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eZNrxuvLyGspJOoIeUrhEA+3r+/SvuVdXORWv3aeSKA=;
 b=s1LMzc5RgxWRJSNRbYyXAAhqtEesqvJkd5a8uPBVE2q+oyThNKrprd0uV8GHSeofFc
 Bf2bs1GX5ovr7td2HJiCXk6/R+IswIIjczjJdmo0MGPqWjItt03UdX4dd6WMfCHGEDS2
 tKZE/Hus5z7Kze3qbZy4IAzIdGYq+j2Irvs4JqPjjU+2lQtTyy0+35AD/xdJZPZs5Mya
 h/vWoOXwDwvisTu261Dzbmznfv8a8nDvgvlYwpYWyPrFf84VQ/C+Wa8G/DOp2EYCEynH
 Klj66BMyNdB3T/7X8zj0Dx00f/CqdcgJE2mR0wRNFzCJxGRM/3jBsElzTPglukoiDZ86
 z/Wg==
X-Gm-Message-State: APjAAAXN40ou3CaxPLaPoolM4BjvR0VFv41L4OogS67q2Wf3PjYX6zJo
 H+vEm/jjmVgfN5mwA8xmJDdysu6OtUcme5cPxeM8smB50QRpSG10hwiNwHtjTi1+JBsG/3KVdDM
 j+6b+fJZEZTgQA0Dmv2HK0+F7NqqtiOs=
X-Received: by 2002:a17:906:b301:: with SMTP id
 n1mr11765617ejz.285.1576181144098; 
 Thu, 12 Dec 2019 12:05:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqyFIQT383dkdZoDYIjWJgettV4TLszWlwA6c06I7j7lTMN6KfrZmLAJKXeki6BQZhPcn9+y4oGNxVQIhcaWlf0=
X-Received: by 2002:a17:906:b301:: with SMTP id
 n1mr11765588ejz.285.1576181143785; 
 Thu, 12 Dec 2019 12:05:43 -0800 (PST)
MIME-Version: 1.0
References: <1576171754-45138-1-git-send-email-pbonzini@redhat.com>
 <1576171754-45138-4-git-send-email-pbonzini@redhat.com>
 <d58b507e-9d68-d112-0f6c-6f9dfb153a93@redhat.com>
In-Reply-To: <d58b507e-9d68-d112-0f6c-6f9dfb153a93@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Dec 2019 21:05:32 +0100
Message-ID: <CABgObfY_19XxcbYUMm=V7pUF-gbkyYViV7Sp4ieNiGSH+VoH3Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] hw: replace hw/i386/pc.h with a header just for
 the i8259
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-MC-Unique: 7FCHQhY2NNypaD2xFNfyDA-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="0000000000002da8ad0599874514"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Sergio Lopez <slp@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002da8ad0599874514
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 12 dic 2019, 20:04 Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> h=
a
scritto:

> On 12/12/19 6:29 PM, Paolo Bonzini wrote:
> > Remove the need to include i386/pc.h to get to the i8259 functions.
> > This is enough to remove the inclusion of hw/i386/pc.h from all non-x86
> > files.
>
> Eh this is very similar to the patch I'v staged for 5.0, now than the
> Malta/PC split got merged.
>

Ok, these patches are not urgent so I will just wait for yours to go in and
rebase.

Paolo

--0000000000002da8ad0599874514
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 12 dic 2019, 20:04 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@redhat.com">philmd@redhat.com</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">On 12/12/19 6:29 PM, Paolo Bonz=
ini wrote:<br>
&gt; Remove the need to include i386/pc.h to get to the i8259 functions.<br=
>
&gt; This is enough to remove the inclusion of hw/i386/pc.h from all non-x8=
6<br>
&gt; files.<br>
<br>
Eh this is very similar to the patch I&#39;v staged for 5.0, now than the <=
br>
Malta/PC split got merged.<br></blockquote></div></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Ok, these patches are not urgent so I will just w=
ait for yours to go in and rebase.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Paolo</div></div>

--0000000000002da8ad0599874514--


