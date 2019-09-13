Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F004C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:50:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0548E20644
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:50:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0548E20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8k6H-00026r-4E
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i8k4n-0000nF-5r
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i8k4k-0005Pj-MW
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:49:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42584)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i8k4f-0005OD-AS; Fri, 13 Sep 2019 07:49:13 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A2CD8793C9;
 Fri, 13 Sep 2019 11:49:12 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-81.ams2.redhat.com
 [10.36.116.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA98210016EA;
 Fri, 13 Sep 2019 11:49:09 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190624173935.25747-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
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
Message-ID: <1bfddc02-54db-b0d7-d530-e55e5c372b30@redhat.com>
Date: Fri, 13 Sep 2019 13:49:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190624173935.25747-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eUR4qZoAlQJiOqOKx9UwXVMNLxChjmBAq"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 13 Sep 2019 11:49:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 00/14] block: Try to create well-typed
 json:{} filenames
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
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eUR4qZoAlQJiOqOKx9UwXVMNLxChjmBAq
Content-Type: multipart/mixed; boundary="gW5FX0VBDgZQYC6WloIUoHNDkTgVKAp0L";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <1bfddc02-54db-b0d7-d530-e55e5c372b30@redhat.com>
Subject: Re: [PATCH v4 00/14] block: Try to create well-typed json:{}
 filenames
References: <20190624173935.25747-1-mreitz@redhat.com>
In-Reply-To: <20190624173935.25747-1-mreitz@redhat.com>

--gW5FX0VBDgZQYC6WloIUoHNDkTgVKAp0L
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Another gentle ping.

Max


On 24.06.19 19:39, Max Reitz wrote:
> Hi,
>=20
> There are two explanations of this cover letter, a relative one (to v3)=

> and an absolute one.
>=20
>=20
> *** Important note ***
>=20
> The final patch in this series is an example that converts most of
> block-core.json to use default values where possible.  We may decide to=

> take it or not.  It isn=E2=80=99t important for the main purpose of thi=
s series,
> so I=E2=80=99d be very much fine with chopping it off.
>=20
> (It does have a nice diff stat, though.)
>=20
> *** Important note end ***
>=20
>=20
> Relative explanation:
>=20
> The actual functional goal of this series is to allow all blockdev
> options that can be represented with -drive to have an equivalent with
> -blockdev (safe for rbd=E2=80=99s =3Dkeyvalue-pairs).
>=20
> To this end, qcow(2)=E2=80=99s encryption needs an =E2=80=9Cauto=E2=80=9D=
 format which can
> automatically deduce the format from the image header.  To make things
> nicer, I decided (already in v1) to make this format optional so users
> could just specify encrypt.secret and let the format driver figure out
> the rest.
>=20
> Until v3, this was implemented by letting the discriminator of flat
> unions be optional, as long as a default-value is provided.  Markus
> (rightfully) complained that this is very specific and would be covered=

> by just having default values for QAPI struct members in general.
> So now this version implements this.  This is a bit more complicated
> than just implementing a default-variant, mainly because the latter onl=
y
> needs to accept enum values, whereas a generally usable =E2=80=9Cdefaul=
t=E2=80=9D should
> accept values of all QAPI types (to the extent what is reasonable).
>=20
> So what was (until v3)
>=20
>   { 'union': 'Foo',
>     'base': { '*discr': 'SomeEnum' },
>     'discriminator': 'discr',
>     'default-variant': 'value1',
>     'data': { 'value1': 'Bar', 'value2': 'Baz' } }
>=20
> becomes
>=20
>   { 'union': 'Foo',
>     'base': { '*discr': { 'type': 'SomeEnum', 'default': 'value1' } },
>     'discriminator': 'discr',
>     'data': { 'value1': 'Bar', 'value2': 'Baz' } }
>=20
>=20
>=20
> Absolute explanation:
>=20
> When qemu reports json:{} filename, it just uses whatever type you gave=

> an option in.  With -drive, all options are strings and they do not hav=
e
> to pass the test of the typing firewall of the QAPI schema, so you just=

> get strings thrown back at you even if that does not match the schema.
> (Also, if you use json:{} yourself, you=E2=80=99re free to give the opt=
ions as
> strings as well.)
>=20
> Example:
>=20
> $ ./qemu-img info --image-opts driver=3Draw,size=3D512,file.driver=3Dnu=
ll-co
> image: json:{"driver": "raw", "size": "512", "file": {"driver": "null-c=
o"}}
>=20
> @size is supposed to be an integer, according to the schema, so the
> correct result would be (which is what you get after this series):
>=20
> $ ./qemu-img info --image-opts driver=3Draw,size=3D512,file.driver=3Dnu=
ll-co
> image: json:{"driver": "raw", "size": 512, "file": {"driver": "null-co"=
}}
>=20
>=20
> This is achieved by patch 11, which makes bdrv_refresh_filename() run
> the options through the flat-confused input visitor, and then through
> the output visitor to get all to the correct type.  If anything fails,
> the result is as before (hence the =E2=80=9CTry=E2=80=9D in the title).=

>=20
> There are cases where this cannot work.  Those are the ones where -driv=
e
> accepts something that is not allowed by the QAPI schema.  One of these=

> cases is rbd=E2=80=99s =3Dkeyvalue-pairs, which is just broken altogeth=
er, so
> let=E2=80=99s simply ignore that.  (I don=E2=80=99t think anybody=E2=80=
=99s going to complain
> that the json:{} filename they get is not correctly typed after they=E2=
=80=99ve
> used that option.)
>=20
> The other case (I know of) is qcow(2)=E2=80=99s encryption.  In the QAP=
I schema,
> encrypt.format is not optional because it is the discriminator for whic=
h
> kind of options to use.  However, for -drive, it is optional because th=
e
> qcow2 driver can infer the encryption format from the image header.
>=20
> The solution that=E2=80=99s proposed by this series is to make flat uni=
on
> discriminators optional and provide a default.  This is accomplished by=

> generally allowing default values to be provided for QAPI struct
> members.
>=20
> Both AES and LUKS encryption allow only a key-secret option, so we can
> add a new pseudo-format =E2=80=9Cauto=E2=80=9D that accepts exactly tha=
t option and
> makes the qcow2 driver read the real format from the image header.  Thi=
s
> pseudo-format is made the default for encrypt.format, and thus you can
> then specify encrypt.key-secret without having to specify
> encrypt.format (while still adhering to the QAPI schema).
>=20
>=20
> So, in this series:
> - The QAPI code generator is modified to allow default values for
>   optional struct members.  This in turn allows flat union
>   discriminators be optional, too, but only if a default value is
>   provided.
>   - Accordingly, documentation, tests, and introspection are adjusted.
>=20
> - This is used to make qcow=E2=80=99s and qcow2=E2=80=99s encrypt.forma=
t parameter
>   optional.  It now defaults to =E2=80=9Cfrom-image=E2=80=9D which is a=
 new
>   pseudo-format that allows a key-secret to be given, and otherwise
>   leaves it to the format driver to determine the encryption format.
>=20
> - json:{} filenames are attempted to be typed correctly when they are
>   generated, by running bs->full_open_options through a healthy mix of
>   qdict_flatten(), the flat-confused input visitor for BlockdevOptions,=

>   and the output visitor.
>   This may not always work but I hope it usually will.  Fingers crossed=
=2E
>   (At least it won=E2=80=99t make things worse.)
>=20
> - Tests, tests, tests.
>=20
>=20
> (Yes, I know that =E2=80=9CIn this series tests, tests, tests.=E2=80=9D=
 is not a
>  sentence.)
>=20
>=20
> v4:
> - Drop the default-variant stuff and replace it by a more general
>   concept of allowing default values for all QAPI struct members
>=20
>=20
> git backport-diff against v3:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/14:[down] 'qapi: Parse numeric values'
> 002/14:[down] 'qapi: Move to_c_string() to common.py'
> 003/14:[down] 'qapi: Introduce default values for struct members'
> 004/14:[down] 'qapi: Allow optional discriminators'
> 005/14:[down] 'qapi: Document default values for struct members'
> 006/14:[down] 'test-qapi: Print struct members' default values'
> 007/14:[down] 'tests: Test QAPI default values for struct members'
> 008/14:[0044] [FC] 'tests: Add QAPI optional discriminator tests'
> 009/14:[0009] [FC] 'qapi: Formalize qcow2 encryption probing'
> 010/14:[0005] [FC] 'qapi: Formalize qcow encryption probing'
> 011/14:[0014] [FC] 'block: Try to create well typed json:{} filenames'
> 012/14:[----] [--] 'iotests: Test internal option typing'
> 013/14:[----] [--] 'iotests: qcow2's encrypt.format is now optional'
> 014/14:[down] 'block: Make use of QAPI defaults'
>=20
>=20
> Max Reitz (14):
>   qapi: Parse numeric values
>   qapi: Move to_c_string() to common.py
>   qapi: Introduce default values for struct members
>   qapi: Allow optional discriminators
>   qapi: Document default values for struct members
>   test-qapi: Print struct members' default values
>   tests: Test QAPI default values for struct members
>   tests: Add QAPI optional discriminator tests
>   qapi: Formalize qcow2 encryption probing
>   qapi: Formalize qcow encryption probing
>   block: Try to create well typed json:{} filenames
>   iotests: Test internal option typing
>   iotests: qcow2's encrypt.format is now optional
>   block: Make use of QAPI defaults
>=20
>  docs/devel/qapi-code-gen.txt                  |  81 +++++-
>  tests/Makefile.include                        |  17 +-
>  qapi/block-core.json                          | 180 +++++++++-----
>  qapi/introspect.json                          |   9 +-
>  tests/qapi-schema/bad-type-int.json           |   1 -
>  tests/qapi-schema/enum-int-member.json        |   1 -
>  ...l-discriminator-invalid-specification.json |  11 +
>  ...on-optional-discriminator-no-default.json} |   5 +-
>  tests/qapi-schema/qapi-schema-test.json       |  38 +++
>  .../struct-member-alternate-default.json      |  10 +
>  ...struct-member-bool-wrong-default-type.json |   3 +
>  .../struct-member-enum-invalid-default.json   |   4 +
>  ...struct-member-enum-wrong-default-type.json |   4 +
>  .../struct-member-float-invalid-default.json  |   4 +
>  ...truct-member-float-wrong-default-type.json |   3 +
>  .../struct-member-int-wrong-default-type.json |   3 +
>  .../struct-member-int8-erange-default.json    |   3 +
>  .../struct-member-list-nonempty-default.json  |   4 +
>  .../struct-member-non-optional-default.json   |   3 +
>  .../struct-member-null-default.json           |   6 +
>  .../struct-member-str-wrong-default-type.json |   3 +
>  .../struct-member-uint8-erange-default.json   |   3 +
>  .../struct-member-uint8-negative-default.json |   3 +
>  block.c                                       |  68 ++++-
>  block/file-posix.c                            |   9 -
>  block/file-win32.c                            |   8 +-
>  block/parallels.c                             |   6 +-
>  block/qcow2.c                                 |  39 +--
>  block/qed.c                                   |   3 -
>  block/sheepdog.c                              |   3 -
>  block/vdi.c                                   |   3 -
>  block/vhdx.c                                  |  28 +--
>  block/vpc.c                                   |   3 -
>  blockdev.c                                    | 182 +++-----------
>  monitor/hmp-cmds.c                            |  27 +-
>  monitor/qmp-cmds.c                            |   3 +-
>  scripts/qapi/commands.py                      |   2 +-
>  scripts/qapi/common.py                        | 232 ++++++++++++++++--=

>  scripts/qapi/doc.py                           |  20 +-
>  scripts/qapi/introspect.py                    |   8 +-
>  scripts/qapi/types.py                         |   2 +-
>  scripts/qapi/visit.py                         |  38 ++-
>  tests/qapi-schema/bad-type-int.err            |   2 +-
>  tests/qapi-schema/enum-int-member.err         |   2 +-
>  ...al-discriminator-invalid-specification.err |   1 +
>  ...-discriminator-invalid-specification.exit} |   0
>  ...l-discriminator-invalid-specification.out} |   0
>  ...nion-optional-discriminator-no-default.err |   1 +
>  ...ion-optional-discriminator-no-default.exit |   1 +
>  ...nion-optional-discriminator-no-default.out |   0
>  .../flat-union-optional-discriminator.err     |   1 -
>  tests/qapi-schema/leading-comma-list.err      |   2 +-
>  tests/qapi-schema/qapi-schema-test.out        |  33 +++
>  .../struct-member-alternate-default.err       |   1 +
>  .../struct-member-alternate-default.exit      |   1 +
>  .../struct-member-alternate-default.out       |   0
>  .../struct-member-bool-wrong-default-type.err |   1 +
>  ...struct-member-bool-wrong-default-type.exit |   1 +
>  .../struct-member-bool-wrong-default-type.out |   0
>  .../struct-member-enum-invalid-default.err    |   1 +
>  .../struct-member-enum-invalid-default.exit   |   1 +
>  .../struct-member-enum-invalid-default.out    |   0
>  .../struct-member-enum-wrong-default-type.err |   1 +
>  ...struct-member-enum-wrong-default-type.exit |   1 +
>  .../struct-member-enum-wrong-default-type.out |   0
>  .../struct-member-float-invalid-default.err   |   1 +
>  .../struct-member-float-invalid-default.exit  |   1 +
>  .../struct-member-float-invalid-default.out   |   0
>  ...struct-member-float-wrong-default-type.err |   1 +
>  ...truct-member-float-wrong-default-type.exit |   1 +
>  ...struct-member-float-wrong-default-type.out |   0
>  .../struct-member-int-wrong-default-type.err  |   1 +
>  .../struct-member-int-wrong-default-type.exit |   1 +
>  .../struct-member-int-wrong-default-type.out  |   0
>  .../struct-member-int8-erange-default.err     |   1 +
>  .../struct-member-int8-erange-default.exit    |   1 +
>  .../struct-member-int8-erange-default.out     |   0
>  .../struct-member-list-nonempty-default.err   |   1 +
>  .../struct-member-list-nonempty-default.exit  |   1 +
>  .../struct-member-list-nonempty-default.out   |   0
>  .../struct-member-non-optional-default.err    |   1 +
>  .../struct-member-non-optional-default.exit   |   1 +
>  .../struct-member-non-optional-default.out    |   0
>  .../struct-member-null-default.err            |   1 +
>  .../struct-member-null-default.exit           |   1 +
>  .../struct-member-null-default.out            |   0
>  .../struct-member-str-wrong-default-type.err  |   1 +
>  .../struct-member-str-wrong-default-type.exit |   1 +
>  .../struct-member-str-wrong-default-type.out  |   0
>  .../struct-member-uint8-erange-default.err    |   1 +
>  .../struct-member-uint8-erange-default.exit   |   1 +
>  .../struct-member-uint8-erange-default.out    |   0
>  .../struct-member-uint8-negative-default.err  |   1 +
>  .../struct-member-uint8-negative-default.exit |   1 +
>  .../struct-member-uint8-negative-default.out  |   0
>  tests/qapi-schema/test-qapi.py                |   8 +-
>  tests/qemu-iotests/059.out                    |   2 +-
>  tests/qemu-iotests/087                        |  65 +++--
>  tests/qemu-iotests/087.out                    |  26 +-
>  tests/qemu-iotests/089                        |  25 ++
>  tests/qemu-iotests/089.out                    |   9 +
>  tests/qemu-iotests/099.out                    |   4 +-
>  tests/qemu-iotests/110.out                    |   2 +-
>  tests/qemu-iotests/198.out                    |   4 +-
>  104 files changed, 915 insertions(+), 384 deletions(-)
>  create mode 100644 tests/qapi-schema/flat-union-optional-discriminator=
-invalid-specification.json
>  rename tests/qapi-schema/{flat-union-optional-discriminator.json =3D> =
flat-union-optional-discriminator-no-default.json} (68%)
>  create mode 100644 tests/qapi-schema/struct-member-alternate-default.j=
son
>  create mode 100644 tests/qapi-schema/struct-member-bool-wrong-default-=
type.json
>  create mode 100644 tests/qapi-schema/struct-member-enum-invalid-defaul=
t.json
>  create mode 100644 tests/qapi-schema/struct-member-enum-wrong-default-=
type.json
>  create mode 100644 tests/qapi-schema/struct-member-float-invalid-defau=
lt.json
>  create mode 100644 tests/qapi-schema/struct-member-float-wrong-default=
-type.json
>  create mode 100644 tests/qapi-schema/struct-member-int-wrong-default-t=
ype.json
>  create mode 100644 tests/qapi-schema/struct-member-int8-erange-default=
=2Ejson
>  create mode 100644 tests/qapi-schema/struct-member-list-nonempty-defau=
lt.json
>  create mode 100644 tests/qapi-schema/struct-member-non-optional-defaul=
t.json
>  create mode 100644 tests/qapi-schema/struct-member-null-default.json
>  create mode 100644 tests/qapi-schema/struct-member-str-wrong-default-t=
ype.json
>  create mode 100644 tests/qapi-schema/struct-member-uint8-erange-defaul=
t.json
>  create mode 100644 tests/qapi-schema/struct-member-uint8-negative-defa=
ult.json
>  create mode 100644 tests/qapi-schema/flat-union-optional-discriminator=
-invalid-specification.err
>  rename tests/qapi-schema/{flat-union-optional-discriminator.exit =3D> =
flat-union-optional-discriminator-invalid-specification.exit} (100%)
>  rename tests/qapi-schema/{flat-union-optional-discriminator.out =3D> f=
lat-union-optional-discriminator-invalid-specification.out} (100%)
>  create mode 100644 tests/qapi-schema/flat-union-optional-discriminator=
-no-default.err
>  create mode 100644 tests/qapi-schema/flat-union-optional-discriminator=
-no-default.exit
>  create mode 100644 tests/qapi-schema/flat-union-optional-discriminator=
-no-default.out
>  delete mode 100644 tests/qapi-schema/flat-union-optional-discriminator=
=2Eerr
>  create mode 100644 tests/qapi-schema/struct-member-alternate-default.e=
rr
>  create mode 100644 tests/qapi-schema/struct-member-alternate-default.e=
xit
>  create mode 100644 tests/qapi-schema/struct-member-alternate-default.o=
ut
>  create mode 100644 tests/qapi-schema/struct-member-bool-wrong-default-=
type.err
>  create mode 100644 tests/qapi-schema/struct-member-bool-wrong-default-=
type.exit
>  create mode 100644 tests/qapi-schema/struct-member-bool-wrong-default-=
type.out
>  create mode 100644 tests/qapi-schema/struct-member-enum-invalid-defaul=
t.err
>  create mode 100644 tests/qapi-schema/struct-member-enum-invalid-defaul=
t.exit
>  create mode 100644 tests/qapi-schema/struct-member-enum-invalid-defaul=
t.out
>  create mode 100644 tests/qapi-schema/struct-member-enum-wrong-default-=
type.err
>  create mode 100644 tests/qapi-schema/struct-member-enum-wrong-default-=
type.exit
>  create mode 100644 tests/qapi-schema/struct-member-enum-wrong-default-=
type.out
>  create mode 100644 tests/qapi-schema/struct-member-float-invalid-defau=
lt.err
>  create mode 100644 tests/qapi-schema/struct-member-float-invalid-defau=
lt.exit
>  create mode 100644 tests/qapi-schema/struct-member-float-invalid-defau=
lt.out
>  create mode 100644 tests/qapi-schema/struct-member-float-wrong-default=
-type.err
>  create mode 100644 tests/qapi-schema/struct-member-float-wrong-default=
-type.exit
>  create mode 100644 tests/qapi-schema/struct-member-float-wrong-default=
-type.out
>  create mode 100644 tests/qapi-schema/struct-member-int-wrong-default-t=
ype.err
>  create mode 100644 tests/qapi-schema/struct-member-int-wrong-default-t=
ype.exit
>  create mode 100644 tests/qapi-schema/struct-member-int-wrong-default-t=
ype.out
>  create mode 100644 tests/qapi-schema/struct-member-int8-erange-default=
=2Eerr
>  create mode 100644 tests/qapi-schema/struct-member-int8-erange-default=
=2Eexit
>  create mode 100644 tests/qapi-schema/struct-member-int8-erange-default=
=2Eout
>  create mode 100644 tests/qapi-schema/struct-member-list-nonempty-defau=
lt.err
>  create mode 100644 tests/qapi-schema/struct-member-list-nonempty-defau=
lt.exit
>  create mode 100644 tests/qapi-schema/struct-member-list-nonempty-defau=
lt.out
>  create mode 100644 tests/qapi-schema/struct-member-non-optional-defaul=
t.err
>  create mode 100644 tests/qapi-schema/struct-member-non-optional-defaul=
t.exit
>  create mode 100644 tests/qapi-schema/struct-member-non-optional-defaul=
t.out
>  create mode 100644 tests/qapi-schema/struct-member-null-default.err
>  create mode 100644 tests/qapi-schema/struct-member-null-default.exit
>  create mode 100644 tests/qapi-schema/struct-member-null-default.out
>  create mode 100644 tests/qapi-schema/struct-member-str-wrong-default-t=
ype.err
>  create mode 100644 tests/qapi-schema/struct-member-str-wrong-default-t=
ype.exit
>  create mode 100644 tests/qapi-schema/struct-member-str-wrong-default-t=
ype.out
>  create mode 100644 tests/qapi-schema/struct-member-uint8-erange-defaul=
t.err
>  create mode 100644 tests/qapi-schema/struct-member-uint8-erange-defaul=
t.exit
>  create mode 100644 tests/qapi-schema/struct-member-uint8-erange-defaul=
t.out
>  create mode 100644 tests/qapi-schema/struct-member-uint8-negative-defa=
ult.err
>  create mode 100644 tests/qapi-schema/struct-member-uint8-negative-defa=
ult.exit
>  create mode 100644 tests/qapi-schema/struct-member-uint8-negative-defa=
ult.out
>=20



--gW5FX0VBDgZQYC6WloIUoHNDkTgVKAp0L--

--eUR4qZoAlQJiOqOKx9UwXVMNLxChjmBAq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl17gjQACgkQ9AfbAGHV
z0CTrAf/T33HfQXtgdEEM4Jyx9ChBgZKMU3K/0llm7C6jTyE/ii9sFt645nj6uJF
ukpOcuP1UjP4SxyaX8ldem59D3te3kvSjqUGQzAXIqrxesWlFdbzF8chMwkHhXhO
jKe+3aLcAOdt5Jl4bJoYsGVC5qAtjly/kr7abtKDA9ZpbvaF92JEScFpGaVnHNxM
soUbSjdWYZHhdifsiZ0n5SWxHQOvdw2N3gb0Iv44w8eNbHMdJx+YBiC/x+7hn77b
ndCnv+2iFw5kIvnRO8EhWYIKi7dP+7T4WSeWUGn0G0GnLQVXdRApRSoBmGP8y5gv
J/brHPvQEA933pqO0Vyj8cN90lhsZg==
=v2mW
-----END PGP SIGNATURE-----

--eUR4qZoAlQJiOqOKx9UwXVMNLxChjmBAq--

