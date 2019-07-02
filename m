Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E229EC06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B968820659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 08:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B968820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiENk-0007w5-0C
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 04:43:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56355)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hiEMc-0007TX-1V
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:42:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hiEMb-0004jB-22
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:42:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hiEMZ-0004i3-2n
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 04:42:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so33820wms.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 01:42:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=Af3HYoD4PgG/fswU2CPrFNNuGk3lT8KbnvPToBvwmbs=;
 b=iAoJUOJ6nmFkIjO8UrW8dHO+vIzyEdPXlWt/Nft6mhXYwtLo/E2iU9+xFwPCLHN/dG
 aNzusM47r3/iw7k75LK4Xk7hUidqry3q9cUMWwPpyT9z4xmwpasGueDHlyHxOaDhK03H
 9/jSOgSp55jNwjIvCm6AlrfjpDwaChJ/+KftMQY+/mkM+ia2qbVYbNK94ub8avhQWlnL
 ZgqQnaK1gC20SdEs8lurlY4j91o5sCrsmhJtQLpEBdzftJC725YvmDSZ6FqoTLGJ0fZZ
 ePq5zRoffPhTyB2i1SCH8+NOtR+3vAx5hrkS20ClsathYn1njtu11AKHLAxbzBH8riiu
 4F8A==
X-Gm-Message-State: APjAAAUkfqKG+X/DZY6bUA7r9Juyp8e3gzOZ4IRs+kCIPrJphTWstVo4
 cFffXm37Z5bGdg66V60gjvzuZpuyPXPdTg==
X-Google-Smtp-Source: APXvYqzP9IZs39nrcE4txMb0deKCET3T68nbejtNhbOukedxh4JAhKrNVHyVN+AG0YC5btuxqCRWgQ==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr2541721wmc.170.1562056923925; 
 Tue, 02 Jul 2019 01:42:03 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id y1sm1746144wma.32.2019.07.02.01.42.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 01:42:03 -0700 (PDT)
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081733.ff6cboiddln5wmti@sirius.home.kraxel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
In-reply-to: <20190702081733.ff6cboiddln5wmti@sirius.home.kraxel.org>
Date: Tue, 02 Jul 2019 10:42:01 +0200
Message-ID: <878stgygiu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
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
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>> Microvm only supports booting PVH-enabled Linux ELF images. Booting
>> other PVH-enabled kernels may be possible, but due to the lack of ACPI
>> and firmware, we're relying on the command line for specifying the
>> location of the virtio-mmio transports. If there's an interest on
>> using this machine type with other kernels, we'll try to find some
>> kind of middle ground solution.
>
> Can we get rid of the kernel command line hacking please?
> The virtio-mmio devices should be discoverable somehow.
>
> Device tree (as suggested by paolo) would work.
> Custom acpi device (simliar to fw_cfg) is another option.
> I'd tend to pick acpi, I wouldn't be surprised if we'll
> need acpi anyway at some point.
>
> Maybe even do both, then switch at runtime depending on -no-acpi
> (simliar to arm/aarch64).

Microvm tries to do things in the cheapest possible way. As I said the
other email, I'm not opposed to support qboot (which will probably imply
ACPI and/or device tree), as long it's optional, and the "cheap" way is
still present.

Otherwise, let's just drop microvm and stick with Q35 + qboot.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0bGNkACgkQ9GknjS8M
AjXBWRAAnj0IQeL7dmb4J2YbyEKiFvI6U0ZMmZZZBQdue9rtNDfQTJOLGiZDt6Pa
mZvxf3NRjBt9/YRPOyrLVeqo5jqjS7kWQfxg2M6WaFGPsdQeWMyanjKghKRPZrDV
DORviSkgIy63/aTkkuljZ4/9D7nMOFhFutgJJeJ93xz5g3w2wvFaPjdRRyTNp4HG
Wx2MQyYYS9o6cjZyUDBDViDcsHVvu5WL1jPUPTXp+daX39ytHY30LxZ6WIRUIwEi
IiODfQ/TV9G0epm5a8pQsz2DKbaJsWR2uHK5MxptsDaGLZTU2/79UEMaEEecREy0
Fh/f3lbW2ONNZwEz8N+wkhe9fwb1v80gp4EDEcKLR6cSXfongYNR7eojUWONv36T
0EYrOlYIDunnyDV+dqQASLSl/9hARlB03wD8KexZO5XAOvgtQXqQdXZ9+emtzBwb
otAsC3DjDdRfEH9fMF9DLDhBnwLFaaive22rcgxJU0Zle1KRV5fnlFFNpIC1u1A1
k4JaxncQXlpcNV5LaX7R5By2qfyY+3Zqq0w/NR4i5KSEFnJmxj0A7QthxO0e5g3T
b/kdvpSY7QRQCB1x2JCckwCteqLvbLajXVWOCG8bUzgRquLrCN5yWAXC4olX8MBF
aYvxHbblNMqfPJTo/1Ds3sVWZp3Pb0S4oXQCFjqXpiraUJaBzYI=
=pr7L
-----END PGP SIGNATURE-----
--=-=-=--

