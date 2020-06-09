Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C346C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 06:56:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B5D2074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 06:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiFk4AmL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B5D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYBK-0008AE-Gp
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 02:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jiYAS-0007b1-38
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 02:55:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36442
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jiYAQ-0001KO-FN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 02:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591685725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlqAhnDQ2SPq0vSS7OYxjf3ONLXxDdsA59s3DtA5dSk=;
 b=NiFk4AmL5XziFWJXmBkGPoH3FbFhajZubXuV4SIvRZtnmrdjPG/8HehPiBfBP2uHyJOpE4
 LddcSCrfzAfcvp10mDqXhDu5hepRepYDsJlEpYdolk+TJqwdoZk37T9coV/ZCrmhaaofnw
 c3nefMAYLKkhSiUEODnAknn/Bz/xVW0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34--xeETjWWMmuZlftDFmQHpw-1; Tue, 09 Jun 2020 02:55:20 -0400
X-MC-Unique: -xeETjWWMmuZlftDFmQHpw-1
Received: by mail-ej1-f69.google.com with SMTP id i17so7051554ejb.9
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 23:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AlqAhnDQ2SPq0vSS7OYxjf3ONLXxDdsA59s3DtA5dSk=;
 b=A/Aqh9k23xZ1w6X7yjLo35WVb9mgeNKXrdIJo+KfcGu7o+ACtcnfZbwyk7X+pSKO/q
 3djB3fU2Smf+Rmkb/fgGAj1cCOgD25DmCfEXIvS5hho9gDHBfwqURXO39TgqvewnXYPP
 U0ik0RO+wxwFRvR0yFsI2C813u9MqTY7qTudk27JSqItk2DPE+ZaU098hb8JdjW0DwS1
 g+XWEh3V3xwXfI4pNBhlNhfvYclBoEvJwKz/pfqKJs8XhLyk4Ae0/zGv85z0hTzgEPoW
 qpmmLc88mkeyvGR1af5kC7qxAN8Gml+7+EOE0nqiV6g7i6GuRwDz0ZLE32lN+uzKdWgU
 isYA==
X-Gm-Message-State: AOAM532231shsRaNgIHPN2mCsqx1bSQK+NIxjJZFZ9lOERGbvslkYZLC
 f5hSsJz4y1IPd5PnRxGZuiUFGWQi1fSA+1qBl2/LSL8Hcy2n+Y3zA04lDxSSKH+Apls2L6eLRay
 9fvM8yHy9d61svjlNrMffx6kB5TjKybc=
X-Received: by 2002:a17:906:fa03:: with SMTP id
 lo3mr24827937ejb.196.1591685719262; 
 Mon, 08 Jun 2020 23:55:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxcJCPNtFFx0ZuCUT1Wf+BGIUa3Sww9c6ceeTbLxCb/WgM1MGynz0YYJRMbm6Wy9QjQYCyNsYUgZQIAOZpvcM=
X-Received: by 2002:a17:906:fa03:: with SMTP id
 lo3mr24827916ejb.196.1591685719085; 
 Mon, 08 Jun 2020 23:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200519145551.22836-1-armbru@redhat.com>
 <5f7c749a-ccbe-5ff6-3889-696d5de05fc0@redhat.com>
 <878sgxvn9q.fsf@dusky.pond.sub.org>
 <8393f947-6573-cfce-4f63-9c027ab7ff04@redhat.com>
 <87h7vkspus.fsf@dusky.pond.sub.org>
In-Reply-To: <87h7vkspus.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 9 Jun 2020 08:55:01 +0200
Message-ID: <CABgObfYvqC2z70nTj=WwOEbi+ZC9v7WB5YuGAKy6we+YNM9gjQ@mail.gmail.com>
Subject: Re: [PATCH 00/55] qdev: Rework how we plug into the parent bus
To: Markus Armbruster <armbru@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000e16f0805a7a135ab"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "P. Berrange, Daniel" <berrange@redhat.com>, "Habkost,
 Eduardo" <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e16f0805a7a135ab
Content-Type: text/plain; charset="UTF-8"

All of it this time.

Paolo

Il mar 9 giu 2020, 08:41 Markus Armbruster <armbru@redhat.com> ha scritto:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > On 08/06/20 12:56, Markus Armbruster wrote:
> >>> Great stuff, I only had some comments on the commit messages.  I still
> >>> have to review patches 47 and 48 more corefully.
> >> Does this translate into any Reviewed-bys?  On v2, maybe?
> >>
> >
> > Yes, please add my Reviewed-by on v2.
>
> All of v2, or v2 less PATCH 49+50 (old 47+48)?
>
>

--000000000000e16f0805a7a135ab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">All of it this time.<div dir=3D"auto"><br></div><div dir=
=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 9 giu 2020, 08:41 Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; ha scritto:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">Paolo Bonzini &lt;<a href=3D"mailto:pbonzi=
ni@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>=
&gt; writes:<br>
<br>
&gt; On 08/06/20 12:56, Markus Armbruster wrote:<br>
&gt;&gt;&gt; Great stuff, I only had some comments on the commit messages.=
=C2=A0 I still<br>
&gt;&gt;&gt; have to review patches 47 and 48 more corefully.<br>
&gt;&gt; Does this translate into any Reviewed-bys?=C2=A0 On v2, maybe?<br>
&gt;&gt; <br>
&gt;<br>
&gt; Yes, please add my Reviewed-by on v2.<br>
<br>
All of v2, or v2 less PATCH 49+50 (old 47+48)?<br>
<br>
</blockquote></div>

--000000000000e16f0805a7a135ab--


