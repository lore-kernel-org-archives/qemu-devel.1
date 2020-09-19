Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE02C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 06:11:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104B221707
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 06:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMU5rHNP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104B221707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJW6B-0005Gt-3p
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 02:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44354)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJW5U-0004qB-0X
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 02:11:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25441)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJW5Q-0008EW-D3
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 02:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600495861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P9QlHWml0/7B+3bG6VNB//uMMR6cYYmjOPG9gYbwsPc=;
 b=CMU5rHNPRtjS/VY1ge9i6ILFhaOt9YpyB2xqdBzraHrWVUKCI26Rhjf3END6GQkunsKWoP
 emGjPA2rL21w96V0kqQkUaLQ3macSuXH5iaAMubyB7N6RVL0aKzFLfUzeQMczxPWfzOVnq
 R8ydqCi8ZvqDlE20cJM8R9seY53zmRs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-UBq5Y4dXOn-I4R14AylneA-1; Sat, 19 Sep 2020 02:10:52 -0400
X-MC-Unique: UBq5Y4dXOn-I4R14AylneA-1
Received: by mail-ed1-f71.google.com with SMTP id n19so3100629eds.8
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 23:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P9QlHWml0/7B+3bG6VNB//uMMR6cYYmjOPG9gYbwsPc=;
 b=UcpswvH0sbi8v4Xr0YE3Xc4f+FyDqaQoS6qoA/dgT3Bv+6DLMa+NkGvdjp2s0zrgyi
 m4Z+uTZ7Samtn45EZ8Z4IGhwL0+Cri6SWAVYsdLxC0GQXj5H3UKt2PDUToKb2W+msBXc
 5Rxt7QHhwiwy2SMVL9zHYjRV23/XUI5O/H6kHc7ubG3eRZ1BnhWsmVKlz0qc1CnKnygi
 KP4kZEHLTwYGtEgwcNkIaXQDKM0v6Rw1IZ8OKKoIqXx1vdFiiemL0oKRM6fo9564n01H
 w2WZsoVnNPV2pejRhgkG1U60OFFU5cMsZCNul0SO9HgsBkc/adDnoeEAU+noZN7m2BYt
 rONA==
X-Gm-Message-State: AOAM530aDxSyuQ9J5AOUS3obR/rfO+f2dYYj0qgdWxtCPTGgojLsEZ4l
 CHhy3IeGyuR9hVg+oGwlm0Fw25bXjsrVMBVx1RmJ0PxZD4RxCt6LUXBAlm/bTCIrajrC5pwHe/W
 HN0zISBsYuCbto6/Eq2VLUtA21FwZPbU=
X-Received: by 2002:a50:8e52:: with SMTP id 18mr42589972edx.28.1600495850961; 
 Fri, 18 Sep 2020 23:10:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjA4hyuObo/cisvqsXKUY6T+O8bKr1iGdphhyPn+Y8ANi3G5wys7FOIGEga0mK/kUksx9pEOqlDR7+FFaGjQA=
X-Received: by 2002:a50:8e52:: with SMTP id 18mr42589959edx.28.1600495850661; 
 Fri, 18 Sep 2020 23:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ+F1CKSBCwWZjdUJ7Q3w5uGvM0ZLe65Vw05mm8v3t6kNLKUzg@mail.gmail.com>
 <CAFEAcA8CHK49OChJ9V6g2xj=_9UZLOzy5My0KViWmSEp5Q8_Qg@mail.gmail.com>
 <20200918142727.GM1628512@redhat.com>
In-Reply-To: <20200918142727.GM1628512@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 19 Sep 2020 08:10:39 +0200
Message-ID: <CABgObfYFSrNMCLJC3YY11uaKPueNP5Hu3C5CqQCEVeHJ_i05Pw@mail.gmail.com>
Subject: Re: Deprecating --enable-gprof?
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000a4d08505afa47acd"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 02:11:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
 QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000a4d08505afa47acd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il ven 18 set 2020, 16:27 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> If we were using meson/ninja directly we'd just do "meson coverage-html"
> to generate a report:
>
>   https://mesonbuild.com/howtox.html#producing-a-coverage-report


Note that it's "meson compile coverage-html", i.e. "ninja coverage-html".
So we ought to be able to do just "make coverage-html".

Paolo


>
> and the resulting file could be published from CI as an artifact.
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000a4d08505afa47acd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 18 set 2020, 16:27 Daniel P. Berrang=C3=A9 &lt;=
<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">If we were using meson/ninja di=
rectly we&#39;d just do &quot;meson coverage-html&quot;<br>
to generate a report:<br>
<br>
=C2=A0 <a href=3D"https://mesonbuild.com/howtox.html#producing-a-coverage-r=
eport" rel=3D"noreferrer noreferrer" target=3D"_blank">https://mesonbuild.c=
om/howtox.html#producing-a-coverage-report</a></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Note that it&#39;s &quot;meson co=
mpile coverage-html&quot;, i.e. &quot;ninja coverage-html&quot;. So we ough=
t to be able to do just &quot;make coverage-html&quot;.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br=
>
<br>
and the resulting file could be published from CI as an artifact.<br>
<br>
Regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>

--000000000000a4d08505afa47acd--


