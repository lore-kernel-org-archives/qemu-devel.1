Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7E9C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69FBA206E0
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 13:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FBA206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47692 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdx0J-0004gQ-35
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 09:21:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51184)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hdwx9-0002kz-IR
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hdwur-0004oy-FA
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 09:15:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hdweP-0007As-MG; Thu, 20 Jun 2019 08:58:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 756BB88319;
 Thu, 20 Jun 2019 12:58:46 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA6CD601A5;
 Thu, 20 Jun 2019 12:58:41 +0000 (UTC)
To: Pino Toscano <ptoscano@redhat.com>
References: <20190618092403.30006-1-ptoscano@redhat.com>
 <ca41c9ef-aa6d-2e17-42a0-3a1beb42e208@redhat.com>
 <3681094.1Qnffhumos@lindworm.usersys.redhat.com>
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
Message-ID: <bca1ddde-652a-11df-5e48-826ab1799d98@redhat.com>
Date: Thu, 20 Jun 2019 14:58:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3681094.1Qnffhumos@lindworm.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ady3dx0N95hSV4HBwTNDB28R4QJUZTQwX"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 20 Jun 2019 12:58:48 +0000 (UTC)
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
--Ady3dx0N95hSV4HBwTNDB28R4QJUZTQwX
Content-Type: multipart/mixed; boundary="fo5L193fUR3craVe10LG8UpNmOJ4adfWg";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Pino Toscano <ptoscano@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com,
 kwolf@redhat.com, philmd@redhat.com, alex.bennee@linaro.org, fam@euphon.net,
 sw@weilnetz.de
Message-ID: <bca1ddde-652a-11df-5e48-826ab1799d98@redhat.com>
Subject: Re: [PATCH v10] ssh: switch from libssh2 to libssh
References: <20190618092403.30006-1-ptoscano@redhat.com>
 <ca41c9ef-aa6d-2e17-42a0-3a1beb42e208@redhat.com>
 <3681094.1Qnffhumos@lindworm.usersys.redhat.com>
In-Reply-To: <3681094.1Qnffhumos@lindworm.usersys.redhat.com>

--fo5L193fUR3craVe10LG8UpNmOJ4adfWg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.06.19 11:49, Pino Toscano wrote:
> On Tuesday, 18 June 2019 15:14:30 CEST Max Reitz wrote:
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
>=20
> Note that SHA-1 is printed with libssh < 0.8; with libssh >=3D 0.8 SHA-=
256
> is used instead.
>=20
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
>=20
> When this situation happens with openssh, the big scary message prints
> three things:
> 1) the fingerprint of the server
> 2) the line of the server in the known_hosts file
> 3) how to remove the keys of the server from known_hosts, i.e. a
>    copy-paste'able `ssh-keygen -R host`
>=20
> Here I'm doing only (1).  Also, the current libssh2 driver does
> something else, i.e. print the base64/printable representation of the
> server key in known_hosts.

Well, I don=E2=80=99t know whether it=E2=80=99s necessary to reproduce th=
e exact message
with all the data it contains.  As I said, I think users can and will
investigate the exact root of the problem with tools outside of qemu.
(Such as openssh=E2=80=99s ssh itself.)

