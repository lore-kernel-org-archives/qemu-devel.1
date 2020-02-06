Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F83C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71992217BA
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8UT8KSI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71992217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izk22-0008HC-MW
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ldoktor@redhat.com>) id 1izk0x-00079L-Im
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:28:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ldoktor@redhat.com>) id 1izk0u-0008RO-Hg
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:28:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32603
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1izk0u-0008Kx-CD
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:28:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581006502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=tkbuGjhSH1lCCeDdb2vqnsbBCBn1E640r1f3kBN2Xw8=;
 b=C8UT8KSI0sqBkXlhEJ0VpE/KYw6yQomFctM46cLB/HeX9izyOuPuRnvpxhJZmnlGG2jUsy
 jJtT3TojKgcGv0dztRV0Rub0dd4vcTaxCw789k0fpJqBHd014eYfaxIqnpIFqw+Em39x05
 YoXSDFjrrXaOnk0mlMToMxrEnmitZzg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-yEkkv_eJPBSEcFnEWA2Hsw-1; Thu, 06 Feb 2020 11:28:04 -0500
X-MC-Unique: yEkkv_eJPBSEcFnEWA2Hsw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C87221098113;
 Thu,  6 Feb 2020 16:28:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-204-27.brq.redhat.com
 [10.40.204.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4B87361071;
 Thu,  6 Feb 2020 16:27:49 +0000 (UTC)
Subject: Re: [PATCH] tests/qemu_iotests: Minimize usage of used ports
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200203075955.28861-1-ldoktor@redhat.com>
 <fe6a7eb5-352a-3cb5-4e75-bd99baf6d54e@redhat.com>
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
Message-ID: <595ffedf-4213-f000-96e1-3216e272b1c1@redhat.com>
Date: Thu, 6 Feb 2020 17:27:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <fe6a7eb5-352a-3cb5-4e75-bd99baf6d54e@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KtDfugBGTBUuNT5QGHIrazfrUvYIgLhk7"
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
Cc: kwolf@redhat.com, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KtDfugBGTBUuNT5QGHIrazfrUvYIgLhk7
Content-Type: multipart/mixed; boundary="PVB6VEQwcLbIr6DmDcWf4cyYgNIyjUje2"

--PVB6VEQwcLbIr6DmDcWf4cyYgNIyjUje2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 06. 02. 20 v 16:03 Max Reitz napsal(a):
> On 03.02.20 08:59, Luk=C3=A1=C5=A1 Doktor wrote:
>> Using a range of ports from 32768 to 65538 is dangerous as some
>> application might already be listening there and interfere with the
>> testing. There is no way to reserve ports, but let's decrease the chance
>> of interactions by only using ports that were free at the time of
>> importing this module.
>>
>> Without this patch CI occasionally fails with used ports. Additionally I
>> tried listening on the first port to be tried via "nc -l localhost
>> $port" and no matter how many other ports were available it always
>> hanged for infinity.
>=20
> I=E2=80=99m afraid I don=E2=80=99t quite understand.  The new functions c=
heck whether
> the ports are available for use by creating a server on them (i.e.,
> binding a socket there).  The current code just lets qemu create a
> server there, and see if that works or not.
>=20
> So the only difference I can see is that instead of trying out random
> ports during the test and see whether they=E2=80=99re free to use we do t=
his
> check only once when the test is started.
>=20
> And the only problem I can imagine from your description is that there
> is some other tool on the system that tries to set up a server but
> cannot because we already have an NBD server there (by accident).
>=20
> But I don=E2=80=99t see how checking for free ports once at startup solve=
s that
> problem reliably.
>=20
> If what I guessed above is right, the only reliable solution I can
> imagine would be to allow users to specify the port range through
> environment variables, and then you=E2=80=99d have to specify a range tha=
t you
> know is free for use.
>=20
> Max
>=20

Hello Max,

thank you and I am sorry for not digging deep enough. This week my CI faile=
d with:

01:24:06 DEBUG| [stdout] +ERROR: test_inet (__main__.QemuNBD)
01:24:06 DEBUG| [stdout] +-------------------------------------------------=
---------------------
01:24:06 DEBUG| [stdout] +Traceback (most recent call last):
01:24:06 DEBUG| [stdout] +  File "147", line 85, in setUp
01:24:06 DEBUG| [stdout] +    self.vm.launch()
01:24:06 DEBUG| [stdout] +  File "/home/jenkins/ppc64le/qemu-master/tests/q=
emu-iotests/../../python/qemu/machine.py", line 302, in launch
01:24:06 DEBUG| [stdout] +    self._launch()
01:24:06 DEBUG| [stdout] +  File "/home/jenkins/ppc64le/qemu-master/tests/q=
emu-iotests/../../python/qemu/machine.py", line 319, in _launch
01:24:06 DEBUG| [stdout] +    self._pre_launch()
01:24:06 DEBUG| [stdout] +  File "/home/jenkins/ppc64le/qemu-master/tests/q=
emu-iotests/../../python/qemu/qtest.py", line 106, in _pre_launch
01:24:06 DEBUG| [stdout] +    super(QEMUQtestMachine, self)._pre_launch()
01:24:06 DEBUG| [stdout] +  File "/home/jenkins/ppc64le/qemu-master/tests/q=
emu-iotests/../../python/qemu/machine.py", line 270, in _pre_launch
01:24:06 DEBUG| [stdout] +    self._qmp =3D qmp.QEMUMonitorProtocol(self._v=
m_monitor, server=3DTrue)
01:24:06 DEBUG| [stdout] +  File "/home/jenkins/ppc64le/qemu-master/tests/q=
emu-iotests/../../python/qemu/qmp.py", line 60, in __init__
01:24:06 DEBUG| [stdout] +    self.__sock.bind(self.__address)
01:24:06 DEBUG| [stdout] +OSError: [Errno 98] Address already in use

I made the mistake of reproducing this on my home system using the qemu rev=
ision that I had and assuming it's caused by a used port. So I limited the =
port range and used nc to occupy the port. It sort-of reproduced but instea=
d of Address already in use it hanged until I kill the nc process. Then it =
failed with:

+Traceback (most recent call last):
+  File "147", line 124, in test_inet
+    flatten_sock_addr(address))
+  File "147", line 59, in client_test
+    self.assert_qmp(result, 'return', {})
+  File "/home/medic/Work/Projekty/qemu/tests/qemu-iotests/iotests.py", lin=
e 821, in assert_qmp
+    result =3D self.dictpath(d, path)
+  File "/home/medic/Work/Projekty/qemu/tests/qemu-iotests/iotests.py", lin=
e 797, in dictpath
+    self.fail('failed path traversal for "%s" in "%s"' % (path, str(d)))
+AssertionError: failed path traversal for "return" in "{'error': {'class':=
 'GenericError', 'desc': 'Failed to read initial magic: Unexpected end-of-f=
