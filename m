Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA79C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:24:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A042C24A8C
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 18:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A042C24A8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39171 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXrdE-00065m-Tg
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 14:24:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1hXrQS-0003w7-Db
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:11:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1hXrQR-0005e9-B6
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:11:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <laine@redhat.com>) id 1hXrQR-0005cK-3X
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 14:11:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D4EB3002F32
	for <qemu-devel@nongnu.org>; Mon,  3 Jun 2019 18:11:09 +0000 (UTC)
Received: from vhost2.laine.org (ovpn-117-135.phx2.redhat.com [10.3.117.135])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DE452E167;
	Mon,  3 Jun 2019 18:10:52 +0000 (UTC)
To: Jens Freimann <jfreimann@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20190517125820.2885-1-jfreimann@redhat.com>
	<20190517125820.2885-4-jfreimann@redhat.com>
	<20190521094504.GB2915@work-vm>
	<20190530145645.tjwkgi4hae5yblsi@jenstp.localdomain>
	<20190531214748.GN22103@habkost.net>
	<20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
From: Laine Stump <laine@redhat.com>
Message-ID: <97b5f189-a75d-3efe-0af6-4570f6d38a58@redhat.com>
Date: Mon, 3 Jun 2019 14:10:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603082456.vzpy256kj4o5e5wu@jenstp.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 03 Jun 2019 18:11:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] net/virtio: add failover support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, berrange@redhat.com, mst@redhat.com, aadam@redhat.com,
	qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 4:24 AM, Jens Freimann wrote:
> On Fri, May 31, 2019 at 06:47:48PM -0300, Eduardo Habkost wrote:
>> On Thu, May 30, 2019 at 04:56:45PM +0200, Jens Freimann wrote:
>>> On Tue, May 28, 2019 at 11:04:15AM -0400, Michael S. Tsirkin wrote:
>>> > On Tue, May 21, 2019 at 10:45:05AM +0100, Dr. David Alan Gilbert=20
>>> wrote:
>>> > > * Jens Freimann (jfreimann@redhat.com) wrote:
>> [...]
>>> > > > +=C2=A0=C2=A0=C2=A0 }
>>> > > > +=C2=A0=C2=A0=C2=A0 if (migration_in_setup(s) && !should_be_hid=
den &&=20
>>> n->primary_dev) {
>>> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_unplug(n->prim=
ary_dev, &err);
>>> > >
>>> > > Not knowing unplug well; can you just explain - is that device ha=
rd
>>> > > unplugged and it's gone by the time this function returns or is=20
>>> it still
>>> > > hanging around for some indeterminate time?
>>>
>>> Qemu will trigger an unplug request via pcie attention button in=20
>>> which case
>>> there could be a delay by the guest operating system. We could give=20
>>> it some
>>> amount of time and if nothing happens try surpise removal or handle t=
he
>>> error otherwise.
>>
>> I'm missing something here:
>>
>> Isn't the whole point of the new device-hiding infrastructure to
>> prevent QEMU from closing the VFIO until migration ended
>> successfully?
>=20
> No. The point of hiding it is to only add the VFIO (that is configured
> with the same MAC as the virtio-net device) until the
> VIRTIO_NET_F_STANDBY feature is negotiated. We don't want to expose to
> devices with the same MAC to guests who can't handle it.
>=20
>> What exactly is preventing QEMU from closing the host VFIO device
>> after the guest OS has handled the unplug request?
>=20
> We qdev_unplug() the VFIO device and want the virtio-net standby device=
 to
> take over. If something goes wrong with unplug or
> migration in general we have to qdev_plug() the device back.
>=20
> This series does not try to implement new functionality to close a
> device without freeing the resources.
>=20
>  From the discussion in this thread I understand that is what libvirt
> needs though. Something that will trigger the unplug from the
> guest but not free the devices resources in the host system (which is
> what qdev_unplug() does). Correct?
> Why is it bad to fully re-create the device in case of a failed migrati=
on?

I think the concern is that if the device was fully released by qemu=20
during migration, it might have already been given to some other/new=20
guest during the time that migration is trying to complete. If migration=20
then fails, you may be unable to restore the guest to the previous state.

