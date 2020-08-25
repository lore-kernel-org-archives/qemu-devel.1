Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87115C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57ACD206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 07:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RjUr9SIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57ACD206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kATiN-0001HY-JS
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 03:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kAThq-0000rC-PS
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50332)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATho-0003zT-9Q
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:49:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598341758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vkdm7NELyKh9uxZ4r/PTtPWVEYhZckrG2iqS0ePxw4Y=;
 b=RjUr9SIjZShrwJvzOlSLnOnPhq5IAf+q5Jchx57CgAFZwGpH+SYSalA7YfZuYY7xi/Ho0X
 XpEIpi9OkpeZAp5GZxm+/ernm+nLC1i3bK4RUhm83HboPOUBkHbaWgOj39CMJ0P0aBdLkG
 Imw1g0Z7VEAkDSTzVeenT2sH2KrxkVU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-0Nt8-fWcNhixkkBZtFiftw-1; Tue, 25 Aug 2020 03:49:14 -0400
X-MC-Unique: 0Nt8-fWcNhixkkBZtFiftw-1
Received: by mail-ed1-f70.google.com with SMTP id c3so4258520edm.7
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 00:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Vkdm7NELyKh9uxZ4r/PTtPWVEYhZckrG2iqS0ePxw4Y=;
 b=sI+/lBuYiL2CbSUUkB/WAEiVbiHzM/Rap/pskFywth2S9QSlMpZd8Bi+zuDUtU8mer
 q3orEE/kZXwrQzyCN480HFOlXUyF6x10Q4rkHMiIECXXWt677U1SzJcho+vXIqPVFdQY
 L1B7rzpU4YBwvg/qD8D8yi4gmBKjd810SZ4lLdd28jqzmznCv3d0kmGTB9ytejkGWZ+0
 MgqqSVlUaBMZoVbLE3BS0G1Qh1xAOWczOWFdSmabaODSHe4gDgJFuJtfKLEuQWi4ERu5
 8qH6d+iPIMkoJgM3Aqj+c1GU+r8IAiEa6wusJ/D2VBzVMXs52InYQu0XFhda7uQbFLJ+
 Ms5A==
X-Gm-Message-State: AOAM531K8ShohFICp6YAu05j4jxiOW8XudToXE2p7+WS+YE5igoYyafy
 /L5rF+7KPG09IqohhuzjF4Zx9gnCpx9ZMVVBULVPHmAcOyiaTdi4M9TgrsHOBXy3mb53SPaG645
 9qUcofcnvqrvvW/27U7u6l24Ts8l13WM=
X-Received: by 2002:a17:906:c001:: with SMTP id
 e1mr9741054ejz.390.1598341752929; 
 Tue, 25 Aug 2020 00:49:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoZ2oSbEJYElUZLflQOszAxpV9Qs1Vh/yv+fwP9QUSZ0nCVrKmfJe6n5ppzuNrT2VmPf9Pls5Ug8LMpk2OnmY=
X-Received: by 2002:a17:906:c001:: with SMTP id
 e1mr9741034ejz.390.1598341752629; 
 Tue, 25 Aug 2020 00:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <d3adbbd0-fb9e-7f7f-8eaf-857c1d14d233@ilande.co.uk>
 <CABgObfZ13taiRpWxcwjpfUA57+N523yDKcYR4un3=D+FXrxPrg@mail.gmail.com>
 <c04489d3-e3f6-24d0-11d4-3ad6ed4f88c9@ilande.co.uk>
In-Reply-To: <c04489d3-e3f6-24d0-11d4-3ad6ed4f88c9@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 09:49:00 +0200
Message-ID: <CABgObfZ+Z_2JAYFS3cbpcM4+5e1Fqs4sa_7j=VPofF+FMxe4Kg@mail.gmail.com>
Subject: Re: meson: problems building under msys2/mingw-w64 native
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000653f8605adaef01a"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000653f8605adaef01a
Content-Type: text/plain; charset="UTF-8"

Il lun 24 ago 2020, 22:27 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
ha scritto:

>
> With this I can get all the way to the link phase so I think it's fairly
> close. I'm
> not sure whether these escaping/quoting problems are with meson or the way
> in which
> configure is using it?
>

You can try building with ninja to find whose fault it is.

We can get rid of ninjatool as soon as tests have been converted, but I
will look into fixing the quoting issue as well. Can you send me off list
the build.ninja file to see if the isystem problem is in Meson or ninjatool?

Paolo


>
> ATB,
>
> Mark.
>
>

--000000000000653f8605adaef01a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 24 ago 2020, 22:27 Mark Cave-Ayland &lt;<a href=
=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>=
&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
With this I can get all the way to the link phase so I think it&#39;s fairl=
y close. I&#39;m<br>
not sure whether these escaping/quoting problems are with meson or the way =
in which<br>
configure is using it?<br></blockquote></div></div><div dir=3D"auto"><br></=
div><div dir=3D"auto">You can try building with ninja to find whose fault i=
t is.</div><div dir=3D"auto"><br></div><div dir=3D"auto">We can get rid of =
ninjatool as soon as tests have been converted, but I will look into fixing=
 the quoting issue as well. Can you send me off list the build.ninja file t=
o see if the isystem problem is in Meson or ninjatool?</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div></div></div>

--000000000000653f8605adaef01a--