ile before all bytes were read'}}"

After a brief study I thought qemu is not doing the job well enough and wan=
ted to add a protection. Anyway after a more thorough overview I came to a =
different conclusion and that is that we are facing the same issue as with =
incoming migration about a year ago. What happened is that I started "nc -l=
 localhost 32789" which results in:

COMMAND   PID  USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
nc      26758 medic    3u  IPv6 9579487      0t0  TCP localhost:32789 (LIST=
EN)

Then we start the server by "_try_server_up" where qemu-nbd detects the por=
t is occupied on IPv6 but available on IPv4, so it claims it:
COMMAND   PID  USER   FD   TYPE  DEVICE SIZE/OFF NODE NAME
nc        26758 medic    3u  IPv6 9579487      0t0  TCP localhost:32789 (LI=
STEN)
qemu-nbd  26927 medic    4u  IPv4 9591857      0t0  TCP localhost:32789 (LI=
STEN)

and reports success. Then we try to connect but the hotplugged VM first att=
empts to connect on the IPv6 address and hangs for infinity.

Now is this an expected behavior? If so then we need the find_free_address =
(but preferably directly in _try_server_up just before starting the qemu-nb=
d) to leave as little time-frame for collision as possible. Otherwise the t=
est is alright and qemu-nbd needs a fix to bail out in case some address is=
 already used (IIRC this is what incoming migration does).


My second mistake was testing this on the old code-base and rebasing it onl=
y before sending the patch (without testing after the rebase). If I were to=
 test it first, I would have found out that the real reproducer is simply r=
unning the test as the commit 8dff69b9415b4287e900358744b732195e1ab2e2 brok=
e it.


So basically there are 2 actions:

1. fix the test as on my system it fails in 100% of cases, bisect says the =
first bad commit is 8dff69b9415b4287e900358744b732195e1ab2e2. Would anyone =
have time in digging into this? I already spent way too much time on this a=
nd don't really know what that commit is trying to do.
2. decide on the behavior when IPv4/6 is already in use (bail-out or start)=
.
2a. In case it should bail-out than the test is correct and there is no nee=
d for my patch. On the other hand qemu-nbd has to be fixed
2b. Otherwise I can send a v2 that will check the port in the _try_server_u=
p just before starting qemu-nbd to minimize the risk of using a utilized po=
rt (or should you decide it's not worth checking, I can simply forget about=
 this)

Regards,
Luk=C3=A1=C5=A1


--PVB6VEQwcLbIr6DmDcWf4cyYgNIyjUje2--

--KtDfugBGTBUuNT5QGHIrazfrUvYIgLhk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl48PoQACgkQJrNi5H/P
IsGWJAgAr7MmZEyDm6sv2zdFhX+6ovJcGJLZc7qZnFp/PvZd7a8T9latTHd/L9tV
72ChiM92qRbEZy72PZXNqaP1c7IWCgDmRHH6GJeIyOINcLZHXlJ8T/rBL8K6KHjU
LeURZVJDDMsxJUhCy6nnQaq0LVAI6vu8QoDlIw0x6cqgD0HFPNbexnu1vA36kCB+
e9AOm9MxcuCsdrOHahLYoor2nc07BfLw36Ow5H/OszQGupiwH6ZwykfbLAZKqCCh
OYngj0p/Vsp4HqAd1LmvckaOEUHxRSL3osNMf0zxXnHfT/m2p9zJwaDH2Yi+jH0G
6kkc/tl9GHAMO47qw+3PCV7vWCO7RA==
=KVIU
-----END PGP SIGNATURE-----

--KtDfugBGTBUuNT5QGHIrazfrUvYIgLhk7--


