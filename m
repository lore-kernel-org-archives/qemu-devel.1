Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E22C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7342B206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 10:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AUt0fXWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7342B206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVXvp-0007mZ-J4
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 06:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVXv6-0007G8-Lm
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:01:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29329
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVXv5-0000DO-Ib
 for qemu-devel@nongnu.org; Mon, 04 May 2020 06:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588586510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sHmLjvJiTLBXV5DlDOiqzShlGysf7d/xSfzgDXVPQog=;
 b=AUt0fXWa9HEqCqPBwNM0i0eRwC+zl/VtTCCbNHG5KnrBM0xww+wB/FJEFTu2AqAwEgQpSj
 b+l6tsYZb18OTT3THNSrjfAJZJawk2G5Aex+lcC7pqWmWKBE+hNxSdtl24R1I+6x6v7/uK
 fTsUhLfpzU0Lu7ZnvmXFyGGgrAxvKHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-cf8JeDeFPdmBh7d8ASjhBw-1; Mon, 04 May 2020 06:01:46 -0400
X-MC-Unique: cf8JeDeFPdmBh7d8ASjhBw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D654A107ACF2;
 Mon,  4 May 2020 10:01:45 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-219.ams2.redhat.com
 [10.36.113.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C85E605D1;
 Mon,  4 May 2020 10:01:43 +0000 (UTC)
Subject: Re: [PATCH v2 3/6] qemu-img: Add bitmap sub-command
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200421212019.170707-1-eblake@redhat.com>
 <20200421212019.170707-4-eblake@redhat.com>
 <1dcf85b6-d9e6-b952-537c-791daec34ad9@redhat.com>
 <9d4769d4-09ea-dced-d4bd-9ceb33044202@redhat.com>
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
Message-ID: <d7c63e6a-a4a8-5b75-5dec-e4f392b3035d@redhat.com>
Date: Mon, 4 May 2020 12:01:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9d4769d4-09ea-dced-d4bd-9ceb33044202@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H18So8ArpdNj5kUmaFyLbi6FAt7zj7PeY"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 04:24:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H18So8ArpdNj5kUmaFyLbi6FAt7zj7PeY
Content-Type: multipart/mixed; boundary="DfyB2JLC08r6FZEeBjWgldlJtCiaMbRJk"

--DfyB2JLC08r6FZEeBjWgldlJtCiaMbRJk
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.04.20 17:21, Eric Blake wrote:
> On 4/30/20 9:55 AM, Max Reitz wrote:
>> On 21.04.20 23:20, Eric Blake wrote:
>>> Include actions for --add, --remove, --clear, --enable, --disable, and
>>> --merge (note that --clear is a bit of fluff, because the same can be
>>> accomplished by removing a bitmap and then adding a new one in its
>>> place,
>>
>> Well, ideally, all of qemu-img is just fluff because =E2=80=9Cthe same c=
an be
>> accomplished by launching qemu and issuing the equivalent QMP
>> commands=E2=80=9D. :)
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 but it matches what QMP comm=
ands exist).=C2=A0 Listing is omitted,
>>> because it does not require a bitmap name and because it was already
>>> possible with 'qemu-img info'.
>>
>> Fair enough, although it can be said that qemu-img info=E2=80=99s output=
 is
>> qcow2-specific.=C2=A0 It might be nice to have some definitely
>> format-independent output.=C2=A0 (But we don=E2=80=99t have persistent b=
itmaps in
>> anything but qcow2 yet (or do we in NBD?), so I don=E2=80=99t expect any=
one to
>> care much.)
>=20
> We can add a list subcommand later if it is still desired.=C2=A0 I agree =
that
> a tabular format:
>=20
> name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enabled=C2=A0=
=C2=A0 granularity
> bitmap1=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false=C2=A0=C2=A0=C2=A0=C2=A0=
 65536
> bitmap2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 true=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 512
>=20
> in isolation is easier to read than:
>=20
> =C2=A0=C2=A0=C2=A0 bitmaps:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [0]:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: =
bitmap1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 granul=
arity: 65536
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [1]:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 [0]: auto
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name: =
bitmap2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 granul=
arity: 512
>=20
> embedded inside even more information.
>=20
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Merge can work either from=
 another
