Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBA1C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:48:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764AA20842
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764AA20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFe36-0005WG-Eq
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 08:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFe1c-0004sH-RE
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFe1a-0004T6-90
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:46:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFe1V-0004QH-SH; Wed, 02 Oct 2019 08:46:30 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2594710C0516;
 Wed,  2 Oct 2019 12:46:28 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9509810018F8;
 Wed,  2 Oct 2019 12:46:26 +0000 (UTC)
Subject: Re: [PATCH 22/22] iotests: Mirror must not attempt to create loops
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-23-mreitz@redhat.com>
 <8ad7e1db-271b-9456-96b1-3ce448423e9f@virtuozzo.com>
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
Message-ID: <21a76051-0d08-2142-ef56-df083874b303@redhat.com>
Date: Wed, 2 Oct 2019 14:46:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <8ad7e1db-271b-9456-96b1-3ce448423e9f@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Wqo2PxJDOyyOiR8N9kUmImYwJqXHW6yBi"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 02 Oct 2019 12:46:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wqo2PxJDOyyOiR8N9kUmImYwJqXHW6yBi
Content-Type: multipart/mixed; boundary="KiRVAuQuYdayVFb1SorgJx9t4DisL3ynS"

--KiRVAuQuYdayVFb1SorgJx9t4DisL3ynS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.09.19 17:03, Vladimir Sementsov-Ogievskiy wrote:
> 20.09.2019 18:28, Max Reitz wrote:
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   tests/qemu-iotests/041     | 152 +++++++++++++++++++++++++++++++++++=
++
>>   tests/qemu-iotests/041.out |   4 +-
>>   2 files changed, 154 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
>> index e4cc829fe2..6ea4764ae8 100755
>> --- a/tests/qemu-iotests/041
>> +++ b/tests/qemu-iotests/041
>> @@ -1265,6 +1265,158 @@ class TestReplaces(iotests.QMPTestCase):
>>  =20
>>           self.vm.assert_block_path('filter0/file', 'target')
>>  =20
>> +    '''
>> +    See what happens when the @sync/@replaces configuration dictates
>> +    creating a loop.
>> +    '''
>> +    def test_loop(self):
>> +        qemu_img('create', '-f', iotests.imgfmt, test_img, str(1 * 10=
24 * 1024))
>> +
>> +        # Dummy group so we can create a NOP filter
>> +        result =3D self.vm.qmp('object-add', qom_type=3D'throttle-gro=
up', id=3D'tg0')
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        result =3D self.vm.qmp('blockdev-add', **{
>> +                                 'driver': 'throttle',
>> +                                 'node-name': 'source',
>> +                                 'throttle-group': 'tg0',
>> +                                 'file': {
>> +                                     'driver': iotests.imgfmt,
>> +                                     'node-name': 'filtered',
>> +                                     'file': {
>> +                                         'driver': 'file',
>> +                                         'filename': test_img
>> +                                     }
>> +                                 }
>> +                             })
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        # Block graph is now:
>> +        #   source[throttle] --file--> filtered[qcow2] --file--> ...
>=20
> or qed, actually

Yep.

>> +
>> +        result =3D self.vm.qmp('drive-mirror', job_id=3D'mirror', dev=
ice=3D'source',
>> +                             target=3Dtarget_img, format=3Diotests.im=
gfmt,
>> +                             node_name=3D'target', sync=3D'none',
>> +                             replaces=3D'filtered')
>> +
>> +        '''
>> +        Block graph before mirror exits would be (ignoring mirror_top=
):
>> +          source[throttle] --file--> filtered[qcow2] --file--> ...
>> +          target[qcow2] --file--> ...
>> +
>> +        Then, because of sync=3Dnone and drive-mirror in absolute-pat=
hs mode,
>> +        the source is attached to the target:
>> +          source[throttle] --file--> filtered[qcow2] --file--> ...
>> +                 ^
>                      |
>> +              backing
>> +                 |
>> +            target[qcow2] --file--> ...
>> +
>> +        Replacing filtered by target would yield:
>> +          source[throttle] --file--> target[qcow2] --file--> ...
>> +                 ^                        |
>> +                 +------- backing --------+
>> +
>> +        I.e., a loop.  bdrv_replace_node() detects this and simply
>> +        does not let source's file link point to target.  However,
>> +        that means that target cannot really replace source.
>> +
>> +        drive-mirror should detect this and not allow this case.
>> +        '''
>> +
>> +        self.assert_qmp(result, 'error/desc',
>> +                        "Replacing 'filtered' by 'target' with this s=
ync " + \
>> +                        "mode would result in a loop, because the for=
mer " + \
>> +                        "would be a child of the latter's backing fil=
e " + \
>> +                        "('source') after the mirror job")
>> +
>> +    '''
>> +    Test what happens when there would be no loop with the pre-mirror=

>> +    configuration, but something changes during the mirror job that a=
sks
>> +    for a loop to be created during completion.
>> +    '''
>> +    def test_loop_during_mirror(self):
>> +        qemu_img('create', '-f', iotests.imgfmt, test_img, str(1 * 10=
24 * 1024))
>> +
>> +        result =3D self.vm.qmp('blockdev-add', **{
>> +                                 'driver': 'null-co',
>> +                                 'node-name': 'common-base',
>> +                                 'read-zeroes': True,
>=20
> why do you need read-zeroes?

It=E2=80=99s my understanding that we=E2=80=99d better always set it to t=
rue.

>> +                                 'size': 1 * 1024 * 1024
>> +                             })
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        result =3D self.vm.qmp('blockdev-add', **{
>> +                                 'driver': 'copy-on-read',
>> +                                 'node-name': 'source',
>> +                                 'file': 'common-base'
>> +                             })
>> +        self.assert_qmp(result, 'return', {})
>=20
> Hmm, why don't you create them both in one query?

No good reason, I think.

>> +
>> +        '''
>=20
> the following is hard to read without some hint like, "We are going to =
=2E.."

I=E2=80=99ll see what I can come up with.

>> +        x-blockdev-change can only add children to a quorum node that=

>> +        have no parent yet, so we need an intermediate node between
>> +        target and common-base that has no parents other than target.=

>> +        We cannot use any parent that would forward the RESIZE
>> +        permission (because the job takes it, but unshares it on the
>> +        source), so we make it a backing child of a qcow2 node.
>> +        Unfortunately, we cannot add backing files to Quorum nodes
>> +        (because of an op blocker), so we put another raw node betwee=
n
>> +        the qcow2 node and common-base.
>> +        '''
>> +        result =3D self.vm.qmp('blockdev-add', **{
>> +                                 'driver': 'qcow2',
>> +                                 'node-name': 'base-parent',
>> +                                 'file': {
>> +                                     'driver': 'file',
>> +                                     'filename': test_img
>> +                                 },
>> +                                 'backing': {
>> +                                     'driver': 'raw',
>> +                                     'file': 'common-base'
>> +                                 }
>> +                             })
>> +
>> +        # Add a quorum node with a single child, we will add
>> +        # base-parent to prepare a loop later
>> +        result =3D self.vm.qmp('blockdev-add', **{
>> +                                 'driver': 'quorum',
>=20
> It would be good to skip test-cases if quorum unsupported, like other t=
est-cases
> with quorum.

Will do.

>> +                                 'node-name': 'target',
>> +                                 'vote-threshold': 1,
>> +                                 'children': [
>> +                                     {
>> +                                         'driver': 'null-co',
>> +                                         'read-zeroes': True
>> +                                     }
>> +                                 ]
>> +                             })
>> +        self.assert_qmp(result, 'return', {})
>=20
> It would be nice to comment out current block graph here...

OK.

>> +
>> +        result =3D self.vm.qmp('blockdev-mirror', job_id=3D'mirror',
>> +                             device=3D'source', target=3D'target', sy=
nc=3D'full',
>> +                             replaces=3D'common-base')
>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        result =3D self.vm.qmp('x-blockdev-change',
>> +                             parent=3D'target', node=3D'base-parent')=

>> +        self.assert_qmp(result, 'return', {})
>> +
>> +        '''
>=20
> and here, like you do in previous test-case. And here it even nicer, as=
 this test-case
> is more complex.

OK.

>> +        This asks for this configuration post-mirror:
>> +
>> +        source -> target (replaced common-base) -> base-parent
>> +                                  ^                    |
>> +                                  |                    v
>> +                                  +----------------- [raw]
>> +
>> +        bdrv_replace_node() would not allow such a configuration, but=

>> +        we should not pretend we can create it, so the mirror job
>> +        should fail during completion.
>> +        '''
>> +
>> +        self.complete_and_wait('mirror',
>> +                               completion_error=3D'Operation not perm=
itted')
>> +
>>   if __name__ =3D=3D '__main__':
>>       iotests.main(supported_fmts=3D['qcow2', 'qed'],
>>                    supported_protocols=3D['file'])
>> diff --git a/tests/qemu-iotests/041.out b/tests/qemu-iotests/041.out
>> index 877b76fd31..20a8158b99 100644
>> --- a/tests/qemu-iotests/041.out
>> +++ b/tests/qemu-iotests/041.out
>> @@ -1,5 +1,5 @@
>> -.....................................................................=
=2E........................
>> +.....................................................................=
=2E..........................
>>   --------------------------------------------------------------------=
--
>> -Ran 94 tests
>> +Ran 96 tests
>>  =20
>>   OK
>>
>=20
>=20



--KiRVAuQuYdayVFb1SorgJx9t4DisL3ynS--

--Wqo2PxJDOyyOiR8N9kUmImYwJqXHW6yBi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2UnCEACgkQ9AfbAGHV
z0CZmwf/WMpNY0KnM390u5LGl5vxjtYPMTIScupjJLMq/vFQjYnneMavbz3dIjCR
xihwmDlwKu+5Uu7ujfiTjYsNgibU03vr3C8wP86CNbnQAdxGbhfFe9/wOfPKgVKz
riG2w86Amzw6RnUDm7vUBBcH5nGXHpSDu1XFOU0NPzj5SUS5/dgcTBVPe2xRZpaJ
dfxzH3CbkXQ4/kRj07YFG4lM1yLt+FICTHhUL51CiEq3kpKkakfGZOVtRNWlq1el
PVH3zQ7tV6zhCUddFJGcK5Pf77dr9R6kP8J1IWbSMSYNj+oKSheu+KXCJz5h3AtG
OTtetda6gr1ucSo/hK68hZXy96+alw==
=O4sn
-----END PGP SIGNATURE-----

--Wqo2PxJDOyyOiR8N9kUmImYwJqXHW6yBi--

