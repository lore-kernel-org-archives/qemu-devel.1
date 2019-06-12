Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E3BC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4569220874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 12:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4569220874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59840 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb2K5-0004ud-Ai
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 08:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jfreimann@redhat.com>) id 1hb24t-0001gg-6x
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1hb1uJ-0002aE-Og
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 07:59:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1hb1uJ-0002WX-Gs
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 07:59:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C8211A3B48
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 11:59:08 +0000 (UTC)
Received: from localhost (dhcp-192-197.str.redhat.com [10.33.192.197])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E60A260BF1;
 Wed, 12 Jun 2019 11:59:02 +0000 (UTC)
Date: Wed, 12 Jun 2019 13:59:01 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190612115901.3n5xkdvbjmzxjmmz@jenstp.localdomain>
References: <20190517125820.2885-1-jfreimann@redhat.com>
 <646d0bf1-2fbb-1adb-d5d3-3ef3944376b5@redhat.com>
 <20190612091123.GF6897@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
In-Reply-To: <20190612091123.GF6897@redhat.com>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 12 Jun 2019 11:59:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/4] add failover feature for assigned
 network devices
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
Cc: pkrempa@redhat.com, ehabkost@redhat.com, mst@redhat.com, aadam@redhat.com,
 qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 12, 2019 at 11:11:23AM +0200, Daniel P. Berrang=E9 wrote:
>On Tue, Jun 11, 2019 at 11:42:54AM -0400, Laine Stump wrote:
>> On 5/17/19 8:58 AM, Jens Freimann wrote:
> >
>> > Command line example:
>> >
>> > qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
>> >          -machine q35,kernel-irqchip=3Dsplit -cpu host   \
>> >          -k fr   \
>> >          -serial stdio   \
>> >          -net none \
>> >          -qmp unix:/tmp/qmp.socket,server,nowait \
>> >          -monitor telnet:127.0.0.1:5555,server,nowait \
>> >          -device pcie-root-port,id=3Droot0,multifunction=3Don,chassi=
s=3D0,addr=3D0xa \
>> >          -device pcie-root-port,id=3Droot1,bus=3Dpcie.0,chassis=3D1 =
\
>> >          -device pcie-root-port,id=3Droot2,bus=3Dpcie.0,chassis=3D2 =
\
>> >          -netdev tap,script=3D/root/bin/bridge.sh,downscript=3Dno,id=
=3Dhostnet1,vhost=3Don \
>> >          -device virtio-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3D52=
:54:00:6f:55:cc,bus=3Droot2,failover=3Don \
>> >          /root/rhel-guest-image-8.0-1781.x86_64.qcow2
>> >
>> > Then the primary device can be hotplugged via
>> >   (qemu) device_add vfio-pci,host=3D5e:00.2,id=3Dhostdev0,bus=3Droot=
1,standby=3Dnet1
>>
>>
>> I guess this is the commandline on the migration destination, and as f=
ar as
>> I understand from this example, on the destination we (meaning libvirt=
 or
>> higher level management application) must *not* include the assigned d=
evice
>> on the qemu commandline, but must instead hotplug the device later aft=
er the
>> guest CPUs have been restarted on the destination.
>>
>> So if I'm understanding correctly, the idea is that on the migration s=
ource,
>> the device may have been hotplugged, or may have been included when qe=
mu was
>> originally started. Then qemu automatically handles the unplug of the =
device
>> on the source, but it seems qemu does nothing on the destination, leav=
ing
>> that up to libvirt or a higher layer to implement.
>>
>> Then in order for this to work, libvirt (or OpenStack or oVirt or whoe=
ver)
>> needs to understand that the device in the libvirt config (it will sti=
ll be
>> in the libvirt config, since from libvirt's POV it hasn't been unplugg=
ed):
>>
>> 1) shouldn't be included in the qemu commandline on the destination,
>
>I don't believe that's the case.  The CLI args above are just illustrati=
ng
>that it is now possible to *optionally* not specify the VFIO device on t=
he
>CLI. This is because previous versions of the patchset *always* required
>the device on the CLI due to a circular dependancy in the CLI syntax. Th=
is
>patch series version fixed that limitation, so now the VFIO device can b=
e
>cold plugged or hotplugged as desired.

I've mostly tested hotplugging but cold plugged should work as well.=20

>> 2) will almost surely need to be replaced with a different device on t=
he
>> destination (since it's almost certain that the destination won't have=
 an
>> available device at the same PCI address)
>
>Yes, the management application that triggers the migration will need to
>pass in a new XML document to libvirt when starting the migration so tha=
t
>we use the suitable new device on the target host.

Yes, that's how I expected it to work. In my tests the pci address was
the same on destination and source host but that was more by accident. I
think the libvirt XML on the destination just needs to have the pci
address of nic of the same type for it to work.=20

>> 3) will probably need to be unbinded from the VF net driver (does this=
 need
>> to happen before migration is finished? If we want to lower the probab=
ility
>> of a failure after we're already committed to the migration, then I th=
ink we
>> must, but libvirt isn't set up for that in any way).

Yes, so I think that's part of the 'partial' unplug I'm trying to
figure out add the moment.=20

>> 4) will need to be hotplugged after the migration has finished *and* a=
fter
>> the guest CPUs have been restarted on the destination.
>
>My understanding is that QEMU takes care of this.

So the re-plugging of the device on the destination is not in the v1
of the patches, which I failed to mention, my bad. I will sent out a v2
that has this part as well shortly. I added a runstate change handler
that is called on the destination when the run state changes from INMIGRA=
TE
to something else. When the new state is RUNNING I hotplug the primary de=
vice.=20

>> a) there isn't anything in libvirt's XML grammar that allows us to sig=
nify a
>> device that is "present in the config but shouldn't be included in the
>> commandline"
>
>I don't thin we need that.
>
>> b) someone will need to replace the device from the source with an
>> equivalent device on the destination in the libvirt XML. There are oth=
er
>> cases of management modifying the XML during migration (I think), but =
this
>> does point out that putting the "auto-unplug code into qemu isn't turn=
ing
>> this into a trivial
>
>The mgmt app should pass the new device details in the XML when starting
>migration. Shouldn't be a big deal as OpenStack already does that for
>quite a few other parts of the config.
>
>> c) there is nothing in libvirt's migration logic that can cause a devi=
ce to
>> be re-binded to vfio-pci prior to completion of a migration. Unless th=
is is
>> added to libvirt (or the re-bind operation is passed off to the manage=
ment
>> application), we will need to live with the possibility that hotpluggi=
ng the
>> device will fail due to failed re-bind *after* we've committed to the
>> migration.
>
>IIUC, we should be binding to vfio-pci during the prepare phase of the
>migration, since that's when QEMU is started by libvirt on the target.
>
>> d) once the guest CPUs are restarted on the destination, [someone] (li=
bvirt
>> or management) needs to hotplug the new device on the destination. (I'=
m
>> guessing that a hotplug can only be done while the guest CPUs are runn=
ing;
>> correct me if this is wrong!)
>
>I don't believe so, since we'll be able to cold plug it during prepare
>phase.

I think I don't understand what happens during the prepare phase on
the destination. Need to look into that. But I think I had an error in
my logic that I need to plug the device from QEMU on the destination
side. You're saying we could just always cold plug it directly when
the VM is started. I think an exception would be when the guest was
migrated before we added the primary device on the source, so before
virtio feature negotiation.

regards,
Jens=20

