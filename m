Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD7FC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:16:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557CF21A49
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 09:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mp8WBJSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557CF21A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUSIE-0004YM-Fp
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 04:16:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iUSH8-0003s5-OM
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:15:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iUSH7-0005KU-OR
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:15:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23445
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iUSH7-0005KF-L6
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 04:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573550149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=A+tdr1qp7+aUa0drhLGKEWaUxpgrWNl/wUgju6EPFRA=;
 b=Mp8WBJSuak/3crzQgRo9RdMiy4YBDNJWn3DbmmvaTzU858hbIHgG09ffzm2yZhS58CBJNt
 x7nqVqDN3UYfOkAiFP6I7jBqDFRvc2IrDaC5y91IqbY6Xk43qi0A/M+pkgbVOE3oL8wuWF
 QMpqXWvKIRgk2ByMlSqPFiwLo0khhxU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-f5e_g4_rOWGXQXxHo9NT7g-1; Tue, 12 Nov 2019 04:15:46 -0500
Received: by mail-wm1-f70.google.com with SMTP id f14so922463wmc.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 01:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fo6RZMfIdlNBUYkZqR9uVjnc1J5hKM3Tz/Ts0c/kyt0=;
 b=qJZ60P61+N0qjsxCD8NEDcIBNb1bNbNII5fQfG/eY+So2dLUe36KzSPth4wSpkJ7pq
 gcXvgaWQrZq42piUkHpctrazRYzvjCRzVy45BImaT/bISQfrjLFGu2tmQ8CcF1qjOpu0
 cbFtpT1djyMQbDBtPUwuF/km8les515Mmu5JiqsQwvKXQ+m9RulbP3mQTQrDGnVs6bSR
 HoVvNYd4m2S9YDiEaEzo/cOK5/a02NVoU3OeSRNTowjOIyUrbbtovm5aKbC1kLnoCDvZ
 kMlmLXyas/FHBu09CPIAY245TB0Ha69YPWagmGjrD8Cp9eZ2sAPRuAYbh+/wrmwd/0JR
 zaSQ==
X-Gm-Message-State: APjAAAW9yuL0GFtc9QkUMU3PsbXXGZxAKA9ZLbX/DFFY8dgxMeHHAzz/
 ouQqo18/E/kknUDbY3dz8qqNBbLuGUj2l3h10q3BYT5qlaYquNn0WW59IMLDJ5CFGRR2na88eAs
 7xzIi5N5a4MtX5F8=
X-Received: by 2002:adf:9506:: with SMTP id 6mr26103512wrs.274.1573550145048; 
 Tue, 12 Nov 2019 01:15:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyI3tpXZhgDWr1vuXVYvXPmeHJW4/Wol11TpBb/x+9EBOXYEMXJGcBYAHXNGauNC9YGjebT3g==
X-Received: by 2002:adf:9506:: with SMTP id 6mr26103486wrs.274.1573550144682; 
 Tue, 12 Nov 2019 01:15:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8c9d:1a6f:4730:367c?
 ([2001:b07:6468:f312:8c9d:1a6f:4730:367c])
 by smtp.gmail.com with ESMTPSA id p14sm20842897wrq.72.2019.11.12.01.15.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2019 01:15:44 -0800 (PST)
Subject: Re: [PATCH qemu] scripts: Detect git worktrees for get_maintainer.pl
 --git
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
References: <20191112034532.69079-1-aik@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <049148d5-0a35-e8bf-4a8b-714a3f1fb9d1@redhat.com>
Date: Tue, 12 Nov 2019 10:15:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191112034532.69079-1-aik@ozlabs.ru>
Content-Language: en-US
X-MC-Unique: f5e_g4_rOWGXQXxHo9NT7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/11/19 04:45, Alexey Kardashevskiy wrote:
> Recent git versions support worktrees where .git is not a directory but
> a file with a path to the .git repository; however the get_maintainer.pl
> script only recognises the .git directory, let's fix it.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  scripts/get_maintainer.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
> index 71415e3c7061..27991eb1cfb4 100755
> --- a/scripts/get_maintainer.pl
> +++ b/scripts/get_maintainer.pl
> @@ -81,7 +81,7 @@ my %VCS_cmds;
> =20
>  my %VCS_cmds_git =3D (
>      "execute_cmd" =3D> \&git_execute_cmd,
> -    "available" =3D> '(which("git") ne "") && (-d ".git")',
> +    "available" =3D> '(which("git") ne "") && (-e ".git")',
>      "find_signers_cmd" =3D>
>  =09"git log --no-color --follow --since=3D\$email_git_since " .
>  =09    '--format=3D"GitCommit: %H%n' .
>=20

Queued, thanks.

Paolo


