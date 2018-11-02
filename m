Received: from eggs.gnu.org ([2001:4830:134:3::10]:34558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gIdbk-0002Ct-Io
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gIdbj-0003JA-CX
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:51:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54488)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gIdbi-00030U-RX
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 13:51:43 -0400
Date: Fri, 2 Nov 2018 17:51:11 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181102175111.GA2388@work-vm>
References: <d5d6e09a-78ed-41c4-bbb9-260263c05bf2@windriver.com>
	<87pnvn6hnq.fsf@linaro.org>
	<b109fe05-1e88-a6e3-34cb-21a4b61e64b3@windriver.com>
	<87lg6b5shx.fsf@linaro.org>
	<98428a27-8634-9521-297c-a61c618e867a@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <98428a27-8634-9521-297c-a61c618e867a@windriver.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] strange situation,
 guest cpu thread spinning at ~100%, but display not yet initialized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chris Friesen <chris.friesen@windriver.com>, famz@redhat.com
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

* Chris Friesen (chris.friesen@windriver.com) wrote:
> On 11/2/2018 10:55 AM, Alex Benn=E9e wrote:
> >=20
> > Chris Friesen <chris.friesen@windriver.com> writes:
> > > Given the "not initialized" message on the console, I wasn't sure
> > > whether the kernel had even started yet.
> >=20
> > There will be a lot that happens between the kernel decompressing and
> > some sort of video hardware output being started. You didn't say what
> > guest architecture you were booting or what your qemu command line wa=
s.
> > You might want to look at enabling the serial console and seeing if y=
ou
> > get some clues from that.
>=20
> The qemu commandline is in the "ps" output in my original message. Gues=
t
> arch is x86-64.
>=20
> The serial console is a good idea, will try that.

This is ringing a bell; if it's actually suck in the BIOS, then please:
  a) Really make sure all your vCPUs are actually pinned/free on real
CPUs
  b) I suspect it is
   https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg00470.html


   so the fix is Fam's 'aio: Do aio_notify_accept only during blocking
aio_poll'.  I see you're running the qemu-kvm-ev from centos, if I read
the version tea-leaves right, then I think that patch is in the
2.10.0-21.el7_5.7.1 package I can see.

Dave


> Chris
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
