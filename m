Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC52C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F31712067B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 21:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F31712067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9yIC-0005RK-06
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 17:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58748)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i9yHJ-0004nx-N6
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:11:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i9yHI-0007lX-7B
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 17:11:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44280)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i9yHB-0007gs-Na; Mon, 16 Sep 2019 17:11:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5BC7E315C02B;
 Mon, 16 Sep 2019 21:11:11 +0000 (UTC)
Received: from [10.3.116.234] (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3C065C1D6;
 Mon, 16 Sep 2019 21:11:10 +0000 (UTC)
To: Sergio Lopez <slp@redhat.com>
References: <20190911161521.59261-1-slp@redhat.com>
 <d47f7e67-2f6a-0dd6-3ab5-93626bfbb02d@redhat.com>
 <6755b34b-b412-9e63-8d25-b7662d0d3860@redhat.com> <871rwmxbo9.fsf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
 xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
 xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
 TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
 GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
 sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
 AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
 CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
 RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
 wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
 Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
 gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
 pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
 zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
 pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
 3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
 NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
 cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
 SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
 I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
 mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
 Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
 2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <325511bf-7b31-4a07-bf91-6a2824c87acc@redhat.com>
Date: Mon, 16 Sep 2019 16:11:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <871rwmxbo9.fsf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iG0RfrkmfhWzcNg0I4N4zbMaBIGLeRpu4"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Mon, 16 Sep 2019 21:11:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] nbd/server: attach client channel to the
 export's AioContext
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iG0RfrkmfhWzcNg0I4N4zbMaBIGLeRpu4
Content-Type: multipart/mixed; boundary="rU7sisvKaxKItYpmj0gx3flomLvF32Cz0";
 protected-headers="v1"
From: Eric Blake <eblake@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-block@nongnu.org, kwolf@redhat.com, qemu-devel@nongnu.org
Message-ID: <325511bf-7b31-4a07-bf91-6a2824c87acc@redhat.com>
Subject: Re: [PATCH] nbd/server: attach client channel to the export's
 AioContext
References: <20190911161521.59261-1-slp@redhat.com>
 <d47f7e67-2f6a-0dd6-3ab5-93626bfbb02d@redhat.com>
 <6755b34b-b412-9e63-8d25-b7662d0d3860@redhat.com> <871rwmxbo9.fsf@redhat.com>
In-Reply-To: <871rwmxbo9.fsf@redhat.com>

--rU7sisvKaxKItYpmj0gx3flomLvF32Cz0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/12/19 1:37 AM, Sergio Lopez wrote:

>> I tried to test this patch, but even with it applied, I still got an
>> aio-context crasher by attempting an nbd-server-start, nbd-server-add,=

>> nbd-server-stop (intentionally skipping the nbd-server-remove step) on=
 a
>> domain using iothreads, with a backtrace of:
>>
>> #0  0x00007ff09d070e35 in raise () from target:/lib64/libc.so.6
>> #1  0x00007ff09d05b895 in abort () from target:/lib64/libc.so.6
>> #2  0x000055dd03b9ab86 in error_exit (err=3D1, msg=3D0x55dd03d59fb0
>> <__func__.15769> "qemu_mutex_unlock_impl")
>>     at util/qemu-thread-posix.c:36
>> #3  0x000055dd03b9adcf in qemu_mutex_unlock_impl (mutex=3D0x55dd062d50=
90,
>> file=3D0x55dd03d59041 "util/async.c",
>>     line=3D523) at util/qemu-thread-posix.c:96
>> #4  0x000055dd03b93433 in aio_context_release (ctx=3D0x55dd062d5030) a=
t
>> util/async.c:523

>> #14 0x000055dd03748845 in qmp_nbd_server_stop (errp=3D0x7ffcdf3cb4e8) =
at
>> blockdev-nbd.c:233
>> ...

Sorry for truncating the initial stackdump report. The rest of the trace
(it is definitely in the main loop):

#15 0x0000560be491c910 in qmp_marshal_nbd_server_stop
(args=3D0x560be54c4d00, ret=3D0x7ffdd832de38,
    errp=3D0x7ffdd832de30) at qapi/qapi-commands-block.c:318
#16 0x0000560be4a7a306 in do_qmp_dispatch (cmds=3D0x560be50dc1f0
<qmp_commands>, request=3D0x7fbcac009af0,
    allow_oob=3Dfalse, errp=3D0x7ffdd832ded8) at qapi/qmp-dispatch.c:131
#17 0x0000560be4a7a507 in qmp_dispatch (cmds=3D0x560be50dc1f0
<qmp_commands>, request=3D0x7fbcac009af0,
    allow_oob=3Dfalse) at qapi/qmp-dispatch.c:174
