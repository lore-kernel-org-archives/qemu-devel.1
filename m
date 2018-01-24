Received: from eggs.gnu.org ([2001:4830:134:3::10]:60714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rom@stratoscale.com>) id 1eeRAy-00076K-I7
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:57:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rom@stratoscale.com>) id 1eeRAx-0001D7-LA
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:57:40 -0500
Received: from mail-io0-x229.google.com ([2607:f8b0:4001:c06::229]:36015)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rom@stratoscale.com>) id 1eeRAx-0001Bx-Er
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 14:57:39 -0500
Received: by mail-io0-x229.google.com with SMTP id l17so6103374ioc.3
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 11:57:37 -0800 (PST)
MIME-Version: 1.0
From: Rom Freiman <rom@stratoscale.com>
Date: Wed, 24 Jan 2018 19:57:26 +0000
Message-ID: <CADs-y4TVn-AZuhBFHCNTuHcyQHw+Q446Zq5b8Dh45tZCJNJ9qw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Solaris vm does not recognize all cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hey,

I'm running solaris 11.2 vm above kvm/qemu (centos 7.3. x86_64).
Unfortunately, inside the vm it does not recognize the correct cpu topology:

Seems that only one core per socket is recognized as device_type=cpu, while
the rest are recognized as device_type="acpicpu" (prtconf -v) and are not
counted as part of the cores (psrinfo -t).
Not sure how to enforce all cores to be recognized.

The cpu which is recognized appears as
name='device_type' type=string items=1
value='cpu'
And those that are not:
name='device_type' type=string items=1
value='acpicpu'

Libvirt xml is:
  <features>
    <acpi/>
    <apic/>
  </features>
  <cputune>
    <shares>16384</shares>
  </cputune>
  <clock offset="utc">
    <timer name="pit" tickpolicy="delay"/>
    <timer name="rtc" tickpolicy="catchup"/>
    <timer name="kvmclock" present="no"/>
    <timer name="hpet" present="no"/>
  </clock>
  <cpu mode="custom" match="exact">
    <model>Haswell-noTSX</model>
    <feature name="x2apic" policy="disable"/>
    <topology sockets='8' cores='4' threads='1'/>
  </cpu>


But tried other options as well (host model instead of Hasswell).

Any help will be appreciated.

Thanks,
Rom
