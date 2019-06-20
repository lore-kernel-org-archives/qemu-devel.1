Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EDFC43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990A0206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 20:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990A0206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52800 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1he3jF-0000kB-Ft
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 16:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55409)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1he3Ov-0007Ei-5X
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 16:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1he3Or-0001qc-Jj
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 16:11:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38838)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1he3Og-0001il-Ln; Thu, 20 Jun 2019 16:11:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E56CDC04FF86;
 Thu, 20 Jun 2019 20:10:48 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A1E25D719;
 Thu, 20 Jun 2019 20:10:44 +0000 (UTC)
To: Pino Toscano <ptoscano@redhat.com>
References: <20190618092403.30006-1-ptoscano@redhat.com>
 <3681094.1Qnffhumos@lindworm.usersys.redhat.com>
 <bca1ddde-652a-11df-5e48-826ab1799d98@redhat.com>
 <4685183.8apt5qi6oh@lindworm.usersys.redhat.com>
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
Message-ID: <9035cc93-ad09-3a4e-892d-c768935e44d6@redhat.com>
Date: Thu, 20 Jun 2019 22:10:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4685183.8apt5qi6oh@lindworm.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="iWppiCoyMsniJdazkOYJP0JQySsIfJzap"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 20 Jun 2019 20:10:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v10] ssh: switch from libssh2 to libssh
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, rjones@redhat.com, sw@weilnetz.de,
 alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iWppiCoyMsniJdazkOYJP0JQySsIfJzap
Content-Type: multipart/mixed; boundary="Cg9q2AzziuRKUa3gpWWywXUN2QgPSB5T7";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Pino Toscano <ptoscano@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com,
 kwolf@redhat.com, philmd@redhat.com, alex.bennee@linaro.org, fam@euphon.net,
 sw@weilnetz.de
Message-ID: <9035cc93-ad09-3a4e-892d-c768935e44d6@redhat.com>
Subject: Re: [PATCH v10] ssh: switch from libssh2 to libssh
References: <20190618092403.30006-1-ptoscano@redhat.com>
 <3681094.1Qnffhumos@lindworm.usersys.redhat.com>
 <bca1ddde-652a-11df-5e48-826ab1799d98@redhat.com>
 <4685183.8apt5qi6oh@lindworm.usersys.redhat.com>
In-Reply-To: <4685183.8apt5qi6oh@lindworm.usersys.redhat.com>

--Cg9q2AzziuRKUa3gpWWywXUN2QgPSB5T7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.06.19 22:03, Pino Toscano wrote:
> On Thursday, 20 June 2019 14:58:40 CEST Max Reitz wrote:
>> On 20.06.19 11:49, Pino Toscano wrote:
>>> On Tuesday, 18 June 2019 15:14:30 CEST Max Reitz wrote:
>>>> On 18.06.19 11:24, Pino Toscano wrote:
>>>>> Rewrite the implementation of the ssh block driver to use libssh in=
stead
>>>>> of libssh2.  The libssh library has various advantages over libssh2=
:
>>>>> - easier API for authentication (for example for using ssh-agent)
>>>>> - easier API for known_hosts handling
>>>>> - supports newer types of keys in known_hosts
>>>>>
>>>>> Use APIs/features available in libssh 0.8 conditionally, to support=

>>>>> older versions (which are not recommended though).
>>>>>
>>>>> Adjust the tests according to the different error message, and to t=
he
>>>>> newer host keys (ed25519) that are used by default with OpenSSH >=3D=
 6.7
>>>>> and libssh >=3D 0.7.0.
>>>>>
>>>>> Adjust the various Docker/Travis scripts to use libssh when availab=
le
>>>>> instead of libssh2. The mingw/mxe testing is dropped for now, as th=
ere
>>>>> are no packages for it.
>>>>>
>>>>> Signed-off-by: Pino Toscano <ptoscano@redhat.com>
>>>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>> ---
>>>>>
>>>>> Changes from v9:
>>>>> - restored "default" case in the server status switch for libssh < =
0.8.0
>>>>> - print the host key type & fingerprint on mismatch with known_host=
s
>>>>> - improve/fix message for failed socket_set_nodelay()
>>>>> - reset s->sock properly
>>>>>
>>>>> Changes from v8:
>>>>> - use a newer key type in iotest 207
>>>>> - improve the commit message
>>>>>
>>>>> Changes from v7:
>>>>> - #if HAVE_LIBSSH_0_8 -> #ifdef HAVE_LIBSSH_0_8
>>>>> - ptrdiff_t -> size_t
>>>>>
>>>>> Changes from v6:
>>>>> - fixed few checkpatch style issues
>>>>> - detect libssh 0.8 via symbol detection
>>>>> - adjust travis/docker test material
>>>>> - remove dead "default" case in a switch
>>>>> - use variables for storing MIN() results
>>>>> - adapt a documentation bit
>>>>>
>>>>> Changes from v5:
>>>>> - adapt to newer tracing APIs
>>>>> - disable ssh compression (mimic what libssh2 does by default)
>>>>> - use build time checks for libssh 0.8, and use newer APIs directly=

