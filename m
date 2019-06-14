Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B369AC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:37:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F06B2173C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F06B2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52756 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hboGQ-0002GV-Sg
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:37:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50781)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbnw2-00056p-B5
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:16:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbnvz-0008Co-PN
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:16:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35827)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbnvz-00088b-Et
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:16:07 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so2717054wml.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 08:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=3oeWMrG9iyCbJMG1a3hxU6dVR+q2fBnhiMQiE6WqYo4=;
 b=kOjhhhhl3B+7tAn6rR+8m6XoFEv26KrmsszCR+U/OHmsB/O/nDg3eFIMtz8WfoLCKq
 ZRk/uwFapyNaeKHddZoV75fjp7rNv6jZCJ8Rxchmc9BYXuzMlUKzFTvZscn0rR9kBqt3
 DOEmngcjD1dQf78CyMi/hE6pIJ8TQSEUjDV3LGxOmsg9197ZBcmpYKrgznwplVFAvTH3
 5+5ABQf+EWefoUHznrtG/ZG0esJ4ZMnm7fOoylML3JopiR0+B6v5NM/Y5zpmUtEXow8P
 EbF4baJcaZXVFhl5NaPFomq0jPuDLdziaX8XQCIZrsvdrEfnc/eaBoQ+03/OlMwDFCDi
 9cFw==
X-Gm-Message-State: APjAAAW9ahTvyk63qyhxoF9m1O12KmtscBKxCbUGwjwHTg9tkQdr78L8
 7L0OxR5tfACyYaLHbdDEP98YsA==
X-Google-Smtp-Source: APXvYqyI3tar24n0hCC4Il49ljzhJqJQqyqQ6O4mFzWUey8PLi++atg++q6ydc9jc98U5pjv0KTk/A==
X-Received: by 2002:a1c:39d6:: with SMTP id g205mr7992566wma.85.1560525359635; 
 Fri, 14 Jun 2019 08:15:59 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id c24sm3136352wmb.21.2019.06.14.08.15.58
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Jun 2019 08:15:58 -0700 (PDT)
To: Max Reitz <mreitz@redhat.com>, Pino Toscano <ptoscano@redhat.com>
References: <20190613132000.2146-1-ptoscano@redhat.com>
 <12e43f31-5fd3-b9eb-37af-e05e6250bd4a@redhat.com>
 <2592166.7WioNeH6bT@lindworm.usersys.redhat.com>
 <a6ba02da-711d-77c7-6bd1-b9ede5aecd81@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e4c2f281-e4d4-4ee9-c9ee-73eb32af8174@redhat.com>
Date: Fri, 14 Jun 2019 17:15:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a6ba02da-711d-77c7-6bd1-b9ede5aecd81@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="c0aUQ8TvlHBYPnN5q6kEJ8gCb41qbwofr"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, sw@weilnetz.de,
 qemu-devel@nongnu.org, rjones@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c0aUQ8TvlHBYPnN5q6kEJ8gCb41qbwofr
Content-Type: multipart/mixed; boundary="T88KCyBgYU9fmufqeKFt6cuJrPOZSDYkh";
 protected-headers="v1"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Pino Toscano <ptoscano@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com,
 kwolf@redhat.com, alex.bennee@linaro.org, fam@euphon.net, sw@weilnetz.de
Message-ID: <e4c2f281-e4d4-4ee9-c9ee-73eb32af8174@redhat.com>
Subject: Re: [PATCH v9] ssh: switch from libssh2 to libssh
References: <20190613132000.2146-1-ptoscano@redhat.com>
 <12e43f31-5fd3-b9eb-37af-e05e6250bd4a@redhat.com>
 <2592166.7WioNeH6bT@lindworm.usersys.redhat.com>
 <a6ba02da-711d-77c7-6bd1-b9ede5aecd81@redhat.com>
In-Reply-To: <a6ba02da-711d-77c7-6bd1-b9ede5aecd81@redhat.com>

