Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,TRACKER_ID autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF05C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 21:24:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038412080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 21:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+EREj2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038412080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iowKw-00086c-01
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 16:24:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iowKH-0007au-Pl
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 16:23:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iowKE-00024b-Sg
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 16:23:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23083
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iowKE-00023s-PG
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 16:23:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578432221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G8WyHDQDN0LYOIMlaBifknREU7wUP+Om9c1upjk7XAU=;
 b=W+EREj2RUecWHFq+GzJEStF3j7HNy3dSW3M2R6onwTDJeKtCDDgaX4qaI5oHt3hxQtKsLe
 /AGkFGA4OkKfy9BZBn3/d4Rei5wTCneIshKlulboea/yPedYlg1+XMWTXF4hkaSzYd6aQf
 E/wwOj3utibuZ7Uj/RpLJOJ0bYsOuFA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-DjZonEavOr-oiklDOHhvIw-1; Tue, 07 Jan 2020 16:23:37 -0500
Received: by mail-ed1-f70.google.com with SMTP id j6so398057edt.21
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 13:23:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HV5/mSHRig7Lm9JeS1R5bGAHFrRWmpTz/k9RO8hZiLI=;
 b=j3Ugu0ZZBoZYTqg058gfSblKsuM/is9ipGO7fdLqqNL6a0RjtrMgu7dIlV8Djtl6xO
 mofm690FWljz/Z1/y5SESCLvAPSBYzXl4jsWtKKX+GXGv63DEtj2od4K2TrfDbItE0s3
 6uH3T1a7z8UlY4Y6hiztSuD1vHF1V2UfIxmTXv6oG5Dq/sBpTr2YM1jzMIxjiimMt9tJ
 431U+EWum3PA7IeHpKMpXyXzjKhzFklbHmU0OC/OWFVNJ6MCnm8Ts4MIBLtg/1GUiX/Q
 mFTa3k00QPp26sRy7paXa/0r23+Po7rXly91BEfdz7FcgDYsKDfX1AACUl4HoRxQXNMK
 DgwQ==
X-Gm-Message-State: APjAAAWvcbeGttOfFaLmr3emnSSRUpUFz8TvLAziHoiDH3xJwW5X4oFo
 Oe6ydG7ND9cXfmT6ziodyJjmcvGFKRsfLcdi+ssqJAYWC4+b4T2wI062ZQrzHWjL7BTwd+ViEa5
 shvZGLzkcW2LzbDxhH+SvxBmO4GJX4fo=
X-Received: by 2002:a05:6402:12d1:: with SMTP id
 k17mr2037532edx.291.1578432216883; 
 Tue, 07 Jan 2020 13:23:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmk33jI2Q3T7E9Cmf+EQlkaiyWn4/vNAbVD8lGmxIvyjFWCkx23ebHLFPxPlL2acAabQqR7xpoLfD5nZhnPGE=
X-Received: by 2002:a05:6402:12d1:: with SMTP id
 k17mr2037515edx.291.1578432216705; 
 Tue, 07 Jan 2020 13:23:36 -0800 (PST)
MIME-Version: 1.0
References: <20200102203926.1179743-1-vkuznets@redhat.com>
 <21556857-3d6a-ad66-5cf5-060b1ab67381@redhat.com>
 <87zhezsc30.fsf@vitty.brq.redhat.com>
 <7c4dcca1-a1e6-a00c-56fd-bcc6c8bcc474@redhat.com>
 <87imlnrv3n.fsf@vitty.brq.redhat.com>
In-Reply-To: <87imlnrv3n.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 7 Jan 2020 22:23:24 +0100
Message-ID: <CABgObfYviBXJNOTrSQk6hZC5HpBW4fZL_eJGSC+vs=Fv9h40bg@mail.gmail.com>
Subject: Re: [PATCH RFC] i386/kvm: fix enlightened VMCS with fine-grained VMX
 feature enablement
To: Vitaly Kuznetsov <vkuznets@redhat.com>
X-MC-Unique: DjZonEavOr-oiklDOHhvIw-1
X-Mimecast-Spam-Score: 0
Content-Type: multipart/alternative; boundary="00000000000094479b059b936317"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Liran Alon <liran.alon@oracle.com>, Roman Kagan <rkagan@virtuozzo.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000094479b059b936317
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES
>
> the problem with it is that we don't have 'apic_access_addr' field in
> eVMCS ('virtual_apic_page_addr' is there). By running the same setup
> with eVMCS disabled I figured out which address can be hardcoded to make
> it boot.
>

Maybe it's really hard coded (what is the value? Is it consistent across
Hyper-V version?) Can you try changing KVM to enable it and see if the
hardcoded APIC access address works?

Paolo

>

--00000000000094479b059b936317
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><br><br><div class=3D"gmail_quote" dir=3D"auto"><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex">SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES<br>
<br>
the problem with it is that we don&#39;t have &#39;apic_access_addr&#39; fi=
eld in<br>
eVMCS (&#39;virtual_apic_page_addr&#39; is there). By running the same setu=
p<br>
with eVMCS disabled I figured out which address can be hardcoded to make it=
=C2=A0boot.<br></blockquote></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">Maybe it&#39;s really hard coded (what is the value? Is it consistent =
across Hyper-V version?) Can you try changing KVM to enable it and see if t=
he hardcoded APIC access address works?</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">Paolo</div><div class=3D"gmail_quote" dir=3D"auto"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">
</blockquote></div></div>

--00000000000094479b059b936317--


