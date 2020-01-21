Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2BBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C98421734
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 08:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2s4KH2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C98421734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itoag-00065V-NU
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 03:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50255)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ldoktor@redhat.com>) id 1itoZY-0005M0-PK
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:07:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ldoktor@redhat.com>) id 1itoZU-0004fc-RR
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:07:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53844
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1itoZU-0004fA-MO
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 03:07:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579594055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8kDzbXV4HOvQTk0xfAKcFTGkikVQ3+jj9NgNvHl4Wxw=;
 b=D2s4KH2oZ6Y6E5GNp/981Ap/Y5zJMg2sxVRLYwltNFE5mP6hDUJ+PjC5ziheFY+TaIRe8e
 8ZajCpkc7FXgC0iOsTZq1bYOC62MkbjR8Ig/kUKKM5nLT11FKDcs+6Se/n05X1NU/JoAqd
 6tV/PlFg5oqFAQ7tkCBLhUrl6by+GHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-BvS024emNdeAGwBRCu0dLg-1; Tue, 21 Jan 2020 03:07:34 -0500
X-MC-Unique: BvS024emNdeAGwBRCu0dLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 031F2107ACCC;
 Tue, 21 Jan 2020 08:07:33 +0000 (UTC)
Received: from localhost.localdomain (ovpn-206-44.brq.redhat.com
 [10.40.206.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1187819C58;
 Tue, 21 Jan 2020 08:07:31 +0000 (UTC)
Subject: Re: [GSoC/Outreachy QEMU project proposal] Measure and Analyze QEMU
 Performance
To: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <324a-5e231180-7-6946d180@169257031>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Autocrypt: addr=ldoktor@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFcV6vsBCADa8NUYov+a+AmCEEUB3stiiMM0NQc1WwlcxGoMxKHcqqIj/kdPhUDvFS32
 V94V7en1Lx+cpXKRMZP3n+3WG+VZWLwaktJgqrECZ161zE7xF5d1H3CLmwStbe6Cw1oR4LYQ
 HBpuqFEA5znoLuTTsP1uXs9h1cYNzX7hmOTvPCLJfDJ1iv954FsgCGtoVvl4CoxaR3u2VNOs
 hXsTTVyJM6gDTsyqn0uvLOHGWGIGVhDkLV4hv6pSdiKrtQKWIUji3Z8x41MbZybmJxHkpOVz
 Jl3jnNE3CbiEq77Is9LMI4yTF2CESs3V4XMBLfZPLrQBC0gzjeRxwCnbdOZRwY5KI457ABEB
 AAG0K0x1a2FzIERva3RvciAoUmVkIEhhdCkgPGxkb2t0b3JAcmVkaGF0LmNvbT6JAVQEEwEI
 AD8CGwMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEF
 Al4caiwFCQsFbrUACgkQJrNi5H/PIsErWAf2OeTv2KSo5ukikdSA/iNItDXqqMhgrN0JbMad
 b82VYKKCFP+NXQy26NQqcKjaJlmv1Q4rYDfLvz+1gvnir6l9gg47g/EPC5s2UxGOlGz8fzgH
 cHne02PFEUKCNSlSZTJW8DCwFKN4VkPGqungJvDd9i8gC9B/TB3HH4IHr82mA3BnQ3wml9KH
 KXRoEJVR15cd6kKU55MRG0mq6VzYnW5Wwyxf0ZC6+R2tQgzxsvxRVPvQXSbcGv3kWoPgRo5a
 8IWzMB194tWVYNaqhMUPKZsgBUGF3JdzrwgDBAuC16mKgyMDrzH3X0ZZ3TXH+mQBXu/px5L8
 BMz/WAibkjPVTeqeuQENBFcV6vsBCADDwkgr2llR9lY1mKsEjA56+R1m7VouGAfzgR9fDjTK
 cwQVrW39zRto6K4s1xVt2ccsa9QBAnag3/6t0akRYhNVKMPEVh/ck6fJJkmEudCAYwbiPeZ0
 Vky5s8bUYkS65s8AAHSG5F+NBO86+kgrTcnYflwyi6DzrY4c6dP6Z+icau5ORI7Q8GrfC18/
 5neAsK4QOSYRlKHggrGzQKgtTgrFZFAemhM7FwCIfOPxybmpu7cJvUqtfPx0SZiEKrZ+kV/+
 H4Z8Q7yBT8gIkPxZBQdhxUrRtuJmyQJxI4a1K2PCrRCqK1kxtyw8Sx63/YvfPjgws+5UCm9z
 3A5Gz/eJP0GHABEBAAGJATwEGAEIACYCGwwWIQSkCkxFxANN4Cpa1IMms2Lkf88iwQUCXhxq
 TwUJCwVutQAKCRAms2Lkf88iwdfeCACyrlND9Kk27optBo2LMBJmoJAOJTl4o8YvWkrGFzK5
 NxWCpaRJCOCfQanACRDW3oEyd4CdLF4GXWsGhIgGymP2+/McpZXJdFwgHNQWtyZ8GHJW/TXr
 GphJ9FLskb2xh83RrLYy29eF+GeZcVLsGP1ZCLz3I6byhbEfklqKymB1q4bQl2cEijm/VK25
 cYpTtNa0SZiNCmfGqfQ60BtDHCjZm1x9GO+67pJmL2FuO0Tq2TtT+SgU1ZKbSYdPWPk2ZetD
 8RRkaPlrVRVGgW1w1/pCS29BHWaazjkmAVHE2Idh6O+7usA/G1Q3OEjWmJpmfwyKHI/rMv/f
 zMoMrrqg5DNH
Message-ID: <a752c621-1c72-e43a-51d8-6b586a2a229b@redhat.com>
Date: Tue, 21 Jan 2020 09:07:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <324a-5e231180-7-6946d180@169257031>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uvPoIkb5Wyilu6IR5esC08ulqj2idmwfY"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uvPoIkb5Wyilu6IR5esC08ulqj2idmwfY
Content-Type: multipart/mixed; boundary="kEuqaIKBX7BKufxL7i8Q6S4bzY2q5qtJm"

--kEuqaIKBX7BKufxL7i8Q6S4bzY2q5qtJm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 18. 01. 20 v 15:08 Aleksandar Markovic napsal(a):
> Hi, everybody.
>=20
> I am going to propose several ideas for QEMU participation in GSoC/Outrea=
chy in next few days. This is the first one. Please feel free to give an ho=
nest feedback.
>=20
> Yours,
> Aleksandar
>=20

Hello Aleksandr,

sounds like a good plan, I'd like to be involved as well.

Why? At Rad Hat I'm exploring a way to monitor qemu performance. At this po=
int it's x86_64 whole system only, but it should be flexible enough to work=
 on various setups. Good news is we're in a process of upstreamizing our se=
tup so it might actually serve for the part II of your proposal. It's not r=
eady yet as it contains many ugly and downstream parts, but I'm replacing t=
he custom modules with Ansible and cleaning things from internal parts as h=
aving it upstream is a high priority at this point. Our motivation is to al=
low public upstream testing (again, starting with x86, but more will hopefu=
lly come).

Your proposal is fairly generic, I'm wondering which way it will turn. I li=
ke the part I, it might catch low-level changes and should lower the variab=
ility of results. In part II I'm a bit scared of how the scope will grow (b=
ased on what I saw in my experiment). You have host, host kernel, host syst=
em, qemu, guest kernel, guest system and than the tested app, which might r=
esult in a great jitter. Additionally qemu contains many features that need=
 to be utilized, you have various disk formats, block devices, various pass=
through options, ... as well as host/guest tune settings. It's gonna be har=
d to not to get lost in the depth and to deliver something useful while ext=
endable for the future...

Anyway, please keep me in the loop and good luck with leading this into the=
 right direction...

Regards,
Luk=C3=A1=C5=A1

>=20
>=20
> *Measure and Analyze Performance of
> QEMU User and System Mode Emulation*
>=20
>=20
> _/PLANNED ACTIVITIES/_
>=20
> PART I: (user mode)
>=20
> =C2=A0=C2=A0 a) select around a dozen test programs (resembling component=
s of SPEC benchmark, but must be open source, and preferably license compat=
ible with QEMU); test programs should be distributed like this: 4-5 FPU CPU=
-intensive, 4-5 non-FPU CPU intensive, 1-2 I/O intensive;
> =C2=A0=C2=A0 b) measure execution time and other performance data in user=
 mode across all platforms for ToT:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - try to improve performance if ther=
