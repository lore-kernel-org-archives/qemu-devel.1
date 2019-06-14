Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8A5C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E0521537
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:12:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E0521537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbns0-0000kn-6V
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35322)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbnIy-0007Ru-5M
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbnIv-0005dT-1u
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53718)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbnIq-0005K9-1z; Fri, 14 Jun 2019 10:35:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 427F3F4958;
 Fri, 14 Jun 2019 14:35:10 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 977907D566;
 Fri, 14 Jun 2019 14:35:00 +0000 (UTC)
To: Pino Toscano <ptoscano@redhat.com>
References: <20190613132000.2146-1-ptoscano@redhat.com>
 <12e43f31-5fd3-b9eb-37af-e05e6250bd4a@redhat.com>
 <2592166.7WioNeH6bT@lindworm.usersys.redhat.com>
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
Message-ID: <a6ba02da-711d-77c7-6bd1-b9ede5aecd81@redhat.com>
Date: Fri, 14 Jun 2019 16:34:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <2592166.7WioNeH6bT@lindworm.usersys.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Dn3CwXfuv2EwMqY3VstjuOA7nXxHmjMDv"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Fri, 14 Jun 2019 14:35:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v9] ssh: switch from libssh2 to libssh
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
--Dn3CwXfuv2EwMqY3VstjuOA7nXxHmjMDv
Content-Type: multipart/mixed; boundary="468McV28QjrRZp0OVP545dBao1Uq0E9j8";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Pino Toscano <ptoscano@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com,
 kwolf@redhat.com, philmd@redhat.com, alex.bennee@linaro.org, fam@euphon.net,
 sw@weilnetz.de
Message-ID: <a6ba02da-711d-77c7-6bd1-b9ede5aecd81@redhat.com>
Subject: Re: [PATCH v9] ssh: switch from libssh2 to libssh
References: <20190613132000.2146-1-ptoscano@redhat.com>
 <12e43f31-5fd3-b9eb-37af-e05e6250bd4a@redhat.com>
 <2592166.7WioNeH6bT@lindworm.usersys.redhat.com>
In-Reply-To: <2592166.7WioNeH6bT@lindworm.usersys.redhat.com>