>> (Hmm, I don=E2=80=99t know if this is a response to my =E2=80=9CBut th=
e specification
>> requires a warning!!1!=E2=80=9D, but if so, I was actually not referri=
ng to more
>> information but to this:
>=20
> You mentioned this few times: can you please point me to this bit?
> I read few RFCs related to ssh, and I did not find this information...

For example:
http://api.libssh.org/master/group__libssh__session.html#gacbc5d04fe66bee=
e863a0c61a93fdf765
> SSH_KNOWN_HOSTS_CHANGED: The server key has changed. Either you are und=
er attack or the administrator changed the key. You HAVE to warn the user=
 about a possible attack.

This doesn=E2=80=99t require any specific formatting or data to be given =
to the
user.  All it requires is =E2=80=9Cto warn the user about a possible atta=
ck=E2=80=9D.
That can be as simple as appending =E2=80=9CThis may be due to a
man-in-the-middle attack=E2=80=9D to the error message.

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
> To be on the explic side: are you asking to basically put the first 6
> lines of the openssh error message (as you quoted them above) as error
> message in the ssh driver?

God forbid no.  I was just making an example of =E2=80=9CHere is a warnin=
g about
a possible attack=E2=80=9D.  I fully agree with Dan (and probably you) th=
at this
is completely unsuitable to qemu=E2=80=99s interface.

Sorry if that came across in another way.

> As data point (I know it is not a strong argument), I'll mention that
> the current libssh2-based driver does not do that, and (according to my=

> possibly limited knowledge) there were no problems/complaints about
> that.  Sure, improvements are good, I get that, although I do not see
> why just changing the underlying implementation of a driver makes an
> error message for the same situation immediately no more acceptable.
> I'm perfectly fine in improving this in sequent patches, for example --=

> as I mentioned, the API for this in libssh is sadly not usable, and it
> will be usable with the future libssh 0.9.0 (kudos to the libssh guys
> for the fast fix).

Again, I=E2=80=99m only being half-serious.  I tried to bring that point =
across
every time I mention this thing.

If you just say =E2=80=9CLet=E2=80=99s leave it as it is, I don=E2=80=99t=
 see any benefit=E2=80=9D,
sure, OK, I=E2=80=99ll accept that.

But so far you didn=E2=80=99t say that, so I kept pestering on.


I would have never mentioned this topic if I hadn=E2=80=99t read the
specification while reviewing your patch last year and noticed that it
explicitly states =E2=80=9CYou HAVE to warn the user about a possible att=
ack.=E2=80=9D

I never said =E2=80=9CPlease emit the exact message openssh=E2=80=99s ssh=
=E2=80=9D emits.  Well,
I never meant to say that.  Maybe I accidentally did.  Sorry again.

My whole point is: The specification requires libssh users to emit
*some* warning.  If we want to adhere to the specification, we have to
do that.  Just one sentence is sufficient.

If we don=E2=80=99t want to adhere to the specification, sure, let=E2=80=99=
s go.  But
you=E2=80=99ll have to explicitly say that.  I=E2=80=99m not the patch au=
thor, I=E2=80=99m but a
humble reviewer, and as such I=E2=80=99ll point out all flaws I see.  You=
 have
to give justifications, not me. O:-)

>> [...]
>>
>>> diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
>>> index b3816136f7..774eb5f2a9 100755
>>> --- a/tests/qemu-iotests/207
>>> +++ b/tests/qemu-iotests/207
>>> @@ -111,7 +111,7 @@ with iotests.FilePath('t.img') as disk_path, \
>>>      iotests.img_info_log(remote_path)
>>> =20
>>>      md5_key =3D subprocess.check_output(
>>> -        'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" |=
 ' +
>>> +        'ssh-keyscan -t ssh-ed25519 127.0.0.1 2>/dev/null | grep -v =
"\\^#" | ' +
>>>          'cut -d" " -f3 | base64 -d | md5sum -b | cut -d" " -f1',
>>>          shell=3DTrue).rstrip().decode('ascii')
>>> =20
>>> @@ -149,7 +149,7 @@ with iotests.FilePath('t.img') as disk_path, \
>>>      iotests.img_info_log(remote_path)
>>> =20
>>>      sha1_key =3D subprocess.check_output(
>>> -        'ssh-keyscan -t rsa 127.0.0.1 2>/dev/null | grep -v "\\^#" |=
 ' +
>>> +        'ssh-keyscan -t ssh-ed25519 127.0.0.1 2>/dev/null | grep -v =
"\\^#" | ' +
>>>          'cut -d" " -f3 | base64 -d | sha1sum -b | cut -d" " -f1',
>>>          shell=3DTrue).rstrip().decode('ascii')
>>
>> I=E2=80=99ve attached a diff that makes this test pass for me.  Maybe =
also for
>> you and Philippe.
>=20
> It works for me as well, thanks!

Great!

Max



--fo5L193fUR3craVe10LG8UpNmOJ4adfWg--

--Ady3dx0N95hSV4HBwTNDB28R4QJUZTQwX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0LgwAACgkQ9AfbAGHV
z0BEywf8CC3cNwziu22RsElURnwFv1IjFIp+a1f1mYWRdRrY1YJ30bEeYcbxHwQb
OgS0gmDoEhIMq0solHXLJErPKJ+NNYZUCVw7S9Jr10XIe/URmqKX7T6htjmIADDo
25uaNsuRtZDetGm7ClTjdsCwgoUm0sLIvnFH8UoB9gaAzCAa/E3FgQTqHcmZnj7m
pa0HvNvXTOqIDBKy2YaOGe5I1yje0vHs0/xrDn1+0dagFj5f9NcXz4MYSpWqgY0k
fXxXMmHSSvFVGKBS7sOZ5+n7OI6Ndj5tDLrKpS8gq/ZaHQEojq8oP0yVJRmANiz+
lilfMVvOnEM8N3944w5ai265T2fjYg==
=DrQF
-----END PGP SIGNATURE-----

--Ady3dx0N95hSV4HBwTNDB28R4QJUZTQwX--

