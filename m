Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADEDC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2736F20738
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsIKFOZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2736F20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBDBg-0006Wk-Dy
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBDB9-00066q-B1
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:22:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53242
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBDB7-0004Ee-Qh
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598516556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jDjpiVojItjCevivgniLD3ESmTQtDrvY9SB5Mb2/ADE=;
 b=PsIKFOZJlqZwnj8qIqsA78dqFk9IojZdBauO50Tg64UNj63u4tsrk6EYC4UFZERAVKABed
 sWolaW4sjWT5WZ9sG7K5Ic5qjDgKB9t5b8nmnt3zHZ0uHHaUCJZ2k7Xu+NOlSiNfOfKfMp
 Mz7VDYyF2Cc22Ws9W0FefJQXZt+Ygbk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-8LoXB0-INo2LkA1V-AszCw-1; Thu, 27 Aug 2020 04:22:31 -0400
X-MC-Unique: 8LoXB0-INo2LkA1V-AszCw-1
Received: by mail-ed1-f69.google.com with SMTP id z11so1639365edj.3
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 01:22:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jDjpiVojItjCevivgniLD3ESmTQtDrvY9SB5Mb2/ADE=;
 b=JgvOWiaJcx2Szdbe+Xyh/8HWJXmgnyF/VznwS87BNka5FQ++MNdql7EwyKsCtA8AWZ
 o3zkvqFCGrspyj7fJ4WQMkNPVdvohWbBJcZ2faHGk/t2ivhZCGZbjFaP+alROQtLZScA
 XgXihrqgxOLhR6RgYUFlls4jbX+mijkM59HwXzJQYvDvdafYcNuGql5mxB+RfsrrBlq5
 qZ6g29q1f6UELJnEXYCir/Ajjkmq3WBopbXKtggAqLpUbHf/BXKfo8tlrUOYJRNy1onh
 J2FsB4Jb9RstVIMFDa1RKxyhQU1QdgHPpvY5deOksQYBs1FtKvkojYYR8AcvDOiPfJf1
 t+jQ==
X-Gm-Message-State: AOAM532ltHJjiq683KU3nQ07cIr3p/NcNoVDlieKbE36l0aksidh8aFZ
 IlWVZGQlcscKNr6vHBrXsb814BzDRmiVc5Dx14WaEHBdScWJKxEKSS4CKQkgQDRM2L/qEDerAaO
 HQYS9uYqRoDxfgiqvfa7zEJ9iz4/CwDI=
X-Received: by 2002:a17:907:693:: with SMTP id
 wn19mr10421647ejb.121.1598516550255; 
 Thu, 27 Aug 2020 01:22:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrDHLspTyNL6YkVHzXgzDx8AMcejxCKOFWfA95iT3h9Zsw7pW7Y1LzhqtxpHrO81nOrn94mLXTge4s426gO8M=
X-Received: by 2002:a17:907:693:: with SMTP id
 wn19mr10421637ejb.121.1598516550040; 
 Thu, 27 Aug 2020 01:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200826190128.22707-1-pbonzini@redhat.com>
 <3c7ca48a-5eb0-cfd4-bac0-a2a7475eec39@vivier.eu>
In-Reply-To: <3c7ca48a-5eb0-cfd4-bac0-a2a7475eec39@vivier.eu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 27 Aug 2020 10:22:19 +0200
Message-ID: <CABgObfZhE1+N1XiHBaPx7SZHawUwNeA4yG5g1TPNQ5TMCO9xSA@mail.gmail.com>
Subject: Re: [PATCH] ninjatool: quote dollars in variables
To: Laurent Vivier <laurent@vivier.eu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="0000000000002212b705add7a313"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:53:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000002212b705add7a313
Content-Type: text/plain; charset="UTF-8"

Il gio 27 ago 2020, 09:33 Laurent Vivier <laurent@vivier.eu> ha scritto:

> This actually fixes the '-Wl,-rpath,$ORIGIN/', but doesn't fix the crash
> with statically linked binaries.
>

I will try to reproduce when I am back; it works for Peter so there must be
something different in the setup.

In any case, if needed we can both momentarily hack around it in Makefiles,
and fix it for good in Meson.

Paolo


> Could we simply remove the the '-Wl,-rpath,$ORIGIN/' in the case of
> "-static" build?
>
> Thanks,
> Laurent
>
>

--0000000000002212b705add7a313
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 27 ago 2020, 09:33 Laurent Vivier &lt;<a href=
=3D"mailto:laurent@vivier.eu">laurent@vivier.eu</a>&gt; ha scritto:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">This actually fixes the &#39;-Wl,-rpath,$O=
RIGIN/&#39;, but doesn&#39;t fix the crash<br>
with statically linked binaries.<br></blockquote></div></div><div dir=3D"au=
to"><br></div><div dir=3D"auto">I will try to reproduce when I am back; it =
works for Peter so there must be something different in the setup.</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">In any case, if needed we can bo=
th momentarily hack around it in Makefiles, and fix it for good in Meson.</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
<br>
Could we simply remove the the &#39;-Wl,-rpath,$ORIGIN/&#39; in the case of=
<br>
&quot;-static&quot; build?<br>
<br>
Thanks,<br>
Laurent<br>
<br>
</blockquote></div></div></div>

--0000000000002212b705add7a313--


