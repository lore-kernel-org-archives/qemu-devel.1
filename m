Received: from eggs.gnu.org ([2001:4830:134:3::10]:41785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cj5af-00075a-CH
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:50:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cj5aa-0006wX-8c
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:50:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46530
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1cj5aa-0006wK-0y
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:50:48 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21EhgL8145226
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 09:50:47 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 28wxr861rn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 09:50:45 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 1 Mar 2017 07:50:43 -0700
References: <20160120162220.GH13215@redhat.com> <20160121113632.GC2446@work-vm>
	<57FA3A002D66E049AA7792D931B894C7060F5494@MOKSCY3MSGUSRGB.ITServices.sbc.com>
	<945CA011AD5F084CBEA3E851C0AB28894B8C3A14@SHSMSX101.ccr.corp.intel.com>
	<575E92DB.3080904@linux.vnet.ibm.com> <20160615193019.GB7300@work-vm>
	<5761C092.5070702@linux.vnet.ibm.com> <20160616080520.GA2249@work-vm>
	<20160616082517.GC11426@redhat.com>
	<5075d390-a1d1-b707-6b57-deb0154c2e37@linux.vnet.ibm.com>
	<20170301125414.GD10160@redhat.com>
	<OF00CA88E0.A7212243-ON002580D6.00498E3C-852580D6.0049CA7A@notes.na.collabserv.com>
	<CAJ+F1C+h7iyCSxE6p91NtEoTZSLtLBuF53=6yuWH+n-tBdV5=A@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 1 Mar 2017 09:50:38 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+h7iyCSxE6p91NtEoTZSLtLBuF53=6yuWH+n-tBdV5=A@mail.gmail.com>
Message-Id: <05b271a3-4bf9-729b-d662-c9886951f26d@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE TPM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Stefan Berger <stefanb@us.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "Xu, Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "SERBAN, CRISTINA" <cs1731@att.com>, "SHIH, CHING C" <cs1815@att.com>

On 03/01/2017 09:17 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Wed, Mar 1, 2017 at 5:26 PM Stefan Berger <stefanb@us.ibm.com=20
> <mailto:stefanb@us.ibm.com>> wrote:
>
>     "Daniel P. Berrange" <berrange@redhat.com
>     <mailto:berrange@redhat.com>> wrote on 03/01/2017 07:54:14
>     AM:
>     >
>     > On Wed, Mar 01, 2017 at 07:25:28AM -0500, Stefan Berger wrote:
>     > > On 06/16/2016 04:25 AM, Daniel P. Berrange wrote:
>     > > > On Thu, Jun 16, 2016 at 09:05:20AM +0100, Dr. David Alan Gilb=
ert
>     wrote:
>     > > > > * Stefan Berger (stefanb@linux.vnet.ibm.com
>     <mailto:stefanb@linux.vnet.ibm.com>) wrote:
>     > > > > > On 06/15/2016 03:30 PM, Dr. David Alan Gilbert wrote:
>     > > > > <snip>
>     > > > >
>     > > > > > > So what was the multi-instance vTPM proxy driver patch =
set
>     about?
>     > > > > > That's for containers.
>     > > > > Why have the two mechanisms? Can you explain how the
>     multi-instance
>     > > > > proxy works; my brief reading when I saw your patch series
>     seemed
>     > > > > to suggest it could be used instead of CUSE for the
>     non-container
>     case.
>     > > > One of the key things that was/is not appealing about this CU=
SE
>     approach
>     > > > is that it basically invents a new ioctl() mechanism for
>     talking to
>     > > > a TPM chardev. With in-kernel vTPM support, QEMU probably
>     doesn't
>     need
>     > > > to have any changes at all - its existing driver for talking
>     to TPM
>     > >
>     > > We still need the control channel with the vTPM to reset it
>     upon VM
>     reset,
>     > > for getting and setting the state of the vTPM upon
>     snapshot/suspend/resume,
>     > > changing locality, etc.
>     >
>     > You ultimately need the same mechanisms if using in-kernel vTPM w=
ith
>     > containers as containers can support snapshot/suspend/resume/etc
>     too.
>
>     The vTPM running on the backend side of the vTPM proxy driver is
>     essentially the same as the CUSE TPM used for QEMU. I has the same
>     control
>     channel through sockets. So on that level we would have support
>     for the
>     operations but not integrated with anything that would support
>     container
>     migration.
>
>
> Ah that might explain why you added the socket control channel, but=20
> there is no user yet? (or some private product perhaps). Could you=20
> tell if control and data channels need to be synchronized in any ways?


In the general case, synchronization would have to happen, yes. So a=20
lock that is held while the TPM processes data would have to lock out=20
control channel commands that operate on the TPM data. That may be=20
missing. In case of QEMU being the client, not much concurrency would be=20
expected there just by the way QEMU interacts with it.

A detail: A corner case is live-migration with the TPM emulation being=20
busy processing a command, like creation of a key. In that case QEMU=20
would keep on running and only start streaming device state to the=20
recipient side after the TPM command processing finishes and has=20
returned the result. QEMU wouldn't want to get stuck in a lock between=20
data and control channel, so would have other means of determining when=20
the backend processing is done.

>
> Getting back to the original out-of-process design: qemu links with=20
> many libraries already, perhaps a less controversial approach would be=20
> to have a linked in solution before proposing out-of-process? This=20
> would be easier to deal with for

I had already proposed a linked-in version before I went to the=20
out-of-process design. Anthony's concerns back then were related to the=20
code not being trusted and a segfault in the code could bring down all=20
of QEMU. That we have test suites running over it didn't work as an=20
argument. Some of the test suite are private, though.

> management layers etc. This wouldn't be the most robust solution, but=20
> could get us somewhere at least for easier testing and development.

Hm. In terms of external process it's basically 'there', so I don't=20
related to the 'easier testing and development.' The various versions=20
with QEMU + CUSE TPM driver patches applied are here.

https://github.com/stefanberger/qemu-tpm/tree/v2.8.0+tpm

I have an older version of libvirt that has the necessary patches=20
applied to start QEMU with the external TPM. There's also virt-manager=20
support.

If CUSE is the wrong interface, then there's a discussion about this=20
here. Alternatively UnixIO for data and control channel could be used.

https://github.com/stefanberger/swtpm/issues/4

    Stefan


>
> thanks
>
>
> --=20
> Marc-Andr=C3=A9 Lureau
