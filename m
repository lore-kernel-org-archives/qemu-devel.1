Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC55C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 10:09:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4BA920679
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 10:09:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4BA920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsP4n-0006nk-S9
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 06:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39407)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hsP4M-0006AU-5U
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 06:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hsP4K-0003IP-OU
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 06:09:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37798)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hsP4H-0003GQ-PQ; Tue, 30 Jul 2019 06:09:17 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 85C74308FBAF;
 Tue, 30 Jul 2019 10:09:16 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-164.ams2.redhat.com
 [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7567219C67;
 Tue, 30 Jul 2019 10:09:15 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20190729164234.11573-1-kwolf@redhat.com>
 <874l34ghjm.fsf@dusky.pond.sub.org>
 <20190730082920.GA8134@localhost.localdomain>
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
Message-ID: <0e04a847-bc0d-bd69-9dcc-f4c10f29d97d@redhat.com>
Date: Tue, 30 Jul 2019 12:09:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730082920.GA8134@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PLmP3eD4EwlSi8eHomfqmWlHdS4m6NDJd"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 30 Jul 2019 10:09:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.1] scsi-cd: Fix inserting read-only
 media in empty drive
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PLmP3eD4EwlSi8eHomfqmWlHdS4m6NDJd
Content-Type: multipart/mixed; boundary="MNuqlgnxy43cHtldm3F12OKRPd3WLYpf2";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Message-ID: <0e04a847-bc0d-bd69-9dcc-f4c10f29d97d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-4.1] scsi-cd: Fix inserting read-only
 media in empty drive
References: <20190729164234.11573-1-kwolf@redhat.com>
 <874l34ghjm.fsf@dusky.pond.sub.org>
 <20190730082920.GA8134@localhost.localdomain>
In-Reply-To: <20190730082920.GA8134@localhost.localdomain>

--MNuqlgnxy43cHtldm3F12OKRPd3WLYpf2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.07.19 10:29, Kevin Wolf wrote:
> Am 30.07.2019 um 08:31 hat Markus Armbruster geschrieben:
>> Kevin Wolf <kwolf@redhat.com> writes:
>>
>>> scsi-disks decides whether it has a read-only device by looking at
>>> whether the BlockBackend specified as drive=3D... is read-only. In th=
e
>>> case of an anonymous BlockBackend (with a node name specified in
>>> drive=3D...), this is the read-only flag of the attached node. In the=
 case
>>> of an empty anonymous BlockBackend, it's always read-write because
>>> nothing prevented it from being read-write.
>>>
>>> This is a problem because scsi-cd would take write permissions on the=

>>> anonymous BlockBackend of an empty drive created without a drive=3D..=
=2E
>>> option. Using blockdev-insert-medium with a read-only node fails then=

>>> with the error message "Block node is read-only".
>>>
>>> Fix scsi_realize() so that scsi-cd devices always take read-only
>>> permissions on their BlockBackend instead.
>>>
>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1733920
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  hw/scsi/scsi-disk.c | 10 ++++++++--
>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
>>> index 8e95e3e38d..af3e622dc5 100644
>>> --- a/hw/scsi/scsi-disk.c
>>> +++ b/hw/scsi/scsi-disk.c
>>> @@ -2318,6 +2318,7 @@ static void scsi_disk_unit_attention_reported(S=
CSIDevice *dev)
>>>  static void scsi_realize(SCSIDevice *dev, Error **errp)
>>>  {
>>>      SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, dev);
>>> +    bool read_only;
>>> =20
>>>      if (!s->qdev.conf.blk) {
>>>          error_setg(errp, "drive property not set");
>>> @@ -2351,8 +2352,13 @@ static void scsi_realize(SCSIDevice *dev, Erro=
r **errp)
>>>              return;
>>>          }
>>>      }
>>> -    if (!blkconf_apply_backend_options(&dev->conf,
>>> -                                       blk_is_read_only(s->qdev.conf=
=2Eblk),
>>> +
>>> +    read_only =3D blk_is_read_only(s->qdev.conf.blk);
>>> +    if (dev->type =3D=3D TYPE_ROM) {
>>> +        read_only =3D true;
>>> +    }
>>> +
>>> +    if (!blkconf_apply_backend_options(&dev->conf, read_only,
>>>                                         dev->type =3D=3D TYPE_DISK, e=
rrp)) {
>>>          return;
>>>      }
>>
>> For what it's worth, we have code similar to the one after this patch =
in
>>
>> * ide_dev_initfn()
>>
>> * xen_block_realize()  (I guess)
>>
>> We have code similar to the one before this patch in
>>
>> * floppy_drive_realize()
>>
>>   I figure we avoid the problem by recomputing read-only on media
>>   change, in fd_change_cb().  Funny: looks like a medium's
>>   read-only-ness lingers after unload until the next medium is loaded.=

>=20
> We may try to, but it looks something is broken for floppies.
>=20
> The bug only came to my attention yesterday, so I haven't got a full
> test case yet, but the half that I already have fails for floppy. I'll
> look into this, but it was more important to me to get at least the
> scsi-cd fix into 4.1.
>=20
>> * nvme_realize()
>>
>> * virtio_blk_device_realize()
>>
>> * scsi_generic_realize()
>>
>> * usb_msd_storage_realize()
>>
>> Are these all okay?  Should they work more like floppy?  If not, what
>> makes floppy special?
>=20
> Most of them aren't relevant in this context because this is a problem
> with removable media, and most devices don't support that. So as far as=

> I know all we need to check is floppy, ATAPI and SCSI CD-ROM.
>=20
> Floppy is special because it's the only read-write device that supports=

> removable media (and you can insert a read-only floppy after ejecting a=

> read-write one or vice versa). CDs can be simpler because they are
> always read-only.

There are also SD cards.

(The SD code just rejects read-only BBs, and it takes PERM_WRITE on it.
 So I suppose it=E2=80=99s good because this way you simply can never ins=
ert
read-only nodes.)

Max


--MNuqlgnxy43cHtldm3F12OKRPd3WLYpf2--

--PLmP3eD4EwlSi8eHomfqmWlHdS4m6NDJd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1AF0kACgkQ9AfbAGHV
z0DRzggAsYPcqvl6mtybi5rGw3keYHHER1o8jeSgNZFTlL/sFbBefLPLNTn0lXgh
xR5vvogwW1Gbqw8JMQUVrxu3i76Q+A2QM+01ZsEAU0MMBHW51mOcTdiIGUCjmhbt
7wO+PDjnaje2B8/VgTd0odOsFhzxgRBDpdbEXlJGuRvlo1rwkvUh+6K/44f+gu8D
Gl2E5yi9F93UppKFicOJ70woUXr8Qif4wkUNnnsfUJ7Ve7Kx94rqv3lfnLUgat9P
C9MsogQVIh7kQP7DFm+RvF5NgthjTtOCNzk8BhyKHCK7gvlr+3/o52wCV7ZAZL7j
u/6TWlaPdRYtKRWiMDbaw+55lI6cRw==
=x6Uf
-----END PGP SIGNATURE-----

--PLmP3eD4EwlSi8eHomfqmWlHdS4m6NDJd--