#18 0x0000560be48edd81 in monitor_qmp_dispatch (mon=3D0x560be55d6670,
req=3D0x7fbcac009af0) at monitor/qmp.c:120
#19 0x0000560be48ee116 in monitor_qmp_bh_dispatcher (data=3D0x0) at
monitor/qmp.c:209
#20 0x0000560be4ad16a2 in aio_bh_call (bh=3D0x560be53dbe90) at util/async=
=2Ec:89
#21 0x0000560be4ad173a in aio_bh_poll (ctx=3D0x560be53daba0) at
util/async.c:117
#22 0x0000560be4ad6514 in aio_dispatch (ctx=3D0x560be53daba0) at
util/aio-posix.c:459
#23 0x0000560be4ad1ad3 in aio_ctx_dispatch (source=3D0x560be53daba0,
callback=3D0x0, user_data=3D0x0) at util/async.c:260
#24 0x00007fbcd7083ecd in g_main_context_dispatch () from
target:/lib64/libglib-2.0.so.0
#25 0x0000560be4ad4e47 in glib_pollfds_poll () at util/main-loop.c:218
#26 0x0000560be4ad4ec1 in os_host_main_loop_wait (timeout=3D1000000000) a=
t
util/main-loop.c:241
#27 0x0000560be4ad4fc6 in main_loop_wait (nonblocking=3D0) at
util/main-loop.c:517
--Type <RET> for more, q to quit, c to continue without paging--
#28 0x0000560be4691266 in main_loop () at vl.c:1806
#29 0x0000560be46988a9 in main (argc=3D112, argv=3D0x7ffdd832e4e8,
envp=3D0x7ffdd832e870) at vl.c:4488


>>
>> Does that sound familiar to what you were seeing?  Does it mean we
>> missed another spot where the context is set incorrectly?
>=20
> It looks like it was trying to release the AioContext while it was stil=
l
> held by some other thread. Is this stacktrace from the main thread or a=
n
> iothread? What was the other one doing?

Kevin had some ideas on what it might be; I'm playing with obtaining the
context in the spots he pointed out.

>=20
>> I'm happy to work with you on IRC for more real-time debugging of this=

>> (I'm woefully behind on understanding how aio contexts are supposed to=

>> work).
>=20
> I must be missing some step, because I can't reproduce this one
> here. I've tried both with an idle NDB server and one with a client
> generating I/O. Is it reproducible 100% of them time?

Yes, with iothreads.  I took some time today to boil it down to
something that does not require libvirt:

$ file myfile
myfile: QEMU QCOW2 Image (v3), 104857600 bytes
$ qemu-img create -f qcow2 -o backing_file=3Dmyfile,backing_fmt=3Dqcow2  =
\
 myfile.wrap
Formatting 'myfile.wrap', fmt=3Dqcow2 size=3D104857600 backing_file=3Dmyf=
ile
backing_fmt=3Dqcow2 cluster_size=3D65536 lazy_refcounts=3Doff refcount_bi=
ts=3D16
$ ./x86_64-softmmu/qemu-system-x86_64 -nodefaults \
  -name tmp,debug-threads=3Don -machine pc-q35-3.1,accel=3Dkvm \
  -object iothread,id=3Diothread1 \
  -drive
file=3Dmyfile,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk0,node-name=3D=
n \
  -device
virtio-blk-pci,iothread=3Diothread1,drive=3Ddrive-virtio-disk0,id=3Dvirti=
o-disk0 \
  -qmp stdio -nographic
{'execute':'qmp_capabilities'}
{'execute':'nbd-server-start','arguments':{'addr':{'type':'inet',
  'data':{'host':'localhost','port':'10809'}}}}
{'execute':'blockdev-add','arguments':{'driver':'qcow2',
 'node-name':'t','file'{'driver':'file',
  'filename':'myfile.wrap'},'backing':'n'}}
{'execute':'blockdev-backup','arguments':{'device':'n',
 'target':'t','sync':'none','job-id':'b'}}
{'execute':'nbd-server-add','arguments':{'device':'t','name':'t'}}
{'execute':'nbd-server-remove','arguments':{'name':'t'}}
Aborted (core dumped)

I'm now playing with Kevin's ideas of grabbing the aiocontext around nbd
unref.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--rU7sisvKaxKItYpmj0gx3flomLvF32Cz0--

--iG0RfrkmfhWzcNg0I4N4zbMaBIGLeRpu4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAl1/+m0ACgkQp6FrSiUn
Q2oALQf/djcdFoOv3ZXUckDBuuvq2B0QZVJ+uB1dgaIa8i29OiquXf4ld6tRHkfE
TqFgH1/eOSEgDO/T8DJAOxoUwIkmI0vlIhZDfRNgNRW9XECNmhF67skcRWFm1n9d
4upWBS3+o0fTR+qFEPORtH7JJ7W50IAGXaFg6mvnSFNZaSw0pDvG9+exAz7/u1YS
BguSK5X93Faz/dMOE/Rq5fAEv4KPsybiQ0BY48Bajwen+wu/LDVMxhbuGBeWqtmD
UiEIDVw3QlIShQZL+gJDBrZG5gqug2/jHcwekTgNpd+4UJJoS8Jt+6GIup4zmUL+
kdkWl4SfCfOQXgO3VCAejpkGcBlAwQ==
=RF/F
-----END PGP SIGNATURE-----

--iG0RfrkmfhWzcNg0I4N4zbMaBIGLeRpu4--

