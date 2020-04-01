Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EC9C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:32:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1074020714
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 12:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZBmctcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1074020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJcXo-0006eN-2Y
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 08:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jJcUY-0002FK-Lf
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:29:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jJcUW-0004sB-4N
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:29:10 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49203
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jJcUV-0004pw-Ty
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 08:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585744146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F4GiOjNR2UGA4Zmn8EojPCWjIYX7xsqkaX+g6WGrokw=;
 b=bZBmctcgLtTs3iSz0uUSxkVYhrXON2KiZ5sM5/XkiS27LeATVT8c96HAQS5fC+oUCDv5Rr
 e1gH45LubVoltImLsvxYvGJ246FGfm3LP8xhqylfJvX31H6fzF2cUFnlxnZhWpdVFPh9N0
 oJaZIm68PhrSwVKzuc9V9KB9xcgsqp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-Ibt4fi1UNkS9VroCYgZJQg-1; Wed, 01 Apr 2020 08:28:50 -0400
X-MC-Unique: Ibt4fi1UNkS9VroCYgZJQg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25EC9DB66;
 Wed,  1 Apr 2020 12:28:49 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-115-160.ams2.redhat.com
 [10.36.115.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 87B3719C6A;
 Wed,  1 Apr 2020 12:28:46 +0000 (UTC)
Subject: Re: [PATCH v10 10/14] iotests: add hmp helper with logging
To: Kevin Wolf <kwolf@redhat.com>
References: <20200331000014.11581-1-jsnow@redhat.com>
 <20200331000014.11581-11-jsnow@redhat.com>
 <88146808-4acc-247e-d34b-5dd16baad0b4@redhat.com>
 <20200331140057.GG7030@linux.fritz.box>
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
Message-ID: <19eedbae-0660-5a28-e20b-ddf82a36fe73@redhat.com>
Date: Wed, 1 Apr 2020 14:28:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331140057.GG7030@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HpTyZ2eQnJBBJYyV2DJNrgzKtw0YpFhpS"
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
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HpTyZ2eQnJBBJYyV2DJNrgzKtw0YpFhpS
Content-Type: multipart/mixed; boundary="Eo1oPHBq0nefpYFhnPyAP7q7S6oiIG9pN"

--Eo1oPHBq0nefpYFhnPyAP7q7S6oiIG9pN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31.03.20 16:00, Kevin Wolf wrote:
> Am 31.03.2020 um 12:21 hat Max Reitz geschrieben:
>> On 31.03.20 02:00, John Snow wrote:
>>> Minor cleanup for HMP functions; helps with line length and consolidate=
s
>>> HMP helpers through one implementation function.
>>>
>>> Although we are adding a universal toggle to turn QMP logging on or off=
,
>>> many existing callers to hmp functions don't expect that output to be
>>> logged, which causes quite a few changes in the test output.
>>>
>>> For now, offer a use_log parameter.
>>>
>>>
>>> Typing notes:
>>>
>>> QMPResponse is just an alias for Dict[str, Any]. It holds no special
>>> meanings and it is not a formal subtype of Dict[str, Any]. It is best
>>> thought of as a lexical synonym.
>>>
>>> We may well wish to add stricter subtypes in the future for certain
>>> shapes of data that are not formalized as Python objects, at which poin=
t
>>> we can simply retire the alias and allow mypy to more strictly check
>>> usages of the name.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  tests/qemu-iotests/iotests.py | 35 ++++++++++++++++++++++-------------
>>>  1 file changed, 22 insertions(+), 13 deletions(-)
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>>> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests=
.py
>>> index b08bcb87e1..dfc753c319 100644
>>> --- a/tests/qemu-iotests/iotests.py
>>> +++ b/tests/qemu-iotests/iotests.py
>>> @@ -37,6 +37,10 @@
>>> =20
>>>  assert sys.version_info >=3D (3, 6)
>>> =20
>>> +# Type Aliases
>>> +QMPResponse =3D Dict[str, Any]
>>> +
>>> +
>>>  faulthandler.enable()
>>> =20
>>>  # This will not work if arguments contain spaces but is necessary if w=
e
>>> @@ -540,25 +544,30 @@ def add_incoming(self, addr):
>>>          self._args.append(addr)
>>>          return self
>>> =20
>>> -    def pause_drive(self, drive, event=3DNone):
>>> -        '''Pause drive r/w operations'''
>>> +    def hmp(self, command_line: str, use_log: bool =3D False) -> QMPRe=
sponse:
>>> +        cmd =3D 'human-monitor-command'
>>> +        kwargs =3D {'command-line': command_line}
>>> +        if use_log:
>>> +            return self.qmp_log(cmd, **kwargs)
>>> +        else:
>>> +            return self.qmp(cmd, **kwargs)
>>
>> Hm.  I suppose I should take this chance to understand something about
>> mypy.  QEMUMachine.qmp() isn=E2=80=99t typed, so mypy can=E2=80=99t chec=
k that this
>> really returns QMPResponse.  Is there some flag to make it?  Like
>> --actually-check-types?
>=20
> There is --check-untyped-defs, but I'm not sure if that actually changes
> the return type of untyped functions from Any to an inferred type. I
> kind of doubt it.

Well, but Any doesn=E2=80=99t fit into QMPResponse, so there should be an e=
rror
reported somewhere.

>> (--strict seems, well, overly strict?  Like not allowing generics, I
>> don=E2=80=99t see why.  Or I suppose for the time being we want to allow=
 untyped
>> definitions, as long as they don=E2=80=99t break type assertions such as=
 it kind
>> of does here...?)
>=20
> At least, --strict does actually complain about this one because Any
> isn't good enough any more (it includes --warn-return-any):

Hm, yes, but we=E2=80=99re not at a point where it=E2=80=99s really feasibl=
e to enable
--strict...

> iotests.py:560: warning: Returning Any from function declared to return "=
Dict[str, Any]"
> iotests.py:560: error: Call to untyped function "qmp_log" in typed contex=
t
> iotests.py:562: warning: Returning Any from function declared to return "=
Dict[str, Any]"
>=20
> Not sure why you think it doesn't allow generics? I never had problems
> with that, even in my Python museum. :-)

I thought --disallow-any-generics would mean that.  But I suppose mypy
understands a =E2=80=9Cgeneric=E2=80=9D to be something else than I do, as =
John
described... *shrug*

Max


--Eo1oPHBq0nefpYFhnPyAP7q7S6oiIG9pN--

--HpTyZ2eQnJBBJYyV2DJNrgzKtw0YpFhpS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6EiPsACgkQ9AfbAGHV
z0A2Ywf/XSf6ubg8809e3P+hi6WGndOiL0BTULeyUFkkrQ/IQy0jsf9h7hInCRl2
KB3aVoFUGWT6xJ0KVQ+R4/xEDduWv0kFSOvdmV7UO5kNQJfz/9Hnk6TlaLkQg4rU
95r1yJIP52WhU2QVsKqX0OUEPZlwgl6rUxTZN7QK6t7RNduRkBy4hKp/IRRZtEeL
wnowGMWl0CLQlJZ8UQZQbxp4a2Jp1P1oKWmiyCb9V/AJr868mH9QQ3gUyqzt+2UQ
wn/mIGLfocUZptR4r/81ZNilTXzeMSIWsbpkIuXt4mEKgyFU04+JQza7em8Xm5WW
popJE1SPuhZSZk0LUaZyCUY/EVmZ2w==
=YTyE
-----END PGP SIGNATURE-----

--HpTyZ2eQnJBBJYyV2DJNrgzKtw0YpFhpS--


