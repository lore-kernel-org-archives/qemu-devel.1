Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF1BC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:23:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 163E820767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 21:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1HivOCK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 163E820767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDDko-0005IL-7m
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 17:23:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDDjl-0004Yv-7n
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:22:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36443
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDDjg-0002hU-T3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 17:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598995351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P4gI08uAA/4Z8rMBJGwvPmw7THk4ZB2PD97YdApKjlg=;
 b=B1HivOCK15O7q/jG/51EuB7hMfJAPUJwax8DpPb8AFZq7XlQYR7VrNDhYmneCILiU99l9V
 DisJmawyDfP4HBwp7JRmhF2LmcAtM+epn3WDdKgrpFuJXEDgMA+MlppwRBHH7pBrW8huhS
 B8GDXYYe6OBFVXUj7pUgR5al19FbXmg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-4QvsDfwePF2rbsF5pg0Lig-1; Tue, 01 Sep 2020 17:22:26 -0400
X-MC-Unique: 4QvsDfwePF2rbsF5pg0Lig-1
Received: by mail-ed1-f71.google.com with SMTP id n4so1103813edo.20
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 14:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P4gI08uAA/4Z8rMBJGwvPmw7THk4ZB2PD97YdApKjlg=;
 b=OPT/olbikstCK8ABrO+yggveJetKMPMqFntYFT0W60N7irMpImFUYkY9vEmR1b2NAp
 +cBa66FKtps/2u7IEL7ciwYxE+ugPsGataO+R7mkNvDw6N38H2z43nDZERxSpq16Grw/
 A7HcplM6r8tS7h8lkUhfNx0haiuyir08MMTKdUTVus6GHDsC6E12kZJp3IqECUxwEOtr
 txoO/03iPXckYI4AHSn12qJ8lVyaY6pbeISKX/av7dBU5FghHtTDZ3GLV7nn3lzipRnU
 oek9GRhE/fM26V44J64iEEEtxBMwrX1PYazDmKtN2yQkWb0vaXpNeY0UCAzjZYe+ZerG
 7MPQ==
X-Gm-Message-State: AOAM530twZ5XaReMDjGVAydSg5x4PeEjBWV2dCN7IPzoS3x1PSgWeXhb
 bx2NgAVUuMR/UlpnCyqKcdxWH0f10RGxAAV54+ybIG/56zKfqQHbY2xdHh30hV8HtEptL4dBIJX
 1Zfgzp2JBSJcIDYMrRhqtViCenqWtTlk=
X-Received: by 2002:a50:8d57:: with SMTP id t23mr3774576edt.308.1598995345197; 
 Tue, 01 Sep 2020 14:22:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDZlQax/Nj96QuIOoia/jrH9nzhCGf3QzMAPkaQnV+gUo5R+qnb2pIc2uSnl7nGgAqyFO1CpFw1oPpb3DgTFU=
X-Received: by 2002:a50:8d57:: with SMTP id t23mr3774562edt.308.1598995344969; 
 Tue, 01 Sep 2020 14:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200901062020.26660-1-pbonzini@redhat.com>
 <156da43a-4744-ac6c-fc4b-54788a40b3e9@ilande.co.uk>
In-Reply-To: <156da43a-4744-ac6c-fc4b-54788a40b3e9@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 1 Sep 2020 23:22:12 +0200
Message-ID: <CABgObfYcaCsZNYof9nd7gzCOY_6qN5MV+xD6dw7W4D4ircsdaQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] Make QEMU installation relocatable
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000088ec1305ae471d47"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 16:44:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yonggang Luo <luoyonggang@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000088ec1305ae471d47
Content-Type: text/plain; charset="UTF-8"

Il mar 1 set 2020, 23:15 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
ha scritto:

> I think this means that it's missing something from Yonggang Luo's patch
> here:
> https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg07668.html.


Yes, I am a bit afraid of that patch. I don't understand exactly why it's
needed and I need to look more closely.

Paolo

I haven't looked
> at patch 1 in that series for converting undefsym.sh to undefsym.py yet,
> although
> last time I was able to get a working build without it.
>
> Also patch 13 wouldn't apply for me to git master: I ended up having to
> make the
> changes by hand, so looks like something requiring a rebase has recently
> snuck in.
>
>
> ATB,
>
> Mark.
>
>

--00000000000088ec1305ae471d47
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 1 set 2020, 23:15 Mark Cave-Ayland &lt;<a href=
=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>=
&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">I think this means=
 that it&#39;s missing something from Yonggang Luo&#39;s patch here:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg07668.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/html/qemu-devel/2020-08/msg07668.html</a>.</blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Yes, I am a bit afraid of tha=
t patch. I don&#39;t understand exactly why it&#39;s needed and I need to l=
ook more closely.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"> I haven&#39;t looked<br>
at patch 1 in that series for converting undefsym.sh to undefsym.py yet, al=
though<br>
last time I was able to get a working build without it.<br>
<br>
Also patch 13 wouldn&#39;t apply for me to git master: I ended up having to=
 make the<br>
changes by hand, so looks like something requiring a rebase has recently sn=
uck in.<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div></div></div>

--00000000000088ec1305ae471d47--


