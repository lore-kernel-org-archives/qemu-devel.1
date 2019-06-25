Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_DR,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E35C48BD6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B979A2146E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 09:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B979A2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57750 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfhVI-0000Tf-Hz
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 05:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38751)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hfhUF-0007qR-Ap
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hfhU9-0002QP-DM
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:11:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56650)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hfhU9-0002Pq-3i
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 05:11:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EC023AC2E5;
 Tue, 25 Jun 2019 09:11:19 +0000 (UTC)
Received: from work-vm (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A68F95C231;
 Tue, 25 Jun 2019 09:11:18 +0000 (UTC)
Date: Tue, 25 Jun 2019 10:11:16 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <20190625091116.GE3226@work-vm>
References: <20190621144541.13770-1-skrtbhtngr@gmail.com>
 <a80f7beb-48c1-553a-f137-731e5500b608@gmail.com>
 <1AD565D7-F99E-4879-BFEF-0E2C7474A09A@gmail.com>
 <91874483-215c-1ccc-6f33-5ceeb8f6ec47@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91874483-215c-1ccc-6f33-5ceeb8f6ec47@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 25 Jun 2019 09:11:20 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 0/1] Add live migration support to the PVRDMA
 device
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
Cc: Sukrit Bhatnagar <skrtbhtngr@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org,
 Yuval Shaia <yuval.shaia@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Marcel Apfelbaum (marcel.apfelbaum@gmail.com) wrote:
> Hi Dmitry,
>=20
> On 6/25/19 11:39 AM, Dmitry Fleytman wrote:
> >=20
> > > On 25 Jun 2019, at 11:14, Marcel Apfelbaum <marcel.apfelbaum@gmail.=
com> wrote:
> > >=20
> > > Hi Sukrit
> > >=20
> > > On 6/21/19 5:45 PM, Sukrit Bhatnagar wrote:
> > > > Hi,
> > > [...]
> > > > This RFC is meant to request suggestions on the things which are
> > > > working and for help on the things which are not.
> > > >=20
> > > [...]
> > > > What is not working:
> > > >=20
> > > [...]
> > > > * It seems that vmxnet3 migration itself is not working properly,=
 at least
> > > >    for me. The pvrdma device depends on it, vmxnet3 is function 0=
 and pvrdma
> > > >    is function 1. This is happening even for a build of unmodifie=
d code from
> > > >    the master branch.
> > > >    After migration, the network connectivity is lost at destinati=
on.
> > > >    Things are fine at the source before migration.
> > > >    This is the command I am using at src:
> > > >=20
> > > >    sudo /home/skrtbhtngr/qemu/build/x86_64-softmmu/qemu-system-x8=
6_64 \
> > > >      -enable-kvm \
> > > >      -m 2G -smp cpus=3D2 \
> > > >      -hda /home/skrtbhtngr/fedora.img \
> > > >      -netdev tap,id=3Dhostnet0 \
> > > >      -device vmxnet3,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:9=
9:ff:bc \
> > > >      -monitor telnet:127.0.0.1:4444,server,nowait \
> > > >      -trace events=3D/home/skrtbhtngr/trace-events \
> > > >      -vnc 0.0.0.0:0
> > > >=20
> > > >    Similar command is used for the dest. Currently, I am trying
> > > >    same-host migration for testing purpose, without the pvrdma de=
vice.
> > > >    Two tap interfaces, for src and dest were created successfully=
 at
> > > >    the host. Kernel logs:
> > > >    ...
> > > >    br0: port 2(tap0) entered forwarding state
> > > >    ...
> > > >    br0: port 3(tap1) entered forwarding state
> > > >=20
> > > >    tcpdump at the dest reports only outgoing ARP packets, which a=
sk
> > > >    for gateway: "ARP, Request who-has _gateway tell guest1".
> > > >=20
> > > >    Tried using user (slirp) as the network backend, but no luck.
> > > >       Also tried git bisect to find the issue using a working com=
mit (given
> > > >    by Marcel), but it turns out that it is very old and I faced b=
uild
> > > >    errors one after another.
> > > >=20
> > > >    Please note that e1000 live migration is working fine in the s=
ame setup.
> > > >=20
> > > I tried to git bisect , but I couldn't find a working version of vm=
xnet supporting live migration ....
> > > I tried even a commit from December 2014 and it didn't work.
> > >=20
> > > What is strange (to me) is that the networking packets can't be sen=
t from the guest (after migration)
> > > even after rebooting the guest.
> > This makes me think that some network offload configuration wasn=E2=80=
=99t properly migrated or applied.
> > What network backend are you using?
>=20
> Suktrit tried with tap device, I tried with slirp.
> If you can point me to the property that disables all the offloads it w=
ill
> really help.
>=20
> > Do you see any outgoing packets in the sniffer?
>=20
> I didn't use the sniffer, I checked dmesg in guest, there was a line
> complaining that it can't send packets.

What exactly was the error?

I don't know much about vmxnet3;  but if the guest driver is seeing the
problem then I guess that's the best pointer we have.


Dave

> Thanks,
> Marcel
>=20
> > > Any help or pointer would be greatly appreciated.
> > > Thanks,
> > > Marcel
> > >=20
> > >=20
> > > [...]
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

