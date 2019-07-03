Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA6C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:59:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203022189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 18:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203022189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hikT8-0003uB-DR
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 14:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37797)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hikSI-00032B-LC
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hikSH-0000Oh-I3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:58:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hikSH-0000Lf-92
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 14:58:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B262830832C9;
 Wed,  3 Jul 2019 18:58:01 +0000 (UTC)
Received: from redhat.com (ovpn-123-166.rdu2.redhat.com [10.10.123.166])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 773761001DC7;
 Wed,  3 Jul 2019 18:57:54 +0000 (UTC)
Date: Wed, 3 Jul 2019 14:57:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-ID: <20190703031041-mutt-send-email-mst@kernel.org>
References: <6EF9E5BE-2FBF-4CC4-BA1F-AE55ADD82A6E@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6EF9E5BE-2FBF-4CC4-BA1F-AE55ADD82A6E@nutanix.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Wed, 03 Jul 2019 18:58:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Should memory hotplug work with vhost-user
 backends?
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
Cc: Mike Cui <cui@nutanix.com>, Malcolm Crossley <malcolm@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Felipe Franciosi <felipe@nutanix.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "changchun.ouyang@intel.com" <changchun.ouyang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 02, 2019 at 10:08:54PM +0000, Raphael Norwitz wrote:
> For background I am trying to work around a ram slot limit imposed by t=
he
> vhost-user protocol. We are having trouble reconciling the comment here=
: https:
> //github.com/qemu/qemu/blob/master/hw/virtio/vhost-user.c#L333  that =E2=
=80=9CFor
> non-vring specific requests, like VHOST_USER_SET_MEM_TABLE., we just ne=
ed to
> send it once the first time=E2=80=9D and the high level implementation =
of memory
> hot-add, which calls set_mem_table every time a VM hot adds memory.

IIUC the comment refers to multiple virtqueue. It is trying to say that
we do not need to send VHOST_USER_SET_MEM_TABLE for each
virtqueue.



> =20
>=20
> A few questions:
>=20
> 1.
>=20
> What exactly is the check `if (vhost_user_one_time_request(msg->hdr.req=
uest) &&
> dev->vq_index !=3D 0)` for?

Some backends register multiple dev instances per backend: one for each
virtqueue.  This check avoids sending VHOST_USER_SET_MEM_TABLE more than
once in this case.


> In the message for commit
> b931bfbf042983f311b3b09894d8030b2755a638, which introduced the check, I=
 see it
> says =E2=80=9Cnon-vring specific messages[, which should] be sent only =
once=E2=80=9D and gives
> VHOST_USER_SET_MEM_TABLE as an example one such message. The
> `vhost_user_one_time_request()` call clearly checks whether this type o=
f
> message is the kind of message is supposed to be sent once of which
> VHOST_USER_SET_MEM_TABLE is one. Why, then, does this commit add the ch=
eck if
> `dev->vq_index !=3D 0`? It seems like there is a latent assumption that=
 after the
> first call dev->vq_index should be set to some value greater than one, =
however
> for many cases such as vhost-user-scsi devices we can see this is clear=
ly not
> the case https://github.com/qemu/qemu/blob/master/hw/scsi/vhost-user-sc=
si.c#
> L95. Is this check then =E2=80=98broken=E2=80=99 for such devices?

I think vhost-scsi has a single instance per backend, that is
why vq_index is 0.

> =20
>=20
> 2.
>=20
> If this check is indeed broken for such devices, and set_mem_table call=
 is only
> supposed to be run once for such devices, is the ability to call it mul=
tiple
> times technically a bug for devices such as vhost-user-scsci devices? I=
f so,
> this would imply that the existing ability to hot add memory to vhost-u=
ser-scsi
> devices is by extension technically a bug/unintended behavior. Is this =
the
> case?
>=20
> =20
>=20
> Thanks,
>=20
> Raphael

I don't think that is the case. It's possible that memory hotplug has
bugs with vhost-user, but I don't think it's anything fundamental.

--=20
MST

