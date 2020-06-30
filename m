Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D77C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:59:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422A02085B
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcLYN+yU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422A02085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFqs-0005LH-GM
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldoktor@redhat.com>)
 id 1jqFq5-0004WW-6d
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:58:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37203)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ldoktor@redhat.com>)
 id 1jqFq2-00088f-S3
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593521893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ltgRFjUYOMEZFmcqriLDiWtu6C3YHHoqFwZIvPz3wm4=;
 b=DcLYN+yUeYqZIQK5coRbI/n2qsOg9KowGd7ohU5+wVlKbCFRHwhYB+qrLeT2WMVmtOjBAC
 6AE3zQi0ZDKTJMZ+E9leUqXzH0WsyFGhFIw7eB2I7U+Kw9zLp4R7f7+PythR0GlR8d7LpK
 E1T6cweuxyFcMm7/CMR7U6bPd725/N8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-B65g-yVYMfm98dztTKf7Hg-1; Tue, 30 Jun 2020 08:58:09 -0400
X-MC-Unique: B65g-yVYMfm98dztTKf7Hg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D100218B9FE2;
 Tue, 30 Jun 2020 12:58:07 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BF412855E;
 Tue, 30 Jun 2020 12:58:05 +0000 (UTC)
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
 <5ff8e75e-787e-a34d-2b3c-da63e2e46e1f@redhat.com>
 <CAHiYmc5MwdvUOOrErUmpXPiviekJnWBU-tp0wEFw0aW6_L6F4g@mail.gmail.com>
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
Message-ID: <eb9ea6f0-03e0-be98-dd01-dc49ad1e3e6c@redhat.com>
Date: Tue, 30 Jun 2020 14:58:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc5MwdvUOOrErUmpXPiviekJnWBU-tp0wEFw0aW6_L6F4g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ldoktor@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="W05CnVxxgAFr83SWLTAkR2DowqPvC7AyR"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ldoktor@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W05CnVxxgAFr83SWLTAkR2DowqPvC7AyR
Content-Type: multipart/mixed; boundary="QEEAqkAOg8UVMLrWD3xPHM1fiVH0nafCE"

--QEEAqkAOg8UVMLrWD3xPHM1fiVH0nafCE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 30. 06. 20 v 11:41 Aleksandar Markovic napsal(a):
> =D1=83=D1=82=D0=BE, 30. =D1=98=D1=83=D0=BD 2020. =D1=83 06:34 Luk=C3=A1=
=C5=A1 Doktor <ldoktor@redhat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=
=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>>
>> Dne 29. 06. 20 v 12:25 Ahmed Karaman napsal(a):
>>> Hi,
>>>
>>> The second report of the TCG Continuous Benchmarking series builds
>>> upon the QEMU performance metrics calculated in the previous report.
>>> This report presents a method to dissect the number of instructions
>>> executed by a QEMU invocation into three main phases:
>>> - Code Generation
>>> - JIT Execution
>>> - Helpers Execution
>>> It devises a Python script that automates this process.
>>>
>>> After that, the report presents an experiment for comparing the
>>> output of running the script on 17 different targets. Many conclusions
>>> can be drawn from the results and two of them are discussed in the
>>> analysis section.
>>>
>>> Report link:
>>> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU=
-Into-Three-Main-Parts/
>>>
>>> Previous reports:
>>> Report 1 - Measuring Basic Performance Metrics of QEMU:
>>> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
>>>
>>> Best regards,
>>> Ahmed Karaman
>>
>> Hello Ahmed,
>>
>> very nice reading, both reports so far. One thing that could be better d=
isplayed is the system you used this to generate. This would come handy esp=
ecially later when you move from examples to actual reports. I think it'd m=
ake sense to add a section with a clear definition of the machine as well a=
s the operation system, qemu version and eventually other deps (like compil=
er, flags, ...). For this report something like:
>>
>> architecture: x86_64
>> cpu_codename: Kaby Lake
>> cpu: i7-8650U
>> ram: 32GB DDR4
>> os: Fedora 32
>> qemu: 470dd165d152ff7ceac61c7b71c2b89220b3aad7
>> compiler: gcc-10.1.1-1.fc32.x86_64
>> flags: --target-list=3D"x86_64-softmmu,ppc64-softmmu,aarch64-softmmu,s39=
0x-softmmu,riscv64-softmmu" --disable-werror --disable-sparse --enable-sdl =
--enable-kvm  --enable-vhost-net --enable-vhost-net --enable-attr  --enable=
-kvm  --enable-fdt   --enable-vnc --enable-seccomp --block-drv-rw-whitelist=
=3D"vmdk,null-aio,quorum,null-co,blkverify,file,nbd,raw,blkdebug,host_devic=
e,qed,nbd,iscsi,gluster,rbd,qcow2,throttle,copy-on-read" --python=3D/usr/bi=
n/python3 --enable-linux-io-uring
>>
>> would do. Maybe it'd be even a good idea to create a script to report th=
is basic set of information and add it after each of the perf scripts so pe=
ople don't forget to double-check the conditions, but others might disagree=
 so take this only as a suggestion.
