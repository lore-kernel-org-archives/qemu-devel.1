Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA32C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D294525F47
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D294525F47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57601 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWPdk-0004RK-5B
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 14:19:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hWPcu-000477-Pn
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hWPct-0000Bz-UW
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:18:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49036)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hWPct-0000Ax-P9
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:18:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 340292E97DA;
	Thu, 30 May 2019 18:18:01 +0000 (UTC)
Received: from localhost (ovpn-116-11.gru2.redhat.com [10.97.116.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CF36E60C6D;
	Thu, 30 May 2019 18:17:48 +0000 (UTC)
Date: Thu, 30 May 2019 15:17:46 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Message-ID: <20190530181746.GZ22103@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190530180022.GB2864@work-vm>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Thu, 30 May 2019 18:18:06 +0000 (UTC)
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
Cc: pkrempa@redhat.com, Sameeh Jubran <sameeh@daynix.com>,
	mdroth@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>,
	aadam@redhat.com, Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org, armbru@redhat.com, liran.alon@oracle.com,
	laine@redhat.com, Yan Vugenfirer <yan@daynix.com>,
	ogerlitz@mellanox.com, Jens Freimann <jfreimann@redhat.com>,
	ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 06, 2018 at 10:01:46AM +0000, Daniel P. Berrang=E9 wrote:
> Users absolutely *do* care why migration is not finishing. A migration =
that
> does not finish is a major problem for mgmt apps in many case of the us=
e
> cases for migration. Especially important when evacuating VMs from a ho=
st
> in order to do a software upgrade or replace faulty hardware. As mentio=
ned
> previously, they will also often serialize migrations to prevent eh net=
work
> being overutilized, so a migration that runs indefinitely will stall
> evacuation of additional VMs too.  Predictable execution of migration a=
nd
> clear error reporting/handling are critical features. IMHO this is the =
key
> reason VFIO unplug/plug needs to be done explicitly by the mgmt app, so=
 it
> can be in control over when each part of the process takes place.

On Fri, Apr 05, 2019 at 09:56:29AM +0100, Dr. David Alan Gilbert wrote:
> Why not just let this happen at the libvirt level; then you do the
> hotunplug etc before you actually tell qemu anything about starting a
> migration?

On Thu, May 30, 2019 at 07:00:23PM +0100, Dr. David Alan Gilbert wrote:
> Well no, we need to know this thing isn't going to hang in the migratio=
n
> setup phase, or if it does how we recover.  This patch series is very
> odd precisely because it's trying to do the unplug itself in the
> migration phase rather than let the management layer do it - so unless
> it's nailed down how to make sure that's really really bullet proof
> then we've got to go back and ask the question about whether we should
> really fix it so it can be done by the management layer.
>=20

I have the impression we are running in circles here.

--=20
Eduardo