>>>>>
>>>>> Changes from v4:
>>>>> - fix wrong usages of error_setg/session_error_setg/sftp_error_setg=

>>>>> - fix few return code checks
>>>>> - remove now-unused parameters in few internal functions
>>>>> - allow authentication with "none" method
>>>>> - switch to unsigned int for the port number
>>>>> - enable TCP_NODELAY on the socket
>>>>> - fix one reference error message in iotest 207
>>>>>
>>>>> Changes from v3:
>>>>> - fix socket cleanup in connect_to_ssh()
>>>>> - add comments about the socket cleanup
>>>>> - improve the error reporting (closer to what was with libssh2)
>>>>> - improve EOF detection on sftp_read()
>>>>>
>>>>> Changes from v2:
>>>>> - used again an own fd
>>>>> - fixed co_yield() implementation
>>>>>
>>>>> Changes from v1:
>>>>> - fixed jumbo packets writing
>>>>> - fixed missing 'err' assignment
>>>>> - fixed commit message
>>>>>
>>>>>  .travis.yml                                   |   4 +-
>>>>>  block/Makefile.objs                           |   6 +-
>>>>>  block/ssh.c                                   | 665 ++++++++++----=
----
>>>>>  block/trace-events                            |  14 +-
>>>>>  configure                                     |  65 +-
>>>>>  docs/qemu-block-drivers.texi                  |   2 +-
>>>>>  .../dockerfiles/debian-win32-cross.docker     |   1 -
>>>>>  .../dockerfiles/debian-win64-cross.docker     |   1 -
>>>>>  tests/docker/dockerfiles/fedora.docker        |   4 +-
>>>>>  tests/docker/dockerfiles/ubuntu.docker        |   2 +-
>>>>>  tests/docker/dockerfiles/ubuntu1804.docker    |   2 +-
>>>>>  tests/qemu-iotests/207                        |   4 +-
>>>>>  tests/qemu-iotests/207.out                    |   2 +-
>>>>>  13 files changed, 423 insertions(+), 349 deletions(-)
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/block/ssh.c b/block/ssh.c
>>>>> index 6da7b9cbfe..644ae8b82c 100644
>>>>> --- a/block/ssh.c
>>>>> +++ b/block/ssh.c
>>>>
>>>> [...]
>>>>
>>>>> +    case SSH_SERVER_KNOWN_CHANGED:
>>>>> +        ret =3D -EINVAL;
>>>>> +        r =3D ssh_get_publickey(s->session, &pubkey);
>>>>> +        if (r =3D=3D 0) {
>>>>> +            r =3D ssh_get_publickey_hash(pubkey, SSH_PUBLICKEY_HAS=
H_SHA1,
>>>>> +                                       &server_hash, &server_hash_=
len);
>>>>> +            pubkey_type =3D ssh_key_type(pubkey);
>>>>> +            ssh_key_free(pubkey);
>>>>> +        }
>>>>> +        if (r =3D=3D 0) {
>>>>> +            fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY=
_HASH_SHA1,
>>>>> +                                                   server_hash,
>>>>> +                                                   server_hash_len=
);
>>>>> +            ssh_clean_pubkey_hash(&server_hash);
>>>>> +        }
>>>>> +        if (fingerprint) {
>>>>> +            error_setg(errp,
>>>>> +                       "host key (%s key with fingerprint %s) does=
 not match "
>>>>> +                       "the one in known_hosts",
>>>>> +                       ssh_key_type_to_char(pubkey_type), fingerpr=
int);
>>>>> +            ssh_string_free_char(fingerprint);
>>>>> +        } else  {
>>>>> +            error_setg(errp, "host key does not match the one in k=
nown_hosts");
>>>>> +        }
>>>>
>>>> Usually I=E2=80=99d say that more information can=E2=80=99t be bad. =
 But here I don=E2=80=99t
>>>> see how this additional information is useful.  known_hosts contains=

>>>> base64-encoded full public keys.  This only prints the SHA-1 digest.=

>>>
>>> Note that SHA-1 is printed with libssh < 0.8; with libssh >=3D 0.8 SH=
A-256
>>> is used instead.
>>>
>>>> The user cannot add that to known_hosts, or easily scan known_hosts =
to
>>>> see whether it perhaps belongs to some other hosts (maybe because DH=
CP
>>>> scrambled something).
>>>>
>>>> Actually, even if this printed the base64 representation of the full=

>>>> key, the user probably wouldn=E2=80=99t just add that to known_hosts=
 or do
>>>> anything with it.  They=E2=80=99ll debug the problem with other tool=
s.
>>>>
>>>> So I don=E2=80=99t think this new information is really useful...?
>>>
>>> When this situation happens with openssh, the big scary message print=
s
>>> three things:
>>> 1) the fingerprint of the server
>>> 2) the line of the server in the known_hosts file
>>> 3) how to remove the keys of the server from known_hosts, i.e. a
>>>    copy-paste'able `ssh-keygen -R host`
>>>
>>> Here I'm doing only (1).  Also, the current libssh2 driver does
>>> something else, i.e. print the base64/printable representation of the=

