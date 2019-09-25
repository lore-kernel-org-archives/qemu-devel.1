Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668DFC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:28:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3935F20673
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3935F20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2fA-0000AV-8c
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 04:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53122)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iD2dF-00072O-Cv
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iD2dC-0006Gu-Hk
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:26:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iD2dC-0006GQ-8e
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:26:38 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B910CC053B32
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:26:36 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id n3so1958501wrt.9
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 01:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=kdp2HK44+wXsmn1byX79nXIhx1QZosWrpcPRfuVl4VE=;
 b=cZksb7vCLLzNmHOtR0VchZiv9DII5Qy7kZjkUm/pVWyR0wEZWerf8PyTTJyJNNPwEd
 dJ4Nt4OuXWIqKeNf+LVGHERKdwju10fWvurjNjb7InrKvTVvj7LKQJFIPgdzBgTp2xkW
 268ut8E5pQ9fY6TzUB7M3GP4r+lCWobdnDZd+13l1u5eC0g0mHv/fg+LP5glZ1B6aUxL
 tOrkgqJWYvGdDhrJgm/w+t73WMPYoH+M+5Veb8ArHSKMeXMmMjYch0pga+Cf8VxRrd4o
 2Xx+71+G5U6t+7X9gfNpHou3j5wKIrgqMhC0B6VR+v6YxvXTGEAHiy0GlnWelT38MWFP
 iaTA==
X-Gm-Message-State: APjAAAVsVwmI4cmuGyyEjgwe2s06FYx4JtBRMFfTackaCRfYpC8Q3Y2D
 H9tMNo1SQu3vKHDgIDd8qjsrg28VUDpZj+SuITTM5q1fxUbZfBau86yNUzh9xhsswmt5Hzwjma+
 WThbGDxXhBYJp5Bk=
X-Received: by 2002:a5d:5384:: with SMTP id d4mr7574954wrv.255.1569399995301; 
 Wed, 25 Sep 2019 01:26:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxt0NJ+/zWQ2hkmAlnPIduPMhGlmGSIRxYlETHvmC3yOWQVUoa/p3E0PmoTSTUwZbct1OuxrQ==
X-Received: by 2002:a5d:5384:: with SMTP id d4mr7574922wrv.255.1569399995039; 
 Wed, 25 Sep 2019 01:26:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id h125sm3440454wmf.31.2019.09.25.01.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 01:26:34 -0700 (PDT)
Subject: Re: [PATCH v4 0/8] Introduce the microvm machine type
To: Sergio Lopez <slp@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20190924124433.96810-1-slp@redhat.com>
 <c689e275-1a05-7d08-756b-0be914ed24ca@redhat.com> <87h850ssnb.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <b361be48-d490-ac6a-4b54-d977c20539c0@redhat.com>
Date: Wed, 25 Sep 2019 10:26:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87h850ssnb.fsf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="F2FwA6MWePplJqqD6t4ZbkIJfHLH21rUa"
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
Cc: Pankaj Gupta <pagupta@redhat.com>, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, lersek@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F2FwA6MWePplJqqD6t4ZbkIJfHLH21rUa
Content-Type: multipart/mixed; boundary="cBcTRQtO2qa6ms4Ydaw0MIaVu5vpj9lLR";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sergio Lopez <slp@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 marcel.apfelbaum@gmail.com, rth@twiddle.net, ehabkost@redhat.com,
 philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com,
 mtosatti@redhat.com, kvm@vger.kernel.org, Pankaj Gupta <pagupta@redhat.com>
Message-ID: <b361be48-d490-ac6a-4b54-d977c20539c0@redhat.com>
Subject: Re: [PATCH v4 0/8] Introduce the microvm machine type
References: <20190924124433.96810-1-slp@redhat.com>
 <c689e275-1a05-7d08-756b-0be914ed24ca@redhat.com> <87h850ssnb.fsf@redhat.com>
In-Reply-To: <87h850ssnb.fsf@redhat.com>

--cBcTRQtO2qa6ms4Ydaw0MIaVu5vpj9lLR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25/09/19 10:10, Sergio Lopez wrote:
> That would be great. I'm also looking forward for virtio-mem (and an
> hypothetical virtio-cpu) to eventually gain hotplug capabilities in
> microvm.

I disagree with this.  virtio is not a silver bullet (and in fact
perhaps it's just me but I've never understood the advantages of
virtio-mem over anything else).

If you want to add hotplug to microvm, you can reuse the existing code
for CPU and memory hotplug controllers, and write drivers for them in
Linux's drivers/platform.  The drivers would basically do what the ACPI
AML tells the interpreter to do.

There is no reason to add the complexity of virtio to something as
low-level and deadlock-prone as CPU hotplug.

Paolo


--cBcTRQtO2qa6ms4Ydaw0MIaVu5vpj9lLR--

--F2FwA6MWePplJqqD6t4ZbkIJfHLH21rUa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl2LJLgACgkQv/vSX3jH
roN4lgf9GWqNVZS1qNFejt/9p2cQeTMMkKEBjT0YpZzxE21zq+Jfx01+Hl5Ros9U
RqVaxBd0S2a3ijnF20NKLLtJig7faeJjx+RD9IO9iUfZeTN6sYx3x7C2rBIGHXqn
eRUN1W9n3PnZ4nSOR13oK7pILWYSHbmV3HpKCIfs0AkOGaOtNZF8o7o+pB3j47Mu
V5SASFrKqVtuGOq3W80cmVUwlj65Yir/4DYA43Z4U6FjLu7R51kgj8MSkuGlM+G7
7yM4iP6VWUNak1i0/RUoh4+2qCks5ileshZJIH5ZxwQBoL068Ky3ilW2DPhIE9RK
NC0g++t91EXj2TBkF/pAfOp7/ekIxg==
=/GvA
-----END PGP SIGNATURE-----

--F2FwA6MWePplJqqD6t4ZbkIJfHLH21rUa--

