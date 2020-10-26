Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89788C388F9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B9020829
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 20:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3iMVtd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B9020829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX9aM-00008H-VH
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 16:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX9ZZ-00088U-B0
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34307)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kX9ZW-0004ut-Q9
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 16:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603745909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MdTWRfv8wLzn4d1P/1zYoXavJgFY7KslRwtkwS0tzbw=;
 b=I3iMVtd0pt8vgBnUFo1fGC/pLkqVepum27rPJxwAmfUFietjTDApUb4Ys3/3JpY2V3hp5S
 0/eoNM9nHBdCI6rHVYTgbBICYy/SMwD9P6Vqmi2hidzY5HBsNrx5nPiSE9N+tmE4c9B+0U
 N862XmCyUOfkv2WfJQEGzvnQKPN5CbM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-x2HyJm1XP2yjdUgIQ8WjFQ-1; Mon, 26 Oct 2020 16:58:24 -0400
X-MC-Unique: x2HyJm1XP2yjdUgIQ8WjFQ-1
Received: by mail-ed1-f69.google.com with SMTP id ay19so5563704edb.23
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 13:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MdTWRfv8wLzn4d1P/1zYoXavJgFY7KslRwtkwS0tzbw=;
 b=PeHB49CCUA5H0AiLBHARGNAHIhic02dQgljffl9catFWx8GwWoMkXIg1yfQxCklSEG
 kliuROP1Rf2cWF7fyxj1If93aQK60aW5K1OWSksQ1KzdS6yOf4LwVntPAtyB7YOSL+N+
 rLfX2bBgAwhzR7rHHpDRlpiyWUaHa7EvE9evON0K05a8wJ/AD2HWd40PzKRk75fOrbJR
 /oVyOAN+lPvpAuWU8d4RsbXDo7Jt1E3KgeCgs6D+RpPz1pv1rp/T2vFP5GRrXIiX5tF+
 vIM4MzXtRSxNQDeKt7ABEUlQDboJrhvV7ycsVC7rYMeIe5bjoFk99kdCplOguklH+h/3
 lIKA==
X-Gm-Message-State: AOAM530FPTNvs35ZR32nDKB+RGKxjHNJlQGBt4ddhCLVAmRbSvUesTT2
 sTbE2tuWdIwX09XWt78YQkKwewlq1ZZbSQYlRF6eoYPVfNXh+cCYlw2S7Hpxh8UMxLSHdG50hro
 nHkLn21ozbrRm2mbiXHRlOUAuEekSbyQ=
X-Received: by 2002:a05:6402:b72:: with SMTP id
 cb18mr17208258edb.129.1603745903356; 
 Mon, 26 Oct 2020 13:58:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwW5fvXObkl/kX9kqiiWzS3i/9IHRRImcAsRTbLmGlfsYa7drEDFFqy5+CVj9ZB1J6vzBDQy/1IBQatQqqQrCI=
X-Received: by 2002:a05:6402:b72:: with SMTP id
 cb18mr17208249edb.129.1603745903177; 
 Mon, 26 Oct 2020 13:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201026135131.3006712-1-pbonzini@redhat.com>
 <CAFEAcA-WscaYcpooMQ0F2Etc+Rzf5M=Bb-b9Dw7pGsaaO8Od=g@mail.gmail.com>
 <CAE2XoE9AvG-G70Rm5S=q+Xz3C2_VVGdL6DHXme=ZFPU+OOwQng@mail.gmail.com>
In-Reply-To: <CAE2XoE9AvG-G70Rm5S=q+Xz3C2_VVGdL6DHXme=ZFPU+OOwQng@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 26 Oct 2020 21:58:10 +0100
Message-ID: <CABgObfaWBLrx6nsZktbDw7PC4_L5_HQKKUF+HGLSwVRMrK+_mQ@mail.gmail.com>
Subject: Re: [PULL 00/17] Build system changes and misc fixes for QEMU 5.2
 soft freeze
To: Yonggang Luo <luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000de861105b29930ef"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000de861105b29930ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 26 ott 2020, 19:59 =E7=BD=97=E5=8B=87=E5=88=9A(Yonggang Luo) <luoyon=
ggang@gmail.com> ha
scritto:

> This pull request confused me, the windows msys2 build time slow down fro=
m
> 40min to more than one hour.
>

Probably just the cache being rebuilt. Cirrus CI times seem to vary a lot
but 40min and 1h5min seem to be the common cases before or after these
changes:

https://cirrus-ci.com/task/5531259461959680
With this PR: 35+2 (build+test)

https://cirrus-ci.com/task/4570682912669696
With this PR: 10+4

https://cirrus-ci.com/task/6662289128423424
With this PR: 35+2, +20 to rebuild cirrus cache

https://cirrus-ci.com/task/5383432727429120
Without this PR: 30+2, +18 to rebuild cirrus cache

Paolo

>

--000000000000de861105b29930ef
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 26 ott 2020, 19:59 =E7=BD=97=E5=8B=87=E5=88=9A(=
Yonggang Luo) &lt;<a href=3D"mailto:luoyonggang@gmail.com" target=3D"_blank=
" rel=3D"noreferrer">luoyonggang@gmail.com</a>&gt; ha scritto:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #=
ccc solid;padding-left:1ex"><div dir=3D"ltr">This pull request confused me,=
 the windows msys2 build time slow down from 40min to more than one hour.<b=
r></div></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div dir=3D"auto">Probably just the cache being rebuilt. Cirrus CI time=
s seem to vary a lot but 40min and 1h5min seem to be the common cases befor=
e or after these changes:</div><div dir=3D"auto"><br></div><div dir=3D"auto=
"><a href=3D"https://cirrus-ci.com/task/5531259461959680">https://cirrus-ci=
.com/task/5531259461959680</a></div><div dir=3D"auto">With this PR: 35+2 (b=
uild+test)</div><div dir=3D"auto"><br></div><div dir=3D"auto"><a href=3D"ht=
tps://cirrus-ci.com/task/4570682912669696">https://cirrus-ci.com/task/45706=
82912669696</a></div><div dir=3D"auto">With this PR: 10+4</div><div dir=3D"=
auto"><br></div><div dir=3D"auto"><a href=3D"https://cirrus-ci.com/task/666=
2289128423424">https://cirrus-ci.com/task/6662289128423424</a></div><div di=
r=3D"auto">With this PR: 35+2, +20 to rebuild cirrus cache</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><a href=3D"https://cirrus-ci.com/task/53=
83432727429120">https://cirrus-ci.com/task/5383432727429120</a></div><div d=
ir=3D"auto">Without this PR: 30+2, +18 to rebuild cirrus cache</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><div dir=3D"auto"><=
div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000de861105b29930ef--


