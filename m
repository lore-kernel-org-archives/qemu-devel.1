Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C31C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0C8524655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 06:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOUqMNhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C8524655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu9eS-0008NG-4e
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 01:38:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35035)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ldoktor@redhat.com>) id 1iu9dl-0007v7-Ts
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:37:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ldoktor@redhat.com>) id 1iu9dk-0002nC-Kp
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:37:25 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58576
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1iu9dk-0002m7-Fy
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 01:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579675043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vdTJazohO4fVekLCUBBFI7MeKxmlpOFPz/GnZJJ+LPs=;
 b=OOUqMNhyYbTRy5dqrScVugSKM5Fga4XJ3DhUnmNboiuUbbcMnopESA0Gaw48n7DdRH9PKi
 p8F/s6ffWyHrq3ip8lsBEW9R4n0NnwAa1xEH4q1bNsvw7P5PGAj/As0OcuMClOAk3C1SOH
 xcSZL+uWyRazylyG4zYSdUVMsnSOuiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-76mM7G6kO5i2hunV4nr3mw-1; Wed, 22 Jan 2020 01:37:21 -0500
X-MC-Unique: 76mM7G6kO5i2hunV4nr3mw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3EC6477
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 06:37:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-206-44.brq.redhat.com
 [10.40.206.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02C875C1BB;
 Wed, 22 Jan 2020 06:37:14 +0000 (UTC)
Subject: Re: [Avocado-devel] How to set a limit and clear Avocado cache?
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 avocado-devel <avocado-devel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Willian Rampazzo <wrampazz@redhat.com>
References: <de831637-040b-d182-2f46-e833fead575b@redhat.com>
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
Message-ID: <8bf0f889-dea9-ae5d-e66f-efebc3ac0297@redhat.com>
Date: Wed, 22 Jan 2020 07:37:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <de831637-040b-d182-2f46-e833fead575b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Sw2R6TEXUlSr6XZqqAjBPdPWzweM5HHV5"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
--Sw2R6TEXUlSr6XZqqAjBPdPWzweM5HHV5
Content-Type: multipart/mixed; boundary="2vu3LuFoU6GzmperhSmeCTn7dr2c7h7jc"

--2vu3LuFoU6GzmperhSmeCTn7dr2c7h7jc
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 21. 01. 20 v 10:15 Philippe Mathieu-Daud=C3=A9 napsal(a):
> Hello,
>=20
> Today I ran out of space in my /home, I ran the 'baobab' tool and while t=
he first bigger directory was obvious to me (~/.ccache), the second wasn't:=
 ~/avocado/data/cache/by_location/, with various GiB.
>=20
> Note, this directory is not listed in my config...
> $ avocado config | fgrep ${HOME}/avocado
> $
>=20
> I might already have asked on qemu-devel mailing list, but is there a way=
 to set a particular location for the cache directory, different than my da=
ta directory where I keep the job-results log files?
>=20

Hello Philippe,

yes, the cache dirs can be specified in the config files in `[datadir.paths=
]` section via `cache_dirs =3D ['/some/location', '/other/location']`. The =
simplest way is to put this to `~/.config/avocado/avocado.conf` (or to `$VI=
RTUAL_ENV/.config/avocado/avocado.conf` in case you use virtual env).

The default is `data_dir/cache` (therefor usually `~/avocado/cache`) and wh=
en it's not specified in the custom cache_dirs it is appended to the list o=
f available cache_dirs. When writing assets we go through the cache_dirs at=
tempting to write them to the first RW location proceeding to the next one.

> From the doc, get_cache_dirs() "Returns the list of cache dirs, according=
 to configuration and convention" but doesn't explain how to configure it:
> https://avocado-framework.readthedocs.io/en/75.1/api/core/avocado.core.ht=
ml#avocado.core.data_dir.get_cache_dirs
>=20

PRs are welcome.

> I searched if there was an Avocado command displaying cache use, and to e=
ventually flush it, like ccache --cleanup/--clear options, but couldn't fin=
d any, so I ended calling a rmdir ~/avocado, which I know it is not correct=
, but saved me some headaches.
>=20

I'm not aware of any such option, we only support asset expiration and IIRC=
 it only replaces the file on use. Willian do you know if there are any pla=
ns for this? Can it be included to the asset handler?

> Is there a clean way to do this?
>=20
> I see the clean_tmp_files() function, but no equivalent for the cache:
> https://avocado-framework.readthedocs.io/en/75.1/api/core/avocado.core.ht=
ml#avocado.core.data_dir.clean_tmp_files
>=20
> Bonus question, can I set a size limit for the cache directory?
>=20

The same here, shouldn't be hard to add to the asset handler or at least co=
ntrib script. (again, PRs welcome)

> Thanks,
>=20
> Phil.
>=20

Regards,
Luk=C3=A1=C5=A1


--2vu3LuFoU6GzmperhSmeCTn7dr2c7h7jc--

--Sw2R6TEXUlSr6XZqqAjBPdPWzweM5HHV5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl4n7ZkACgkQJrNi5H/P
IsEhWAf/SHG4r/IfGGcszJQn9rZQZJlZyB334giELXsVjvMu8zEGKQkV6jeNcQc1
JhhangeHdD953Eknz2DTBNuFH2DsIPIjDVHfB1wv9PVLKPOjXbsULnt1umAEb2Sb
b4PkftsXX8xM9qBU15Ud32wotFJFw1H5qWWHOfM7oUuB+7ZrQlWEsl+k64Mc3N1a
ZP3Xkqpga/f4tHvxT7BPLRV8QXcrNkmDrgjq4VnixwHwLXQqW3+EPx8ZjmmDUu6h
XdjPJjVJ49CumOraGoIm0BAPgjwlpsbqK9R7A/e+W5ojOwceIzZC4a8RgKxhUCnY
lVCmlT31ubmUtv9hjdRMLqda/GO5cA==
=x7fN
-----END PGP SIGNATURE-----

--Sw2R6TEXUlSr6XZqqAjBPdPWzweM5HHV5--


