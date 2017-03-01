Received: from eggs.gnu.org ([2001:4830:134:3::10]:60819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cj54i-00032d-JK
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:17:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cj54h-0004hd-4x
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:17:52 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:34944)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cj54g-0004hF-Oq
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:17:51 -0500
Received: by mail-lf0-x242.google.com with SMTP id z127so3492730lfa.2
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 06:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20160120162220.GH13215@redhat.com> <20160121113632.GC2446@work-vm>
	<57FA3A002D66E049AA7792D931B894C7060F5494@MOKSCY3MSGUSRGB.ITServices.sbc.com>
	<945CA011AD5F084CBEA3E851C0AB28894B8C3A14@SHSMSX101.ccr.corp.intel.com>
	<575E92DB.3080904@linux.vnet.ibm.com> <20160615193019.GB7300@work-vm>
	<5761C092.5070702@linux.vnet.ibm.com> <20160616080520.GA2249@work-vm>
	<20160616082517.GC11426@redhat.com>
	<5075d390-a1d1-b707-6b57-deb0154c2e37@linux.vnet.ibm.com>
	<20170301125414.GD10160@redhat.com>
	<OF00CA88E0.A7212243-ON002580D6.00498E3C-852580D6.0049CA7A@notes.na.collabserv.com>
In-Reply-To: <OF00CA88E0.A7212243-ON002580D6.00498E3C-852580D6.0049CA7A@notes.na.collabserv.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 01 Mar 2017 14:17:36 +0000
Message-ID: <CAJ+F1C+h7iyCSxE6p91NtEoTZSLtLBuF53=6yuWH+n-tBdV5=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Stefan Berger <stefanb@us.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: "mst@redhat.com" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "Xu,
	Quan" <quan.xu@intel.com>, "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>, "SERBAN,
	CRISTINA" <cs1731@att.com>, "SHIH, CHING C" <cs1815@att.com>

Hi

On Wed, Mar 1, 2017 at 5:26 PM Stefan Berger <stefanb@us.ibm.com> wrote:

> "Daniel P. Berrange" <berrange@redhat.com> wrote on 03/01/2017 07:54:14
> AM:
>
> > From: "Daniel P. Berrange" <berrange@redhat.com>
> > To: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Berger/
> > Watson/IBM@IBMUS, "mst@redhat.com" <mst@redhat.com>, "qemu-
> > devel@nongnu.org" <qemu-devel@nongnu.org>, "SERBAN, CRISTINA"
> > <cs1731@att.com>, "Xu, Quan" <quan.xu@intel.com>,
> > "silviu.vlasceanu@gmail.com" <silviu.vlasceanu@gmail.com>,
> > "hagen.lauer@huawei.com" <hagen.lauer@huawei.com>, "SHIH, CHING C"
> > <cs1815@att.com>
> > Date: 03/01/2017 08:03 AM
> > Subject: Re: [Qemu-devel] [PATCH v5 1/4] Provide support for the CUSE
> TPM
> >
> > On Wed, Mar 01, 2017 at 07:25:28AM -0500, Stefan Berger wrote:
> > > On 06/16/2016 04:25 AM, Daniel P. Berrange wrote:
> > > > On Thu, Jun 16, 2016 at 09:05:20AM +0100, Dr. David Alan Gilbert
> wrote:
> > > > > * Stefan Berger (stefanb@linux.vnet.ibm.com) wrote:
> > > > > > On 06/15/2016 03:30 PM, Dr. David Alan Gilbert wrote:
> > > > > <snip>
> > > > >
> > > > > > > So what was the multi-instance vTPM proxy driver patch set
> about?
> > > > > > That's for containers.
> > > > > Why have the two mechanisms? Can you explain how the
> multi-instance
> > > > > proxy works; my brief reading when I saw your patch series seemed
> > > > > to suggest it could be used instead of CUSE for the non-container
> case.
> > > > One of the key things that was/is not appealing about this CUSE
> approach
> > > > is that it basically invents a new ioctl() mechanism for talking to
> > > > a TPM chardev. With in-kernel vTPM support, QEMU probably doesn't
> need
> > > > to have any changes at all - its existing driver for talking to TPM
> > >
> > > We still need the control channel with the vTPM to reset it upon VM
> reset,
> > > for getting and setting the state of the vTPM upon
> snapshot/suspend/resume,
> > > changing locality, etc.
> >
> > You ultimately need the same mechanisms if using in-kernel vTPM with
> > containers as containers can support snapshot/suspend/resume/etc too.
>
> The vTPM running on the backend side of the vTPM proxy driver is
> essentially the same as the CUSE TPM used for QEMU. I has the same contro=
l
> channel through sockets. So on that level we would have support for the
> operations but not integrated with anything that would support container
> migration.
>
>
Ah that might explain why you added the socket control channel, but there
is no user yet? (or some private product perhaps). Could you tell if
control and data channels need to be synchronized in any ways?

Getting back to the original out-of-process design: qemu links with many
libraries already, perhaps a less controversial approach would be to have a
linked in solution before proposing out-of-process? This would be easier to
deal with for management layers etc. This wouldn't be the most robust
solution, but could get us somewhere at least for easier testing and
development.

thanks


--=20
Marc-Andr=C3=A9 Lureau
