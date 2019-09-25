Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A528FC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:43:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A4FC2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4FC2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1xs-0002qA-Qi
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iD1np-0001Na-EI
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iD1nm-0002oC-V7
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:33:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52793)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iD1nm-0002nj-NS
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:33:30 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 30FA186668
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 07:33:29 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id n6so1866032wrm.20
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 00:33:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=CuB2l1l2AW1aA9nML3ymWwi25AU3aMKPJA39BqfZBOA=;
 b=Hu9aVZ5LXJ3hbSJnsy3ToOV+3MGh1MTFQTr6KhHfdZf6hl7oOugKsJZZgVUXmMwzUd
 6jf1oAWubnPR6JlUIFJv6azkMudclsgd+UVIFrYSzjm1UdCxt/4CcqaQCFORhKXat8Wx
 7ItCvlgj/gXaohhFG7lTTxvzP+nrFutH9KI9+Agqf7LyemF0IlMXqInQWVU1CQt0/NvJ
 lFRjGjMbTV35Bbq70I9e13RkrxcydoqCSMaNlO8M1uV3wrNYE9rJlSSXm2rSCYezmQaD
 uUV48GTTVGjks7LuyKSbAt8d9G4kOsrgS1d+t172HaUGeiBSPqijgSJeu7kcVdVlq/9Z
 iHKA==
X-Gm-Message-State: APjAAAW4k+j7lOI+uV+jljeB04MNLkCPJelDIH0keNn8cK0jVEFtyFiV
 XDB0xtJJ4l3Njkntpp1A9BNP3f9tlZRP10JGsF3L/EQ1MnSkH4cqBhj/4whSHHsCDdq5l46uwjQ
 i51cwLuYy8MMNQ6s=
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr7531922wrv.10.1569396807750; 
 Wed, 25 Sep 2019 00:33:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx3TyvI/tukpUJDUD7w//YM87kZq+CXXLiEYXSPShzH6WwxctW/KKDXl2aWRIBMKFShb5sZDg==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr7531893wrv.10.1569396807538; 
 Wed, 25 Sep 2019 00:33:27 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id z9sm5560762wrp.26.2019.09.25.00.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 00:33:26 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <20190925050629.lg5w6vvikxtgddy6@sirius.home.kraxel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
In-reply-to: <20190925050629.lg5w6vvikxtgddy6@sirius.home.kraxel.org>
Date: Wed, 25 Sep 2019 09:33:12 +0200
Message-ID: <87impgsudj.fsf@redhat.com>
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
 mtosatti@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com,
 imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>> +microvm.kernel-cmdline=bool (Set off to disable adding virtio-mmio devices to the kernel cmdline)
>
> Hmm, is that the long-term plan?  IMO the virtio-mmio devices should be
> discoverable somehow.  ACPI, or device-tree, or fw_cfg, or ...

I'd say that depends on the machine type. ARM's virt and vexpress do
support virtio-mmio devices, adding them to a generated DTB.

For microvm that's simply not worth it. Fiddling with the command line
achieves the same result without any significant drawbacks, with less
code and less consumed cycles on both sides.

>> +As no current FW is able to boot from a block device using virtio-mmio
>> +as its transport,
>
> To fix that the firmware must be able to find the virtio-mmio devices.

No FW supports modern virtio-mmio transports anyway. And, from microvm's
perspective, there's little incentive to change this situation, given
that it's main use cases (serverless computing and VM-isolated
containers) will run with an external kernel.

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2LGDgACgkQ9GknjS8M
AjUGFA/9En3xpwaRRlk8noOWngoaHWQN83Ugk1tJ6/lQackkpCwakxv+Bhupj9C4
bdw0Fa7nwIKDfEWx5j/iQH8ig1pyw7qWAlJaZuo09XAW2qkBdIvacyTuIK9z/Xxz
C2IXRdIY1X90ovNqrZPCX48TtUlGBgCBB8CTMBMktKmA1aqcGahzzHYJE7B24iRo
onXEy5w3Hss6ln+voTgOvLHtrJ+qBAE92h+UjdICIa748gGWqGI8HjqEIDjMUZfb
VjxlzR+0U92kOGH6bQmc+inVENltSAlyEC5PuzKUZ8X24VGFae1EHY3nAB9wKtPI
uxGsqNYJIxliWSwMOEWJzde81b3H30l9dYhxbQKfZri4oOIfr/EG4pAARSKjsZBI
pZMe9C5eNeCWcfaHA59SHR7Sw4XBdgU+xekL8RR5lCgYz4DYPlVd+1ny6IKcUICV
aZdY0SYC0eOWVHaAsphjEHf6c+WTQ9CZkC/Wzha8UgGMsL3s0oU6nRcUhIe1LVL/
Gv75N19Ji+XW2fSRYLi7WMXL7hpgQxWzJ4H8G4ijb88tBtHlGttHlnxtj7g/PIvp
9w90y+xdK6JXzRYOTwGzN8TSMBmUeEkgUT2EiWCPZNCAZrze0WliEktUBN1g+rsQ
c74pQhEfC8cAPWMHpGgn1/vsz7K8YOi6KDuoPNpcVOEAkBNcjhs=
=McNV
-----END PGP SIGNATURE-----
--=-=-=--

