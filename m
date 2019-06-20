Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FB1C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:27:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F194920675
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F194920675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdx6E-00029X-6m
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 09:27:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51184)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdwxT-0002kz-P4
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:18:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdwmT-0001DA-I3
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:08:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37332)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdwhd-0008MS-9N; Thu, 20 Jun 2019 09:02:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C199307D935;
 Thu, 20 Jun 2019 13:02:08 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C05291001E81;
 Thu, 20 Jun 2019 13:02:03 +0000 (UTC)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190618092403.30006-1-ptoscano@redhat.com>
 <ca41c9ef-aa6d-2e17-42a0-3a1beb42e208@redhat.com>
 <20190620101113.GV25448@redhat.com>
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
Message-ID: <b7fb15db-fb16-b0c6-e099-3d0a2a6dd55b@redhat.com>
Date: Thu, 20 Jun 2019 15:01:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190620101113.GV25448@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="W7lC5XEMfat3BDCQZAZvudtPQQjKD6obp"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 20 Jun 2019 13:02:08 +0000 (UTC)
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, rjones@redhat.com,
 sw@weilnetz.de, qemu-devel@nongnu.org, Pino Toscano <ptoscano@redhat.com>,
 alex.bennee@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W7lC5XEMfat3BDCQZAZvudtPQQjKD6obp
Content-Type: multipart/mixed; boundary="teuDlYQjULC7sRTqZWELyqeaG4TWQ1Vrd";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, kwolf@redhat.com, fam@euphon.net, philmd@redhat.com,
 rjones@redhat.com, sw@weilnetz.de, alex.bennee@linaro.org
Message-ID: <b7fb15db-fb16-b0c6-e099-3d0a2a6dd55b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10] ssh: switch from libssh2 to libssh
References: <20190618092403.30006-1-ptoscano@redhat.com>
 <ca41c9ef-aa6d-2e17-42a0-3a1beb42e208@redhat.com>
 <20190620101113.GV25448@redhat.com>
In-Reply-To: <20190620101113.GV25448@redhat.com>

--teuDlYQjULC7sRTqZWELyqeaG4TWQ1Vrd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.06.19 12:11, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Jun 18, 2019 at 03:14:30PM +0200, Max Reitz wrote:
>> On 18.06.19 11:24, Pino Toscano wrote:
>>> Rewrite the implementation of the ssh block driver to use libssh inst=
ead
>>> of libssh2.  The libssh library has various advantages over libssh2:
>>> - easier API for authentication (for example for using ssh-agent)
>>> - easier API for known_hosts handling
>>> - supports newer types of keys in known_hosts
>>>
>>> Use APIs/features available in libssh 0.8 conditionally, to support
>>> older versions (which are not recommended though).
>>>
>>> Adjust the tests according to the different error message, and to the=

>>> newer host keys (ed25519) that are used by default with OpenSSH >=3D =
6.7
>>> and libssh >=3D 0.7.0.
>>>
>>> Adjust the various Docker/Travis scripts to use libssh when available=

