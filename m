Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5399AC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 08:46:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 261392133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 08:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 261392133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFDo7-0007gn-8E
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 04:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57591)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iFDnK-0007Av-Ni
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iFDnJ-0005cw-OP
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 04:46:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34562)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iFDnE-0005YP-Et; Tue, 01 Oct 2019 04:46:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62431316D797;
 Tue,  1 Oct 2019 08:45:59 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E12C95D717;
 Tue,  1 Oct 2019 08:45:55 +0000 (UTC)
Date: Tue, 1 Oct 2019 10:45:53 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: Qemu Dirty Bitmap backup to encrypted target
Message-ID: <20191001084553.GA4688@linux.fritz.box>
References: <OFADB7E923.8BF08D6B-ON00258485.0069D537-00258485.006AC672@notes.na.collabserv.com>
 <facf5e37-18e0-7de5-09cf-a088f471d8ad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <facf5e37-18e0-7de5-09cf-a088f471d8ad@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Tue, 01 Oct 2019 08:45:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
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
Cc: Craig Mull <cmull@us.ibm.com>, pkrempa@redhat.com, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>, Leo Luan <leoluan@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 01.10.2019 um 02:24 hat John Snow geschrieben:
>=20
>=20
> On 9/30/19 3:26 PM, Craig Mull wrote:
> > How can have QEMU backup write the output=A0to an encrypted target?
> > =A0
> > Blocks in the dirty bitmap are unencrypted, and as such when I write
> > them with QEMU backup they are written to the target unencrypted.
> > =A0
> > I've experimented with providing a json string as the target but with=
 no
> > luck.
> > =A0
> >=20
> > transaction=3D'{ "execute": "transaction",=A0
> >=20
> > =A0 "arguments": {=A0
> >=20
> > =A0 =A0 "actions": [
> >=20
> > =A0 =A0 =A0 {"type": "block-dirty-bitmap-add",=A0
> >=20
> > =A0=A0 =A0 =A0 "data": {"node": "drive-virtio-disk0", "granularity": =
2097152,
> > "name": "mybitmap"} },
> >=20
> > =A0 =A0 =A0 {"type": "drive-backup",
> >=20
> > =A0=A0 =A0 =A0 "data": {"device": "drive-virtio-disk0", "target":
> > "json:{\"encrypt.format\": \"luks\", \"encrypt.key-secret\":
> > \"virtio-disk0-luks-secret0\", \"driver\": \"qcow2\", \"file\":
> > {\"driver\": \"file\", \"filename\": \"/tmp/target-encrypt-test.qcow2=
\"}}",
> >=20
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "sync": "full", "format": "qcow2"} }=A0
> >=20
> > =A0 =A0 ]=A0
> >=20
> > =A0 }=A0
> >=20
> > }'
> >=20
> > =A0
> >=20
> > virsh -c qemu:///system qemu-monitor-command --pretty 28 $transaction
> >=20
> > =A0
> >=20
> > {
> >=20
> > =A0 "id": "libvirt-45",
> >=20
> > =A0 "error": {
> >=20
> > =A0 =A0 "class": "GenericError",
> >=20
> > =A0 =A0 "desc": "Unknown protocol 'json'"
> >=20
> > =A0 }
> >=20
> > }
> >=20
> >
>=20
> I'll be honest, I'm not very good at the json specifications and don't
> really know when they're appropriate to use. At the basic level,
> drive-backup expects a filename. Sometimes the filename can get fancy,
> but... I stay away from that.
>=20
> Try using qmp-blockdev-create to create the target node instead, and
> then using blockdev-backup to backup to that target.

As the actual invocation is a virsh command, I think this is more of a
libvirt question than a QEMU one.

I suspect that libvirt won't support this without -blockdev support
(which will enable blockdev-backup instead of drive-backup), but even
then libvirt might not even offer an API for an encrypted target. Not
sure, though, so CCing Peter.

Kevin

