Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA85C33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 22:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD1D20718
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 22:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD1D20718
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iulS4-0002Xy-9j
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 17:59:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48351)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1iulR2-0001EF-T9
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1iulR1-0006Ow-JR
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 17:58:48 -0500
Received: from kerio.kamp.de ([195.62.97.192]:58425)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>)
 id 1iulQw-0006Ds-89; Thu, 23 Jan 2020 17:58:42 -0500
X-Footer: a2FtcC5kZQ==
Received: from [82.141.7.52] ([79.200.90.31]) (authenticated user pl@kamp.de)
 by kerio.kamp.de with ESMTPSA
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits));
 Thu, 23 Jan 2020 23:58:35 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Peter Lieven <pl@kamp.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] iscsi: Cap block count from GET LBA STATUS (CVE-2020-1711)
Date: Thu, 23 Jan 2020 23:58:35 +0100
Message-Id: <9F93582E-139B-45B2-8630-FDD331F09DEF@kamp.de>
References: <B07CB62A-7860-4385-A6A4-4ECA211DBE42@nutanix.com>
In-Reply-To: <B07CB62A-7860-4385-A6A4-4ECA211DBE42@nutanix.com>
To: Felipe Franciosi <felipe@nutanix.com>
X-Mailer: iPhone Mail (17C54)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 195.62.97.192
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Turschmid <peter.turschm@nutanix.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, P J P <ppandit@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 23.01.2020 um 22:29 schrieb Felipe Franciosi <felipe@nutanix.com>:
>=20
> =EF=BB=BFHi,
>=20
>> On Jan 23, 2020, at 5:46 PM, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>>=20
>>> On 1/23/20 1:44 PM, Felipe Franciosi wrote:
>>> When querying an iSCSI server for the provisioning status of blocks (via=

>>> GET LBA STATUS), Qemu only validates that the response descriptor zero's=

>>> LBA matches the one requested. Given the SCSI spec allows servers to
>>> respond with the status of blocks beyond the end of the LUN, Qemu may
>>> have its heap corrupted by clearing/setting too many bits at the end of
>>> its allocmap for the LUN.
>>> A malicious guest in control of the iSCSI server could carefully program=

>>> Qemu's heap (by selectively setting the bitmap) and then smash it.
>>> This limits the number of bits that iscsi_co_block_status() will try to
>>> update in the allocmap so it can't overflow the bitmap.
>>=20
>> Please add:
>>=20
>> Fixes: CVE-2020-1711 (title of CVE if possible)
>=20
> I wasn't sure we had one yet. Kevin: can you do the needful in your branch=
?
>=20
>> Cc: qemu-stable@nongnu.org
>=20
> Yeah, that's there.
>=20
>>=20
>>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>>> Signed-off-by: Peter Turschmid <peter.turschm@nutanix.com>
>>> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
>>> ---
>>> block/iscsi.c | 5 +++--
>>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>> diff --git a/block/iscsi.c b/block/iscsi.c
>>> index 2aea7e3f13..cbd57294ab 100644
>>> --- a/block/iscsi.c
>>> +++ b/block/iscsi.c
>>> @@ -701,7 +701,7 @@ static int coroutine_fn iscsi_co_block_status(BlockD=
riverState *bs,
>>>     struct scsi_get_lba_status *lbas =3D NULL;
>>>     struct scsi_lba_status_descriptor *lbasd =3D NULL;
>>>     struct IscsiTask iTask;
>>> -    uint64_t lba;
>>> +    uint64_t lba, max_bytes;
>>>     int ret;
>>>       iscsi_co_init_iscsitask(iscsilun, &iTask);
>>> @@ -721,6 +721,7 @@ static int coroutine_fn iscsi_co_block_status(BlockD=
riverState *bs,
>>>     }
>>>       lba =3D offset / iscsilun->block_size;
>>> +    max_bytes =3D (iscsilun->num_blocks - lba) * iscsilun->block_size;
>>>       qemu_mutex_lock(&iscsilun->mutex);
>>> retry:
>>> @@ -764,7 +765,7 @@ retry:
>>>         goto out_unlock;
>>>     }
>>> -    *pnum =3D (int64_t) lbasd->num_blocks * iscsilun->block_size;
>>> +    *pnum =3D MIN((int64_t) lbasd->num_blocks * iscsilun->block_size, m=
ax_bytes);
>>>       if (lbasd->provisioning =3D=3D SCSI_PROVISIONING_TYPE_DEALLOCATED |=
|
>>>         lbasd->provisioning =3D=3D SCSI_PROVISIONING_TYPE_ANCHORED) {
>>=20
>> What about this?
>>=20
>> -- >8 --
>> diff --git a/block/iscsi.c b/block/iscsi.c
>> index 2aea7e3f13..25598accbb 100644
>> --- a/block/iscsi.c
>> +++ b/block/iscsi.c
>> @@ -506,6 +506,11 @@ iscsi_allocmap_update(IscsiLun *iscsilun, int64_t of=
fset,
>>    /* shrink to touch only completely contained clusters */
>>    cl_num_shrunk =3D DIV_ROUND_UP(offset, iscsilun->cluster_size);
>>    nb_cls_shrunk =3D (offset + bytes) / iscsilun->cluster_size - cl_num_s=
hrunk;
>> +    if (nb_cls_expanded >=3D iscsilun->allocmap_size
>> +        || nb_cls_shrunk >=3D iscsilun->allocmap_size) {
>> +        error_report("iSCSI invalid request: ..." /* TODO */);
>> +        return;
>> +    }
>>    if (allocated) {
>>        bitmap_set(iscsilun->allocmap, cl_num_expanded, nb_cls_expanded);
>>    } else {
>> ---
>=20
> I'm not sure the above is correct because (if I read this right)
> nb_cls_* represents the number of clusters, not the last cluster.
>=20
> Personally, I would have the checks (or "trim"s) closer to where they
> were issued (to fail sooner) and assert()s closer to bitmap (as no oob
> accesses should be happening at this point). There were also
> discussions about using safer (higher level) bitmaps for this. I'm
> always in favour of adding all reasonable checks. :)

I would add assertions that cl_num + nb_cls <=3D allocmap_size before every s=
et and clear.

Peter



