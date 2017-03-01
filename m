Received: from eggs.gnu.org ([2001:4830:134:3::10]:39618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cj6dz-00061W-F4
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cj6dv-000628-6o
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:58:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53411
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1cj6du-00061r-Th
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 10:58:19 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v21FsA61020381
	for <qemu-devel@nongnu.org>; Wed, 1 Mar 2017 10:58:17 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28x139s138-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 10:58:16 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 1 Mar 2017 10:58:16 -0500
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
	<05b271a3-4bf9-729b-d662-c9886951f26d@linux.vnet.ibm.com>
	<CAJ+F1C+PrT9cPGQoKSjZBmtX8EE78y1USiaWfCGmW82Su-Pamw@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 1 Mar 2017 10:58:10 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+PrT9cPGQoKSjZBmtX8EE78y1USiaWfCGmW82Su-Pamw@mail.gmail.com>
Message-Id: <40978bce-53e9-a3e5-a801-0bf4ba1e1094@linux.vnet.ibm.com>
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

On 03/01/2017 10:24 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Wed, Mar 1, 2017 at 6:50 PM Stefan Berger=20
> <stefanb@linux.vnet.ibm.com <mailto:stefanb@linux.vnet.ibm.com>> wrote:
>
>     On 03/01/2017 09:17 AM, Marc-Andr=C3=A9 Lureau wrote:
>>     Hi
>>
>>     On Wed, Mar 1, 2017 at 5:26 PM Stefan Berger <stefanb@us.ibm.com
>>     <mailto:stefanb@us.ibm.com>> wrote:
>>
>>         "Daniel P. Berrange" <berrange@redhat.com
>>         <mailto:berrange@redhat.com>> wrote on 03/01/2017 07:54:14
>>         AM:
>>         >
>>
>>         > On Wed, Mar 01, 2017 at 07:25:28AM -0500, Stefan Berger wrot=
e:
>>         > > On 06/16/2016 04:25 AM, Daniel P. Berrange wrote:
>>         > > > On Thu, Jun 16, 2016 at 09:05:20AM +0100, Dr. David
>>         Alan Gilbert
>>         wrote:
>>         > > > > * Stefan Berger (stefanb@linux.vnet.ibm.com
>>         <mailto:stefanb@linux.vnet.ibm.com>) wrote:
>>         > > > > > On 06/15/2016 03:30 PM, Dr. David Alan Gilbert wrote=
:
>>         > > > > <snip>
>>         > > > >
>>         > > > > > > So what was the multi-instance vTPM proxy driver
>>         patch set
>>         about?
>>         > > > > > That's for containers.
>>         > > > > Why have the two mechanisms? Can you explain how the
>>         multi-instance
>>         > > > > proxy works; my brief reading when I saw your patch
>>         series seemed
>>         > > > > to suggest it could be used instead of CUSE for the
>>         non-container
>>         case.
>>         > > > One of the key things that was/is not appealing about
>>         this CUSE
>>         approach
>>         > > > is that it basically invents a new ioctl() mechanism
>>         for talking to
>>         > > > a TPM chardev. With in-kernel vTPM support, QEMU
>>         probably doesn't
>>         need
>>         > > > to have any changes at all - its existing driver for
>>         talking to TPM
>>         > >
>>         > > We still need the control channel with the vTPM to reset
>>         it upon VM
>>         reset,
>>         > > for getting and setting the state of the vTPM upon
>>         snapshot/suspend/resume,
>>         > > changing locality, etc.
>>         >
>>         > You ultimately need the same mechanisms if using in-kernel
>>         vTPM with
>>         > containers as containers can support
>>         snapshot/suspend/resume/etc too.
>>
>>         The vTPM running on the backend side of the vTPM proxy driver =
is
>>         essentially the same as the CUSE TPM used for QEMU. I has the
>>         same control
>>         channel through sockets. So on that level we would have
>>         support for the
>>         operations but not integrated with anything that would
>>         support container
>>         migration.
>>
>>
>>     Ah that might explain why you added the socket control channel,
>>     but there is no user yet? (or some private product perhaps).
>>     Could you tell if control and data channels need to be
>>     synchronized in any ways?
>
>
>     In the general case, synchronization would have to happen, yes. So
>     a lock that is held while the TPM processes data would have to
>     lock out control channel commands that operate on the TPM data.
>     That may be missing. In case of QEMU being the client, not much
>     concurrency would be expected there just by the way QEMU interacts
>     with it.
>
>
> Could the data channel be muxed in with the control channel? )that is=20
> only use one control socket)


