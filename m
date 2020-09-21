Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8616CC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0866A2085B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 07:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9suhQL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0866A2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKGcd-000214-3q
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 03:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKGak-0000WJ-V9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 03:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51480)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kKGai-0004u0-FL
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 03:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600674627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gqB5Lsx5OTfD+6RQpzI7lDyFZmCsoBp5Q2c2kV60uWU=;
 b=h9suhQL+DYKySA6LjWqUfF5eQ5QUto3h8EtJG66+UMCpy54VeyE4moyzWP+X1MLeV3LgCS
 qIROczcW+nxpNIl0++Im8uNnu7APjOPk4zSbkfAlJGpqR5fGFeAKoQbYHXQub9rxIzYRDo
 EayljC9phpqF+RCmplFA/ORwD2mDSyw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-cTXZc9S_NjSn1SnSI94o2w-1; Mon, 21 Sep 2020 03:50:24 -0400
X-MC-Unique: cTXZc9S_NjSn1SnSI94o2w-1
Received: by mail-ej1-f69.google.com with SMTP id d8so4551267ejt.14
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 00:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gqB5Lsx5OTfD+6RQpzI7lDyFZmCsoBp5Q2c2kV60uWU=;
 b=X6D1TwtmipeoFzQPxwJoRaMUVf7j5k7BVlBCQw+CUJKwxloFAvMNGQmemafrgr7IB7
 zObyfRcpDh0XjnQwzp6vTq/6xqAyYsmoln14JU4QgJMzBdw5SiCbpT3bCAE+D3xPDozj
 M7Bntn97LWFdhKhViPKYXW6JhYj1fQuw54dPYH/gENy2frJrKJrhgE+CyivEQ5cgbpuv
 Gt47g2BYOL7lZnx1L3iJYOX+pZBro15R9QjBD7UsjHvX0WKcObaxpjXFDYdFXM7bLfeL
 g1ODeQNn3lvXZ1UsZj2DPOMyq4c8qEyMo1mzLZUnd4Atl/1a1QgkEYIkIYsFR6PhkK4p
 KQkQ==
X-Gm-Message-State: AOAM530kZtWsATrR6HqRIxEYhPEAftbz0aFPVpInyf865jNF2yZ/UDJD
 MDqrw1MMjShVOtNo4roA2gFzdZE/j0jGumXXCPxTWl84dI+hUt86Wdij0gyOvV1b+vp1AMYNsvC
 DyHkWpG6OHwPUQxnKAnEIj0NvDY9xbho=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr48638594edo.243.1600674622883; 
 Mon, 21 Sep 2020 00:50:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzU6lV4lshv48skzt1KXxNSdntdJE+GNWubkBAUvDCQZTaPMrFCGPLrvw9cAIyPcMqGODzV75bmRHElyRm7sSA=
X-Received: by 2002:aa7:d043:: with SMTP id n3mr48638584edo.243.1600674622639; 
 Mon, 21 Sep 2020 00:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200920130708.1156310-1-pbonzini@redhat.com>
 <20200920130708.1156310-9-pbonzini@redhat.com>
 <3e7c8af9-f110-13d2-b522-f5cff6490f16@linaro.org>
In-Reply-To: <3e7c8af9-f110-13d2-b522-f5cff6490f16@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Sep 2020 09:50:10 +0200
Message-ID: <CABgObfYi_rnYMHbUD1NzMN-TLZgL1gYKY=JATNa9Bu_V0J=HrA@mail.gmail.com>
Subject: Re: [PATCH 8/9] default-configs/targets: remove useless lines
To: Richard Henderson <richard.henderson@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000048b3a005afce1a3b"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

--00000000000048b3a005afce1a3b
Content-Type: text/plain; charset="UTF-8"

Il lun 21 set 2020, 02:29 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> On 9/20/20 6:07 AM, Paolo Bonzini wrote:
> > Some lines are only meaningful for user-mode targets, remove them.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
>
> This seems like it could be folded with the previous.
>

The previous patch was just taking the (constant) config-target.mak from a
Linux and a BSD build tree and copying them over to default-configs, which
I liked. Alternatively I could first remove these lines from the files with
a configure patch.

Paolo


>
> r~
>
>

--00000000000048b3a005afce1a3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 21 set 2020, 02:29 Richard Henderson &lt;<a hre=
f=3D"mailto:richard.henderson@linaro.org">richard.henderson@linaro.org</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 9/20/20 6:07 AM,=
 Paolo Bonzini wrote:<br>
&gt; Some lines are only meaningful for user-mode targets, remove them.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
<br>
This seems like it could be folded with the previous.<br></blockquote></div=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">The previous patch was=
 just taking the (constant) config-target.mak from a Linux and a BSD build =
tree and copying them over to default-configs, which I liked. Alternatively=
 I could first remove these lines from the files with a configure patch.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
<br>
r~<br>
<br>
</blockquote></div></div></div>

--00000000000048b3a005afce1a3b--


