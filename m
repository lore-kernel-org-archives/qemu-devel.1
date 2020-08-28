Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA84C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 21:33:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60AC52080C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 21:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ize3Zkph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60AC52080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBm08-0000I2-JF
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 17:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBlzW-0008Gq-QT
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 17:32:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54351
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBlzU-0002SX-B8
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 17:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598650374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ju53stWfwMFcuCbUFJMwgiR9+btMQqApWQd7azRtlZ0=;
 b=Ize3ZkphnTX0K4fP/DoK6gQx28wSwnfZ/vlRJiFQ2zhGKb+zu+nxAj2aVpiAOcPTzlOaQ1
 cJduijbrZO+apbFOyct6+o/i8cnN4zYW/PGArZFsClagFfTs3bUxCnmLa8ZbW/ShqABMBh
 5mJF8NPRktyTU1xiYCNzAeF5I2u+H4Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-l-fwx0faNwOc7M-CjPhDVw-1; Fri, 28 Aug 2020 17:32:52 -0400
X-MC-Unique: l-fwx0faNwOc7M-CjPhDVw-1
Received: by mail-ej1-f70.google.com with SMTP id dr9so1131349ejc.19
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 14:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ju53stWfwMFcuCbUFJMwgiR9+btMQqApWQd7azRtlZ0=;
 b=Hr/01fSq/bZEd44gnwh0Le18OT5u6JLlbBB6lkuY35sLqjXRsc65U3bhXiASUviyUA
 9e1SpWkhP+Pzih8CqtbBojGJTpsmwldVhEPAAZukfDjzg6+LSVlPdM757oEzOBnnutIt
 UujfMOUsZcHzDcezWdAaeQYO9Ks/OGe5xP7vHnr5vGPyJ1/A5yxYoQPWNQiPg+9qiu4z
 kkUxLx7ZOpuCw+Y5odvQ6y7M+0FPsW3ChfZYCccTD2SgccwQ3Q29chiCgWvkXOeWRWyp
 9ALQ/EECEr1KXS0cftGj57MMeOSW8yh7TtC6K6DR2Qbww1z7yYsJl7UtcgVde4STyMuR
 2OBg==
X-Gm-Message-State: AOAM532j6tCX4rZfDyiNdi64f42yGWF7LXJVTT0LslwmvBviug1kR8Ia
 2dliQ55dxZ/E9pFgAG7Ee124IMp3/8d4oBp+Q0g/tBVC1uyxYQ0TLGcnSA5KeoBUXiikzC1J9ZF
 pNOrGNU0+Oy5vYipOr7V8A9K3B37hdPs=
X-Received: by 2002:a17:906:c001:: with SMTP id
 e1mr775182ejz.390.1598650371115; 
 Fri, 28 Aug 2020 14:32:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwf1W+3WMAWE+n+OyrTJWWZziCvmWyxy95z1fdSDq4eYEIonHlaDF2AbIEvOtZ4tvIT310X0WgOxqSsFU7vkc=
X-Received: by 2002:a17:906:c001:: with SMTP id
 e1mr775166ejz.390.1598650370876; 
 Fri, 28 Aug 2020 14:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200828173841.33505-1-pbonzini@redhat.com>
 <CAE2XoE8TWB_qnqYjNe=qUEebO0xktfWai77c-ab938XBoeqesQ@mail.gmail.com>
In-Reply-To: <CAE2XoE8TWB_qnqYjNe=qUEebO0xktfWai77c-ab938XBoeqesQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 28 Aug 2020 23:32:39 +0200
Message-ID: <CABgObfYHjKFgoxPKBGg-HwVA-5ZL8-Rw1hv2Wxu1-Uabxkfmfw@mail.gmail.com>
Subject: Re: [PATCH] meson: move zlib detection to meson
To: luoyonggang@gmail.com
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000079fb7b05adf6cba1"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/28 16:27:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000079fb7b05adf6cba1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 28 ago 2020, 23:13 =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyon=
ggang@gmail.com> ha
scritto:

> -  --disable-zlib-test) zlib=3D"no"
>> +  --disable-zlib-test)
>>
> Why not remove this no-op
>

Because I did not want to introduce visible changes.

Paolo

--00000000000079fb7b05adf6cba1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=
=3D"ltr" class=3D"gmail_attr">Il ven 28 ago 2020, 23:13 =E7=BD=97=E5=8B=87=
=E5=88=9A(Yonggang Luo) &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyon=
ggang@gmail.com</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><di=
v dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">-=C2=A0 --disable-zlib-test) zlib=3D&quot;no&quot;<br>
+=C2=A0 --disable-zlib-test)<br></blockquote><div>Why not remove this no-op=
=C2=A0</div></div></div></blockquote></div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Because I did not want to introduce visible changes.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div>

--00000000000079fb7b05adf6cba1--


