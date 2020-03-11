Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17149C0044D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:25:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0934120737
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 20:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JvMOv3j9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0934120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC7uk-0007KU-0k
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 16:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jC7u5-0006Nb-0n
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:24:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jC7u3-0002Tw-US
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:24:32 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55914
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jC7u3-0002Si-QQ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 16:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583958271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W6fHQgXgFQUH/PrmauwRb5OBzB5h2g8EoARfbQS9/EY=;
 b=JvMOv3j9njkJBWqsw29CtK7JmVam/YSfKzxpy/Iz71OrWNrvG0rFB8vcxyi/Jwg8Qr9sEY
 EKK+myNpa4srjXSgQ68nRLronnV4zWHAqroIXIx0LzswhDz2FAgytTfAa5QaKsCKag173F
 8FukT4zifDfvKJedAon/TjDa+TVSQ/w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-WA6eLTAJMy6O3LqG8h7Pxg-1; Wed, 11 Mar 2020 16:24:26 -0400
X-MC-Unique: WA6eLTAJMy6O3LqG8h7Pxg-1
Received: by mail-qt1-f200.google.com with SMTP id g6so2008968qtp.20
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 13:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gAv/RxmtSwBPUlBwgHaySWPYxJlNgQyihElRc76ENvg=;
 b=O0ZrgeKmACjSGVrasOKMHwsq0IlZLLLdgVRAK7fMxEkS89oHuIHeXN0jLcIG+FJhEl
 eotaTFj1GOXmdLbtm6NhO4Kp8RqbNK3HPCGdUgPZ7BQSdQRf3ked11lZ6+E/LzPREht0
 As3vdUVdLpMAIWmi9/qp3CJgsax+nEL72rPB4BDdf4cO/rgIWo4HiZohhCSeR2zuCmZ2
 4se6y2FlZyNb/jNRY8VDQnVIOxB7cLAw8CvJM821m9yCmY9CUyEV+Xwv+p2Hi5Oe3MAb
 IKDNXIpYzHM9qhsBa+evLFTJJ5gcBcJLkHm7J/Np8na2mQ6ywdQSCRWZBCbZguuCKxFa
 dOkQ==
X-Gm-Message-State: ANhLgQ1/PSH8mC5qzxrGmv2HVlzfdTyrY4B7UXBpDdopM6FiuW7F0pCv
 QMOwXvDKWE2SOp15zUhfNp/Aa908g7NXfqCQH+5HK3ZtT1znkf3V/v6IXbMWQP/8EDMBUTXC2TY
 3HnDGC/+yGjYjhTw=
X-Received: by 2002:ac8:1345:: with SMTP id f5mr4426608qtj.128.1583958266147; 
 Wed, 11 Mar 2020 13:24:26 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsbQ4z1t5TT2iygCVid1LoggTNkKuo9hI349cjyStI7FVWURkcQz63kSUMGsbtcTEgYd8UdVg==
X-Received: by 2002:ac8:1345:: with SMTP id f5mr4426596qtj.128.1583958265900; 
 Wed, 11 Mar 2020 13:24:25 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
 by smtp.gmail.com with ESMTPSA id l18sm824102qke.132.2020.03.11.13.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2020 13:24:25 -0700 (PDT)
Date: Wed, 11 Mar 2020 16:24:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH] acpi: Add Windows ACPI Emulated Device Table (WAET)
Message-ID: <20200311162321-mutt-send-email-mst@kernel.org>
References: <158395315920.8804.12475968769225149761@39012742ff91>
 <ebb59967-ebd3-374a-a2a6-1f374e4768ad@oracle.com>
MIME-Version: 1.0
In-Reply-To: <ebb59967-ebd3-374a-a2a6-1f374e4768ad@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 elad.gabay@oracle.com, imammedo@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 11, 2020 at 09:08:56PM +0200, Liran Alon wrote:
>=20
> On 11/03/2020 20:59, no-reply@patchew.org wrote:
> > Patchew URL: https://urldefense.com/v3/__https://patchew.org/QEMU/20200=
311170826.79419-1-liran.alon@oracle.com/__;!!GqivPVa7Brio!L4XXKjkDknE86ihbn=
ytm45vsQI41J-QWVCZRoXEXtPKIAsMmknrGJWVPZpKgLyM$
> >=20
> > Hi,
> >=20
> > This series failed the docker-quick@centos7 build test. Please find the=
 testing commands and
> > their output below. If you have Docker installed, you can probably repr=
oduce it
> > locally.
> >=20
> > =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> > #!/bin/bash
> > make docker-image-centos7 V=3D1 NETWORK=3D1
> > time make docker-test-quick@centos7 SHOW_ENV=3D1 J=3D14 NETWORK=3D1
> > =3D=3D=3D TEST SCRIPT END =3D=3D=3D
> >=20
> > Using expected file 'tests/data/acpi/pc/HPET'
> > Looking for expected file 'tests/data/acpi/pc/WAET'
> > **
> > ERROR:/tmp/qemu-test/src/tests/qtest/bios-tables-test.c:367:load_expect=
ed_aml: assertion failed: (exp_sdt.aml_file)
> > ERROR - Bail out! ERROR:/tmp/qemu-test/src/tests/qtest/bios-tables-test=
.c:367:load_expected_aml: assertion failed: (exp_sdt.aml_file)
>=20
> My bad. Didn't notice there are tests which verifies ACPI haven't changed
> and requires update for such patch.
> Will submit a patch for this test in v2.
>=20
> -Liran
>=20

Notice the process as documented in ./tests/qtest/bios-tables-test.c

--=20
MST


