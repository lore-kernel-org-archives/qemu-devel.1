Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC56C4CED1
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:53:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A83DD205C9
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A83DD205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGO1d-0003yj-Q7
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 09:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49986)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iGNyk-00031K-Gh
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:50:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iGNyj-0005bc-4x
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:50:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60410)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iGNya-0005Ua-BE; Fri, 04 Oct 2019 09:50:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 52AC83082128;
 Fri,  4 Oct 2019 13:50:31 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-31.brq.redhat.com
 [10.40.204.31])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 98296601A3;
 Fri,  4 Oct 2019 13:50:27 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
 <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
 <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
 <20191002164438.GD5819@localhost.localdomain>
 <a7f532cc-68cb-175e-6c8f-930401221ef9@redhat.com>
 <20191004101952.GC5491@linux.fritz.box>
 <d194e22c-7125-e558-0a80-131a28a87419@redhat.com>
 <CAFEAcA-4-ttpQ5S-HuEtv86TeNjBnFzp77D5ML1D9CZMYGR5Ow@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <2873f340-cac2-c168-d46a-e22c0571e83d@redhat.com>
Date: Fri, 4 Oct 2019 15:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-4-ttpQ5S-HuEtv86TeNjBnFzp77D5ML1D9CZMYGR5Ow@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lqp1x7wZecpSgFdXThQOtzwtwTPruFLsl"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 04 Oct 2019 13:50:31 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lqp1x7wZecpSgFdXThQOtzwtwTPruFLsl
Content-Type: multipart/mixed; boundary="08dx4IjA7VKv8eKtgzagf2WvAgh7bc2KZ"

--08dx4IjA7VKv8eKtgzagf2WvAgh7bc2KZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 04.10.19 15:16, Peter Maydell wrote:
> On Fri, 4 Oct 2019 at 13:45, Max Reitz <mreitz@redhat.com> wrote:
>>> In the end, I don't care what code these patches touched. I do an
>>> innocent git pull, and when I finally see that it's master that break=
s
>>> iotests and not my patches on top of it, I'm annoyed.
>>
>> Hm.  Part of my point was that this still happens all the time.
>>
>> Which is why I=E2=80=99d prefer more tests to run in CI than a handful=
 of not
>> very useful ones in make check.
>>
>> (Of course, running it in a CI won=E2=80=99t prevent iotest failures o=
n your
>> machine, but in practice neither does the current model.)
>=20
> If you want the tree to be defended against problems, then
> you need to run tests in 'make check'. Nothing else gets consistently
> run and has failures spotted either before code goes into the
> tree or quickly afterwards.

Yes, but part of the problem is that what does get run as part of make
check currently does not help much.

So this doesn=E2=80=99t really defend the iotests from problems.

> 'make check' does have the restriction
> that we don't want the tests to take too long to run, but in
> general the block layer should be running some reasonable subset
> of tests in the project's standard "run the tests please" command.
> (I have no opinion on exactly what that subset ought to be, beyond
> that it would be good if that subset doesn't have known intermittent
> failures in it.)

Deciding the subset is difficult.  My stance was that it=E2=80=99s better=
 to not
choose an arbitrary subset here but ensure that really everything gets
run as part of CI, that is asynchronously so it doesn=E2=80=99t block any=
one and
can take as long as it wants.

If we decide to get pull requests based on that, then that=E2=80=99d brin=
g even
more pain, but at least it=E2=80=99d be honest.  But just running half of=
 the
qcow2 tests to me seems only like we want to pretend we ran the iotests.
 So for me, iotests still break, and we need to deal with make check
failures on top.  I=E2=80=99d at least prefer one or the other.


I voted for dropping make check, because running all iotests doesn=E2=80=99=
t
seem feasible to me.

>> I still think that I personally would prefer the iotests to not run as=

>> part of make check, but just as CI.
>=20
> 'make check' *is* our CI gate, to a first approximation. Most of
> the various travis and other setups are simply a front-end for
> "build QEMU in various configurations and on various hosts
> and then run 'make check'". The travis setup at the moment is
> a bit odd, because it runs tests but it's not a gate on our
> merging changes. Ideally I would like to fix this so that
> rather than me personally running "make check" via a bunch
> of scripts we have one CI setup that we trust (gitlab seems
> the current favoured contender) and that gates changes flowing
> into master rather than me doing it manually. We might then turn
> travis off if it's not providing anything for us that the gitlab
> setup doesn't.

Hm, but make check also serves other purposes.  I would suppose e.g.
distributions generally require make check to pass when building packages=
=2E

I assumed our CI included more things than just make check, so we could
move the iotests from out of make check but keep them as part of CI.

Max


--08dx4IjA7VKv8eKtgzagf2WvAgh7bc2KZ--

--lqp1x7wZecpSgFdXThQOtzwtwTPruFLsl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2XTiIACgkQ9AfbAGHV
z0ArKQf/cYS0wd+kwKssD8I1fTXXw43yxhAJzkWbsZz19d2tBEtNgj96evtoCMd2
RZLn8+fkE4lI2lfv5JpkMcFWAvN7jfThVhVJPbOlJgjIxo5SmPonwkQQTXT7C14F
wcc7Deb8sF5B7hke/kc0TumsI+pB1LJ8MadKh/wF/wi6JA8EeyMrtHMEpWWyArN9
ZAhmcA1YCj32dZ8Pw6QWP6atllnKdcoUBEQQvkql4MtU+VMmbpCT/iNlEORGIfTJ
40qYqivPvxvxy4hV1qVYd/9Q9gmFK/bXqd8e6mlHiBSNNkd5uCE099+JgdlnCtEE
qj5EoOuKqbgF2IMj4IoyyM3WcfELLA==
=/61D
-----END PGP SIGNATURE-----

--lqp1x7wZecpSgFdXThQOtzwtwTPruFLsl--

