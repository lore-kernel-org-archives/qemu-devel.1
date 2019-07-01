Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415CEC0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1651920652
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1651920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhtNt-00076K-Eb
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 06:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59670)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hhtMl-0006Dm-OU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:16:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hhtMk-0000Ys-Er
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:16:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40339)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hhtMk-0000Pv-3F
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:16:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id v19so15249627wmj.5
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 03:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=/Bh0ZE3ySP65zEP+1jY5wYg+ao0IFv/nT9ofGj0rZz0=;
 b=ICm1JuC1FhfAyc/fsIw6e70S4SO4ShUAvklwxBOxoQCS4dzbtwaaS30c+8W7171LF9
 vg59mU2K6vxmC/gQxBzFjRuZq8pUoImHe7iiYeuWJrXNiEHXaaSLBHGSrg9rQm1QkUH7
 P2jMylDbm8Qd3FjXU7e/MiH4ICYXjRXn92bFVQuYKGcRujYLaMKw8nOAzuoD5hk4RSFm
 X9j4P4Pa1O2onrM4pUOWjgjzNLe/SxjbPXFCdSjJGQ9wZDJPGlcBkWqx7ZrjsI9OdZbh
 57YzuuxUjeh+m0W8bfdwBmIJ9ntQ01ssI5R/zFi5F6UIy11GD1nrD+36w0wiTXDUzHaw
 WGMA==
X-Gm-Message-State: APjAAAUeiRvruL/anpbNzJpks1dR1ts8QCce+VBnFRdhtleMnVqIcfWQ
 EsAIpWd0jE+2yEAb4OAaMW2M/Q==
X-Google-Smtp-Source: APXvYqxiKHgRlLluxa2dAmo3pYDclqfXlXPC8pQIFBMYUYYKfbWSJmtWUoNidaGjsSL3W83sQ72b8Q==
X-Received: by 2002:a1c:407:: with SMTP id 7mr17700236wme.113.1561976207235;
 Mon, 01 Jul 2019 03:16:47 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id c65sm10436708wma.44.2019.07.01.03.16.45
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jul 2019 03:16:46 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Damien Hedde <damien.hedde@greensocs.com>
References: <20190628124534.10679-1-damien.hedde@greensocs.com>
 <20190701083710.GA18173@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <94a3da17-c1c5-b9ce-8e92-4d346ed98782@redhat.com>
Date: Mon, 1 Jul 2019 12:16:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190701083710.GA18173@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="YfGVBmusw7n6pIy6jM2PcEydhRnNiSQKd"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] FAULT INJECTION FRAMEWORK
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
Cc: ehabkost@redhat.com, sakisp@xilinx.com, mark.burton@greensocs.com,
 qemu-devel@nongnu.org, armbru@redhat.com, edgari@xilinx.com, crosa@redhat.com,
 pbonzini@redhat.com, luc.michel@greensocs.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YfGVBmusw7n6pIy6jM2PcEydhRnNiSQKd
Content-Type: multipart/mixed; boundary="LlcdVuBcZzboLB3UiZE5FaRbP37nDnYJM";
 protected-headers="v1"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Damien Hedde <damien.hedde@greensocs.com>
Cc: ehabkost@redhat.com, sakisp@xilinx.com, mark.burton@greensocs.com,
 armbru@redhat.com, qemu-devel@nongnu.org, edgari@xilinx.com,
 crosa@redhat.com, pbonzini@redhat.com, luc.michel@greensocs.com,
 rth@twiddle.net
Message-ID: <94a3da17-c1c5-b9ce-8e92-4d346ed98782@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] FAULT INJECTION FRAMEWORK
References: <20190628124534.10679-1-damien.hedde@greensocs.com>
 <20190701083710.GA18173@stefanha-x1.localdomain>
In-Reply-To: <20190701083710.GA18173@stefanha-x1.localdomain>

--LlcdVuBcZzboLB3UiZE5FaRbP37nDnYJM
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 7/1/19 10:37 AM, Stefan Hajnoczi wrote:
> On Fri, Jun 28, 2019 at 02:45:29PM +0200, Damien Hedde wrote:
>> This series adds a python framework aiming to provide some ways to do =
fault
>> injection in a running vm. In its current state, it allows to easily i=
nteract
>> with memory, change gpios and qom properties.
>>
>> The framework consists in a python script based on the qmp existing mo=
dule
>> which allows to interact with the vm.
>=20
> How does this compare to qtest?  There seems to be a lot of overlap
> between them.
>=20
> Why is it called "fault injection"?  The commands seem to be
> general-purpose device testing functions (like qtest and libqos), not
> functions for testing error code paths as would be expected from a faul=
t
> injection framework.

I understand qtest is to test QEMU, while this framework/command is to
test how the guest react to an hardware faults.

To use the qtest_mem commands you need to run QEMU with the qtest
chardev backend, while this series expose a QMP interface.

To avoid the overlap, a cleaner follow up might be to have qtest wrap
these QMP commands (mostly like HMP commands do).

Another note while looking at a glance, qtest uses the 1st cpu address
space view, this series allow to select a specific cpu.

It makes sense to me to be able to select address spaces by name (more
generic, not restricted to a cpu view, since one might want to inject
fault in a device ram not always mapped to a cpu: dma, emac desc).


--LlcdVuBcZzboLB3UiZE5FaRbP37nDnYJM--

--YfGVBmusw7n6pIy6jM2PcEydhRnNiSQKd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAl0Z3Y0ACgkQoqP9bt6t
wN59bQ//eTBrj3KkZh2wr8M3Y4lTq6tHWTAS8zuRnofQBiw3wCARYxYEiNmAYBAR
LCXfFWZ6xMlLRYtX2N4UMDf8xFihSFwFlOF9oF5PotslEHX12diMtfQBX7oNKaBD
tZZy35EpaCgY9C9fa93t0k3q21dPU1wZmwD06R+mKQtvch/fg1xCy3p8f8XpzxJX
pp1/7aHNazPej9lhhsq6G4wXdQrqdn65b+YcAIw585WCghHpESr1JXBecrqQLGHX
v3zsVqWTrM5GiKc888nmg4x+89TV0bNwj8MyUVpgYEpuygVeHcLSuVnrwL1FF++U
nqySFdqBZJF1MJz0DvXiwhxWTzmcyCDN7ZMWyUCdvEHCGu8xf7771cEoIT1Oy+kS
T2CAUOAxob2g9lAVSsZ3x0ZeCNrWU3TPGIq2FxDioK/L+mKr1N61XNlnnsXxR4e4
TKPtU4rtyEkyZfyHfsFYKkN74AAOYt3CHfRfr1GGwxIYSOkG++Zxik0/kxgRmgCp
WhvHeRa89JUd92WQabmkKNilpkPCnQGfJLeXLDtk9I+csru3H205hJWuEJu66w+9
tSkqcPE/pPS8jD8VJCNOPVaEosGX+NQGMx3tkynfEPv4UgL3DGUQDgwr7aYmA32b
fgeftlicLgLmrVI+w7VnClchQj0eqfpnY9XNocdHN5UkFbYWte0=
=Czfx
-----END PGP SIGNATURE-----

--YfGVBmusw7n6pIy6jM2PcEydhRnNiSQKd--

