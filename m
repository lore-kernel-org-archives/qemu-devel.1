Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69271C388F3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:44:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E4C21906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:44:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E4C21906
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFGa1-0000rE-84
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 07:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iFGYq-0008Sq-BN
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iFGYp-0004a0-6Y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:43:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>)
 id 1iFGYj-0004UU-10; Tue, 01 Oct 2019 07:43:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B3476C0546FE;
 Tue,  1 Oct 2019 11:43:11 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.43.2.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CB9E05D9DC;
 Tue,  1 Oct 2019 11:43:06 +0000 (UTC)
Date: Tue, 1 Oct 2019 13:43:04 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: Qemu Dirty Bitmap backup to encrypted target
Message-ID: <20191001114304.GZ9210@angien.pipo.sk>
References: <OFADB7E923.8BF08D6B-ON00258485.0069D537-00258485.006AC672@notes.na.collabserv.com>
 <facf5e37-18e0-7de5-09cf-a088f471d8ad@redhat.com>
 <20191001084553.GA4688@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191001084553.GA4688@linux.fritz.box>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 01 Oct 2019 11:43:11 +0000 (UTC)
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
Cc: Craig Mull <cmull@us.ibm.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>,
 Leo Luan <leoluan@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 01, 2019 at 10:45:53 +0200, Kevin Wolf wrote:
> Am 01.10.2019 um 02:24 hat John Snow geschrieben:
> >=20
> >=20
> > On 9/30/19 3:26 PM, Craig Mull wrote:
> > > How can have QEMU backup write the output=A0to an encrypted target?
> > > =A0
> > > Blocks in the dirty bitmap are unencrypted, and as such when I write
> > > them with QEMU backup they are written to the target unencrypted.
> > > =A0
> > > I've experimented with providing a json string as the target but with=
 no
> > > luck.
> > > =A0
> > >=20
> > > transaction=3D'{ "execute": "transaction",=A0
> > >=20
> > > =A0 "arguments": {=A0
> > >=20
> > > =A0 =A0 "actions": [
> > >=20
> > > =A0 =A0 =A0 {"type": "block-dirty-bitmap-add",=A0
> > >=20
> > > =A0=A0 =A0 =A0 "data": {"node": "drive-virtio-disk0", "granularity": =
2097152,
> > > "name": "mybitmap"} },
> > >=20
> > > =A0 =A0 =A0 {"type": "drive-backup",
> > >=20
> > > =A0=A0 =A0 =A0 "data": {"device": "drive-virtio-disk0", "target":
> > > "json:{\"encrypt.format\": \"luks\", \"encrypt.key-secret\":
> > > \"virtio-disk0-luks-secret0\", \"driver\": \"qcow2\", \"file\":
> > > {\"driver\": \"file\", \"filename\": \"/tmp/target-encrypt-test.qcow2=
\"}}",
> > >=20
> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "sync": "full", "format": "qcow2"} }=
=A0
> > >=20
> > > =A0 =A0 ]=A0
> > >=20
> > > =A0 }=A0
> > >=20
> > > }'
> > >=20
> > > =A0
> > >=20
> > > virsh -c qemu:///system qemu-monitor-command --pretty 28 $transaction
> > >=20
> > > =A0
> > >=20
> > > {
> > >=20
> > > =A0 "id": "libvirt-45",
> > >=20
> > > =A0 "error": {
> > >=20
> > > =A0 =A0 "class": "GenericError",
> > >=20
> > > =A0 =A0 "desc": "Unknown protocol 'json'"
> > >=20
> > > =A0 }
> > >=20
> > > }
> > >=20
> > >
> >=20
> > I'll be honest, I'm not very good at the json specifications and don't
> > really know when they're appropriate to use. At the basic level,
> > drive-backup expects a filename. Sometimes the filename can get fancy,
> > but... I stay away from that.
> >=20
> > Try using qmp-blockdev-create to create the target node instead, and
> > then using blockdev-backup to backup to that target.
>=20
> As the actual invocation is a virsh command, I think this is more of a
> libvirt question than a QEMU one.

The above virsh command is a direct (unsupported/experimental) command
passthrough to qemu, thus the syntax is identical to raw QMP.

You must use blockdev-backup as outlined above along with any management
necessary for adding the devices previously. Obviously this may
desynchronize state with libvirt.

> I suspect that libvirt won't support this without -blockdev support
> (which will enable blockdev-backup instead of drive-backup), but even
> then libvirt might not even offer an API for an encrypted target. Not
> sure, though, so CCing Peter.

The current state is that libvirt will support backup only with
-blockdev. In that case everything including encrypted images should be
supported same way as we (will [1]) support them with snapshots or
normal disks.

This is currently being worked on.

[1] All the code for blockdev is in but it's not enabled yet as we are
waiting for the possibility to detect the fix for 'savevm' done
recently. -blockdev will be supported with qemu-4.2.

