Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30F2C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:45:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8151624655
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 19:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VB+5mjSc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8151624655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irS80-0008QG-Io
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 14:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1irS2B-0000me-DR
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:39:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1irS27-00043s-EQ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:39:27 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58135
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1irS27-00042V-9S
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 14:39:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579030762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=93oFLu50vA9g7oaS1SWMjVtYpGQlFJgbDG0l71Lohp4=;
 b=VB+5mjScmHqxnyfvbMOOKHDiXpk8Voen5SujrRfvfQBpKbYd6n1cHidLA9c+8wFlF6exQc
 h0ofQo6w0AFDXkWwnNs9UzIUOvQBjqZID+royjZjucWqFqlrSfyFUY9VpwtdNAqRkHUXXc
 6Q7wgzvXBnKPmfkbbUuoN7oCq5TEaLM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-dhovSPblPcaWPFKQeC4hqA-1; Tue, 14 Jan 2020 14:39:21 -0500
X-MC-Unique: dhovSPblPcaWPFKQeC4hqA-1
Received: by mail-wr1-f71.google.com with SMTP id u18so6899499wrn.11
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 11:39:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=QiyHRnpeYMxI2KKDaieHZ4OUWt4InM/ROPSeYPrAKjA=;
 b=Bp3/Uz1ItSWOR7GHizPugXZpJnmb304lfHm5DC8CUoQx7DvCKwaSNmaILjC6nwU+1K
 mcklGWXOT0/ki0C/qxDSXwi9ttT2bkUeo51ZWK39Dqw8YknF1sPZJoHO/sDL6oi39WwF
 JuXVKI3sSsg0TJvBTybdIMFOO2uoaaSQHOYFvXo9nHIHlf73rGpmKgwO1hT/Uei59BCv
 s0+8LufrWGxgmM5NnEwwarptGY1Erk2MQW09Ear9DOBhY1eKzjSHQtFxJYrlPq4y9mX7
 Yw9tLES7Dc64l0SCdYL7J3tOk5iTRywaVQjpTkP+mECbM5qEhZk5MkwOFbHa1PZvQcpj
 O1AA==
X-Gm-Message-State: APjAAAW54GX0M11pbedFzklxNH4vthWVTdIHCfBTyTu1qjEd8JglMAaP
 COtohs6ThzpYmVAb0yOB3ubOLB9ZKbmJZrG1qutrvzW3W+C4s4Gs0o7YFUrMqbZsTzpsoRBmxX+
 5hUGz1xB80Fe5YhE=
X-Received: by 2002:a1c:5945:: with SMTP id n66mr27404486wmb.98.1579030758978; 
 Tue, 14 Jan 2020 11:39:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwwy4z9vbNkOOubcJrArxW6AxRqLNLmFpI8yDF+ryNFBddxAvNLlV+iSHJ9oVvugx3U/0YLVQ==
X-Received: by 2002:a1c:5945:: with SMTP id n66mr27404467wmb.98.1579030758707; 
 Tue, 14 Jan 2020 11:39:18 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:1475:5c37:e2e2:68ea?
 ([2001:b07:6468:f312:1475:5c37:e2e2:68ea])
 by smtp.gmail.com with ESMTPSA id s3sm20009550wmh.25.2020.01.14.11.39.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2020 11:39:17 -0800 (PST)
Subject: Re: [PATCH v2 0/3] block/io: serialising request clean up and locking
 fix
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <1578495356-46219-1-git-send-email-pbonzini@redhat.com>
 <20200114162858.GD132666@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bea6d0f3-ddca-66a1-de9f-2c11c44d251e@redhat.com>
Date: Tue, 14 Jan 2020 20:39:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200114162858.GD132666@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OUHi7047uqrKEDITdBgEh3hIdVHevrofR"
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OUHi7047uqrKEDITdBgEh3hIdVHevrofR
Content-Type: multipart/mixed; boundary="9S4A70bCKdStrFKpmkG8g1HCcU25bGZXQ"

--9S4A70bCKdStrFKpmkG8g1HCcU25bGZXQ
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14/01/20 17:28, Stefan Hajnoczi wrote:
> On Wed, Jan 08, 2020 at 03:55:53PM +0100, Paolo Bonzini wrote:
>> Peter Lieven noticed that reqs->overlap_offset and reqs->overlap_bytes
>> are written outside bs->reqs_lock.  Patch 3 fixes it, while patches 1
>> and 2 are preparatory cleanups.
>>
>> v1->v2: fix comment in patch 2, commit message in patch 3 [Kevin]
>>
>> Paolo Bonzini (3):
>>   block: eliminate BDRV_REQ_NO_SERIALISING
>>   block/io: wait for serialising requests when a request becomes
>>     serialising
>>   block/io: take bs->reqs_lock in bdrv_mark_request_serialising
>>
>>  block/file-posix.c        |   1 -
>>  block/io.c                | 162 +++++++++++++++++++++++----------------=
-------
>>  include/block/block.h     |  12 ----
>>  include/block/block_int.h |   3 +-
>>  4 files changed, 81 insertions(+), 97 deletions(-)
> Is it possible to trigger the bug somehow?
>=20
> Can you implement a test case?

No, it was found by inspection only, and it's actually protected by the
AioContext lock for now.

Paolo


--9S4A70bCKdStrFKpmkG8g1HCcU25bGZXQ--

--OUHi7047uqrKEDITdBgEh3hIdVHevrofR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl4eGOQACgkQv/vSX3jH
roPN5Af/St35L9hQ5z8z8Qj15TlPwxZ9dQDlkyMFAM1lrynA0Hjz5PWDzoXFz8YB
gkd+rssArFYFrxY150xffsZi3dv0cav0FedKZBgWL+3RStK+XSEbG/RufixL5bNU
HGD4fjjLpWxV2KXkqcqVZtOjzF2lkOlhipCeuM3C68d6Jqg/dYXGuFbfDYCigaHI
c63MTrFWaLMMsJAuhTTYgZvdikCe39FE4+4uzZNyIWe0kcy+hVV362n5Eq7E0yTk
AxmklmM8GvZaHblmF6K2BgVgNSdNbY2rYE6xv5gNHHu/OY6uPSFwIgru6w8NVDFr
cntQ1+KCjGHTCmkbbtR/s1pkbmmdKw==
=YaDS
-----END PGP SIGNATURE-----

--OUHi7047uqrKEDITdBgEh3hIdVHevrofR--


