Received: from eggs.gnu.org ([209.51.188.92]:57898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <casasfernando@hotmail.com>) id 1gpAaP-0007iB-JP
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:32:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <casasfernando@hotmail.com>) id 1gpAaN-000463-J7
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:32:49 -0500
From: =?iso-8859-1?Q?Fernando_Casas_Sch=F6ssow?= <casasfernando@hotmail.com>
Date: Thu, 31 Jan 2019 11:32:32 +0000
Message-ID: <VI1PR0602MB324559765BFE372F75D52E57A4910@VI1PR0602MB3245.eurprd06.prod.outlook.com>
References: <VI1PR1001MB137395F2FCBDE6389A9AC5FCB7C30@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7358YVXbk++Z7s+q6Z5O0Q=6CQiQvYsTdc35eqmQeUnP_Q@mail.gmail.com>
	<VI1PR1001MB1373C8915C51F7453D41B950B7C10@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7345_Nu_kpsSDGq7OyOSuKmgtyS-DuXTafkGeaCCXzV5LQ@mail.gmail.com>
	<VI1PR1001MB1373B1F3C97D9528166E2305B7C40@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb735e_NjY47LRZ58+zvKGmCRQKAmFo-HhByhsosRzQkOgxA@mail.gmail.com>
	<HE1PR1001MB1371F7874B487B0907C42A7EB7C50@HE1PR1001MB1371.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7372Pv3hR4S8C0TCV19u9XAKn=y0VmreGuZavhOjqRrypQ@mail.gmail.com>
	<VI1PR1001MB13731144A5E55914A9E414A5B7DA0@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
	<CABdb7377U9SpZno1kU6+TuARUmqfMMcC2uuwXTHqSZpLsqB7Gw@mail.gmail.com>
	<1498199343.2815.0@smtp-mail.outlook.com>,
	<VI1PR1001MB13731EF256C1E7380E1D657AB7D90@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <VI1PR1001MB13731EF256C1E7380E1D657AB7D90@VI1PR1001MB1373.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Guest unresponsive after Virtqueue size exceeded
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>

Hi,

Sorry for resurrecting this thread after so long but I just upgraded the ho=
st to Qemu 3.1 and libvirt 4.10 and I'm still facing this problem.
At the moment I cannot use virtio disks (virtio-blk nor virtio-scsi) with m=
y guests in order to avoid this issue so as a workaround I'm using SATA emu=
lated storage which is not ideal but is perfectly stable.

Do you have any suggestions on how can I progress troubleshooting?
Qemu is not crashing so I don't have any dumps that can be analyzed. The gu=
est is just "stuck" and all I can do is destroy it and start it again.
It's really frustrating that after all this time I couldn't find the cause =
for this issue so any ideas are welcome.

Thanks.

Fernando

________________________________
From: Fernando Casas Sch=F6ssow <casasfernando@hotmail.com>
Sent: Saturday, June 24, 2017 10:34 AM
To: Ladi Prosek
Cc: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] Guest unresponsive after Virtqueue size exceeded =
error

Hi Ladi,

After running for about 15hrs two different guests (one Windows, one Linux)=
 crashed with around 1 hour difference and the same error in qemu log "Virq=
ueue size exceeded".

The Linux guest was already running on virtio_scsi and without virtio_ballo=
on. :(
I compiled and attached gdbserver to the qemu process for this guest but wh=
en I did this I got the following warning in gdbserver:

warning: Cannot call inferior functions, Linux kernel PaX protection forbid=
s return to non-executable pages!

The default Alpine kernel is a grsec kernel. Not sure if this will interfer=
e with debugging or not but I suspect yes.
If you need me to replace the grsec kernel with a vanilla one (also availab=
le as an option in Alpine) let me know and I will do so.
Otherwise send me an email directly so I can share with you the host:port d=
etails so you can connect to gdbserver.

Thanks,

Fer

On vie, jun 23, 2017 at 8:29 , Fernando Casas Sch=F6ssow <casasfernando@hot=
mail.com> wrote:
Hi Ladi,

Small update. Memtest86+ was running on the host for more than 54 hours. 8 =
passes were completed and no memory errors found. For now I think we can as=
sume that the host memory is ok.

I just started all the guests one hour ago. I will monitor them and once on=
e fails I will attach the debugger and let you know.

Thanks.

Fer

On jue, jun 22, 2017 at 9:43 , Ladi Prosek <lprosek@redhat.com> wrote:
Hi Fernando, On Wed, Jun 21, 2017 at 2:19 PM, Fernando Casas Sch=F6ssow <ca=
sasfernando@hotmail.com<mailto:casasfernando@hotmail.com>> wrote:
Hi Ladi, Sorry for the delay in my reply. I will leave the host kernel alon=
e for now then. For the last 15 hours or so I'm running memtest86+ on the h=
ost. So far so good. Two passes no errors so far. I will try to leave it ru=
nning for at least another 24hr and report back the results. Hopefully we c=
an discard the memory issue at hardware level. Regarding KSM, that will be =
the next thing I will disable if after removing the balloon device guests s=
till crash. About leaving a guest in a failed state for you to debug it rem=
otely, that's absolutely an option. We just need to coordinate so I can giv=
e you remote access to the host and so on. Let me know if any preparation i=
s needed in advance and which tools you need installed on the host.
I think that gdbserver attached to the QEMU process should be enough. When =
the VM gets into the broken state please do something like: gdbserver --att=
ach host:12345 <QEMU pid> and let me know the host name and port (12345 in =
the above example).
Once I again I would like to thank you for all your help and your great dis=
position!
You're absolutely welcome, I don't think I've done anything helpful so far =
:)
Cheers, Fer On mar, jun 20, 2017 at 9:52 , Ladi Prosek <lprosek@redhat.com<=
mailto:lprosek@redhat.com>> wrote: The host kernel is less likely to be res=
ponsible for this, in my opinion. I'd hold off on that for now. And last bu=
t not least KSM is enabled on the host. Should I disable it? Could be worth=
 the try. Following your advice I will run memtest on the host and report b=
ack. Just as a side comment, the host is running on ECC memory. I see. Woul=
d it be possible for you, once a guest is in the broken state, to make it a=
vailable for debugging? By attaching gdb to the QEMU process for example an=
d letting me poke around it remotely? Thanks!
