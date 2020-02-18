Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BA1C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B85124125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WufCdghO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B85124125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46ok-0006Ps-Qp
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:37:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j46oB-0005wi-FY
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:37:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j46oA-0004vF-HV
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:37:19 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39982
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j46oA-0004ub-CW
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582047437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MYfO6S4YzNPcFA/CJMilUxsy2iImQ6p46xY+7mwlOk4=;
 b=WufCdghOVcWVOb+ohuy5OgoEN8hMbfhNepxEUz2+HPMXq5fxf5QVBIW8GYc5sfvk2h0Ux2
 +JUa36mHDiIDJuF+1mxITUaqmgymc/IS/HyvL5Edk4HD31EQCtOB73fkA6Bxb6MPB2dkx1
 hk/hcYuhCy3fvbgKkb+2+66sFSppic4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-TbqDh9cCPui1LIibig_d4A-1; Tue, 18 Feb 2020 12:37:15 -0500
X-MC-Unique: TbqDh9cCPui1LIibig_d4A-1
Received: by mail-wr1-f70.google.com with SMTP id o6so11143104wrp.8
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to;
 bh=UWHrt4FfGdvceQFjzkPDVkpfr8L3m6GzBA8mjMPHeQ0=;
 b=bqeiZalFsaLjK9ELXuVMPiHezsZPj+GRDiV/eeqhNW2Rnyr+cB6RY2/h1A5IRBVLWI
 fOuGdrXXfJuF9+VZvHvLbXclVMr7Y+C9mOD+Am58TSYfNEGfuc3oh9rS29SLxkCFIU+Y
 e4U02y38VmATCOKbhbcg41LAOE/5l/4AHClPX7IL0q8S0RwMzGtjaSoPrkQqdB4BKcjI
 0VdRWhDlia7SXIqIFx77TPvSGe9MVb8dkIDD1SzBCc9DzT5UGWMVKyRSflw0R+cWmMsc
 spqQgFSpzp6xC8lZ3TV1fBycZk3nFvYbyQISjV00Zl4EFc2EDRLIUlxNPlX7tS7cInvc
 pU4g==
X-Gm-Message-State: APjAAAWQfnGtZtK2AOWXl8H/8CaC+W4yNqtzuYsvnyCeNwrIojK24dSU
 7Z6eHrVWD/4Ciy1eKKmhMLrsBd7hBA3uKwIydPYlYZg66x2HEDVf+FMvVcQuKudpdfEjclMhBtz
 M4h2haPcumLXxNfw=
X-Received: by 2002:adf:b352:: with SMTP id k18mr29599349wrd.242.1582047434025; 
 Tue, 18 Feb 2020 09:37:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDFRv1F8rNs/3fiEnGQ7Bu+zPdKIlQGuvXPWawKZsq13ME4nqfQIaq+A1GnGGdD0jPYXY/2A==
X-Received: by 2002:adf:b352:: with SMTP id k18mr29599322wrd.242.1582047433757; 
 Tue, 18 Feb 2020 09:37:13 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4?
 ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
 by smtp.gmail.com with ESMTPSA id u4sm6986814wrt.37.2020.02.18.09.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:37:13 -0800 (PST)
Subject: Re: [PATCH v2] hw/i386: disable smbus migration for xenfv
To: Olaf Hering <olaf@aepfle.de>, Paul Durrant <pdurrant@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>
References: <20200113174521.3336-1-olaf@aepfle.de>
 <20200116180321.24968-1-olaf@aepfle.de>
 <0335edd2-3d33-88f8-2ab4-4791f7289885@redhat.com>
 <20200117102244.22edd8a6.olaf@aepfle.de>
 <ea3a65c3-bd69-7815-6893-cb1cd8b9cfd6@redhat.com>
 <20200117140616.18cb8c45.olaf@aepfle.de>
 <CACCGGhCO_OqPq__t+V9RrFMYhXCJ5N4PPkq9CASJULV2rTkT-g@mail.gmail.com>
 <20200127100951.0803d167.olaf@aepfle.de>
 <20200218182728.4b7f17b7.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b1313071-0eae-0465-4b3f-85c49c77a256@redhat.com>
Date: Tue, 18 Feb 2020 18:37:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200218182728.4b7f17b7.olaf@aepfle.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NOdwcHRhIKb0J5ufznEcWJ2VodHVpZ4qo"
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NOdwcHRhIKb0J5ufznEcWJ2VodHVpZ4qo
Content-Type: multipart/mixed; boundary="z6xW8kUJDWqNK6TP5ua2P04h1HODe4LdU"

--z6xW8kUJDWqNK6TP5ua2P04h1HODe4LdU
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18/02/20 18:27, Olaf Hering wrote:
> The approach below (making 'xenfv' an alias of 'pc') does not work:
> xen_enabled() is false when pc_i440fx_3_1_machine_options runs.

Don't use an alias, copy the 3.1 code into the xenfv machine type and/or
call the 3.1 functions from the xenfv machine type.

Paolo

> So, how is this incompatibility between qemu2/3 and qemu4+ supposed to be=
 fixed?
> Using '-machine pc,accel=3Dxen -device xen-platform' is incompatible
> with '-machine xenpv' because the platform device has a different PCI
> address. As such it is not migrateable.


--z6xW8kUJDWqNK6TP5ua2P04h1HODe4LdU--

--NOdwcHRhIKb0J5ufznEcWJ2VodHVpZ4qo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl5MIMUACgkQv/vSX3jH
roMR6Qf6Aybpv5feueIkafR/6VcF3EvMgXZ+gsYhO2HPrThCgmsN81r8cdD+yO6A
MB135zxcy+kYNUqwOdi63IgriAmwfF781+u+wkvHrFqEf7JHVmsIrZxTq6iCktcc
8KYqrKMwS5ConT/+RyRJdStnpLXYjFfpx/LGKh5kqc/B6aCQ8fhmYn25WcQZ2FCJ
npgOf+N9bXgoXdZi4IaqFA2lXFix3byKtZj/sWOGCnj3M4YtqVfNI2xab7ekptM/
Be6IobWxzILvYysb8fFuiAY89k2p13SFTtZMm2QQtmblCZlyTiIW4oqYiluWg+61
A+aDR8ZHoCHD2Psrt6tOlMigMHLKkg==
=ToeW
-----END PGP SIGNATURE-----

--NOdwcHRhIKb0J5ufznEcWJ2VodHVpZ4qo--


