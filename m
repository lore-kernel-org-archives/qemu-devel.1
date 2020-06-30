Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2D4C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D2C3206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 04:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eEuDIQo0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2C3206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq80e-0003A5-Mn
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 00:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldoktor@redhat.com>)
 id 1jq806-0002kp-7N
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 00:36:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ldoktor@redhat.com>)
 id 1jq802-00057k-DM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 00:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593491761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZwlDxeqkFZ1mLVVWxdC4a9hz7L/arw/qFk7Va1XzURg=;
 b=eEuDIQo0jR1X4I5N28qH+odIIlyVqsVJVSPyTochQla/6Ocd93QaH1Mg+Po44fJGL6reV1
 Bsij8asLhcgCKcmkrgb8OylDFd2q1YrY+WbG7jVeLg8Jhnm976pCkmVyenOpkRrbbxT0g9
 s/cQYoUX50f0CI2N6EupfgV7jzqzjkg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-RmJdQb1_PASlCW8_PYEQpA-1; Tue, 30 Jun 2020 00:33:56 -0400
X-MC-Unique: RmJdQb1_PASlCW8_PYEQpA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D970464;
 Tue, 30 Jun 2020 04:33:55 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B7D555F7D8;
 Tue, 30 Jun 2020 04:33:53 +0000 (UTC)
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#2] Dissecting
 QEMU Into Three Main Parts
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>
References: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
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
Message-ID: <5ff8e75e-787e-a34d-2b3c-da63e2e46e1f@redhat.com>
Date: Tue, 30 Jun 2020 06:33:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALTWKrVAW33jJs1Q+51wN07DDUbAqwo=o+WDCpoT=NFB6dNZ6A@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xVFpjeFfxSyYGVLp6HXVSAP3RHPnL348M"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ldoktor@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xVFpjeFfxSyYGVLp6HXVSAP3RHPnL348M
Content-Type: multipart/mixed; boundary="ABXMcNCdvaLyLuhTXRyOSRPVV92hNLEOu"

--ABXMcNCdvaLyLuhTXRyOSRPVV92hNLEOu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 29. 06. 20 v 12:25 Ahmed Karaman napsal(a):
> Hi,
>=20
> The second report of the TCG Continuous Benchmarking series builds
> upon the QEMU performance metrics calculated in the previous=C2=A0report.
> This report presents a method to dissect the number of instructions
> executed by a QEMU invocation into three main phases:
> - Code Generation
> - JIT Execution
> - Helpers Execution
> It devises a Python script that automates this process.
>=20
> After that, the report presents an experiment for comparing the
> output of running the script on 17 different targets. Many conclusions
> can be drawn from the results and two of them are discussed in the
> analysis section.
>=20
> Report link:
> https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Dissecting-QEMU-I=
nto-Three-Main-Parts/
>=20
> Previous reports:
> Report 1 - Measuring Basic Performance Metrics of QEMU:
> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
>=20
> Best regards,
> Ahmed Karaman

Hello Ahmed,

very nice reading, both reports so far. One thing that could be better disp=
layed is the system you used this to generate. This would come handy especi=
ally later when you move from examples to actual reports. I think it'd make=
 sense to add a section with a clear definition of the machine as well as t=
he operation system, qemu version and eventually other deps (like compiler,=
 flags, ...). For this report something like:

architecture: x86_64
cpu_codename: Kaby Lake
cpu: i7-8650U
ram: 32GB DDR4
os: Fedora 32
qemu: 470dd165d152ff7ceac61c7b71c2b89220b3aad7
compiler: gcc-10.1.1-1.fc32.x86_64
flags: --target-list=3D"x86_64-softmmu,ppc64-softmmu,aarch64-softmmu,s390x-=
softmmu,riscv64-softmmu" --disable-werror --disable-sparse --enable-sdl --e=
nable-kvm  --enable-vhost-net --enable-vhost-net --enable-attr  --enable-kv=
m  --enable-fdt   --enable-vnc --enable-seccomp --block-drv-rw-whitelist=3D=
"vmdk,null-aio,quorum,null-co,blkverify,file,nbd,raw,blkdebug,host_device,q=
ed,nbd,iscsi,gluster,rbd,qcow2,throttle,copy-on-read" --python=3D/usr/bin/p=
ython3 --enable-linux-io-uring

would do. Maybe it'd be even a good idea to create a script to report this =
basic set of information and add it after each of the perf scripts so peopl=
e don't forget to double-check the conditions, but others might disagree so=
 take this only as a suggestion.

Regards,
Luk=C3=A1=C5=A1

PS: Automated cpu codenames, hosts OSes and such could be tricky, but one c=
an use other libraries or just best-effort-approach with fallback to "unkno=
wn" to let people filling it manually or adding their branch to your script=
.

Regards,
Luk=C3=A1=C5=A1


--ABXMcNCdvaLyLuhTXRyOSRPVV92hNLEOu--

--xVFpjeFfxSyYGVLp6HXVSAP3RHPnL348M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl76wLAACgkQJrNi5H/P
IsFRYQgAgPqF1bB6s8MxylWioJFfFhKFWfdSkZW2lDpdYMcIlxiCzj49D3Gd7H7V
jzKta1wySF1whMECUe4fuZVKJX+Sy3VgCGgmJM2gXItc6jByb152ati9/D6CoHer
naojCp7ZyAGyG/ySJ4knrlJeoFRD4QKnHLax5Vfhr602Zpvc2o7pKOmLG5zHtNXE
Zsb6XYJb4DCqa2wHtdBhQOLpUdt7bnkTniaXwjcs++ZdtGVj4T9Ci20zDQ/tNwj/
FIiNmrri6PxRMNiYa3baeDddbJbVKURllBZC0p4p5aFJj6w9OgiGdv8ac34Treer
jcsl1uFGQp135dMOmMazgcv1VgDoDg==
=JBu5
-----END PGP SIGNATURE-----

--xVFpjeFfxSyYGVLp6HXVSAP3RHPnL348M--


