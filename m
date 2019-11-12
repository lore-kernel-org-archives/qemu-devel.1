Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA53C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:21:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2520821D7F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 18:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJnwbQ2N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2520821D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUan7-0006dH-83
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 13:21:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iUamS-00068S-3N
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iUamR-0002Di-11
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:20:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55472
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iUamQ-0002DU-Sr
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 13:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573582842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwfMGdZ0LRJFwHLVYzMTAtDvU1P/sV2TpCImCPUoXVg=;
 b=eJnwbQ2NAUsFh+q/Tp0faxVz7XDMMmQYiWA3kGoBaWXja+ohVs2fGTZROG6l6ye6PMh/oM
 6sBXrxMPS/Dreb6sjfEDMHEYCsogf9PFBEUK7xw+3WhinNROf15QSKzANYz91jE7D3sj2m
 Em81dBXgYQ8u9h9fe9uVwvuoHkJr/To=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232--cYOz2WJNiShcJu6J2FiPw-1; Tue, 12 Nov 2019 13:20:41 -0500
Received: by mail-wr1-f69.google.com with SMTP id 92so12468932wro.14
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 10:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=migp4Ev5+nwifmMBFw9H/sfQDtdmrtnRYIgJZ7wGCds=;
 b=Z33WCtP3V0nlokjw2AXvsCUmlPNNxRlsffjfK5s6imvSUyc3juut8t8w8SVMchWohu
 BHS+3kgrvuPG0AxOc/XLcQ81eazQBeNQ0odLhDh88cFmOttF8J3pY8i3KUec78XhoSfa
 V1aqw1uvxl0rfF0loZQZVDaBSKlk+8868Nh7cQSWKaWtTPS7CoqZmkisfxn5FkHDxup1
 AFfcVMaINTWYOsdWCNqkfdCdecmFXYY+TtI4znr3+zc3aLgrhtLs2n2L5l7AwYUK3dpi
 ksQc2Q3i+gYH6ZXRR1b8mnT573J3gNlJLhF28bLP0/jmVKpytV/w/Je+YoGdAk7RRW6/
 o+Nw==
X-Gm-Message-State: APjAAAUwjiDKdSi8TDiM4evCf3PuWtm23tHORwUmDB5933xvTqKxM0WS
 CcEtW6biE0WRwUs9X0vkMnDrn7nqS2PZMuDgd2VTIDOj4+R6Lm7ySFAgJIJWTVdQEZAjeQv03Sv
 qNFz/6MQrfmxQN4Y=
X-Received: by 2002:adf:f743:: with SMTP id z3mr25781763wrp.200.1573582840217; 
 Tue, 12 Nov 2019 10:20:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIrLy4kH99DF4O6BT7N3ZH6NHGMWgt/YLIxs2ut42OfnqAlI9uYKRkCypsmJ4Y4zT6jzyNDg==
X-Received: by 2002:adf:f743:: with SMTP id z3mr25781732wrp.200.1573582839970; 
 Tue, 12 Nov 2019 10:20:39 -0800 (PST)
Received: from [192.168.1.35] (170.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.170])
 by smtp.gmail.com with ESMTPSA id 62sm28779560wre.38.2019.11.12.10.20.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2019 10:20:39 -0800 (PST)
Subject: Re: [PATCH v7 8/8] Acceptance test: add "boot_linux" tests
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-9-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1a4e69bb-2713-3aa8-a58d-7fbb6c6886ed@redhat.com>
Date: Tue, 12 Nov 2019 19:20:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191104151323.9883-9-crosa@redhat.com>
Content-Language: en-US
X-MC-Unique: -cYOz2WJNiShcJu6J2FiPw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Beraldo Leal <bleal@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/19 4:13 PM, Cleber Rosa wrote:
> This acceptance test, validates that a full blown Linux guest can
> successfully boot in QEMU.  In this specific case, the guest chosen is
> Fedora version 31.
>=20
>   * x86_64, pc and q35 machine types, with and without kvm as an
>     accellerator

typo "accelerator"

>=20
>   * aarch64 and virt machine type, with and without kvm as an
>     accellerator

Ditto.

>=20
>   * ppc64 and pseries machine type
>=20
>   * s390x and s390-ccw-virtio machine type
>=20
> The method for checking the successful boot is based on "cloudinit"
> and its "phone home" feature.  The guest is given an ISO image
> with the location of the phone home server, and the information to
> post (the instance ID).  Upon receiving the correct information,
> from the guest, the test is considered to have PASSed.
>=20
> This test is currently limited to user mode networking only, and
> instructs the guest to connect to the "router" address that is hard
> coded in QEMU.
>=20
> To create the cloudinit ISO image that will be used to configure the
> guest, the pycdlib library is also required and has been added as
> requirement to the virtual environment created by "check-venv".
>=20
> The console output is read by a separate thread, by means of the
> Avocado datadrainer utility module.
>=20
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---