>>> server key in known_hosts.
>>
>> Well, I don=E2=80=99t know whether it=E2=80=99s necessary to reproduce=
 the exact message
>> with all the data it contains.  As I said, I think users can and will
>> investigate the exact root of the problem with tools outside of qemu.
>> (Such as openssh=E2=80=99s ssh itself.)
>>
>>>> (Hmm, I don=E2=80=99t know if this is a response to my =E2=80=9CBut =
the specification
>>>> requires a warning!!1!=E2=80=9D, but if so, I was actually not refer=
ring to more
>>>> information but to this:
>>>
>>> You mentioned this few times: can you please point me to this bit?
>>> I read few RFCs related to ssh, and I did not find this information..=
=2E
>>
>> For example:
>> http://api.libssh.org/master/group__libssh__session.html#gacbc5d04fe66=
beee863a0c61a93fdf765
>>> SSH_KNOWN_HOSTS_CHANGED: The server key has changed. Either you are u=
nder attack or the administrator changed the key. You HAVE to warn the us=
er about a possible attack.
>=20
> Ah, now I see what you mean! I thought that "libssh specification" was
> any of the SSH RFCs, and that's why I did not find what you meant.
> I see you were talking about the libssh API documentation :-)
> (Never heard the API docs of a library called as "specification" before=
,
> TBH.)

Ah, sorry.  I have no excuse.  I just call everything a =E2=80=9Cspec=E2=80=
=9D that=E2=80=99s
telling me what to do.  (I should probably stop doing that.)

>> This doesn=E2=80=99t require any specific formatting or data to be giv=
en to the
>> user.  All it requires is =E2=80=9Cto warn the user about a possible a=
ttack=E2=80=9D.
>> That can be as simple as appending =E2=80=9CThis may be due to a
>> man-in-the-middle attack=E2=80=9D to the error message.
>=20
> Makes sense -- I just asked to the libssh people, and appending
> "this may be a possible attack" should be enough, especially that this
> is not a UI message like the one written by the ssh client.

OK, great!

>>>> $ ssh 192.168.0.12
>>>> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>>>> @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
>>>> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>>>> IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
>>>> Someone could be eavesdropping on you right now (man-in-the-middle a=
ttack)!
>>>> It is also possible that a host key has just been changed.
>>>>
>>>>
>>>> I mean, I was also only half-serious.  I should be serious because t=
he
>>>> libssh specification requires us to print some warning like that, bu=
t,
>>>> well.  Yes, I=E2=80=99ll stop mumbling about this stuff now.)
>>>
>>> To be on the explic side: are you asking to basically put the first 6=

>>> lines of the openssh error message (as you quoted them above) as erro=
r
>>> message in the ssh driver?
>>
>> God forbid no.  I was just making an example of =E2=80=9CHere is a war=
ning about
>> a possible attack=E2=80=9D.  I fully agree with Dan (and probably you)=
 that this
>> is completely unsuitable to qemu=E2=80=99s interface.
>>
>> Sorry if that came across in another way.
>=20
> Not a problem. I preferred to ask explicitly to make sure to get it
> right -- any amount of information shown is fine for me, I want to make=

> sure to follow QEMU best practices (if any).

I mean, as you=E2=80=99ve seen yourself, there currently is no warning.  =
So it=E2=80=99s
not like there is any practice, not to mention a best one...

Max


--Cg9q2AzziuRKUa3gpWWywXUN2QgPSB5T7--

--iWppiCoyMsniJdazkOYJP0JQySsIfJzap
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0L6EMACgkQ9AfbAGHV
z0AAYggAlMj61R0NssB/zCj53s1p5JhO6pF5g4I9i6KZN1ZohAQDYCYWkLMM1fx+
G+W9f+kzoNTh7jDvItDAHUZd8FgNZFoWgopjSLoNYHZgQuRZzJEB7Bn+VzGOMWBd
aeqgQYYwj44jd0IcHtu7HGRjqb0tRKh5S9fI2le6NhQ0GpaVXhbCFZQQTmc4NCJy
IMSHuxbuN3h5nTW9WbeIWyVmWwe0UqxGMhxBePnCIqM2epwITH0nx8ow/kcMugR8
ScMEjQI3SP9+PimTznFDQpgV+QobRRjUBqUQczvI3LVNV/ZNYQxtJ3X4w5lqvpuh
JuECXMT59sBGOTEGzFsNJJllFevamg==
=oxgr
-----END PGP SIGNATURE-----

--iWppiCoyMsniJdazkOYJP0JQySsIfJzap--

