Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94709C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696CD21019
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696CD21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33320 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb5bX-00082a-NB
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 11:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44478)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laine@redhat.com>) id 1hb5aP-00079N-LW
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:54:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laine@redhat.com>) id 1hb5aN-0001Ca-LB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:54:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laine@redhat.com>) id 1hb5aL-0000oS-Fg
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:54:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6BC41A3B65
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 15:54:12 +0000 (UTC)
Received: from vhost2.laine.org (ovpn-116-157.phx2.redhat.com [10.3.116.157])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C96007BE69;
 Wed, 12 Jun 2019 15:54:02 +0000 (UTC)
To: qemu-devel@nongnu.org
References: <20190517125820.2885-1-jfreimann@redhat.com>
 <646d0bf1-2fbb-1adb-d5d3-3ef3944376b5@redhat.com>
 <20190612091123.GF6897@redhat.com>
 <20190612115901.3n5xkdvbjmzxjmmz@jenstp.localdomain>
From: Laine Stump <laine@redhat.com>
Message-ID: <896db7fc-f8b6-aaf2-dbd5-322d9a203c50@redhat.com>
Date: Wed, 12 Jun 2019 11:54:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612115901.3n5xkdvbjmzxjmmz@jenstp.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Wed, 12 Jun 2019 15:54:12 +0000 (UTC)
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
Cc: pkrempa@redhat.com,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 ehabkost@redhat.com, mst@redhat.com, aadam@redhat.com,
 Jens Freimann <jfreimann@redhat.com>, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/19 7:59 AM, Jens Freimann wrote:
> On Wed, Jun 12, 2019 at 11:11:23AM +0200, Daniel P. Berrang=C3=A9 wrote=
:
>> On Tue, Jun 11, 2019 at 11:42:54AM -0400, Laine Stump wrote:
>>> On 5/17/19 8:58 AM, Jens Freimann wrote:
>> >
>>> > Command line example:
>>> >
>>> > qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -machine q35,=
kernel-irqchip=3Dsplit -cpu host=C2=A0=C2=A0 \
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -k fr=C2=A0=C2=
=A0 \
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -serial stdio=
=C2=A0=C2=A0 \
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -net none \
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -qmp unix:/tm=
p/qmp.socket,server,nowait \
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -monitor teln=
et:127.0.0.1:5555,server,nowait \
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device=20
>>> pcie-root-port,id=3Droot0,multifunction=3Don,chassis=3D0,addr=3D0xa \
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device pcie-=
root-port,id=3Droot1,bus=3Dpcie.0,chassis=3D1 \
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device pcie-=
root-port,id=3Droot2,bus=3Dpcie.0,chassis=3D2 \
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -netdev=20
>>> tap,script=3D/root/bin/bridge.sh,downscript=3Dno,id=3Dhostnet1,vhost=3D=
on \
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -device=20
>>> virtio-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3D52:54:00:6f:55:cc,bu=
s=3Droot2,failover=3Don=20
>>> \
>>> >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /root/rhel-gu=
est-image-8.0-1781.x86_64.qcow2
>>> >
>>> > Then the primary device can be hotplugged via
>>> >=C2=A0=C2=A0 (qemu) device_add=20
>>> vfio-pci,host=3D5e:00.2,id=3Dhostdev0,bus=3Droot1,standby=3Dnet1
>>>
>>>
>>> I guess this is the commandline on the migration destination, and as=20
>>> far as
>>> I understand from this example, on the destination we (meaning=20
>>> libvirt or
>>> higher level management application) must *not* include the assigned=20
>>> device
>>> on the qemu commandline, but must instead hotplug the device later=20
>>> after the
>>> guest CPUs have been restarted on the destination.
>>>
>>> So if I'm understanding correctly, the idea is that on the migration=20
>>> source,
>>> the device may have been hotplugged, or may have been included when=20
>>> qemu was
>>> originally started. Then qemu automatically handles the unplug of the=
=20
>>> device
>>> on the source, but it seems qemu does nothing on the destination,=20
>>> leaving
>>> that up to libvirt or a higher layer to implement.
>>>
>>> Then in order for this to work, libvirt (or OpenStack or oVirt or=20
>>> whoever)
>>> needs to understand that the device in the libvirt config (it will=20
>>> still be
>>> in the libvirt config, since from libvirt's POV it hasn't been=20
>>> unplugged):
>>>
>>> 1) shouldn't be included in the qemu commandline on the destination,
>>
>> I don't believe that's the case.=C2=A0 The CLI args above are just=20
>> illustrating
>> that it is now possible to *optionally* not specify the VFIO device on=
=20
>> the
>> CLI. This is because previous versions of the patchset *always* requir=
ed
>> the device on the CLI due to a circular dependancy in the CLI syntax.=20
>> This
>> patch series version fixed that limitation, so now the VFIO device can=
 be
>> cold plugged or hotplugged as desired.
>=20
> I've mostly tested hotplugging but cold plugged should work as well.


Okay, in that case my issues 1, 3, and 4 are irrelevant (and (2) is=20
handled by management), so the concerns from my previous email are all=20
addressed.

