Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32826C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 15:33:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD672080C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 15:33:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD672080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg9v9-00047X-RI
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 11:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44534)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cdupontd@redhat.com>) id 1hg9t3-0003My-79
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cdupontd@redhat.com>) id 1hg9t0-0000sa-G5
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:31:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44589)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <cdupontd@redhat.com>) id 1hg9sv-0000di-Ev
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:31:00 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16so3214833wrl.11
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 08:30:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=4vmIoMBEfVwRj2ceMUu/PmBJOZVjdqsUgJURsn0H6GM=;
 b=toKxnNdiX2zMUfgP269XWZ54qXbPkpLloLaT/xWwivwSvtB3aDVFpPOWCxH0vwlrf/
 Eteixa41DH2KYx+8L93by0Y8w0+BQ7eiJQ9JfQn/hBc8aoQ8PKe2y7Zs5X2gHTDoeXfh
 hhaZ/ZaatyXoMPMLFDBYLZzz06NPyfaHatwhdPWCaeZle89PhirlX/1CUu53LKdsp03d
 j3rajsQ2N0APeT5RKTmF8z/tamdFUYBieVgAC2hy1WKHxuvEXQOMtw4sY8W1f85FfM04
 kbLfstUl4ZJh7ATxlT1034/IWYvF22VwZI3MwcVsqyfgDzmRguthfTLfYzy0q5n5j4Gs
 yFjA==
X-Gm-Message-State: APjAAAW8rsuTr2Y3a9Pi2Hdyw9zNuJQIyRuXOKlr/vzODycTLEMTCvH4
 vvs/I3t5JRXmyIfTTQOfD+Vw1Q==
X-Google-Smtp-Source: APXvYqw5oGypDtzGgNwvvWbslpU4EMb/BnrRDKBpEjy5N/diMrjDcitfFjkBoPWofM/KjPVv+WoNiw==
X-Received: by 2002:adf:e283:: with SMTP id v3mr4153132wri.338.1561563044816; 
 Wed, 26 Jun 2019 08:30:44 -0700 (PDT)
Received: from ?IPv6:2a01:e35:8b6a:1220:e080:14ab:15ae:4341?
 ([2a01:e35:8b6a:1220:e080:14ab:15ae:4341])
 by smtp.gmail.com with ESMTPSA id o6sm3511640wmc.15.2019.06.26.08.30.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Jun 2019 08:30:43 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
From: Christophe de Dinechin <cdupontd@redhat.com>
In-Reply-To: <20190624123835.28869-1-alex.bennee@linaro.org>
Date: Wed, 26 Jun 2019 17:30:42 +0200
Content-Transfer-Encoding: quoted-printable
Message-Id: <44600E39-15E9-4E1C-ACA1-B435F5EEB8FB@redhat.com>
References: <20190624123835.28869-1-alex.bennee@linaro.org>
To: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] target/i386: fix feature check in
 hyperv-stub.c
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
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On 24 Jun 2019, at 14:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>=20
> Commit 2d384d7c8 broken the build when built with:
>=20
>  configure --without-default-devices --disable-user
>=20
> The reason was the conversion of cpu->hyperv_synic to
> cpu->hyperv_synic_kvm_only although the rest of the patch introduces a
> feature checking mechanism. So I've fixed the KVM_EXIT_HYPERV_SYNIC in
> hyperv-stub to do the same feature check as in the real hyperv.c

Sorry, I failed to check on the mailing list before sending an exact
duplicate of this patch=E2=80=A6


>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Roman Kagan <rkagan@virtuozzo.com>
> ---
> target/i386/hyperv-stub.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/i386/hyperv-stub.c b/target/i386/hyperv-stub.c
> index fe548cbae2..0028527e79 100644
> --- a/target/i386/hyperv-stub.c
> +++ b/target/i386/hyperv-stub.c
> @@ -15,7 +15,7 @@ int kvm_hv_handle_exit(X86CPU *cpu, struct =
kvm_hyperv_exit *exit)
> {
>     switch (exit->type) {
>     case KVM_EXIT_HYPERV_SYNIC:
> -        if (!cpu->hyperv_synic) {
> +        if (!hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNIC)) {
>             return -1;
>         }
>=20
> --=20
> 2.20.1
>=20
>=20


