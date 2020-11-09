Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A23BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E8042067C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 21:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afKRJHuS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8042067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcExg-0007jn-Er
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 16:44:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcEwG-0007Hd-Ib
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:43:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25488)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcEwC-0007af-AL
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 16:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604958174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+jcj7EA/HdXtGImWzQ1zn+JILnAtpHF0j9yHIlriuuI=;
 b=afKRJHuSvjfdQR6DgmoAycp/8h+ovFTRBnVaZjxIZUebJDp+CZjvPZedrgQg7hPgWQf2EZ
 30oZz+NQejfNNG6F3DAACQmN44ArEkhZL51NgcT8X0BmBwbyhRVTj622vRMJU/2HSp0Wwy
 v6F/yt6lTDUudItHy/Hy/4QuWOA5gEg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-U1tlmgqSMSuxkEtHQJYcxw-1; Mon, 09 Nov 2020 16:42:51 -0500
X-MC-Unique: U1tlmgqSMSuxkEtHQJYcxw-1
Received: by mail-pg1-f197.google.com with SMTP id j13so7379354pgp.11
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 13:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+jcj7EA/HdXtGImWzQ1zn+JILnAtpHF0j9yHIlriuuI=;
 b=sy+TDtZ9JW2XeZwOOAAvk65Yp2rboEE1iUe7s4xUsnZ/gxnLrtzkgFUz5s6xvHAo8o
 fXUB65+c60D1RRQcouAgMTxvjWZMgyuMtdd/EvX5suwOphY/WwnCaquWfm83hF1h0+Ln
 lNe7V5YlVtAmKQh2NffG6+E6OPUJC3KDOQ+4g3365cGnsEwfZiMIVuc+acabP5uwv/Dp
 RvC0R4Z8zrz2AKwegQSnYpL0KGUgriVsRdIydKPx1WTsx6t4PvWso9lPgNAe5InjfKNu
 Y97Lqdxvs44shdLn177PKOTVhyOQz8xUO+vl3O/ZmA21htRIZFCQoj/aqw9acgMj/6nB
 exwQ==
X-Gm-Message-State: AOAM530F6MmFcGkrpqsWZ/B/TkPNDXe24EtcSoMjuqygCMUCBriy1xyT
 FRIEuWsZ+Pqr/pqQN1q1xzZZlgKUON7aOik7kKvhOXDexPVfBEM5VUKK24mxem6hZBMUn3U5WAY
 qyTX6AltNhZsvSEin/XrXhRGl5lrvlLc=
X-Received: by 2002:a65:6086:: with SMTP id t6mr14213872pgu.146.1604958170794; 
 Mon, 09 Nov 2020 13:42:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwmXLXlDQLhOIgm227fhYvTWod3DCgJuVDGShyCdm7dFi16y859TV2O4K8SrS4OMxszW9XlEDitiVs808eiu6E=
X-Received: by 2002:a65:6086:: with SMTP id t6mr14213861pgu.146.1604958170495; 
 Mon, 09 Nov 2020 13:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20201109133931.979563-1-pbonzini@redhat.com>
 <20201109133931.979563-7-pbonzini@redhat.com>
 <87h7py2ppj.fsf@dusky.pond.sub.org>
In-Reply-To: <87h7py2ppj.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 9 Nov 2020 22:42:37 +0100
Message-ID: <CABgObfaZESSsvTvSR_BUdRWQ-UPtoFyP7r1RPET2kzvjbWiE3w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] qemu-option: warn for short-form boolean options
To: Markus Armbruster <armbru@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a1d8dc05b3b37136"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a1d8dc05b3b37136
Content-Type: text/plain; charset="UTF-8"

Il lun 9 nov 2020, 22:19 Markus Armbruster <armbru@redhat.com> ha scritto:

> This function now warns, except for "help" and "?".  The exception
> applies even when we treat "help" and "?" as sugar for "help=on" and
> "?=on" because opts_accepts_any().
>

Right, because again help_wanted will be false for non-validated
QemuOptsList.

Summary: only qemu_opts_parse_noisily() warns.  This is airtight only if
> all user input flows through qemu_opts_parse_noisily().


HMP doesn't. But that's too hard to change now, and it's not considered as
much of a stable interface as the command line.

Anyway I am not going to push this for 5.2. Thanks for the speedy reviews
anyway!

Paolo

--000000000000a1d8dc05b3b37136
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 9 nov 2020, 22:19 Markus Armbruster &lt;<a href=
=3D"mailto:armbru@redhat.com">armbru@redhat.com</a>&gt; ha scritto:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">This function now warns, except for &quot;=
help&quot; and &quot;?&quot;.=C2=A0 The exception<br>
applies even when we treat &quot;help&quot; and &quot;?&quot; as sugar for =
&quot;help=3Don&quot; and<br>
&quot;?=3Don&quot; because opts_accepts_any().<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Right, because again help_wan=
ted will be false for non-validated QemuOptsList.</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex">Summary: only qemu_opts_parse_noisily() warns.=C2=A0 This is airti=
ght only if<br>
all user input flows through qemu_opts_parse_noisily().</blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">HMP doesn&#39;t. But tha=
t&#39;s too hard to change now, and it&#39;s not considered as much of a st=
able interface as the command line.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Anyway I am not going to push this for 5.2. Thanks for the spee=
dy reviews anyway!</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=
</div></div>

--000000000000a1d8dc05b3b37136--