>>> instead of libssh2. The mingw/mxe testing is dropped for now, as ther=
e
>>> are no packages for it.
>>>
>>> Signed-off-by: Pino Toscano <ptoscano@redhat.com>
>>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>> Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> ---
>>>
>>> Changes from v9:
>>> - restored "default" case in the server status switch for libssh < 0.=
8.0
>>> - print the host key type & fingerprint on mismatch with known_hosts
>>> - improve/fix message for failed socket_set_nodelay()
>>> - reset s->sock properly
>>>
>>> Changes from v8:
>>> - use a newer key type in iotest 207
>>> - improve the commit message
>>>
>>> Changes from v7:
>>> - #if HAVE_LIBSSH_0_8 -> #ifdef HAVE_LIBSSH_0_8
>>> - ptrdiff_t -> size_t
>>>
>>> Changes from v6:
>>> - fixed few checkpatch style issues
>>> - detect libssh 0.8 via symbol detection
>>> - adjust travis/docker test material
>>> - remove dead "default" case in a switch
>>> - use variables for storing MIN() results
>>> - adapt a documentation bit
>>>
>>> Changes from v5:
>>> - adapt to newer tracing APIs
>>> - disable ssh compression (mimic what libssh2 does by default)
>>> - use build time checks for libssh 0.8, and use newer APIs directly
>>>
>>> Changes from v4:
>>> - fix wrong usages of error_setg/session_error_setg/sftp_error_setg
>>> - fix few return code checks
>>> - remove now-unused parameters in few internal functions
>>> - allow authentication with "none" method
>>> - switch to unsigned int for the port number
>>> - enable TCP_NODELAY on the socket
>>> - fix one reference error message in iotest 207
>>>
>>> Changes from v3:
>>> - fix socket cleanup in connect_to_ssh()
>>> - add comments about the socket cleanup
>>> - improve the error reporting (closer to what was with libssh2)
>>> - improve EOF detection on sftp_read()
>>>
>>> Changes from v2:
>>> - used again an own fd
>>> - fixed co_yield() implementation
>>>
>>> Changes from v1:
>>> - fixed jumbo packets writing
>>> - fixed missing 'err' assignment
>>> - fixed commit message
>>>
>>>  .travis.yml                                   |   4 +-
>>>  block/Makefile.objs                           |   6 +-
>>>  block/ssh.c                                   | 665 ++++++++++------=
--
>>>  block/trace-events                            |  14 +-
>>>  configure                                     |  65 +-
>>>  docs/qemu-block-drivers.texi                  |   2 +-
>>>  .../dockerfiles/debian-win32-cross.docker     |   1 -
>>>  .../dockerfiles/debian-win64-cross.docker     |   1 -
>>>  tests/docker/dockerfiles/fedora.docker        |   4 +-
>>>  tests/docker/dockerfiles/ubuntu.docker        |   2 +-
>>>  tests/docker/dockerfiles/ubuntu1804.docker    |   2 +-
>>>  tests/qemu-iotests/207                        |   4 +-
>>>  tests/qemu-iotests/207.out                    |   2 +-
>>>  13 files changed, 423 insertions(+), 349 deletions(-)
>>
>> [...]
>>
>>> diff --git a/block/ssh.c b/block/ssh.c
>>> index 6da7b9cbfe..644ae8b82c 100644
>>> --- a/block/ssh.c
>>> +++ b/block/ssh.c
>>
>> [...]
>>
>>> +    case SSH_SERVER_KNOWN_CHANGED:
>>> +        ret =3D -EINVAL;
>>> +        r =3D ssh_get_publickey(s->session, &pubkey);
>>> +        if (r =3D=3D 0) {
>>> +            r =3D ssh_get_publickey_hash(pubkey, SSH_PUBLICKEY_HASH_=
SHA1,
>>> +                                       &server_hash, &server_hash_le=
n);
>>> +            pubkey_type =3D ssh_key_type(pubkey);
>>> +            ssh_key_free(pubkey);
>>> +        }
>>> +        if (r =3D=3D 0) {
>>> +            fingerprint =3D ssh_get_fingerprint_hash(SSH_PUBLICKEY_H=
ASH_SHA1,
>>> +                                                   server_hash,
>>> +                                                   server_hash_len);=

>>> +            ssh_clean_pubkey_hash(&server_hash);
>>> +        }
>>> +        if (fingerprint) {
>>> +            error_setg(errp,
>>> +                       "host key (%s key with fingerprint %s) does n=
ot match "
>>> +                       "the one in known_hosts",
>>> +                       ssh_key_type_to_char(pubkey_type), fingerprin=
t);
>>> +            ssh_string_free_char(fingerprint);
>>> +        } else  {
>>> +            error_setg(errp, "host key does not match the one in kno=
wn_hosts");
>>> +        }
>>
>> Usually I=E2=80=99d say that more information can=E2=80=99t be bad.  B=
ut here I don=E2=80=99t
>> see how this additional information is useful.  known_hosts contains
>> base64-encoded full public keys.  This only prints the SHA-1 digest.
>> The user cannot add that to known_hosts, or easily scan known_hosts to=

>> see whether it perhaps belongs to some other hosts (maybe because DHCP=

>> scrambled something).
>>
>> Actually, even if this printed the base64 representation of the full
>> key, the user probably wouldn=E2=80=99t just add that to known_hosts o=
r do
>> anything with it.  They=E2=80=99ll debug the problem with other tools.=

>>
>> So I don=E2=80=99t think this new information is really useful...?
>>
>>
>> (Hmm, I don=E2=80=99t know if this is a response to my =E2=80=9CBut th=
e specification
>> requires a warning!!1!=E2=80=9D, but if so, I was actually not referri=
ng to more
>> information but to this:
>>
>> $ ssh 192.168.0.12
>> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>> @    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
>> @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
>> IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
>> Someone could be eavesdropping on you right now (man-in-the-middle att=
ack)!
>> It is also possible that a host key has just been changed.
>>
>>
>> I mean, I was also only half-serious.  I should be serious because the=

>> libssh specification requires us to print some warning like that, but,=

>> well.  Yes, I=E2=80=99ll stop mumbling about this stuff now.)
>=20
> Those giant messages are targetted at humans though so I'm not so
> convinced it is useful for apps managing QEMU. IMHO it is sufficient
> to just report a simple error that the host ident check failed as
> the patch does now. It gives enough info to then investigate further
> to identify the root cause problems.

I fully agree that that message is absolutely unsuitable for qemu.  I
didn=E2=80=99t state that, which is my mistake, sorry.

The point I wanted to make is that I=E2=80=99m citing something that does=
n=E2=80=99t
print any data, but just an attack warning.  I=E2=80=99d be content with =
just a
single sentence to that effect (and please not in caps lock), like =E2=80=
=9CIt
is possible that someone is attempting a man-in-the-middle attack.=E2=80=9D=


Max


--teuDlYQjULC7sRTqZWELyqeaG4TWQ1Vrd--

--W7lC5XEMfat3BDCQZAZvudtPQQjKD6obp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0Lg8UACgkQ9AfbAGHV
z0Cqhgf+JjYcP9g3oVLpUVwIdG4zKSvGhZz13INFMH0n/5y5oTgt+DoxYFC+tOBz
DOOp2BOxcCk3azvLcyTi8xesMZd+P/DDoBY7+9W2UU6F8kQtpfwVvVAE42SSuPAR
NGNUz3uDrhteOGaLy8Kd1R8KqYAwgOmeVJfRp/Y6OO3nNb9AuBm3SdvRzqfiGFII
Kl9mtF94WHA6blL2q79FzDdWsmAAiodp2+y/F3ObfHPBYXp5tEhisjGazfzmemw0
hSNDc0I6oVS+x+k64emtzNYu3eXLm/rWWWjFgTZiEJKnGT/SriFcUVoeZprYwG3A
m3tBOQEYwRWO2C4brrpMUzhnqs41yA==
=54Wh
-----END PGP SIGNATURE-----

--W7lC5XEMfat3BDCQZAZvudtPQQjKD6obp--

