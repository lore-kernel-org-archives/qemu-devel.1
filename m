Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEF4C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD87E22CBE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 16:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vr1fAyW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD87E22CBE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBL13-0000I8-68
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 12:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBL0V-0008GT-RV
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBL0S-0002wq-P3
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 12:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598546646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nPmsmHw0ACcgFGhsL5owajIbOa4VP6/EtnkFsqSMW5o=;
 b=Vr1fAyW0kb4H5ppE0ym3Sy3UbHZ6dl4TF4TcZ+SLvjMP0qapfGslODZAj7xkulcnrMQFdv
 K4Hf7NpEezTMPXd3pNe/Ovs2MD4mv/3LIJHs98EppIdrQVgzTqQhgYbtHjWGACt5TBi9N8
 2ba6dJkp2C1LSt4dg0Kga/jueKQGV/o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-Tg9FR1v9OF2hXCF5FQPXMQ-1; Thu, 27 Aug 2020 12:43:56 -0400
X-MC-Unique: Tg9FR1v9OF2hXCF5FQPXMQ-1
Received: by mail-ed1-f72.google.com with SMTP id g20so2163266edj.15
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 09:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nPmsmHw0ACcgFGhsL5owajIbOa4VP6/EtnkFsqSMW5o=;
 b=mRkDiRyUxnlBh5oYP80xDiaak84+U4U69QnzlJx37VLigZVlz0wpHB2EE7NfgMZrak
 VqnplTe+3BJp7yvxOjeD+tZhGgOi8whDG7jpEsDMmuKo5DLLy069TKX0t4uVFaKUdssb
 mV6M6AX/kuTLwJKYa16taEjE0l1S1Q4C65HFPo0h6RcATTG03SXaBNcFwNnoPFbrf1CU
 xHo0zxaocD0f7TBNVWrx43l5ZMEeUpk7UgswaMz0QJuEcR4EgQKIjEBJmiQGQSmOm4VC
 7+fi4zc32+RcCc5SnwZiaM6l9trSWL8iC9BFlJfa8xT32ie5MESCoXvDulG0ltLeIWAt
 IVNQ==
X-Gm-Message-State: AOAM533hAboNZXwD/4JVLaD0m0bx9sXV+xsgbds/WmII+sSecS5HhNX1
 +e6GwaKQr9xBZj1nEnRjq9LFgie03QZt2CslmgcNMy0B21Ca4p8aDRdqpuJcgirEFexVK6SJdMJ
 C2zK1IvK7HDbFAsmH9O3GZ1N3brqmNqM=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr22661590ejw.71.1598546635408; 
 Thu, 27 Aug 2020 09:43:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxl5FrdZpOn00FOcaMv0ljQKPbXG7qtkwn7dAR94bM9bMvqOrZJggKD8qoOxaQigrq5srzr9MfdmPZzfiNxJFc=
X-Received: by 2002:a17:906:328d:: with SMTP id
 13mr22661569ejw.71.1598546635206; 
 Thu, 27 Aug 2020 09:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200825165341.520-1-luoyonggang@gmail.com>
 <426ddc96-c26d-e762-0598-7ae61c711d8e@ilande.co.uk>
 <CABgObfb4K8=5Ydkhx2px+kfDwb8SmQ97LFpsaNbRbU6U0rvXwA@mail.gmail.com>
 <0abb8d9a-cf86-1c00-df8c-2dacf8f99d76@ilande.co.uk>
In-Reply-To: <0abb8d9a-cf86-1c00-df8c-2dacf8f99d76@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Aug 2020 18:43:43 +0200
Message-ID: <CABgObfboz=7tAT6_FfxMZ9M7Nu_RtCP_gwQeFT=X9pj=yTwaUQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] meson: Fixes the ninjatool issue that E$$: are
 generated in Makefile.ninja
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000594da905addea493"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 02:54:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: luoyonggang@gmail.com,
 =?UTF-8?B?RGFuaWVsIFAgLiBCZXJyYW5n6IyF?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000594da905addea493
Content-Type: text/plain; charset="UTF-8"

Il gio 27 ago 2020, 18:05 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
ha scritto:

> On 26/08/2020 07:45, Paolo Bonzini wrote:
>
> > On Tue, Aug 25, 2020 at 11:26 PM Mark Cave-Ayland
> > <mark.cave-ayland@ilande.co.uk> wrote:
> >> I've tested this and it changes build.ninja so instead of Windows paths
> beginning C$$
> >> they now begin C$ instead e.g.:
> >>
> >> build qemu-version.h: CUSTOM_COMMAND  |
> >> C$:/msys64/home/Mark/qemu/scripts/qemu-version.sh PHONY
> >
> > The patch should not change build.ninja in any way, but indeed it will
> > fix the transformation so that the (correct) ninja quoting is removed.
>
> It definitely changes build.ninja here, with the escaping changing from
> C$$:\ to C$:\
> in my tests.


Yes, the ^ makes no difference but I missed that it also adds a $.

Thanks for testing!!

Paolo

if you're saying that $: with just a single $ is the correct
> escaping for colon then I guess the patch is fine (and indeed it works for
> me with
> the $ now being removed in the transformation to Makefile.ninja).
>
>
> ATB,
>
> Mark.
>
>

--000000000000594da905addea493
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 27 ago 2020, 18:05 Mark Cave-Ayland &lt;<a href=
=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>=
&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 26/08/2020 07:4=
5, Paolo Bonzini wrote:<br>
<br>
&gt; On Tue, Aug 25, 2020 at 11:26 PM Mark Cave-Ayland<br>
&gt; &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk" target=3D"_blank"=
 rel=3D"noreferrer">mark.cave-ayland@ilande.co.uk</a>&gt; wrote:<br>
&gt;&gt; I&#39;ve tested this and it changes build.ninja so instead of Wind=
ows paths beginning C$$<br>
&gt;&gt; they now begin C$ instead e.g.:<br>
&gt;&gt;<br>
&gt;&gt; build qemu-version.h: CUSTOM_COMMAND=C2=A0 |<br>
&gt;&gt; C$:/msys64/home/Mark/qemu/scripts/qemu-version.sh PHONY<br>
&gt; <br>
&gt; The patch should not change build.ninja in any way, but indeed it will=
<br>
&gt; fix the transformation so that the (correct) ninja quoting is removed.=
<br>
<br>
It definitely changes build.ninja here, with the escaping changing from C$$=
:\ to C$:\<br>
in my tests.</blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">Yes, the ^ makes no difference but I missed that it also adds a $=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks for testing!!</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"> if you&#39;re saying that $: with just a single $ is the co=
rrect<br>
escaping for colon then I guess the patch is fine (and indeed it works for =
me with<br>
the $ now being removed in the transformation to Makefile.ninja).<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div></div></div>

--000000000000594da905addea493--


