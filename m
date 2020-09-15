Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B254EC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35907212CC
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 06:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJ9A/qRj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35907212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI4T2-0006NW-Dh
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 02:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kI4Rs-0005Xk-Qj
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kI4Rq-0005f4-1z
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 02:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600151292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rl70FFMkSFrM+UinDIwYVsoHsQOO8dgZd9QZdHfwRGc=;
 b=QJ9A/qRj79BmGQD5uZcGvl6qk1qN/H9D8k8yhaten//N6PpK1VTFYqskq5orZi1pam8Xlp
 eQ53opV+NDsGXlWDHLaIUTFvtCxrKr9S2pq610G0dk0eziNMCXBMB4bmSQunILMYmYETr+
 SlWTz5IqAkGRdhPaWrAmAugrJ93WKnI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-HuUbu42EP72KVQdKIxAj1g-1; Tue, 15 Sep 2020 02:28:10 -0400
X-MC-Unique: HuUbu42EP72KVQdKIxAj1g-1
Received: by mail-ej1-f69.google.com with SMTP id b23so858236ejv.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 23:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rl70FFMkSFrM+UinDIwYVsoHsQOO8dgZd9QZdHfwRGc=;
 b=G1XdAFWdlmNZGWrThdC0BGA3ONcut+64KtQDf/gLcH9Gjo0LZDaGDULvpR9LEepHZM
 TN43nuOLW//lBoPkf9UjC59tNVdtdsWOFyBKKZvU1BquyIT2B8uQlhEbwED3CXDmuoNr
 ZMcNyqhdsYRHh4S8dF6fArcZO6WWLACU4KJFJUwIscr3aEI+jwjvK8J7dcjIvkP8tnlW
 xfC1G2cJrNJ1qQCxqAbZn3tb5r9b/yo/0J4RKtJEIudb3m91hhcGhOPOgNryy4LzqdtK
 XbqsPLgkrDdTh57iOl4XUN/Q7TfeZ09mRCLLp/eUgfBJYnAsV/uWweWdowaYSxl6p324
 qaRw==
X-Gm-Message-State: AOAM5313zvZ9IXbqiTbzEhXsP9XvH8CAiuZgxx62VHc98mHqTN0dkGdl
 Cf3niYVWFG65g2i7FWF0t8A/j0twqZt9RQpan1paBj/N/E9XTeb1XdAHJpJbXQvB4GRjThWoRQg
 Z+5ScBQ77NpLfnsnOc7PC9li3xbGqS4Q=
X-Received: by 2002:a17:906:8508:: with SMTP id
 i8mr19224392ejx.390.1600151289277; 
 Mon, 14 Sep 2020 23:28:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcK09TIPODbaml8iVjTv5G91eXxKxr0txsnl3rwtn7RdOH7EL6+Txk9MHn6GFH3MssLGDqHg7J2g/NZO3vjes=
X-Received: by 2002:a17:906:8508:: with SMTP id
 i8mr19224371ejx.390.1600151289097; 
 Mon, 14 Sep 2020 23:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200914230210.2185860-1-richard.henderson@linaro.org>
 <20200914230210.2185860-2-richard.henderson@linaro.org>
 <eced490f-0250-3516-5d75-c6c3ff6e97be@linaro.org>
In-Reply-To: <eced490f-0250-3516-5d75-c6c3ff6e97be@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 15 Sep 2020 08:27:56 +0200
Message-ID: <CABgObfbWzf7DLgx23+yMqYqnMUaiJ=0WKaW4zvzkA4u5T9fQXQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] capstone: Convert Makefile bits to meson bits
To: Richard Henderson <richard.henderson@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000002c87c705af5441c4"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:23:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: thuth@redhat.com, luoyonggang@gmail.com,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002c87c705af5441c4
Content-Type: text/plain; charset="UTF-8"

Looks good. Can you just add a "# Submodules" heading above the test?

I would also like to remove the "yes" value (that is, the default fails if
the internal copy is not there) but it can be done later for all submodules.

Paolo

Il mar 15 set 2020, 01:06 Richard Henderson <richard.henderson@linaro.org>
ha scritto:

> On 9/14/20 4:02 PM, Richard Henderson wrote:
> > +option('capstone', type: 'combo', value: 'no',
> > +       choices: ['no', 'yes', 'auto', 'system', 'internal'],
> > +       description: 'Whether and how to find the capstone library')
>
> Dangit, meant to change value: back to 'auto'.
>
>
> r~
>
>

--0000000000002c87c705af5441c4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Looks good. Can you just add a &quot;# Submodules&quot; h=
eading above the test?<div dir=3D"auto"><br></div><div dir=3D"auto">I would=
 also like to remove the &quot;yes&quot; value (that is, the default fails =
if the internal copy is not there) but it can be done later for all submodu=
les.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 1=
5 set 2020, 01:06 Richard Henderson &lt;<a href=3D"mailto:richard.henderson=
@linaro.org">richard.henderson@linaro.org</a>&gt; ha scritto:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">On 9/14/20 4:02 PM, Richard Henderson wrote:<br>
&gt; +option(&#39;capstone&#39;, type: &#39;combo&#39;, value: &#39;no&#39;=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0choices: [&#39;no&#39;, &#39;yes&#39;, &#3=
9;auto&#39;, &#39;system&#39;, &#39;internal&#39;],<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0description: &#39;Whether and how to find =
the capstone library&#39;)<br>
<br>
Dangit, meant to change value: back to &#39;auto&#39;.<br>
<br>
<br>
r~<br>
<br>
</blockquote></div>

--0000000000002c87c705af5441c4--


