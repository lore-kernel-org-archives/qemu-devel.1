Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19CFC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 19:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219E52072E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 19:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KxYDv6ef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219E52072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNhSe-000783-Q7
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 15:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNhRU-0006gH-5o
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 15:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56344)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kNhRS-0003IO-HA
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 15:07:07 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601492825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZlX+k3mrdrg9pzzi3b1KH/xW2/J/U03Sp15IKcxQxe4=;
 b=KxYDv6efjHzcpVsThgcJcHTh+/C4ypr4rqENeVOY2TyKOZTzh2KcyZG8OCVlPp3QapbkI4
 oMZaNcbvijs4Mtppui67RURwu3umln7kjeDHIQMynfpOfS8JKDedwGXb3UD0qM7+aUQPK1
 BSQ42ci+fNF/uVKou2cudHXfFtZO3EQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-o_7HusOTMsmCBx7SovQf-A-1; Wed, 30 Sep 2020 15:05:15 -0400
X-MC-Unique: o_7HusOTMsmCBx7SovQf-A-1
Received: by mail-ej1-f71.google.com with SMTP id rs9so1176937ejb.17
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 12:05:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZlX+k3mrdrg9pzzi3b1KH/xW2/J/U03Sp15IKcxQxe4=;
 b=poKICJYTiikkV1ELBnU/TMJOSIajImaUO3nGNnaMESGgYK47gfLLvVgf0mhCImbY8Q
 AePMyZaaLdi2VLh+jlS2iEGW3hWF1pxuFfEQJ/g+XE6qVyxUAYH+A/6MIfApeeGuonSI
 cYscuvnTY5T5JKxI5cuVTNlY31PEcQtJgoYxfECfC6JOWMqCpKlVhnrL68D8a+5Fz8ex
 JmNKaqdIEV8H2YkL35YcwyL3LITaXru36Nx+fpd28H2JP9Bt0MCGSloiowWII5AETlJN
 SsQfUGHxG37AQkM9aOdjMZMqUBc0wT4qVcs5Bzf2pgoZIEW9frbo8uMPzemAKrcOc3iq
 I+lQ==
X-Gm-Message-State: AOAM530JRC+rbFcP5IQX3/opTd2kvwuFoRxfsbz2Yu8odCFzstm0HDfx
 9VbZxzrMi33jbSUUP7w91nU29x61Jir3ErdyrgAp5mgQODfjRK9i4YEw/DKFsZIg34sDEkLX/pm
 VK41JKp+g49a1ABFjqqZMj5SiYQmHqgI=
X-Received: by 2002:a17:906:b88e:: with SMTP id
 hb14mr4164826ejb.543.1601492714390; 
 Wed, 30 Sep 2020 12:05:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsXnER/32c4vtdMgtXcfpjmk2SzcBQU5yHJBRBZh+byga4exSQw7nPZYBVTbsLogJ1Z3ZjESEgER0pCyFmD1U=
X-Received: by 2002:a17:906:b88e:: with SMTP id
 hb14mr4164778ejb.543.1601492714000; 
 Wed, 30 Sep 2020 12:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200930164949.1425294-1-philmd@redhat.com>
 <20200930171529.GR3717385@habkost.net>
 <0c46bedf-9aa6-4ea9-40e1-b0f85a767bb5@redhat.com> <87lfgrnle1.fsf@linaro.org>
In-Reply-To: <87lfgrnle1.fsf@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 30 Sep 2020 21:05:02 +0200
Message-ID: <CABgObfazj_msv60wByUhumfzHfw5txwid_bR17b-g3Ho42+MdA@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] user-mode: Prune build dependencies (part 3)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000054307605b08c94b8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Peter Lieven <pl@kamp.de>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000054307605b08c94b8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 30 set 2020, 20:57 Alex Benn=C3=A9e <alex.bennee@linaro.org> ha scri=
tto:

> > 1-8 is fine, but I think 9-11 is too much complication (especially not
> > really future-proof) for the benefit.
>
> Isn't qdev considered an internal API for our object and device lifetime
> handling (which should be shared) versus QAPI which only exists for
> system emulation and tool integration?
>

qdev is nothing more than a bunch of QOM classes, and QAPI is an integral
part of QOM (though properties, which are used when setting up CPUs in user
more emulation)

Therefore, even though most of the QAPI schema is specific to system
emulation and tools, a small part is used by common code.

Paolo

>

--00000000000054307605b08c94b8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 30 set 2020, 20:57 Alex Benn=C3=A9e &lt;<a href=
=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; ha scritt=
o:</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex">
&gt; 1-8 is fine, but I think 9-11 is too much complication (especially not=
<br>
&gt; really future-proof) for the benefit.<br>
<br>
Isn&#39;t qdev considered an internal API for our object and device lifetim=
e<br>
handling (which should be shared) versus QAPI which only exists for<br>
system emulation and tool integration?<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">qdev is nothing more than a bunch of =
QOM classes, and QAPI is an integral part of QOM (though properties, which =
are used when setting up CPUs in user more emulation)</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Therefore, even though most of the QAPI schem=
a is specific to system emulation and tools, a small part is used by common=
 code.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div d=
ir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--00000000000054307605b08c94b8--


