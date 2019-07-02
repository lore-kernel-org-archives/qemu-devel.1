Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56274C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:43:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF534206A3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 14:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF534206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiK0S-0000qi-V0
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 10:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52278)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hiJzF-0008KK-4O
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hiJzB-00073S-Uk
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:42:23 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hiJz7-0006ws-HF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 10:42:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id f17so1330693wme.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 07:42:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=3KybRH5yyjsHZjBHnS5qiKk8KQ7FFVDodzlAobZqW/E=;
 b=E3YxmBqFlfhyLQhakACkAmnzXMVBgz2+EPEBQ0w5WZ7698SpImuCp4jequjwZLMBn7
 1koAVQ5fwk/CqycMpcfCJN0AU3Xqx9Nbd6AWUsy4kmMqjLJK9lJumqjV6IBcv5VCVFsc
 tc4N0dv5zUQONv9zxnkvA6h7/9iV2IgqL81b55KQ3NOjTxlDQk56kFIzGf8vo4je2djb
 SS+lWDcjxYmaJ+zKqDXoIM8YmKFQvp5AainoV+BxKfFT9hVBTcbjEiXKE6zthl8qqfV5
 So6vVRAHvY8C/JqQ4ONC3wIEIzjZkKhjiiPGidsbKfJNiKT2ed1LLWYAxoYcrWuwIzXl
 mBgw==
X-Gm-Message-State: APjAAAVMhwULSa4hbjAPKxlPOakVZAEasXQ6PUGQGICj3m2K0+dRFEw0
 0alXl2CAoUfZkYuGleyfNdxT3t/QkJkVpw==
X-Google-Smtp-Source: APXvYqxsXInDKQq4Yk0BqDe+117nIERUOFUNFi6PYit2oWu3T83n7CRw9qXIiWMOU2xop3xA0zdKwQ==
X-Received: by 2002:a05:600c:2311:: with SMTP id
 17mr3609904wmo.18.1562078534989; 
 Tue, 02 Jul 2019 07:42:14 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id r16sm26909832wrr.42.2019.07.02.07.42.13
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 07:42:14 -0700 (PDT)
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081733.ff6cboiddln5wmti@sirius.home.kraxel.org>
 <878stgygiu.fsf@redhat.com>
 <20190702101625.trsg5dnnf2a4woqs@sirius.home.kraxel.org>
 <875zokyahg.fsf@redhat.com> <8c3b4619-f779-fb0c-7a53-b67150036a07@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <8c3b4619-f779-fb0c-7a53-b67150036a07@redhat.com>
Date: Tue, 02 Jul 2019 16:41:51 +0200
Message-ID: <8736joxzv4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386: Introduce the microvm
 machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 02/07/19 12:52, Sergio Lopez wrote:
>> As I said, I'm also in favor of microvm supporting booting from
>> firmware in the future, as long we keep the simple mode too.
>
> The simple mode adds code to QEMU's x86 target that only exists to
> support microvm.  It should be motivated by a clear win in boot times.

OK. When I'm back from my PTO, I'll work on adding the firmware
support to microvm. I'll run and share some numbers to see whether the
simple mode makes sense or we can just rely on qboot for lower boot
times plus SeaBIOS for compatibility.

Cheers,
Sergio.

>> My main concern about supporting SeaBIOS, in addition to boot times, is
>> having to support ACPI, which due to its complexity and size, is a clear
>> candidate to be stripped out from a minimalistic QEMU build.
>
> SeaBIOS doesn't need ACPI.  I agree that ACPI should be optional in microvm.
>
>> AFAIK, qboot can't boot a guest without both ACPI and PCI.
>
> It currently needs PCI, but that's a one-line change to avoid panicking.
>  ACPI is optional, on the other hand qboot doesn't support mptable so
> that can be a problem when ACPI is disabled.
>
> Paolo


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0bbS8ACgkQ9GknjS8M
AjUWEA/+NnJdIeIwIqLJkPEdykh28ubeJymdqLSAwRfoGyxtC4HrdQAFnV2Gjcwo
HVKnQzrj/hcZu93P7ZeOF7wiXRU+UWdCOWXOrET7RUI8N+ygwTYE6VMnrP9eEwnG
Vzsc9OsOc3HoHvXql1fmMisbMzFICdLbyW82cTI3nWbz5hy7KVRItQjPrfbrRQ2E
IxmDdfIHwvk7zpYsbcdvIpyZQMir8Grz7IZ/OVZdGLzryTkyGwkpKOYkd1gG0tAS
lJwZHYPeAIHe9Ph9JXnCYIMnx81hWB89vMCOnY9BdwDD1njg+6wfj7QmVVSko9VW
wmkLhJlQ0Gpwe+jMeQ/nYerdHfQOx+hvJYssI6REKBnR8Z12Lbrf16hx/wN2ytAs
c3oqdRhqrioAexG8/QB77Rxb5YcZ5v/eKvjDeq/Bmm8I6t62sCI34Bd5HAw4UYSI
mWi9egHi4jVaxAhpuA8176JiNQM1Ho8XGpumZ4tyk5y9XhOZLtDTD/2pVrtIJCDb
iaKd5SlkXzVAvwa0BpSlMnPkMxSUrweErA9a3cdaTFDShOwuyyrXgq8gc2AyK3ZA
nwkH3IGlMDpcoUonj7xX8lpMa29KSyGMXh5b4PzE+huMloYfxRQHeTS17DeoYySv
fRT6osefLE1dlPQYV4hxZDYbgdN7yaU6PdLY3m+r75ddK4TyLMA=
=vd0U
-----END PGP SIGNATURE-----
--=-=-=--

