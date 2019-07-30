Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC31C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0A120693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 11:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0A120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsQ33-0007SX-QZ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 07:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50307)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hsQ2U-0006ys-93
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:11:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hsQ2T-0001NU-0K
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 07:11:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hsQ2Q-0001Ln-5N; Tue, 30 Jul 2019 07:11:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFC284627A;
 Tue, 30 Jul 2019 11:11:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13ED25C1B4;
 Tue, 30 Jul 2019 11:11:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A6B91138619; Tue, 30 Jul 2019 13:11:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Max Reitz <mreitz@redhat.com>
References: <20190729164234.11573-1-kwolf@redhat.com>
 <874l34ghjm.fsf@dusky.pond.sub.org>
 <20190730082920.GA8134@localhost.localdomain>
 <0e04a847-bc0d-bd69-9dcc-f4c10f29d97d@redhat.com>
Date: Tue, 30 Jul 2019 13:11:20 +0200
In-Reply-To: <0e04a847-bc0d-bd69-9dcc-f4c10f29d97d@redhat.com> (Max Reitz's
 message of "Tue, 30 Jul 2019 12:09:13 +0200")
Message-ID: <87mugvdbfr.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Tue, 30 Jul 2019 11:11:24 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max Reitz <mreitz@redhat.com> writes:

> On 30.07.19 10:29, Kevin Wolf wrote:
>> Am 30.07.2019 um 08:31 hat Markus Armbruster geschrieben:
>>> Kevin Wolf <kwolf@redhat.com> writes:
>>>
>>>> scsi-disks decides whether it has a read-only device by looking at
>>>> whether the BlockBackend specified as drive=3D... is read-only. In the
>>>> case of an anonymous BlockBackend (with a node name specified in
>>>> drive=3D...), this is the read-only flag of the attached node. In the =
case
>>>> of an empty anonymous BlockBackend, it's always read-write because
>>>> nothing prevented it from being read-write.
>>>>
>>>> This is a problem because scsi-cd would take write permissions on the
>>>> anonymous BlockBackend of an empty drive created without a drive=3D...
>>>> option. Using blockdev-insert-medium with a read-only node fails then
>>>> with the error message "Block node is read-only".
>>>>
>>>> Fix scsi_realize() so that scsi-cd devices always take read-only
>>>> permissions on their BlockBackend instead.
>>>>
>>>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1733920
>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>> ---
>>>>  hw/scsi/scsi-disk.c | 10 ++++++++--
>>>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
>>>> index 8e95e3e38d..af3e622dc5 100644
>>>> --- a/hw/scsi/scsi-disk.c
>>>> +++ b/hw/scsi/scsi-disk.c
>>>> @@ -2318,6 +2318,7 @@ static void scsi_disk_unit_attention_reported(SC=
SIDevice *dev)
>>>>  static void scsi_realize(SCSIDevice *dev, Error **errp)
>>>>  {
>>>>      SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, dev);
>>>> +    bool read_only;
>>>>=20=20
>>>>      if (!s->qdev.conf.blk) {
>>>>          error_setg(errp, "drive property not set");
>>>> @@ -2351,8 +2352,13 @@ static void scsi_realize(SCSIDevice *dev, Error=
 **errp)
>>>>              return;
>>>>          }
>>>>      }
>>>> -    if (!blkconf_apply_backend_options(&dev->conf,
>>>> -                                       blk_is_read_only(s->qdev.conf.=
blk),
>>>> +
>>>> +    read_only =3D blk_is_read_only(s->qdev.conf.blk);
>>>> +    if (dev->type =3D=3D TYPE_ROM) {
>>>> +        read_only =3D true;
>>>> +    }
>>>> +
>>>> +    if (!blkconf_apply_backend_options(&dev->conf, read_only,
>>>>                                         dev->type =3D=3D TYPE_DISK, er=
rp)) {
>>>>          return;
>>>>      }
>>>
>>> For what it's worth, we have code similar to the one after this patch in
>>>
>>> * ide_dev_initfn()
>>>
>>> * xen_block_realize()  (I guess)
>>>
>>> We have code similar to the one before this patch in
>>>
>>> * floppy_drive_realize()
>>>
>>>   I figure we avoid the problem by recomputing read-only on media
>>>   change, in fd_change_cb().  Funny: looks like a medium's
>>>   read-only-ness lingers after unload until the next medium is loaded.
>>=20
>> We may try to, but it looks something is broken for floppies.

Ha!  Cc: John.

>> The bug only came to my attention yesterday, so I haven't got a full
>> test case yet, but the half that I already have fails for floppy. I'll
>> look into this, but it was more important to me to get at least the
>> scsi-cd fix into 4.1.

I think this patch is okay as a narrow fix for scsi-cd, thus
Reviewed-by: Markus Armbruster <armbru@redhat.com>

>>> * nvme_realize()
>>>
>>> * virtio_blk_device_realize()
>>>
>>> * scsi_generic_realize()
>>>
>>> * usb_msd_storage_realize()
>>>
>>> Are these all okay?  Should they work more like floppy?  If not, what
>>> makes floppy special?
>>=20
>> Most of them aren't relevant in this context because this is a problem
>> with removable media, and most devices don't support that. So as far as
>> I know all we need to check is floppy, ATAPI and SCSI CD-ROM.
>>=20
>> Floppy is special because it's the only read-write device that supports
>> removable media (and you can insert a read-only floppy after ejecting a
>> read-write one or vice versa). CDs can be simpler because they are
>> always read-only.
>
> There are also SD cards.
>
> (The SD code just rejects read-only BBs, and it takes PERM_WRITE on it.
>  So I suppose it=E2=80=99s good because this way you simply can never ins=
ert
> read-only nodes.)

I'd prefer to call this "differently broken" :)