You could run the data channel as part of the control channel or vice=20
versa. I think the problem is that TCG hasn't defined anything in this=20
area and two people in different rooms will come up with two different=20
designs.



>
>     A detail: A corner case is live-migration with the TPM emulation
>     being busy processing a command, like creation of a key. In that
>     case QEMU would keep on running and only start streaming device
>     state to the recipient side after the TPM command processing
>     finishes and has returned the result. QEMU wouldn't want to get
>     stuck in a lock between data and control channel, so would have
>     other means of determining when the backend processing is done.
>
>
>>
>>     Getting back to the original out-of-process design: qemu links
>>     with many libraries already, perhaps a less controversial
>>     approach would be to have a linked in solution before proposing
>>     out-of-process? This would be easier to deal with for
>
>     I had already proposed a linked-in version before I went to the
>     out-of-process design. Anthony's concerns back then were related
>     to the code not being trusted and a segfault in the code could
>     bring down all of QEMU. That we have test suites running over it
>     didn't work as an argument. Some of the test suite are private,
>     though.
>
>
> I think Anthony argument is valid for anything running in qemu :) So I=20
> don't see why TPM would be an exception now.
>
> Could you say how much is covered by the public test suite?

I don't know anything in terms of percentage of code coverage. But I=20
think in terms of coverage of commands of a TPM 1.2 we were probably=20
 >95%. Now there's also TPM 2 and for that I don't know.

>
> About tests, is there any test for qemu TIS?

For the TIS I had some very limited tests in SeaBIOS, which of course=20
are not upstreamed. Though the primary goal there was to test live=20
migration while doing PCR Extends.


>
>
>>     management layers etc. This wouldn't be the most robust solution,
>>     but could get us somewhere at least for easier testing and
>>     development.
>
>     Hm. In terms of external process it's basically 'there', so I
>     don't related to the 'easier testing and development.' The various
>     versions with QEMU + CUSE TPM driver patches applied are here.
>
>     https://github.com/stefanberger/qemu-tpm/tree/v2.8.0+tpm
>
>
>
> Some people may want to use simulated TPM with qemu without the need=20
> for security, just to do development/testing.
>

For that they have a solution with the above tree and the swtpm and=20
libtpms projects.

> Dealing with external processes makes also qemu development and=20
> testing more difficult.

Well, internal didn't fly previously.

>
> Changing the IPC interface is more complicated  than having linked in=20
> solution. Testing is easier if you can just start/kill one qemu process.
>
> I can't say if it's really needed to ease progress, but at least it=20
> would avoid that CUSE/IPC discussion for now.
>
>     I have an older version of libvirt that has the necessary patches
>     applied to start QEMU with the external TPM. There's also
>     virt-manager support.
>
>
> Ok, I think it would be worth to list all the up to date trees in=20
> http://www.qemu-project.org/Features/TPM (btw, that page is 5y old,=20
> would be nice if you could refresh it, I bet some changed happened)
>
>     If CUSE is the wrong interface, then there's a discussion about
>     this here. Alternatively UnixIO for data and control channel could
>     be used.
>
>     https://github.com/stefanberger/swtpm/issues/4
>
>
> If there is no strong argument for CUSE, I would go without it
>
> (I'd also suggest a similar approach to vhost-user backend I proposed=20
> in http://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg01014.htm=
l,
> it spawns a backend and pass an extra socketpair fd to it)
>
