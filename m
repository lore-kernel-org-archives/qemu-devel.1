Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE74C43141
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11162082F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AIhHGNSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11162082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWzRQ-0006bk-Vd
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 04:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56492)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iWzPZ-0005BP-QF
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iWzPY-0005mL-0n
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:03:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39294
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iWzPX-0005kl-Dn
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:02:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574154178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=QMOgpE2mWOJz+MuX030RCZSe43N2aceM2E4v5Fp6Jwg=;
 b=AIhHGNSktbHFlI/S9+fHhsJBzaby0R+BHLhcIlEfj1WLTx/vnns+CrWl7hL8zdnmCxCkUc
 zd8/BEGZqDxiqiUfBYr9gu30kHjHI5SZwEsGJT9ZBhrHwZapXNKw/1tDoow+usliZxE7Lg
 fzSjy8jmZV8nyAFOg3llnXBK+aVMOF0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-dpeQ9gK4O4ailcjgzaFMBA-1; Tue, 19 Nov 2019 04:02:55 -0500
Received: by mail-wm1-f69.google.com with SMTP id f21so1923790wmh.5
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 01:02:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cbF7lfMCpfTG51Y/MT1jinkZlY0S+fqnGMCvLnUJqMI=;
 b=D4b3RJNbJ55XKJiY1UxKhI12U27b8MPt8+WOlLBKlFJOenlq1vbEA9BSuR+7SRBPUh
 eZrhzBwy3Yl0HGiKnb1cDsG9LU9Pa/tIyuJJy9tkdbnXLlGRSH8aWmHf/BX1UkHP7wgW
 BWJEB4Iwd3CzZs5mUwX2rXZDFvrHXMZf2auvwtCcVDW4rMNIcCknNdSMEVkI4iPi80Xz
 ZtxS+2z1s3hw1PeUhrwH2lf+iTvMAbkCXEoWXSO1MiqjRa9yai7U/9GL5YiIuIrMwlma
 ryGTaV2cu6RNF9/BlzPpA7Awg7hiv1KWcIgvCpHTkW+2biGpxLWf0+Ufu4OA6fgjT3KI
 3NVA==
X-Gm-Message-State: APjAAAUMfW3sivWkNGRYCw2d4uYjhWsb1Kk7eT531RQTINyG3tGUuyz1
 gawSPaEAoLEITUESR9bVtXWOaCCA8W0TF/iyFkeOHlgXyHN24Hh9sIaDG1ijN18BUpWGc7lyJRn
 0pq9Xhrv5lsVZOX0=
X-Received: by 2002:adf:ed4b:: with SMTP id u11mr33329579wro.215.1574154173728; 
 Tue, 19 Nov 2019 01:02:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqxrIjZTbSKZ+V8t8gnjOwZUU4p+4EM6pjfdpjkw0fWUffttqMKUjV+92CcRj5XqGIz+7mo3nA==
X-Received: by 2002:adf:ed4b:: with SMTP id u11mr33329548wro.215.1574154173363; 
 Tue, 19 Nov 2019 01:02:53 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:8d9a:562d:908f:f88?
 ([2001:b07:6468:f312:8d9a:562d:908f:f88])
 by smtp.gmail.com with ESMTPSA id y189sm2384886wmb.13.2019.11.19.01.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 01:02:52 -0800 (PST)
Subject: Re: [PATCH] target/i386: Export TAA_NO bit to guests
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
References: <20191119072327.GA30825@guptapadev.amr>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5077456f-bab3-fe58-12c0-3dad2ffcc472@redhat.com>
Date: Tue, 19 Nov 2019 10:02:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191119072327.GA30825@guptapadev.amr>
Content-Language: en-US
X-MC-Unique: dpeQ9gK4O4ailcjgzaFMBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/11/19 08:23, Pawan Gupta wrote:
> TSX Async Abort (TAA) is a side channel attack on internal buffers in
> some Intel processors similar to Microachitectural Data Sampling (MDS).
>=20
> Some future Intel processors will use the ARCH_CAP_TAA_NO bit in the
> IA32_ARCH_CAPABILITIES MSR to report that they are not vulnerable to
> TAA. Make this bit available to guests.
>=20
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a624163ac2cd..af84b04951cf 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1205,7 +1205,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WO=
RDS] =3D {
>          .feat_names =3D {
>              "rdctl-no", "ibrs-all", "rsba", "skip-l1dfl-vmentry",
>              "ssb-no", "mds-no", NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            "taa-no", NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>=20

Queued, thanks.

Paolo


