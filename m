Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EE0C76190
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 19:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAEA7229F3
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 19:42:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAEA7229F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqjdK-0004FJ-N9
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 15:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37510)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hqjdA-0003mP-GN
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 15:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hqjd9-0005B5-2M
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 15:42:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42058)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hqjd5-00054b-R9; Thu, 25 Jul 2019 15:42:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 764C630C746E;
 Thu, 25 Jul 2019 19:42:16 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-178.ams2.redhat.com
 [10.36.116.178])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2330F608A4;
 Thu, 25 Jul 2019 19:42:05 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, Sam Eiderman <shmuel.eiderman@oracle.com>,
 Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 philmd@redhat.com
References: <20190626123948.10199-1-shmuel.eiderman@oracle.com>
 <20190701074117.pkmzhon6v7nafq2p@sirius.home.kraxel.org>
 <424BE97C-7EAF-4B28-B580-AC2B5261197C@oracle.com>
 <EB5E5E3C-CCA1-4138-9623-89ECA7335F88@oracle.com>
 <20190717194623.GF6471@localhost.localdomain>
 <65B72D23-26BE-4C3B-B298-A6231D08BF6C@oracle.com>
 <63344112-c84b-f239-3c34-ad3a613910f7@redhat.com>
 <3ecc13e7-097f-7e8c-347d-443020c944d2@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6321bb1e-dda4-bac1-e8ea-83bacee0d724@redhat.com>
Date: Thu, 25 Jul 2019 21:42:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3ecc13e7-097f-7e8c-347d-443020c944d2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 25 Jul 2019 19:42:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [QEMU] [PATCH v5 0/8] Add Qemu to
 SeaBIOS LCHS interface
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
Cc: qemu-block@nongnu.org, Arbel Moshe <arbel.moshe@oracle.com>,
 seabios@seabios.org, QEMU <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Kevin O'Connor <kevin@koconnor.net>,
 Liran Alon <liran.alon@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/25/19 02:50, John Snow wrote:
>=20
>=20
> On 7/24/19 8:47 PM, John Snow wrote:
>>
>>
>> On 7/19/19 6:10 AM, Sam Eiderman wrote:
>>> Well, this patch introduces 3 command line parameters (=E2=80=9Clcyls=
=E2=80=9D, =E2=80=9Clheads=E2=80=9D, =E2=80=9Clsecs=E2=80=9D)
>>> to =E2=80=9Cscsi-hd=E2=80=9D =E2=80=9Cide-hd=E2=80=9D and =E2=80=9Cvi=
rtio-pci-blk=E2=80=9D so this somehow has something to do with
>>> block.
>>>
>>> This patch also adds fw_cfg interface to send these parameters to Sea=
BIOS.
>>>
>>> "scripts/get_maintainer.pl -f hw/nvram/fw_cfg.c=E2=80=9D gives
>>>
>>> "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> (supporter:Firmware=
 configur...)
>>> Laszlo Ersek <lersek@redhat.com> (reviewer:Firmware configur...)
>>> Gerd Hoffmann <kraxel@redhat.com> (reviewer:Firmware configur=E2=80=A6=
)
>>>
>>> And this was already Reviewed-by Gerd.
>>>
>>> How should I proceed?
>>>
>>> Sam
>>>
>>
>> I feel like it would be up to Gerd as the general SeaBIOS point of con=
tact?
>>
>=20
> ...ah, who is offline for vacation.
>=20
> We're in freeze right now anyway, so I would think that Gerd and/or
> Kevin can work out who ought to stage this for a PR when the tree opens
> again.
>=20

I think the sole patch in the series that modifies "hw/nvram/fw_cfg.c" is

 [Qemu-devel] [QEMU] [PATCH v5 7/8] bootdevice: FW_CFG interface for LCHS=
 values
  http://mid.mail-archive.com/20190626123948.10199-8-shmuel.eiderman@orac=
le.com

and neither Phil nor myself seem to be CC'd on it (I've found the message=
 in my list folder only).

Regarding fw_cfg, I only review Phil's fw_cfg patches (so that whenever h=
e posts patches, he can count on my review); other than that, I generally=
 skip fw_cfg patches. And, I totally don't have a tree for collecting suc=
h patches.

Now, while Phil does:

  T: git https://github.com/philmd/qemu.git fw_cfg-next

I still don't think that tree would be the best for queueing this series,=
 given the diffstat:

 bootdevice.c             | 148 +++++++++---
 hw/block/virtio-blk.c    |   6 +
 hw/ide/qdev.c            |   7 +-
 hw/nvram/fw_cfg.c        |  14 +-
 hw/scsi/scsi-bus.c       |  15 ++
 hw/scsi/scsi-disk.c      |  14 ++
 include/hw/block/block.h |  22 +-
 include/hw/scsi/scsi.h   |   1 +
 include/sysemu/sysemu.h  |   4 +
 tests/Makefile.include   |   2 +-
 tests/hd-geo-test.c      | 582 +++++++++++++++++++++++++++++++++++++++++=
++++++
 11 files changed, 774 insertions(+), 41 deletions(-)

Just my two cents.

Thanks
Laszlo

