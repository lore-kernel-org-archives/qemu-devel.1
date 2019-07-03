Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA46C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 886EF2184C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 17:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 886EF2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hijSx-0004NK-S2
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 13:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53182)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hijPt-0000Vu-2n
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:51:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hijPq-0002hq-84
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:51:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47140)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1hijPp-0002hG-Uo
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 13:51:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DC4A030821FF;
 Wed,  3 Jul 2019 17:51:21 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-65.brq.redhat.com
 [10.40.204.65])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37AFC83085;
 Wed,  3 Jul 2019 17:51:15 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Alberto Garcia <berto@igalia.com>
References: <cover.1550842915.git.berto@igalia.com>
 <20190423165501.GA27867@redhat.com>
 <b5fe7ed7-c11c-4f36-4973-c86031cbe046@redhat.com>
 <9a76848c-f499-6355-70ca-1d638dad3e8e@redhat.com>
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
Message-ID: <1c1c3302-a87c-6e3e-d1d7-c805972a7384@redhat.com>
Date: Wed, 3 Jul 2019 19:51:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9a76848c-f499-6355-70ca-1d638dad3e8e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nVmHrCsHTydHnhNtJWSIRlIDEmZkbMmgD"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 03 Jul 2019 17:51:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 0/3] char-socket: Fix race condition
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nVmHrCsHTydHnhNtJWSIRlIDEmZkbMmgD
Content-Type: multipart/mixed; boundary="03z1CoyzL7Cmzpbsuj9UXhCmNjzeatXk8";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Alberto Garcia <berto@igalia.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <1c1c3302-a87c-6e3e-d1d7-c805972a7384@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] char-socket: Fix race condition
References: <cover.1550842915.git.berto@igalia.com>
 <20190423165501.GA27867@redhat.com>
 <b5fe7ed7-c11c-4f36-4973-c86031cbe046@redhat.com>
 <9a76848c-f499-6355-70ca-1d638dad3e8e@redhat.com>
In-Reply-To: <9a76848c-f499-6355-70ca-1d638dad3e8e@redhat.com>

--03z1CoyzL7Cmzpbsuj9UXhCmNjzeatXk8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 05.06.19 21:36, Max Reitz wrote:
> On 26.04.19 09:51, Paolo Bonzini wrote:
>> On 23/04/19 18:55, Daniel P. Berrang=C3=A9 wrote:
>>> ping - paolo/marc-andr=C3=A9 - unless I'm missing something, it looks=
 like
>>> this chardev series slipped through the cracks and missed 4.0
>>
>> Yeah, it had a bug unfortunately.  I'm looking at it RSN.
>=20
> I=E2=80=99ll just leave another ping here

And another one.

Max

>> Paolo
>>
>>>
>>> On Fri, Feb 22, 2019 at 03:46:23PM +0200, Alberto Garcia wrote:
>>>> This fixes a race condition in which the tcp_chr_read() ioc handler
>>>> can close a connection that is being written to from another thread.=

>>>>
>>>> Note: vhost-user-test still fails if QTEST_VHOST_USER_FIXME is set.
>>>>
>>>> Berto
>>>>
>>>> RFC: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01510.=
html
>>>>
>>>> v1: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg01834.h=
tml
>>>> - Fixes memory leaks and adds a qemu_idle_add() function
>>>>
>>>> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg06137.h=
tml
>>>> - Rebased on top of the current master (fc3dbb90f2eb069801bfb4cfe9cb=
c)
>>>> - Patches 1 and 2: Remove the changes in char-pty.c, they're not
>>>>                    needed after the rebase.
>>>> - Patch 3: Fix conflicts after the rebase.
>>>>
>>>> v3:
>>>> - Patch 3: Add tcp_chr_disconnect_locked() [Daniel]
>>>>
>>>> Alberto Garcia (3):
>>>>   main-loop: Fix GSource leak in qio_task_thread_worker()
>>>>   main-loop: Add qemu_idle_add()
>>>>   char-socket: Lock tcp_chr_disconnect() and socket_reconnect_timeou=
t()
>>>>
>>>>  chardev/char-socket.c    | 25 +++++++++++++++++++++----
>>>>  include/qemu/main-loop.h | 12 ++++++++++++
>>>>  io/task.c                |  9 +++------
>>>>  util/main-loop.c         |  9 +++++++++
>>>>  4 files changed, 45 insertions(+), 10 deletions(-)
>>>>
>>>> --=20
>>>> 2.11.0
>>>>
>>>
>>> Regards,
>>> Daniel
>>>
>>
>>
>>
>=20
>=20



--03z1CoyzL7Cmzpbsuj9UXhCmNjzeatXk8--

--nVmHrCsHTydHnhNtJWSIRlIDEmZkbMmgD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0c6xEACgkQ9AfbAGHV
z0Dv8AgAvFf2TkCUs/dyZ3PrsAvz0LWga1EMYEnzBMVqL4/mr21QykxEFC2MvEo6
YD7V2N4qWN/lhkREYGrh62fu1ftCq4pnkNoQ5peOEDes3uI16qubM8Y72vJ/MaWA
ZDth9VsWAybMJTeLWig42W5zM3Hl3mv5GorSyQIoW1JsmYHXPPdlggdYydN32olA
vZTY8VS5i0DSd54T7rpPSIeoMCc1z0n8yonUnAirOJkhkLSeVOFbvQGN+aryZGd9
LyrTkGdYrL0+EUpB6Bh513IMi4yVR4TFKw20s/I9TYImVQxxLakjCrgrRli1bvIk
cenDzMLI/HWEl5rcZ3wBJNXpkwRN6Q==
=Ao6K
-----END PGP SIGNATURE-----

--nVmHrCsHTydHnhNtJWSIRlIDEmZkbMmgD--