--468McV28QjrRZp0OVP545dBao1Uq0E9j8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.06.19 16:29, Pino Toscano wrote:
> On Thursday, 13 June 2019 21:31:40 CEST Max Reitz wrote:
>> On 13.06.19 15:20, Pino Toscano wrote:
>>> -    switch (r) {
>>> -    case LIBSSH2_KNOWNHOST_CHECK_MATCH:
>>> +    switch (state) {
>>> +    case SSH_KNOWN_HOSTS_OK:
>>>          /* OK */
>>> -        trace_ssh_check_host_key_knownhosts(found->key);
>>> +        trace_ssh_check_host_key_knownhosts();
>>>          break;
>>> -    case LIBSSH2_KNOWNHOST_CHECK_MISMATCH:
>>> +    case SSH_KNOWN_HOSTS_CHANGED:
>>>          ret =3D -EINVAL;
>>> -        session_error_setg(errp, s,
>>> -                      "host key does not match the one in known_host=
s"
>>> -                      " (found key %s)", found->key);
>>> +        error_setg(errp, "host key does not match the one in known_h=
osts");
>>
>> So what about the possible attack warning that the specification
>> technically requires us to print? O:-)
>=20
> There is the API since libssh 0.8.0... which unfortunately is not
> usable, as they forgot to properly export the symbol :-(

Actuall, I just meant adding some wording about that to the error message=
=2E

>>>          goto out;
>>> -    case LIBSSH2_KNOWNHOST_CHECK_NOTFOUND:
>>> +    case SSH_KNOWN_HOSTS_OTHER:
>>>          ret =3D -EINVAL;
>>> -        session_error_setg(errp, s, "no host key was found in known_=
hosts");
>>> +        error_setg(errp,
>>> +                   "host key for this server not found, another type=
 exists");
>>>          goto out;
>>> -    case LIBSSH2_KNOWNHOST_CHECK_FAILURE:
>>> +    case SSH_KNOWN_HOSTS_UNKNOWN:
>>>          ret =3D -EINVAL;
>>> -        session_error_setg(errp, s,
>>> -                      "failure matching the host key with known_host=
s");
>>> +        error_setg(errp, "no host key was found in known_hosts");
>>> +        goto out;
>>> +    case SSH_KNOWN_HOSTS_NOT_FOUND:
>>> +        ret =3D -ENOENT;
>>> +        error_setg(errp, "known_hosts file not found");
>>> +        goto out;
>>> +    case SSH_KNOWN_HOSTS_ERROR:
>>> +        ret =3D -EINVAL;
>>> +        error_setg(errp, "error while checking the host");
>>>          goto out;
>>>      default:
>>>          ret =3D -EINVAL;
>>> -        session_error_setg(errp, s, "unknown error matching the host=
 key"
>>> -                      " with known_hosts (%d)", r);
>>> +        error_setg(errp, "error while checking for known server");
>>>          goto out;
>>>      }
>>> +#else /* !HAVE_LIBSSH_0_8 */
>>> +    int state;
>>> +
>>> +    state =3D ssh_is_server_known(s->session);
>>> +    trace_ssh_server_status(state);
>>> +
>>> +    switch (state) {
>>> +    case SSH_SERVER_KNOWN_OK:
>>> +        /* OK */
>>> +        trace_ssh_check_host_key_knownhosts();
>>> +        break;
>>> +    case SSH_SERVER_KNOWN_CHANGED:
>>> +        ret =3D -EINVAL;
>>> +        error_setg(errp, "host key does not match the one in known_h=
osts");
>>> +        goto out;
>>> +    case SSH_SERVER_FOUND_OTHER:
>>> +        ret =3D -EINVAL;
>>> +        error_setg(errp,
>>> +                   "host key for this server not found, another type=
 exists");
>>> +        goto out;
>>> +    case SSH_SERVER_FILE_NOT_FOUND:
>>> +        ret =3D -ENOENT;
>>> +        error_setg(errp, "known_hosts file not found");
>>> +        goto out;
>>> +    case SSH_SERVER_NOT_KNOWN:
>>> +        ret =3D -EINVAL;
>>> +        error_setg(errp, "no host key was found in known_hosts");
>>> +        goto out;
>>> +    case SSH_SERVER_ERROR:
>>> +        ret =3D -EINVAL;
>>> +        error_setg(errp, "server error");
>>> +        goto out;
>>
>> No default here?
>=20
> This switch is for libssh < 0.8.0, so enumerating all the possible
> values of the enum of the old API is enough.

state is an integer.  I feel very uneasy about not having a default
clause for a plain integer, especially if it is supplied by an external
library.

>>> @@ -775,16 +845,13 @@ static int ssh_file_open(BlockDriverState *bs, =
QDict *options, int bdrv_flags,
>>>      }
>>> =20
>>>      /* Go non-blocking. */
>>> -    libssh2_session_set_blocking(s->session, 0);
>>> +    ssh_set_blocking(s->session, 0);
>>> =20
>>>      qapi_free_BlockdevOptionsSsh(opts);
>>> =20
>>>      return 0;
>>> =20
>>>   err:
>>> -    if (s->sock >=3D 0) {
>>> -        close(s->sock);
>>> -    }
>>>      s->sock =3D -1;
>>
>> Shouldn=E2=80=99t connect_to_ssh() set this to -1 after closing the se=
ssion?
>=20
> It should, although it will not make a difference. connect_to_ssh() is
> used in only two places:
> - in ssh_file_open, and s->sock is reset to -1 on error
> - in ssh_co_create, which uses a local BDRVSSHState

I meant: Why don=E2=80=99t you move this to connect_to_ssh()?

>>> diff --git a/tests/qemu-iotests/207 b/tests/qemu-iotests/207
>>> index b3816136f7..774eb5f2a9 100755
>>> --- a/tests/qemu-iotests/207
>>> +++ b/tests/qemu-iotests/207
>>
>> [...]
>>
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
>> Hm.  This is a pain.
>>
>> I suppose the best would be to drop the "-t" altogether and then check=

>> whether any of the entries ssh-keyscan reports matches.
>=20
> The problem here is slightly more than this:
> - libssh2 supports only rsa and dsa keys, so when connecting rsa keys
>   are usually used, and thus it is easy to pass a fingerprint for that
>   rsa key
> - libssh supports more recent (and stronger) types of keys, which of
>   course are preferred by more modern (open)ssh servers.  Thus it is no=
t
>   possible to know which key will be used when connecting, unless force=
d
>   (which I'd rather not do)
> A possible future improvement could be IMHO to add an extra option to
> set the allowed key types for the connection, so you can set it to a
> specific one and specify the right fingerprint for it.

I suppose we can just try all fingerprints we have and then see whether
any works.

Max


--468McV28QjrRZp0OVP545dBao1Uq0E9j8--

--Dn3CwXfuv2EwMqY3VstjuOA7nXxHmjMDv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0DsJMACgkQ9AfbAGHV
z0DNdwf/Zby7HEVlHyZWDOTxJByiaAaIYWDeXNvBmm65lr2IweMjHMnTvcLXYs/f
+RMbaBk8o3Bjq2j5X4F2YxUE6F43elE3OhKrneefBbvsXqxBzPvP4kMXmiW7RLug
8I8HlDfZuBS2iudHBdHAx5kK9mhnnYkOZGjPwlhbAMTp7eeW9/6eVADUEbxiJ/jG
oKLY34IZPQsu+4PBZmtus8qtmjjDCbNJOlu3Y1fTUQ3WryuXgjDvYYFC54v2b9m5
rAZo8rzhtnowuyCI9n0Av9EAO20Cs/8brZUvblL9FlVBk+4Yv28RHjtWg0GQ/kjd
MZSJPuKpwSqDWjMwrVmmXUb2tBl5tw==
=n5+/
-----END PGP SIGNATURE-----

--Dn3CwXfuv2EwMqY3VstjuOA7nXxHmjMDv--

