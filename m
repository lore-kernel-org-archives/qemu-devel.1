Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C47FC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427C521924
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 18:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427C521924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0jT-0008Fm-6Q
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 14:00:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iB07X-0008UJ-36
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iAzt6-0002o1-3q
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:06:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iAzt4-0002nJ-Ds; Thu, 19 Sep 2019 13:06:34 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFE31369DA;
 Thu, 19 Sep 2019 17:06:33 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 625775D6B0;
 Thu, 19 Sep 2019 17:06:29 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH 4/4] iotests: Add test for failing mirror
 complete
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
References: <20190912135632.13925-1-mreitz@redhat.com>
 <20190912135632.13925-5-mreitz@redhat.com>
 <377314de-2a77-0fe7-e5ea-07f368c504ec@redhat.com>
 <37b2e17e-6a66-f044-98cf-7603cac5f66f@redhat.com>
 <f9018735-2cfd-d568-ca17-0b78352c93fc@redhat.com>
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
Message-ID: <6ad4ea79-0c50-7724-0507-8299a54dcca8@redhat.com>
Date: Thu, 19 Sep 2019 19:06:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f9018735-2cfd-d568-ca17-0b78352c93fc@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C06FciHB8vwLoqdLNoGGX84a5bzNKmSqX"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 19 Sep 2019 17:06:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C06FciHB8vwLoqdLNoGGX84a5bzNKmSqX
Content-Type: multipart/mixed; boundary="XhiDZVSpnYL6kWINCLxfKUES6ou0vLCSI";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <6ad4ea79-0c50-7724-0507-8299a54dcca8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] iotests: Add test for failing mirror
 complete
References: <20190912135632.13925-1-mreitz@redhat.com>
 <20190912135632.13925-5-mreitz@redhat.com>
 <377314de-2a77-0fe7-e5ea-07f368c504ec@redhat.com>
 <37b2e17e-6a66-f044-98cf-7603cac5f66f@redhat.com>
 <f9018735-2cfd-d568-ca17-0b78352c93fc@redhat.com>
In-Reply-To: <f9018735-2cfd-d568-ca17-0b78352c93fc@redhat.com>