>>> bitmap in the same image, or from a bitmap in a distinct image.
>>>
>>> While this supports --image-opts for the file being modified, I did
>>> not think it worth the extra complexity to support that for the source
>>> file in a cross-file bitmap merge.=C2=A0 Likewise, I chose to have --me=
rge
>>> only take a single source rather than following the QMP support for
>>> multiple merges in one go; in part to simplify the command line, and
>>> in part because an offline image can achieve the same effect by
>>> multiple qemu-img bitmap --merge calls.=C2=A0 We can enhance that if ne=
eded
>>> in the future (the same way that 'qemu-img convert' has a mode that
>>> concatenates multiple sources into one destination).
>>>
>>> Upcoming patches will add iotest coverage of these commands while
>>> also testing other features.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>> =C2=A0 docs/tools/qemu-img.rst |=C2=A0 24 +++++
>>> =C2=A0 qemu-img.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 198 ++++++++++++++++++++++++++++++++++++++++
>>> =C2=A0 qemu-img-cmds.hx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 7 ++
>>> =C2=A0 3 files changed, 229 insertions(+)
>>>
>>> diff --git a/docs/tools/qemu-img.rst b/docs/tools/qemu-img.rst
>>> index 7d08c48d308f..4f3b0e2c9ace 100644
>>> --- a/docs/tools/qemu-img.rst
>>> +++ b/docs/tools/qemu-img.rst
>>> @@ -281,6 +281,30 @@ Command description:
>>> =C2=A0=C2=A0=C2=A0 For write tests, by default a buffer filled with zer=
os is
>>> written. This can be
>>> =C2=A0=C2=A0=C2=A0 overridden with a pattern byte specified by *PATTERN=
*.
>>>
>>> +.. option:: bitmap {--add [-g GRANULARITY] [--disabled] | --remove |
>>> --clear | --enable | --disable | --merge SOURCE_BITMAP [-b
>>> SOURCE_FILE [-F SOURCE_FMT]]} [--object OBJECTDEF] [--image-opts] [-f
>>> FMT] FILENAME BITMAP
>>
>> So I can do multiple operations in one roll, but they all use the same
>> BITMAP?=C2=A0 Sounds a bit weird.=C2=A0 It actually took me a while to u=
nderstands
>> this, because I thought for sure that each command would take a bitmap
>> name.=C2=A0 (And was ready to complain that it looked like they don=E2=
=80=99t, but,
>> well, that=E2=80=99s because they don=E2=80=99t.)
>=20
> All of the operations take one bitmap name (the final BITMAP).
> Additionally, the --merge operation takes a second bitmap name
> (SOURCE_BITMAP).=C2=A0 None of the other operations need a second bitmap
> name, so only --merge requires an option argument.=C2=A0 As written, the =
{ a
> | b | c } implies that operations are mutually exclusive: you can only
> request one operation per qemu-img invocation.

Well, as I found out later it=E2=80=99s supposed to imply that.  I always e=
xpect
{} to mean repetition.

>> Although I suppose some practical example like
>>
>> $ qemu-img bitmap --add --merge sbmap --disable foo.qcow2 nbmap
>>
>> does make sense.[1]
>>
>>
>> Would
>>
>> $ qemu-img bitmap --add nbmap --merge nbmap sbmap --enable nbmap \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 foo.qcow2
>>
>> make more sense?
>=20
> That would be more transactional, and more effort to implement.

As a user, I wouldn=E2=80=99t expect it to be a transaction, but just execu=
ted
in order.

> My argument is that you should instead write:
>=20
> $ qemu-img bitmap --add foo.qcow2 nbmap
> $ qemu-img bitmap --merge sbmap foo.qcow2 nbmap
> $ qemu-img bitmap --enable foo.qcow2 nbmap
>=20
> where I only have to implement one operation per qemu-img.

I don=E2=80=99t know about the =E2=80=9Chave to=E2=80=9D, because from an a=
lgorithm standpoint,
doing so would be trivial.  (That is, collecting the operations into a
list, along with their specific arguments, and then execute the list in
a loop.)

I can see that doing this in C is more difficult than it would be in
nicer languages, and so not actually trivial.

But allowing all switches at most once without mutual exclusion still
seems simple.  The question is mostly whether the implementation would
match what we can expect users to expect.

