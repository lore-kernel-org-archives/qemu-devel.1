Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E09CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12EB2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12EB2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpGX-0002Yk-Nx
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iMp6n-000151-7z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:01:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iMp6m-0000KJ-1r
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:01:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48656)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iMp6l-0000Jk-KV
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:01:35 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AC3B13295
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 08:01:33 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id g67so5489750wmg.4
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 01:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HXXN+3kDcWAOSZ1ZWAzAQgSOSkw6dc0GHqeq50N84fk=;
 b=OswKW57qvbWWxAY15L2Ba3RBqbPCb2qHcgt6BQ9rHn7VasrAgdLD1RU8Kcv5aAYcKr
 QAMY5m9y0QUF/kifpUGKCvOoTlmZaRvI2F/XCHbQkvppE+VeUx1jEwVTYa/YfH7gAl5y
 keb+4/yqVjbaYrrsiOSQQQGux3D+o3gWwkHTIfDlonec5GfOYEYkMdaQqk0x5vJNXm81
 tFjlD3YupqOf7gO1ciUHlbGvJMx9g1Okyp4hF6MmuUL/hX9J0l+chsdta8WYC+P82ahH
 5ImKbJ7A6ZiegDnikfW8m4S67yqLTQ9H53L+yOZOC7Ky3YBdF1q+VTzBHXRlQO8vv/sW
 zMjA==
X-Gm-Message-State: APjAAAXHvgd7/Ye3A9N5ckzVEPukiPQe0n/z+4uYkoGYBftZb/T6u4vt
 DbV0q1G9RKCk5aojtxeryfUELRm3J7njjbOPhhkJHGSjcmxem0PQWIr0l4T0sc8lW07vK0IcDJ1
 MKnD82wyJ4X9/DOA=
X-Received: by 2002:a05:600c:1107:: with SMTP id
 b7mr1825805wma.151.1571731292256; 
 Tue, 22 Oct 2019 01:01:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwmhy302UpITXow3hJ1E+BmaT4sTUOadqADMJWakV9Xnhq2XXwrJOMQo4pCShYFu0u8iZC7AA==
X-Received: by 2002:a05:600c:1107:: with SMTP id
 b7mr1825775wma.151.1571731291971; 
 Tue, 22 Oct 2019 01:01:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:566:fc24:94f2:2f13?
 ([2001:b07:6468:f312:566:fc24:94f2:2f13])
 by smtp.gmail.com with ESMTPSA id z13sm20395954wrm.64.2019.10.22.01.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2019 01:01:31 -0700 (PDT)
Subject: Re: [PATCH] runstate: ignore exit request in finish migrate state
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20191017101806.3644-1-lvivier@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <ac941d4f-fd24-a84c-05d9-c0770a2fb088@redhat.com>
Date: Tue, 22 Oct 2019 10:01:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191017101806.3644-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/10/19 12:18, Laurent Vivier wrote:
> Trying to reboot a VM while a migration is running can
> move to the prelaunch state (because of the reset) while
> the runstate is in finish migrate state.
> As the logical step after the finish migrate is postmigrate,
> this can create an invalid state transition from prelaunch state
> to postmigrate state and this raises an error and aborts:
>=20
>     invalid runstate transition: 'prelaunch' -> 'postmigrate'
>=20
> As we are not able to manage reset in finish migrate state the
> best we can do is to ignore any changes and delay them until
> the next state which should be postmigrate and which should allow
> this kind of transition.
>=20
> Reported-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  vl.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/vl.c b/vl.c
> index 0a295e5d77d6..dc71c822ba24 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1744,6 +1744,9 @@ static bool main_loop_should_exit(void)
>      RunState r;
>      ShutdownCause request;
> =20
> +    if (runstate_check(RUN_STATE_FINISH_MIGRATE)) {
> +        return false;
> +    }
>      if (preconfig_exit_requested) {
>          if (runstate_check(RUN_STATE_PRECONFIG)) {
>              runstate_set(RUN_STATE_PRELAUNCH);
>=20

Your patch makes sense, but I don't understand this function very much.
 In particular I don't understand why it returns true when
preconfig_exit_requested is true.  Wouldn't that cause main_loop() and
thus QEMU to exit?  Igor, can you help?

Paolo