--XhiDZVSpnYL6kWINCLxfKUES6ou0vLCSI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.09.19 19:02, John Snow wrote:
>=20
>=20
> On 9/19/19 12:58 PM, Max Reitz wrote:
>> On 18.09.19 20:46, John Snow wrote:
>>>
>>>
>>> On 9/12/19 9:56 AM, Max Reitz wrote:
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>> =C2=A0 tests/qemu-iotests/041=C2=A0=C2=A0=C2=A0=C2=A0 | 44 +++++++++=
+++++++++++++++++++++++++++++
>>>> =C2=A0 tests/qemu-iotests/041.out |=C2=A0 4 ++--
>>>> =C2=A0 2 files changed, 46 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
>>>> index 8568426311..84bc6d6581 100755
>>>> --- a/tests/qemu-iotests/041
>>>> +++ b/tests/qemu-iotests/041
>>>> @@ -1121,6 +1121,50 @@ class TestOrphanedSource(iotests.QMPTestCase)=
:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 target=3D'dest-ro')
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_q=
mp(result, 'error/class', 'GenericError')
>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 def test_failing_permission_in_complete(s=
elf):
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_no_active_bl=
ock_jobs()
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Unshare consistent-rea=
d on the target
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # (The mirror job does n=
ot care)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm.qmp('=
blockdev-add',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 driver=3D'blkdebug',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 node_name=3D'dest-perm',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 image=3D'dest',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 unshare_child_perms=3D['consistent-read'])
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(result, =
'return', {})
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm.qmp('=
blockdev-mirror', job_id=3D'job',
>>>> device=3D'src',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sync=3D'full', target=3D'dest',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 filter_node_name=3D'mirror-filter')
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(result, =
'return', {})
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Require consistent-rea=
d on the source
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # (We can only add this =
node once the job has started, or it
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # will complain that it =
does not want to run on non-root nodes)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D self.vm.qmp('=
blockdev-add',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 driver=3D'blkdebug',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 node_name=3D'src-perm',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 image=3D'src',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 take_child_perms=3D['consistent-read'])
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assert_qmp(result, =
'return', {})
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # While completing, mirr=
or will attempt to replace src by
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # dest, which must fail =
because src-perm requires
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # consistent-read but de=
st-perm does not share it; thus
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # aborting the job when =
it is supposed to complete
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.complete_and_wait('=
job',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 completion_error=3D'Operation not
>>>> permitted')
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Assert that all of our=
 nodes are still there (except for the
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # mirror filter, which s=
hould be gone despite the failure)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nodes =3D self.vm.qmp('q=
uery-named-block-nodes')['return']
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nodes =3D list(map(lambd=
a image: image['node-name'], nodes))
>>>
>>> Sadly, the list comprehension is a good suggestion. Squash it in if
>>> you'd like.
>>
>> You know I don=E2=80=99t, but I=E2=80=99ll do it anyway.
>>
>=20
> Don't you dare make me feel bad by re-spinning, though.

I have to respin anyway. ;-)

>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for expect in ['src', 's=
rc-perm', 'dest', 'dest-perm']:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
self.assertTrue(expect in nodes, '%s disappeared' % expect)
>>>
>>> I could be a real weenie and say "why not use a tuple here?"
>>
>> OK.
>>
>>> but, I'll only pretend I didn't say that instead of couching it in a
>>> self-deprecating wrapper to the same end effect.
>>>
>>> (I'm a weenie.)
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.assertFalse('mirror=
-filter' in nodes,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 'Mirror filter node did not disappear')
>>>> +
>>>> =C2=A0 if __name__ =3D=3D '__main__':
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iotests.main(supported_fmts=3D['qcow2=
', 'qed'],
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 supported_protocols=3D['file'])
>>>> diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out=

>>>> index 2c448b4239..f496be9197 100644
>>>> --- a/tests/qemu-iotests/041.out
>>>> +++ b/tests/qemu-iotests/041.out
>>>> @@ -1,5 +1,5 @@
>>>> -...................................................................=
=2E......................
>>>>
>>>> +...................................................................=
=2E.......................
>>>>
>>>> =C2=A0 -------------------------------------------------------------=
---------
>>>> -Ran 90 tests
>>>> +Ran 91 tests
>>>> =C2=A0 =C2=A0 OK
>>>>
>>>
>>> Or don't do anything, because I'm just being obnoxious, and I owe you=

>>> one for giving you bad advice last round.
>>
>> Come on, I have better (more selfish) reasons.
>>
>> For the list comprehension: I want to introduce as many instances of
>> map/filter as I can so using those functions becomes normal.
>>
>=20
> They have their uses! But also they're usually just simply longer and
> aren't worth using where list comprehensions do.

The point is that they=E2=80=99re special language constructs whereas map=
/filter
are available in basically any decent language.

>> For the tuple: This is a test, nobody cares whether it uses 60 bytes
>> more memory or is 10 =C2=B5s slower or lets something be mutable when =
it is
>> actually never changed.  As such, I like to use the most general
>> solution which is simply a list.
>>
>=20
> I did say I was being a weenie. You really can take the reviewed-by!

I=E2=80=99m just saying those would be my reasons if I rejected the chang=
es
suggested by you both.  I don=E2=80=99t reject them, though. :-)

Max


--XhiDZVSpnYL6kWINCLxfKUES6ou0vLCSI--

--C06FciHB8vwLoqdLNoGGX84a5bzNKmSqX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2DtZMACgkQ9AfbAGHV
z0BlvQf+MJOVfE63vHF1nY7Xq71H9YDayUlq9ObRcTPRbZHnsLf8/Uy/nLFvqxfW
TapefeOUb2b6f17YDN5PkGtZIIF3IPLWo8Pdzu4r6qQmtaB6EtW1ncXZRFdxUz+X
/PO/UuYD8oATftoZ2sx0plq/cY4bTBZXJFuJtIodDGxhkT7tUw/l2VioFk+fGmQ9
kpA46GW9tHMQhLpRyLdHW0pNuuUmKl4Wa5IXUNc4HE5c7VXO1ALefBrW7x+oGBz3
ytxuIIHph6KE0XW02UWKtD69BqySOEyvttGSu7F076rZMIGQdPX2mOY6ofivhr0d
sXWp1Q95fL06Bwb4gH+9UnEzSWYEgg==
=Jujz
-----END PGP SIGNATURE-----

--C06FciHB8vwLoqdLNoGGX84a5bzNKmSqX--

