Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1A4C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 05:54:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B30221D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 05:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B30221D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD0G1-0001XM-I7
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 01:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60244)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iD0Eu-0000t5-KK
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:53:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iD0Et-0005Xu-Mc
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:53:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47056)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iD0Et-0005Xf-Dc
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:53:23 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4A6FC37E88
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 05:53:22 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id t11so1728010wrq.19
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 22:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=7woLVgJ+KVYVdpUNNP/OKdOYyHMYlJN3b6YJJgwv2Mg=;
 b=uOdE6VPcKRm/b4M1y/+tCUNksUhegRNnm+hmyFO0+AATxxD5j7JYCfBXo5ts77LEjk
 2A9MpM6Bs0TXvzv4WAEdfF3Hd6N5VkezN7qZefJlEFc2gTUWml8yVz2w6TuLpsE7ZA/s
 5VXRzaH4mSlTHxnZUdB+hcfbdqg+FY+1JBD6GM1orATmWYbB2FCQUDwT/h8zArIS5CWc
 9P1SJzzTKztM/Ap2OH4tfK9P9FDS4DrhFMj7m+kN1VuG78B4xPSV3zta+49rcAwBXOCG
 M+7oDNiLqi1+kCExrVHKgDN5vaLbz9kRoKIKXnj4iy+HHHdMogYV6m74BKhRcrnvfCjT
 5x2Q==
X-Gm-Message-State: APjAAAWoGhwhcrHtlRX9Rlp94p8xIKM0SlR1oliO2eLUe0S38Nkwbnej
 lYamHYNAX0VVQRI2vHGu44gbmgaT7TERZeQMctN5urz6qW/TcTkRB56FXN7Vac9EuMdR+3aXyAp
 dVC0v2TtPTHekqH8=
X-Received: by 2002:adf:f9ce:: with SMTP id w14mr7310625wrr.132.1569390800990; 
 Tue, 24 Sep 2019 22:53:20 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxpOy6S9KG5JEGMS7+UMGl6cv6QPmCytFMF2tJor3GyybuL6Zygr8G2mNtKtbI+zvp6UGV9vg==
X-Received: by 2002:adf:f9ce:: with SMTP id w14mr7310602wrr.132.1569390800830; 
 Tue, 24 Sep 2019 22:53:20 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id b184sm2316815wmg.47.2019.09.24.22.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 22:53:19 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-9-slp@redhat.com>
 <2cbd2570-d158-c9ce-2a38-08c28cd291ea@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 8/8] hw/i386: Introduce the microvm machine type
In-reply-to: <2cbd2570-d158-c9ce-2a38-08c28cd291ea@redhat.com>
Date: Wed, 25 Sep 2019 07:53:17 +0200
Message-ID: <87o8z8sz02.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, lersek@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 24/09/19 14:44, Sergio Lopez wrote:
>> microvm.option-roms=bool (Set off to disable loading option ROMs)
>
> Please make this x-option-roms

OK.

>> microvm.isa-serial=bool (Set off to disable the instantiation an ISA serial port)
>> microvm.rtc=bool (Set off to disable the instantiation of an MC146818 RTC)
>> microvm.kernel-cmdline=bool (Set off to disable adding virtio-mmio devices to the kernel cmdline)
>
> Perhaps auto-kernel-cmdline?

Yeah, that sounds better.

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2LAM0ACgkQ9GknjS8M
AjUg2w/+ISuBhSmncT32Fm1YTvxEh2PDdUF/lq3mxoIxKfl2KOfRnj/jlrz6JofU
L7M8lrc1+NXSf35Tbavcf/enK3Fs/gRF54h3J5NtlVNK6nbYb5+g7I3o8iUWbwJk
FbwHv7SmRnOzyzQFlzFoW5C2kHfieRn+biVoFCVScdkM9CSJSZg4+vJUJoHcg7tB
FItkCQfhm1R940qFmP7EmzrcY9pb0sUoJkOpoUhjr/2F32nJQexBCxn7dDDYvDPY
g6o5QKR0jzbwye/luxKofqhMHrhlblg6MT8ygIDxtNuOfBJj+O67hXaXx+0lY9w9
XxZ2mY9nHmRTXvP6c9CaN+bZUj20BhcpEU+hl6fDjx3aBw753I4pGCZJcNdOv682
Cop3r/7HyHDs2Wr7/pJEhBXnFMKOanjmak1uef8c1JYz5VuKt2878Kd4dHfef9Xr
IlNHmjjpiF5jjVtcBXw1i+xT5LQ2p53Hb2bUcu23W6qxSGji0rxA3W2F80qDk3m5
tUJjuZ9ltF6995/oijT5wTxOSp/ahH9aBtz4lg9OcesdlJolyPvFMXDggxZRI0Vq
fC27hF97dgK85qh/JgzhleMgwAzIzZRQwmzV0xiboonY+UnF1MaD1+WlNeLlo2pL
pYkja5qRd9I+BOfzCdjanDE/uDE54yW8xcgJGxVpLLMrWY7dDec=
=E2ve
-----END PGP SIGNATURE-----
--=-=-=--

