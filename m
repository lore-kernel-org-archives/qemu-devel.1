Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666FBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312BB21655
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bu5FxpiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312BB21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRBQ-0006i3-Bd
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55940)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1ifRAa-00060J-5I
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1ifRAX-0008AX-Ul
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:18:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47612
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ifRAX-000885-Nw
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576167504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ri0tPC7keIY++wBAbiav+ItLu0zloOtiTvg9jmwmIpQ=;
 b=bu5FxpiWJQ+p30SJZ5gDGLw4/7t8KZ3YL8ogrHIN2RF/4cTPVsB7pCqEis6Py/7FvjJtES
 JqkU04ACaRVLfh589GVFrHa2i+xVH+7XuRj+m0vhfOsSTUkEWh7nrq33H1EneEPliSE2m4
 IcFTFQUgMt3Fcz6UEx6SvvwT1TcIq/E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-WQEMc25sMLOmMim5hbQN4Q-1; Thu, 12 Dec 2019 11:18:22 -0500
X-MC-Unique: WQEMc25sMLOmMim5hbQN4Q-1
Received: by mail-wm1-f72.google.com with SMTP id b131so1041227wmd.9
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 08:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=eeG+NqanQpugRavHBrA4MwmvsISNSWd2VLkRheZXH6E=;
 b=LuX6mamLCs1wjhvV4WsBCvbXuQGQtR9x0AtWRK6FR5oAM4p0S1I9KoseUzEZdo07Ya
 Xgzw5AwfoTE5tYXJZsuJSFC6STsj3nlKfd6yhu20MRij6+800xUuNS1gc/X58FpYoWJ2
 H2xDGBab9ueTvpgyTEs8RBmWxN1NFJ/CkuMi0bNftSsuuTJ/jnpeujlW6Uldek2nk8Km
 jfnmqUJJV2HjMOwtEUWrnGoulXoDSaTj7gbsCa1r7uGaHqIUCHBNa2hR883dqBNgllZB
 gAlT3q8OOMttymQVlPTqr1IWkApGc5l5eiRZLC8mNENqfpE6VZYIFlK3pjK+CGR86QYz
 Th4A==
X-Gm-Message-State: APjAAAXhi5+j4pxmlb/XEwnikTkTSZCEDBfks+ONU+WyIBCizE7yBf6J
 9ghnPkYluJXr4/e6dDajrAgJSBBX5I9KLR9tcH8+mM4qexMxXZd6IbtQ8RUiLmR4ktKqck3Jf3R
 UudNqfQ6kSFUoiC4=
X-Received: by 2002:a5d:514a:: with SMTP id u10mr7060417wrt.169.1576167501708; 
 Thu, 12 Dec 2019 08:18:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLwrYLQZUZUhoR8n8WzweQ2VRmGX2njHBhPd7zant4cXLMb2JOfIj8lTG0kqShaKSZ81t6og==
X-Received: by 2002:a5d:514a:: with SMTP id u10mr7060397wrt.169.1576167501489; 
 Thu, 12 Dec 2019 08:18:21 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9?
 ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
 by smtp.gmail.com with ESMTPSA id g69sm7285287wmg.13.2019.12.12.08.18.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2019 08:18:20 -0800 (PST)
Subject: Re: [PATCH 5/5] kvm: check before accessing PCMachineState fields
To: Sergio Lopez <slp@redhat.com>
References: <1576161021-5359-1-git-send-email-pbonzini@redhat.com>
 <1576161021-5359-6-git-send-email-pbonzini@redhat.com>
 <87v9qlbk25.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c8720b43-4c04-b3bb-cc35-56decd3bbcd5@redhat.com>
Date: Thu, 12 Dec 2019 17:18:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <87v9qlbk25.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SGcpaEvXcEbmMumyaQZuW6G5cf82QZbYZ"
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SGcpaEvXcEbmMumyaQZuW6G5cf82QZbYZ
Content-Type: multipart/mixed; boundary="AD77WEJzkqGKtWsAkHdovD3NUvoiZLhAg"

--AD77WEJzkqGKtWsAkHdovD3NUvoiZLhAg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/12/19 17:11, Sergio Lopez wrote:
>>      }
>> =20
>> -    if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
>> +    if (
>> +#ifdef CONFIG_PC
>> +        kvm_check_extension(s, KVM_CAP_X86_SMM) &&
>>          object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE) &&
>> -        pc_machine_is_smm_enabled(PC_MACHINE(ms))) {
>> +        pc_machine_is_smm_enabled(PC_MACHINE(ms))
>> +#else
>> +=090
>> +#endif
>> +       ) {
>>          smram_machine_done.notify =3D register_smram_listener;
>>          qemu_add_machine_init_done_notifier(&smram_machine_done);
>>      }
> I'm not familiar with SMM, can we consider it a PC specific thing? If it
> isn't, perhaps we should move smm to X86MachineState.

Ok, I will do that.

Paolo


--AD77WEJzkqGKtWsAkHdovD3NUvoiZLhAg--

--SGcpaEvXcEbmMumyaQZuW6G5cf82QZbYZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl3yaEoACgkQv/vSX3jH
roO3cAf+Igzy+pj3Yn5krDzHFVaGfThyXdp0a0Tjoi0RJ0E1rb7FMTYA2k4hmziZ
3wMfHpkwC0x3Iw4NZ0GnTbk1uRC3ymAwENOgWAdpCrNbrXw3KWWQ7qBUFmn/xjbk
mLEn4YA80UPpeeAyua9xk8HraRn05e5n+P947nzYNo4YndnJqXCi++cqnYtFY3FM
s/2rOEaaHgwT49Aetzbon11tLAHhzLlO7QXVScPB4+qoNUH6WCo4SK6LdXXWWvfu
KmABE6IHtMRsx+FuHzY+SLx28rqdfjqUBVBEtJJI7bA33M/eiFokMjQJTohFLsip
vJFtx6E9+rIV6efch+Q8vg8f9n4lEQ==
=ASiq
-----END PGP SIGNATURE-----

--SGcpaEvXcEbmMumyaQZuW6G5cf82QZbYZ--