>>
>=20
> I just want to follow up on this observation here, and not related to
> Ahmed's report at all.
>=20
> We often receive bug reports of the following style: "I have Debian
> 10.2 system and mips emulation misbehaves". As you may imagine, I
> assign the bug to myself, install Debian 10.2 system on my
> experimental box, and mips emulation works like charm.
> <banging-head-against-the-wall-emoji> Obviously, I need more info on
> the submitter's system.
>=20
> After all these years, we don't have (or at least I don't know about
> it) a script that we could give the submitter, that picks up various
> aspects of his system. This script, since it is not "for presentation"
> could be even far more aggressive in picking ups system information
> that what Lukas mentioned above. It could collect the output of
> various relevant commands, and yip it in a single file. We should have
> "get_system_info.py" in our scripts directory!
>=20
> Sincerely,
> Aleksandar
>=20

Well this itself is a very complicated matter that could deserve a GSoC pro=
ject. It's hard to balance the utils required to obtain the knowledge. I'm =
fond of sosreport, that is heavily used by RH but the result is quite big. =
Slightly smaller set can be generated via ansible, which itself gathers a l=
ot of useful information. If we are to speak only about minimal approach es=
pecially tailored to qemu, than I'd suggest taking a look at `avocado.utils=
` especially `avocado.utils.cpu` as Avocado is already used for qemu testin=
g.

Anyway don't consider this as a complete list, I just wanted to demonstrate=
 how difficult and complex this subject is.

Regards,
Luk=C3=A1=C5=A1

>=20
>> Regards,
>> Luk=C3=A1=C5=A1
>>
>> PS: Automated cpu codenames, hosts OSes and such could be tricky, but on=
e can use other libraries or just best-effort-approach with fallback to "un=
known" to let people filling it manually or adding their branch to your scr=
ipt.
>>
>> Regards,
>> Luk=C3=A1=C5=A1
>>
>=20



--QEEAqkAOg8UVMLrWD3xPHM1fiVH0nafCE--

--W05CnVxxgAFr83SWLTAkR2DowqPvC7AyR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl77Nt0ACgkQJrNi5H/P
IsG8qAf9GY218PcZZ8Wz4Xd3BH8LaaRRJ0360BjD87gBEQfSMcKJQhP4W1fOXDrs
1tJu6dqTA4BekFxEJY4SaSXi7w4/0IsJbP76NSzKQvurzScuq6CmL4pg/HAsTTCE
AYq65SGsrxLF/MQlqUJSiilqnrwmFJ23A35TaeMmb6OHpfstkMq2Yl8s/+1DU5o9
y8ewf1ZGvDGl3WJy9HUbhhFZAoY+cs38i99+AvG4hGyotfkSSdi+Ya3bOE5E40Uz
2TL9MoaD1tCW5my3PJn38OCBZ/GAqgfhxuXRaFX9ZtUYADKVgW7yPqZWd8woAMHY
wJsjzNzTErRoX6Sas46YIahJZvSFlQ==
=CqOO
-----END PGP SIGNATURE-----

--W05CnVxxgAFr83SWLTAkR2DowqPvC7AyR--