[...]
>> So if --disable and --disabled are exactly the same, I really don=E2=80=
=99t know
>> why --disabled even exists.
>=20
> Logically, '--add --disabled' matches the name of the QMP command with
> its optional 'disabled' parameter, while --disable matches the name of
> the QMP command.=C2=A0 We don't have to have the alias; and in fact, if y=
ou
> agree that supporting '--add --disabled' is too much sugar (since we
> don't care about atomicity the way QMP did), then life gets simpler to
> drop --disabled altogether.

I find it makes the interface unnecessarily complex, as does requiring
mutual exclusion.

If we want mutual exclusion, I can see that a separate --disabled for
--add makes sense.

>>> +=C2=A0=C2=A0=C2=A0 if (add && disable) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 disable =3D false;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 add_disabled =3D true;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (add + remove + clear + enable + disable + !!mer=
ge !=3D 1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Need exactly =
one mode of --add, --remove,
>>> --clear, "
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "--enable, --disable, o=
r --merge");
>>
>> Aha.=C2=A0 So you can actually only do a single operation.
>>
>> That means the doc shouldn=E2=80=99t use {}, in my opinion, because that=
 to me
>> means repetition (thanks to EBNF).=C2=A0 It definitely served to confuse=
 me
>> greatly until this point.
>=20
> In command line syntax, I'm most used to seeing repetition as '...',
> optional as [], and mutually-exclusive choice as {|}.=C2=A0 Yes, that's
> different than EBNF.

It=E2=80=99s confusing is what it is, and unnecessarily so.  The | already
signifies exclusion: Say there are -a and -b, if they=E2=80=99re not mutual=
ly
exclusive, then the doc describe them as =E2=80=9C[-a] [-b]=E2=80=9D; if th=
ey are, it=E2=80=99d
be =E2=80=9C-a | -b=E2=80=9D.  Maybe =E2=80=9C(-a | -b)=E2=80=9D.

I can=E2=80=99t remember having seen {|} for mutual exclusivity before, but=
 then
again, it doesn=E2=80=99t happen often, I suppose.  git for one thing seems=
 to
use (|).

(Regex also uses {} for repetition, even if in a different way from EBNF.)

I=E2=80=99ve never seen =E2=80=9C...=E2=80=9D used for switches, only for f=
ree-form arguments
like filenames.  (Because normally, a switch can be specified only once,
or it wouldn=E2=80=99t be a =E2=80=9Cswitch=E2=80=9D.)

>> I also don=E2=80=99t see why we would disallow multiple operations in on=
e go.
>> The --add --merge combination seems useful to me, and I don=E2=80=99t se=
e a
>> problem in implementing it.
>>
>> I don=E2=80=99t know why we don=E2=80=99t just create a list of operatio=
ns to execute,
>> based on the order given in the argument list, and then execute them in
>> order.=C2=A0 That would even allow multiple --merge operations.
>=20
> If I understand, you're asking why we can't do:
>=20
> qemu-img bitmap foo.qcow2 --add b1 --merge sb b1
>=20
> in one operation.
>=20
> That changes the syntax entirely, compared to what I implemented.=C2=A0 Y=
ou'd
> have to have an argument to every option, AND figure out how to specify
> TWO arguments to the --merge option.=C2=A0 Might be doable, but seems hai=
ry.

Just =E2=80=9Cqemu-img bitmap --add --merge sb foo.qcow2 b1=E2=80=9D would =
be enough.

>> If we don=E2=80=99t want that (because we don=E2=80=99t want argument or=
der to matter),
>> we could still allow all operations to be done at least once and always
>> execute them in the same order, e.g.:
>> (1) add
>> (2) clear
>> (3) merge
>> (4) disable
>> (5) enable
>> (6) remove
>=20
> I still find it simpler to do exactly one operation per invocation.

I feel like that=E2=80=99s mostly because of our coding style allowing an =
=E2=80=9Celse
if=E2=80=9D to end and start a block on the same line.

(That is, I feel like if we allowed multiple operations in a single go,
the only difference would be that we wouldn=E2=80=99t have to check for mut=
ual
exclusivity, and that all =E2=80=9C} else if (cond) {=E2=80=9Ds would have =
to be turned
into =E2=80=9C} if (cond) {=E2=80=9Ds.  And reordered.)

It=E2=80=99s possible that I mostly feel compelled to vote for non-exclusiv=
ity
because it would be clear then how to document the interface (i.e.,
=E2=80=9C[--add] [--clear] [...]=E2=80=9D) and I wouldn=E2=80=99t have to e=
xplain my utter
confusion at the sight of {}.

Max


--DfyB2JLC08r6FZEeBjWgldlJtCiaMbRJk--

--H18So8ArpdNj5kUmaFyLbi6FAt7zj7PeY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6v6AUACgkQ9AfbAGHV
z0A6Rgf+PLU59oyvtawqhPn9FSTR38fI8NmkXq6c3e+Z86zzyogNXUoEy4xviZd+
EyayPR3c3MYmm5pXFR6P2BgrK7OwpCzY0fjtyD9vjdzr5Iw1W5Z6sRojqrCvaUD0
AY7VUR3CuBrn5Q4NR/7WbJu+HpBdHQ9GRWDx5hH6+iPM9/joAAEVesY2hFL0z1Kv
4lV8huAJpyLZMpSaz62emqq6ntUgg0b8VRhIJ+BY0h58aUsFDfa/LaATNtstuIp8
P/2nyenaB594Kubaf16p10+E5CreZowsPeS5AWFHHNdHwlV+ljcZZYYoLeUy9coW
d8xSKWAmNUrPIhz2knvKTgMNoS+Uwg==
=x4bI
-----END PGP SIGNATURE-----

--H18So8ArpdNj5kUmaFyLbi6FAt7zj7PeY--


