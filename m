Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A31C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:07:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F096320866
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:07:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F096320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52440 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnny-0005s8-8N
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34228)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbnEU-0004dk-Iv
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbnES-00027b-LK
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:31:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58834)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbnEH-0001wi-0U; Fri, 14 Jun 2019 10:30:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 96C48C058CBA;
 Fri, 14 Jun 2019 14:30:55 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3ECFF5D9D2;
 Fri, 14 Jun 2019 14:30:51 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20190613132000.2146-1-ptoscano@redhat.com>
 <12e43f31-5fd3-b9eb-37af-e05e6250bd4a@redhat.com>
 <69064867-56ec-be41-a59e-30cb085247ea@redhat.com>
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
Message-ID: <04ebf0f8-25eb-57ba-4b09-def017726714@redhat.com>
Date: Fri, 14 Jun 2019 16:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <69064867-56ec-be41-a59e-30cb085247ea@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AtMlqVygL9u4mfFNGddp63FQD8beuybfj"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 14 Jun 2019 14:30:55 +0000 (UTC)
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
Cc: kwolf@redhat.com, fam@euphon.net, alex.bennee@linaro.org, rjones@redhat.com,
 sw@weilnetz.de
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AtMlqVygL9u4mfFNGddp63FQD8beuybfj
Content-Type: multipart/mixed; boundary="EnkBhynUPDmZ6EBgzRsjhsoAycEK4qnzZ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: rjones@redhat.com, kwolf@redhat.com, alex.bennee@linaro.org,
 fam@euphon.net, sw@weilnetz.de
Message-ID: <04ebf0f8-25eb-57ba-4b09-def017726714@redhat.com>
Subject: Re: [PATCH v9] ssh: switch from libssh2 to libssh
References: <20190613132000.2146-1-ptoscano@redhat.com>
 <12e43f31-5fd3-b9eb-37af-e05e6250bd4a@redhat.com>
 <69064867-56ec-be41-a59e-30cb085247ea@redhat.com>
In-Reply-To: <69064867-56ec-be41-a59e-30cb085247ea@redhat.com>

--EnkBhynUPDmZ6EBgzRsjhsoAycEK4qnzZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.06.19 16:26, Philippe Mathieu-Daud=C3=A9 wrote:
> On 6/13/19 9:31 PM, Max Reitz wrote:
>> On 13.06.19 15:20, Pino Toscano wrote:
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
>>
>> Can confirm that this runs much faster than the last version I tested.=

>> 197 and 215 are still whacky (like 100 s instead of 50), but that=E2=80=
=99s fine
>> with me. :-)
>>
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
>>>  block/ssh.c                                   | 622 +++++++++-------=
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
>>>  13 files changed, 376 insertions(+), 353 deletions(-)
>>
>> Surprisingly little has changed since v4.  Good, good, that makes my
>> reviewing job much easier because I can thus rely on past me. :-)
>>
>>> diff --git a/block/ssh.c b/block/ssh.c
>>> index 6da7b9cbfe..fb458d4548 100644
>>> --- a/block/ssh.c
>>> +++ b/block/ssh.c
>>
>> [...]
>>
>>> @@ -282,82 +274,85 @@ static void ssh_parse_filename(const char *file=
name, QDict *options,
>>>      parse_uri(filename, options, errp);
>>>  }
>>> =20
>>> -static int check_host_key_knownhosts(BDRVSSHState *s,
>>> -                                     const char *host, int port, Err=
or **errp)
>>> +static int check_host_key_knownhosts(BDRVSSHState *s, Error **errp)
>>>  {
>>
>> [...]
>>
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
>>
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
> I explicitly suggested Pino to not use default here, since
> ssh_server_known_e is a finite enum. If upstream libssh adds more
> errors, and a distrib packages a new version, we'll get a build error.
> It looks quicker for us to react than adding a abort() here and wait an=

> user to complain. But this is a personal preference, I won't object if
> you prefer we use a default here.

Well, OK, but this is the pre-0.8 code path,  "state" is an integer here.=


Max

>>> +    }
>>> +#endif /* !HAVE_LIBSSH_0_8 */

[...]

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
> This was my first approach, but then the 207.out file doesn't match.
> I don't know enough of iotests fu to help here :(

I=E2=80=99ll see what I can do.

Max


--EnkBhynUPDmZ6EBgzRsjhsoAycEK4qnzZ--

--AtMlqVygL9u4mfFNGddp63FQD8beuybfj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0Dr5kACgkQ9AfbAGHV
z0ARPQf8C69ooI4jHiVx4jQHQ4YZGipjFw0QNVq7rQjNymxVt3vSZYju4q4AFYRl
ejhDCICiQb0IBSyaUzryvhW9KrwoOrazdVOSwmbFKaWuV/zOog7GKQEpWaVLmkGs
alzlmtuN214Ft+ZvMwlYLHhpA3X31auXoOHKNO6ImNQS7xk9AqBXAbo1byCTGjrP
ImrLt1CCwBnWsfHzlbGe/P2Lu875gIlYNq4yNrDmUv69l7T3q57eXTbHbTrOVtCB
YnEZVWsPMf4vmxXRei/wjje9VBobDn6K6KGj5mTiAfBFph68zIs2UWfkRE7zqg/h
XEHWOVagDA2L60PVGl2qBSI7yGH1zQ==
=jhgT
-----END PGP SIGNATURE-----

--AtMlqVygL9u4mfFNGddp63FQD8beuybfj--

