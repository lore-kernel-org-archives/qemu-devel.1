Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D781BC432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5A51222C0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5A51222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDPfs-0004TO-Pn
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDPer-0003tY-Ed
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDPep-0001uh-Ax
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:01:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60227)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDPcs-0008RN-I6
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:01:50 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 860853B738
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 08:59:49 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id b6so661128wrx.0
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 01:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=edpoGsqQ65H3Og8WvxTfFnznGLy9c4jNpqmavlqEW8I=;
 b=f0RqNLZqHwDckS1MQaMzxXPmG/3yr3yacfGC1FCUTmEHUgR9gCk4Azu1SQv7LKrnEq
 2ZEonQRqY+FHkF5+1V8FQsFScNMq8SBpRMPlemU6yEelDpYxRKadSw4P59mqSxRKhBaM
 1lr05tqv2SnPyeYXoBmqNaIvj8NjcoB5nwM/jI407BjSRz1YE0UXGPn/GxbL7NAHN5ju
 RGlBUye8wPLBfC1GxEnX/yo5f7fwCm5CzYTnahzT+aPSnvAL1gJrLEisgPd/LSWKwvhG
 +6ZYjD73dQomACf454/pqTinVXyBOfjA75qsv07fDtHkLww7rLvf3xy5DF90WAxE/Q3v
 jldg==
X-Gm-Message-State: APjAAAVO+ysVbXT/iXbAmU9GcF0Ih8IGEZUv2Sg1dUFdhuCOsLsd4GJR
 /NXCI3CLvKyWEjyq8OXAnogUuXQme2PZHa2zMDTSNbRZeYpP8HzIDbta9bp/m70VmK44uM1/JmQ
 hL980HoU4YuOZJKU=
X-Received: by 2002:a1c:a853:: with SMTP id r80mr1976694wme.140.1569488388135; 
 Thu, 26 Sep 2019 01:59:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyAUmUjHA/DfTedbR1Linvyr8n0uou69CP7kzs/Vp8bLNQl7s5q41Y3O/WX+P+knoO7zLlXMw==
X-Received: by 2002:a1c:a853:: with SMTP id r80mr1976667wme.140.1569488387812; 
 Thu, 26 Sep 2019 01:59:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id g4sm2290486wrw.9.2019.09.26.01.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 01:59:46 -0700 (PDT)
Subject: Re: [PATCH v4 8/8] hw/i386: Introduce the microvm machine type
To: Sergio Lopez <slp@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-9-slp@redhat.com>
 <061b720c-2ef2-b270-f18b-b0619573862d@redhat.com> <87muer36sd.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <95d0dc60-c418-4ad3-a0f7-dba0ff50515a@redhat.com>
Date: Thu, 26 Sep 2019 10:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87muer36sd.fsf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mBw58v5fqflKGijhL5FZIGYsU0C7MbX9K"
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 imammedo@redhat.com, lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mBw58v5fqflKGijhL5FZIGYsU0C7MbX9K
Content-Type: multipart/mixed; boundary="EoJheJKDNp7fTYfkQWiKwoABRgq4OkHsM";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sergio Lopez <slp@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 marcel.apfelbaum@gmail.com, rth@twiddle.net, ehabkost@redhat.com,
 lersek@redhat.com, kraxel@redhat.com, mtosatti@redhat.com,
 kvm@vger.kernel.org
Message-ID: <95d0dc60-c418-4ad3-a0f7-dba0ff50515a@redhat.com>
Subject: Re: [PATCH v4 8/8] hw/i386: Introduce the microvm machine type
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-9-slp@redhat.com>
 <061b720c-2ef2-b270-f18b-b0619573862d@redhat.com> <87muer36sd.fsf@redhat.com>
In-Reply-To: <87muer36sd.fsf@redhat.com>

--EoJheJKDNp7fTYfkQWiKwoABRgq4OkHsM
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26/09/19 08:34, Sergio Lopez wrote:
>> Isn't this inherited from TYPE_X86_MACHINE?
> Good question. Should we assume all x86 based machines have NMI, or jus=
t
> leave it to each board?

NMI is hardcoded to exception 2 in the processor so it is there in all
x86 machines.

Paolo


--EoJheJKDNp7fTYfkQWiKwoABRgq4OkHsM--

--mBw58v5fqflKGijhL5FZIGYsU0C7MbX9K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl2MfgEACgkQv/vSX3jH
roPZEQf8CbicOml/CMfSZdGdwKF012b22PpkdV0y1zJok7WLvGoKWe5ul4k+liSH
9k7YH2KoP2bKMwxai0uO5S7AMRm8OR0GzDlSDHT1r9kzhL/ZjrQi2cHa5ssGy4aS
Y+q4svGEZ3DoGBY0xJ5DqJBm1WEHhuRY96xgt/FiHpmOOeHhuFyAp5LQYqhC5stb
WF4/tDJVo00Ajrtm0FjQaSBOzadZwEanShhlF3EOHCumcLhsATiQOnxV4/QfUkDN
zU7Pb6Y21L/oJqJe/rdBrrJj6deREGspRqT+C3YALHkT8LV44rtTKM0g231g5Acr
Dl98TIPRYiP11SRAiwOKzBvQwuP/4w==
=JDZc
-----END PGP SIGNATURE-----

--mBw58v5fqflKGijhL5FZIGYsU0C7MbX9K--

