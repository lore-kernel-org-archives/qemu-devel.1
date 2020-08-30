Return-Path: <SRS0=e36u=CI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AADBC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 15:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B67A206EB
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2020 15:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z+vJED+6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B67A206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCPSG-0001aA-FK
	for qemu-devel@archiver.kernel.org; Sun, 30 Aug 2020 11:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59376)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCPRM-000169-VX
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 11:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43293)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kCPRH-0007Z5-07
 for qemu-devel@nongnu.org; Sun, 30 Aug 2020 11:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598802013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aDr0y0Bs++ZQQAHV4By+u6xjivGkswX6wksZLoQB38Q=;
 b=Z+vJED+6tuyIUBEhxopZVBl4GXF8SCzUcTVl+QYjIgkaWupEyskjcNwvDGjnZunJiXptQ9
 VPkWfOKzSxxArKdXS7okbBRACWZ73gmXDH+9gLaBfixI+Gan0e3eXNRM6NIJ/0BSnTmcya
 9O7cFl49gYHhSZ0fhCKph4XqaT5Wqgw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-531-j0_H4S0bNtqKNfpRGz5unw-1; Sun, 30 Aug 2020 11:40:10 -0400
X-MC-Unique: j0_H4S0bNtqKNfpRGz5unw-1
Received: by mail-ej1-f70.google.com with SMTP id dr9so2863759ejc.19
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2020 08:40:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aDr0y0Bs++ZQQAHV4By+u6xjivGkswX6wksZLoQB38Q=;
 b=t2VmC5HBf5HIzcrxhWOkPhwOiIoGvN05AdJRAR0vyA28rdJros5lEXxp6fyCyKPR/6
 AYAuJJn9r6y4PDzaEmJ0wpwsWP460tL+hX3Y1lLlXdnqFo5+XNithZMP1NzG7iJ0t+WL
 hcTpNexJoyRyGIJr9izNfmvaIetPpngWkf/umXK41ImhkpxasXyuCZl4yoGZT60+MfWy
 uooMe9v98by12ANzrlZjfIaneklc5ZMERKBvESxKWpUjgiaQ9uhZoXEFt4li2hzHKMFo
 +3SiEIz43EvdOo5aNI5+fNzcepVhJDAr7KCuxluJXmr5y1p9z0A+XqjaBTXmQD9wB+/G
 mM9g==
X-Gm-Message-State: AOAM531xFVadpVPIYolZ/RHCRsFnYcixg5Tt3VGgk3POjCPULbaWtUCb
 G1JShxWWZVLjBOXdq3GhFy7T7wh6f57Jzm1rVi26IbuTNd4xQMyCh/Ht1A8CHzgmzzpgBBXWuMD
 lkBRrIPa7VgNlx45IKvC5t8/rdg+pL6I=
X-Received: by 2002:a50:fd84:: with SMTP id o4mr7709340edt.76.1598802009448;
 Sun, 30 Aug 2020 08:40:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5gGGINkVcSxqVQb6gMm4+nOHiAM0TU4qJNpvMahFZcRsaxi5aq3O6qckssiLVgwecaQxr0viFSaimy+h8WQg=
X-Received: by 2002:a50:fd84:: with SMTP id o4mr7709321edt.76.1598802009133;
 Sun, 30 Aug 2020 08:40:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200826070243.11969-1-pbonzini@redhat.com>
 <6332e682-cf24-d8ca-6aa5-d7d72555d235@weilnetz.de>
In-Reply-To: <6332e682-cf24-d8ca-6aa5-d7d72555d235@weilnetz.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 30 Aug 2020 17:39:56 +0200
Message-ID: <CABgObfZ9XXifywiO-8gWcDFTVLLEXkkZeBn3RSEOz2wP8nFA_Q@mail.gmail.com>
Subject: Re: [PATCH] meson: move pixman detection to meson
To: Stefan Weil <sw@weilnetz.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000d22fcb05ae1a19a8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/30 11:40:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Rafael Kitover <rkitover@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000d22fcb05ae1a19a8
Content-Type: text/plain; charset="UTF-8"

Il dom 30 ago 2020, 15:31 Stefan Weil <sw@weilnetz.de> ha scritto:

> Obviously the compiler flags which are required for pixman-1
> (-I/usr/include/pixman-1) are not passed to the compiler.
>

Yes, they must be added to the modules' sourcesets. I will fix this.

A build without --enable-modules does not show these errors. Are there
> already CI tests with --enable-modules?
>

Clearly there are none on Gitlab or among Peter's tests.

Paolo

>

--000000000000d22fcb05ae1a19a8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il dom 30 ago 2020, 15:31 Stefan Weil &lt;<a href=3D"m=
ailto:sw@weilnetz.de">sw@weilnetz.de</a>&gt; ha scritto:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">Obviously the compiler flags which are required for p=
ixman-1<br>
(-I/usr/include/pixman-1) are not passed to the compiler.<br></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, they must be =
added to the modules&#39; sourcesets. I will fix this.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">A build without --enable-modules does not show these errors. =
Are there<br>
already CI tests with --enable-modules?<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Clearly there are none on Gitlab or =
among Peter&#39;s tests.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Paolo</div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
</blockquote></div></div></div>

--000000000000d22fcb05ae1a19a8--


