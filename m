Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC42C432C2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:23:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040E9222C0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 08:23:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040E9222C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDP3o-0001xN-5d
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 04:23:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41250)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iDP2a-00016f-Qu
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iDP2Z-0000Jk-Ne
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:22:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iDP2Z-0000Id-F2
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 04:22:19 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 73ADA7FDF4
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 08:22:18 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id f11so605387wrt.18
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 01:22:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=L5O1kmRhQ9uti81iZw7t4dCg2Fpyg6HhGNykAVE4yJo=;
 b=VAq73/AWP8UJ4hrjazMYukkI62OFv61M5BZVGVbQp4K+bOCiLWEpwNTCMsuAVG51yW
 2dqsBRev1B91tSRhvodHdWwtQfju5sHaJ0nuYlUkK7yKBsJ0BbvjJbOGGq+Nxm0ZlkSv
 4Pn7ciOy3vsiIyHtuIQVVq7PyzAF+/dwdi4iFznlYxlRi9dUtLaFdMkRCtWcTcr/zO4y
 HO4fEts2VO+EYe0M+VK02GOYDVjZ5Wye5yFrLczzqB2PGeN6FrnQPzM7RU0qv6pXI4dh
 Fq0w+L3LKX1aP9sepAzb3zQaeKMOta0ci5R4w0SlcPjmX2SkkdZmnv1t85RMHY9u5MTF
 xvTg==
X-Gm-Message-State: APjAAAXWBxI+ftZZbAN5TGBAGua3M9ImRD/CXWckmsV085zNKs8MsVFs
 61ngTOQj8Y32v1+bcRJC402N667I4i2Gls30zqfBTCXWcodcfr8R3nxoTsTsWrLjUoWEUHPgVdZ
 SlTtxz9WJwRJSjEA=
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr1858619wma.91.1569486137147; 
 Thu, 26 Sep 2019 01:22:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzw+wnsIl3jdbfN9r5xmn6DoNFfDXR6L8cbd3/67rab9sVawMNIdQ9m1uS1vBy/TPvRtO4/lQ==
X-Received: by 2002:a1c:35c9:: with SMTP id c192mr1858595wma.91.1569486136891; 
 Thu, 26 Sep 2019 01:22:16 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id a13sm2174171wrf.73.2019.09.26.01.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 01:22:16 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <7d3b903a-e696-9960-a7f0-cb45101876c5@de.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v4 0/8] Introduce the microvm machine type
In-reply-to: <7d3b903a-e696-9960-a7f0-cb45101876c5@de.ibm.com>
Date: Thu, 26 Sep 2019 10:22:12 +0200
Message-ID: <87lfub31sb.fsf@redhat.com>
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
 pbonzini@redhat.com, imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Christian Borntraeger <borntraeger@de.ibm.com> writes:

> On 24.09.19 14:44, Sergio Lopez wrote:
>> Microvm is a machine type inspired by both NEMU and Firecracker, and
>> constructed after the machine model implemented by the latter.
>>=20
>> It's main purpose is providing users a minimalist machine type free
>> from the burden of legacy compatibility, serving as a stepping stone
>> for future projects aiming at improving boot times, reducing the
>> attack surface and slimming down QEMU's footprint.
>>=20
>> The microvm machine type supports the following devices:
>>=20
>>  - ISA bus
>>  - i8259 PIC
>>  - LAPIC (implicit if using KVM)
>>  - IOAPIC (defaults to kernel_irqchip_split =3D true)
>>  - i8254 PIT
>>  - MC146818 RTC (optional)
>>  - kvmclock (if using KVM)
>>  - fw_cfg
>>  - One ISA serial port (optional)
>>  - Up to eight virtio-mmio devices (configured by the user)
>
> Just out of curiosity.=20
> What is the reason for not going virtio-pci? Is the PCI bus really
> that expensive and complicated?

Well, expensive is a relative term. PCI does indeed require a
significant amount of code and cycles, but that's for a good reason, as
it provides an extensive bus logic allowing things like vector
configuration, hot-plug, chaining, etc...

On the other hand, MMIO lacks any kind of bus logic, as it basically
works by saying "hey, take a look at this address, there may be
something there" to the kernel, so of course is cheaper. This makes it
ideal for microvm's aim of supporting a VM with the smallest amount of
code, but bad for almost everything else.

I don't think this means PCI is expensive. That would be the case if
there were a bus providing similar functionality while requiring less
code and cycles. And this is definitely not the case of MMIO.

In other words, I think PCI cost is justified by its use case, while
MMIO simplicity makes it ideal for some specific purposes (like
microvm).

Cheers,
Sergio.

> FWIW, I do not complain. When people start using virtio-mmio more
> often this would also help virtio-ccw (which I am interested in)
> as this forces people to think beyond virtio-pci.


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2MdTQACgkQ9GknjS8M
AjVqdw//TuWD02WrtyIPcNp1ca4WEyqPbBD1NanxFWCrzgeXG36+x9ZFphoeKukS
y/92Sl1JhUjMLcsfUvh5TjkshNRyFAV3BRoPog0IP242chfVjTCFJRaqkViCFyGO
coHzEROioOjO+lGs6OnP/RNRuQCmGcFMY4EBMTPhM6gyCGyrDcuzp6o6RM0NZxLt
Dq4pSqneNyOFsqBakcqBAxy/c9nluJhdL/MvmeTuaXiaCKhgEecR2ZYMr61e1pSk
l98t2PXevnIUZb0LUAl4bVuYNnB1WJzd4UlcCo6ixL6zHVdYJgX+5M4E7lV9pnLr
tlv9D98FRV8yXulIDEX0Zu9AKPCDyk44qV22aslhis9ST8wEFs777RW04EeAyCfw
SjyhfVmWgUII0BmdLBSCEgxAohi1r8Q9J2OAF5l0in0WCBJyOiq3l5n1WHd0Txdg
TLYX3AJgj/+PFnvmI9rw2x00UhoV8mPgZ+sTzO2aHWVF02YLwFPyeSaAQa8VM7l3
qzXgB58PZjiiS8ToGeJdSMiZ8YDqMuT+mQ31kcs8W4YH3PrAqfC8mGPnzD25NZnq
zbWqxEw1ywZbSjqS6Sh/cJogDhciviBS2qsjQ5+a1fN0dCMHCLjnQ/VMToq3fveT
SmyVstcHXIU+Ysmq20CgD/d+Ep9ok2BhbF1Tha4CDK3bHAqi9qI=
=nexF
-----END PGP SIGNATURE-----
--=-=-=--

