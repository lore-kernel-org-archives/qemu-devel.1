Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E68CC433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54CCD20775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 15:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSvIlzsX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CCD20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrYq-0004Df-Gc
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 11:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ldoktor@redhat.com>)
 id 1kDrY4-0003j4-H7
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:53:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ldoktor@redhat.com>)
 id 1kDrY2-00052S-K3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 11:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599148393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ta5GW8FhVye+XG5KwaYDXmCUYylOGeSWk3wt3hG3r0E=;
 b=dSvIlzsXozV5v+h8aVzqSHKq96p1GlGsrhvUn8/5SGuIbafEHjaF6l3OcfsBxfz2cNKpPS
 uMtunoSr940EIX8XYS1ZPY3s70iu9ecB2pfc947jelpnCEds3YBiv4v6Qr7vFQFLL9RQ2D
 R6kWtLjqEJPz1Qh1LsZ4zEL6Gg4yGBk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-OPZAHBh4OTq-z7kRriiNtg-1; Thu, 03 Sep 2020 11:52:04 -0400
X-MC-Unique: OPZAHBh4OTq-z7kRriiNtg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A4B180733D;
 Thu,  3 Sep 2020 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B78BB10013D7;
 Thu,  3 Sep 2020 15:51:57 +0000 (UTC)
Subject: Re: [PATCH] qemu-iotests: move check-block back to Makefiles
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200902080046.10412-1-pbonzini@redhat.com>
 <20200902081933.GE403297@redhat.com>
 <579e9d08-6235-0cdc-bbf6-07f2fc489426@redhat.com>
 <4ec5c197-3ff9-da88-9dac-c0e85042f586@redhat.com>
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
Message-ID: <b1e1df88-328f-bafe-3f42-8a2ac5511b2a@redhat.com>
Date: Thu, 3 Sep 2020 17:51:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <4ec5c197-3ff9-da88-9dac-c0e85042f586@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ldoktor@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KMn2xudKhaX83e4kNejjvpz0OnBJvykKQ"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ldoktor@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 04:23:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.403, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Wainer Moschetta <wainersm@redhat.com>, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KMn2xudKhaX83e4kNejjvpz0OnBJvykKQ
Content-Type: multipart/mixed; boundary="o8VZucffUUztkYtEptEL8x663My0sJmqF"

--o8VZucffUUztkYtEptEL8x663My0sJmqF
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dne 02. 09. 20 v 12:21 Thomas Huth napsal(a):
> On 02/09/2020 10.37, Paolo Bonzini wrote:
>> On 02/09/20 10:19, Daniel P. Berrang=C3=A9 wrote:
>>> On Wed, Sep 02, 2020 at 04:00:46AM -0400, Paolo Bonzini wrote:
>>>> check-block has its own test harness, unlike every other test.  If
>>>> we capture its output, as is in general nicer to do without V=3D1,
>>>> there will be no sign of progress.  So for lack of a better option
>>>> just move the invocation of the test back to Makefile rules.
>>>
>>> I expect the correct long term solution here is to stop using the
>>> check-block.sh script.  Instead have code which sets up each
>>> of the I/O tests as an explicit test target in meson. We could
>>> use meson's test grouping features too.
>>
>> I'm not sure, "check-acceptance" will never be integrated in Meson, and
>> it may well be the same for "check-block".  Actually I wonder if Avocado
>> would be a better check-block.sh than check-block.sh.
>=20
> Wasn't there even some support for the iotests in avocado (or
> avocado-vt) at one point in time? ... not sure anymore, Cleber, Wainer,
> do you remember?
>=20
>  Thomas
>=20

Avocado supports so called "external runner", which allows to specify a com=
mand to be executed and arguments as different variants so it was just a ma=
tter of coming up with the list of "./check" invocation like "./check -qcow=
2 -nbd 001". All of these were executed as a separate test and reported PAS=
S/FAIL. Actually I created a wrapper, which also checked the output of the =
"./check" and allowed the test to result in "WARN" which I then used for re=
porting skipped tests.

Cleber, is there a better way of running qemu-iotests? I know Drew had a pl=
an on adding kvm-unit-test runner which would support kvm-unit-tests out of=
 the box including the proper setup, but I'm not aware of any such initiati=
ve for qemu-iotests.

Regards,
Luk=C3=A1=C5=A1

PS: Now I remembered that I actually contributed the kvm-unit-test wrapper =
upstream, it's slightly outdated compare to the downstream version but coul=
d work as an example (if you're interested I can try to synchronize it with=
 the current downstream implementation): https://github.com/avocado-framewo=
rk/avocado/blob/master/contrib/testsuites/run-kvm-unit-test.sh


--o8VZucffUUztkYtEptEL8x663My0sJmqF--

--KMn2xudKhaX83e4kNejjvpz0OnBJvykKQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEpApMRcQDTeAqWtSDJrNi5H/PIsEFAl9RERwACgkQJrNi5H/P
IsE8EAgAykXpdG2AfrMKqkS/O4ga7l6U9IxAptki76oNHfY/elgAGgHLnmTgzk3l
BYYdKNDeojfJjpaR+gNQt6/U1vfmlBMpupQKK9BQ0sroOoKkuonWtbiTHSBRoyPp
obPiWgrlCjOl5CDiwsQUYsRgMTD3A6/A9v56oBJSCHVjEp4lxFFWuDQ5lPwV7pE1
TpFLbHXgBOO7nBkrt46PNBO2upbHZDYDDN7cIJdZjxb4AXMGK3JJMMxAN00ZFVrU
+0RNj97PlLAHszJ4jvIhpThnq/sQUYTaxJFdpjsGs1JYeR9LUejOQohCLeHC5f1V
2W0e16gkNv46/EBCoIyzXJYxXOlgZg==
=9C1C
-----END PGP SIGNATURE-----

--KMn2xudKhaX83e4kNejjvpz0OnBJvykKQ--


