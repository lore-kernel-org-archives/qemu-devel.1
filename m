Received: from eggs.gnu.org ([2001:4830:134:3::10]:55146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cvpEk-0008Na-64
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:00:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cvpEh-0006Q5-3X
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:00:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54294
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1cvpEg-0006Px-Sx
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 14:00:51 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v35HwcRg119398
	for <qemu-devel@nongnu.org>; Wed, 5 Apr 2017 14:00:49 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29n3s8n5sx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 14:00:49 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 5 Apr 2017 14:00:48 -0400
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
	<6a70868f-8831-54ce-5c67-c325acf03fec@intel.com>
	<b894f5b7-64ad-7696-b3fe-82941e2d6c5b@linux.vnet.ibm.com>
	<CAJ+F1C+XKOWyqse2L+4sYPOOnSfqX89+tVGtHhOqwc-GP0eZKQ@mail.gmail.com>
	<090205a2-2246-5fd1-2d60-d78848eb8af5@linux.vnet.ibm.com>
	<CAJ+F1CLxZ15CnOxEwha6=NQyUSyLmoWh62ZAmr2OJT8TQDOB+A@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 5 Apr 2017 14:00:44 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CLxZ15CnOxEwha6=NQyUSyLmoWh62ZAmr2OJT8TQDOB+A@mail.gmail.com>
Message-Id: <7b090051-40f1-0903-994c-461ec22b0e07@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] Provide support for the software TPM
 emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org

On 04/05/2017 01:49 PM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Wed, Apr 5, 2017 at 7:32 PM Stefan Berger=20
> <stefanb@linux.vnet.ibm.com <mailto:stefanb@linux.vnet.ibm.com>> wrote:
>
>     On 04/05/2017 11:08 AM, Marc-Andr=C3=A9 Lureau wrote:
>     > Hi
>     >
>     > On Wed, Apr 5, 2017 at 5:04 PM Stefan Berger
>     <stefanb@linux.vnet.ibm.com <mailto:stefanb@linux.vnet.ibm.com>>
>     > wrote:
>     >
>     >> On 04/05/2017 03:09 AM, Amarnath Valluri wrote:
>     >>>
>     >>> On 03.04.2017 20 <tel:03%2004%2020%2017%2020>
>     <03%2004%2020%2017%2020>:07, Daniel P. Berrange wrote:
>     >>>> On Fri, Mar 31, 2017 at 04:10:09PM +0300, Amarnath Valluri wro=
te:
>     >>>>> Briefly, Theses set of patches introduces:
>     >>>>>    - new TPM backend driver to support software TPM
>     emulators(swtpm(1)).
>     >>>>>    - and few supported fixes/enhancements/cleanup to
>     existing tpm
>     >>>>> backend code.
>     >>>>>
>     >>>>> The similar idea was initiated earliar(2) by Stefan Berger(CC=
ed)
>     >>>>> with slightly
>     >>>>> different approach, using CUSE. As swtpm has excellent
>     support for
>     >>>>> unix domain
>     >>>>> sockets, hence this implementation uses unix domain sockets t=
o
>     >>>>> communicate with
>     >>>>> swtpm.
>     >>>>>
>     >>>>> When Qemu is configured with 'emulator' tpm backend, it spawn=
s
>     >>>>> 'swtpm' and
>     >>>>> communicates its via Unix domain sockets.
>     >>>> I'm not convinced that having QEMU spawning swtpm itself is a
>     desirable
>     >>>> approach, as it means QEMU needs to have all the privileges
>     that swtpm
>     >>>> will need, so that swtpm can inherit them. At the very least
>     I think we
>     >>>> need to have a way to disable this spawning, so it can
>     connect to a
>     >>>> pre-existing swtpm process that's been spawned ahead of time.
>     This will
>     >>>> let us have stricter privilege separation.
>     >>> Both spawning inside qemu and connecting to already running
>     swtpm has
>     >>> its own pros, Hence we can make this spawning as backend
>     configuration
>     >>> detail, So it looks like this:
>     >>>
>     >>> -tpmdev
>     >>>
>     >>
>     emulator,id=3Did,tpmstatedir=3Ddir[,spawn=3D[on|off],data-path=3Dpa=
th,ctrl-path=3Dpath,logfile=3Dpath,loglevel=3Dnumber]
>     >>>    Options details:
>     >>>       tpmstatedir - Directory path, which swtpm should  use for
>     >>> storing  TPM state
>     >>>       *spawn      - should spawn new process, defaults to 'off'
>     >>>       *path         - swtpm binary path to spawn, ignored if
>     spawn is off
>     >>>       *data-path - Socket path to use/connect for data messages
>     >>>       *ctrl-path   - Socket path to use/connect for
>     out-of-band control
>     >>> messages
>     >> FD passing would work?
>     >>
>     > Could with /dev/fdset in theory, but it would be better to use
>     chardevs
>     > instead.
>     >
>     > Is there any reason left to have 2 sockets? Couldn't the data be
>     sent as
>     > another message on the "ctrl-path" ?
>
>     Better to keep them separate so whatever comes out of a VM will
>     never be
>     mistaken for a control command.
>
>
> This is a moot argument, there is no reason the code would mix the two,
>
> An alternative to make the setup easier is to pass the data socket=20
> through the ctrl socket, perhaps.

Libvirt could open two sockets and pass them via command line. I don't=20
think there's a problem in this case.
With command line it may be a bit more typing, but passing the data=20
socket through the ctrl socket doesn't seem to work so easily, so one=20
may have to resort to typing the paths.