e is an obvious bottleneck (but this is unlikely);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - develop tests that will be protect=
ion against performance regressions in future.
> =C2=A0=C2=A0 c) measure execution time in user-mode for selected platform=
s for all QEMU versions in last 5 years:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - confirm performance improvements a=
nd/or detect performance degradations.
> =C2=A0=C2=A0 d) summarize all results in a comprehensive form, using also=
 graphics/data visualization.
>=20
> PART II: (system mode)
>=20
> =C2=A0=C2=A0 a) measure execution time and other performance data for boo=
t/shutdown cycle for selected machines for ToT:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - try to improve performance if ther=
e is an obvious bottleneck;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - develop tests that will be protect=
ion against performance regressions in future.
> =C2=A0=C2=A0 b) summarize all results in a comprehensive form.
>=20
>=20
> /_DELIVERABLES_/
>=20
> 1) Each maintainer for target will be given a list of top 25 functions in=
 terms of spent host time for each benchmark described in the previous sect=
ion. Additional information and observations will be also provided, if the =
judgment is they are useful and relevant.
>=20
> 2) Each maintainer for machine (that has successful boot/shutdown cycle) =
will be given a list of top 25 functions in terms of spent host time during=
 boot/shutdown cycle. Additional information and observations will be also =
provided, if the judgment is they are useful and relevant.
>=20
> 3) The community will be given all devised performance measurement method=
s in the form of easily reproducible step-by-step setup and execution proce=
dures.
>=20
> (parts 1) and 2) will be, of course, published to everybody, maintainers =
are simply singled out as main recipients and decision-makers on possible n=
ext action items)
>=20
> Deliverable will be distributed over wide time interval (in other words, =
they will not be presented just at the end of project, but gradually during=
 project execution).