--T88KCyBgYU9fmufqeKFt6cuJrPOZSDYkh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/14/19 4:34 PM, Max Reitz wrote:
> On 14.06.19 16:29, Pino Toscano wrote:
>> On Thursday, 13 June 2019 21:31:40 CEST Max Reitz wrote:
>>> On 13.06.19 15:20, Pino Toscano wrote:
[...]
>>>> -    case LIBSSH2_KNOWNHOST_CHECK_NOTFOUND:
>>>> +    case SSH_KNOWN_HOSTS_OTHER:
>>>>          ret =3D -EINVAL;
>>>> -        session_error_setg(errp, s, "no host key was found in known=
_hosts");
>>>> +        error_setg(errp,
>>>> +                   "host key for this server not found, another typ=
e exists");
>>>>          goto out;
>>>> -    case LIBSSH2_KNOWNHOST_CHECK_FAILURE:
>>>> +    case SSH_KNOWN_HOSTS_UNKNOWN:
>>>>          ret =3D -EINVAL;
>>>> -        session_error_setg(errp, s,
>>>> -                      "failure matching the host key with known_hos=
ts");
>>>> +        error_setg(errp, "no host key was found in known_hosts");
>>>> +        goto out;
>>>> +    case SSH_KNOWN_HOSTS_NOT_FOUND:
>>>> +        ret =3D -ENOENT;
>>>> +        error_setg(errp, "known_hosts file not found");
>>>> +        goto out;
>>>> +    case SSH_KNOWN_HOSTS_ERROR:
>>>> +        ret =3D -EINVAL;
>>>> +        error_setg(errp, "error while checking the host");
>>>>          goto out;
>>>>      default:
>>>>          ret =3D -EINVAL;
>>>> -        session_error_setg(errp, s, "unknown error matching the hos=
t key"
>>>> -                      " with known_hosts (%d)", r);
>>>> +        error_setg(errp, "error while checking for known server");
>>>>          goto out;
>>>>      }
>>>> +#else /* !HAVE_LIBSSH_0_8 */
>>>> +    int state;
>>>> +
>>>> +    state =3D ssh_is_server_known(s->session);
>>>> +    trace_ssh_server_status(state);
>>>> +
>>>> +    switch (state) {
>>>> +    case SSH_SERVER_KNOWN_OK:
>>>> +        /* OK */
>>>> +        trace_ssh_check_host_key_knownhosts();
>>>> +        break;
>>>> +    case SSH_SERVER_KNOWN_CHANGED:
>>>> +        ret =3D -EINVAL;
>>>> +        error_setg(errp, "host key does not match the one in known_=
hosts");
>>>> +        goto out;
>>>> +    case SSH_SERVER_FOUND_OTHER:
>>>> +        ret =3D -EINVAL;
>>>> +        error_setg(errp,
>>>> +                   "host key for this server not found, another typ=
e exists");
>>>> +        goto out;
>>>> +    case SSH_SERVER_FILE_NOT_FOUND:
>>>> +        ret =3D -ENOENT;
>>>> +        error_setg(errp, "known_hosts file not found");
>>>> +        goto out;
>>>> +    case SSH_SERVER_NOT_KNOWN:
>>>> +        ret =3D -EINVAL;
>>>> +        error_setg(errp, "no host key was found in known_hosts");
>>>> +        goto out;
>>>> +    case SSH_SERVER_ERROR:
>>>> +        ret =3D -EINVAL;
>>>> +        error_setg(errp, "server error");
>>>> +        goto out;
>>>
>>> No default here?
>>
>> This switch is for libssh < 0.8.0, so enumerating all the possible
>> values of the enum of the old API is enough.
>=20
> state is an integer.  I feel very uneasy about not having a default
> clause for a plain integer, especially if it is supplied by an external=

> library.

Agreed. What's odd is I tested it on Ubuntu Xenial which is 0.6.3 and no
got no cpp warning. I wonder if it is using a backported patch adding
ssh_session_is_known_server(), like 0.7.1 on Ubuntu Bionic. Anyway,
better add a default.


--T88KCyBgYU9fmufqeKFt6cuJrPOZSDYkh--

--c0aUQ8TvlHBYPnN5q6kEJ8gCb41qbwofr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAl0Dui0ACgkQoqP9bt6t
wN6sRg/+OxlJ1N/rqSaJokUGR+3fv8pSshRnB69YZEoFLZRjXpTn2kqwb0CqIOSE
xAqjBaiPakyGMRiElvB7hhGgQ1L64nv9R9SrLg471aFjiWfUbLp4bPmu8cwWlkKO
gRy+m3bsZQNotqz5MSQww2nsafXO3zjNYXtF7sblwdpVBHMCoPrsfk1IheU5TczC
hJ0YY+qF/WPuurjUwVDC1V8BvSzNcVaqnQwbGsp4+GGXIHpAE9aGsBBzSQLHg7Ee
o7Vha/wS8YLwLjvdMjXUrHlDXUc6Si7Jz1cxePRBxoR2O2ZYIXKuetdCb9sw3MuL
yvP5Hbzn59PATHhQyagg1urqGiqUGlNTAtX2v2ht5oRCsunRJANvoBaiHOPMxJxO
eKNmVEFk/4JZiP8pRdOske7uI5PPWVxOAdG45tmXApxbz/4tQleD9wACU/hUxBgs
vjJMKDnWWH6ElLxhfFg28Xdr3zygHwdPoAFOGRIpIkxbF8G3cYwDrwV5ramvgMGN
DQbpOLbyHsdI3LKTN3Mhun3Ma9RLZO2LfuIqKG8ORMJVSXtPYMpIZ9kn0Fy+ari7
Kjbp+uVf4ksw1ZuBPUBf177jZSsP1bOjENNDqkXwtNpvR2r+aPjUdgxjSXZj8OOj
wSGVRomtMXAVKijJTrDA9f8rILQR3cJ6ms54qov0KakUVMqJi/M=
=kAaW
-----END PGP SIGNATURE-----

--c0aUQ8TvlHBYPnN5q6kEJ8gCb41qbwofr--