>=20
>=20
> /Mentor:/ Aleksandar Markovic (myself) (but, I am perfectly fine if someb=
ody else wants to mentor the project, if interested)
>=20
> /Student:/ open
>=20
>=20
> That would be all, feel free to ask for additional info and/or clarificat=
ion.
> =C2=A0



--kEuqaIKBX7BKufxL7i8Q6S4bzY2q5qtJm--

--uvPoIkb5Wyilu6IR5esC08ulqj2idmwfY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl4msUIACgkQJrNi5H/P
IsEDOQf+Pd27dtJaAusgrBEiOgs8w3Fi+/U18OCw5M7JQU6NTkqDWQX8ThETXanH
A8TZdPjbZvPE5YldPQHEwE+rSAqGjCJvNwayqY8uufvE27DTPVjgTpC1Y87lEQZB
fgcl/CNBko1iEKgKuiODXMQdtW9LijKAgKYa9ZMJoz7+/qmO+x+XTRcT6IbRuBzC
0CY2Kzp7jLVYu9PtLeON3vdn7qUnjS39uI86tnS5a1tnGuoC/yQhKx6Nj6DsZ+R1
dLNyC8PF7CPxds9kGhkzQ+6q8vpmrhaV5WjqMXIh31uqP0/lW8HZdWy6gAiI9C7s
lPMo6J297JJB6CWWId8BRvyIpPEjkg==
=YWnn
-----END PGP SIGNATURE-----

--uvPoIkb5Wyilu6IR5esC08ulqj2idmwfY--


