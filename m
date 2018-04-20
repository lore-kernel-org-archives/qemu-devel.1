Received: from eggs.gnu.org ([2001:4830:134:3::10]:35343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9ZvY-00006z-N6
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1f9ZvX-0000St-Nx
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 13:34:28 -0400
References: <CAMxP3BTEzHjfxr=nnYDCL2v1djYJt5t5_hZ8rWo_S=qcbhQYVQ@mail.gmail.com>
	<3d41de05-4bbd-3843-a0b7-fd71fc187022@redhat.com>
	<CAMxP3BQSAMk2ytNajWMnr14t30uFEdE6FkNJU62J9A9MJcbVSQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <af35a794-6c39-bdaa-8aa6-9d50ca759198@redhat.com>
Date: Fri, 20 Apr 2018 13:34:12 -0400
MIME-Version: 1.0
In-Reply-To: <CAMxP3BQSAMk2ytNajWMnr14t30uFEdE6FkNJU62J9A9MJcbVSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [SPDK] qemu process hung at boot-up,
 no explicit errors or warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bob Chen <a175818323@gmail.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>



On 04/20/2018 07:13 AM, Bob Chen wrote:
> 2.11.1 could work, qemu is no longer occupying 100% CPU. That's
> interesting...
>=20

Does 2.12 use 100% even at the firmware menu? Maybe we're not giving
this VM long enough to hit the spot that causes it to use 100%.

> Now I can see the starting screen via vnc, says that not a bootable dis=
k.
>=20

If it's stopping at the firmware I think the guest is not being taken
into account, and the firmware is either trying to boot the wrong disk
or your disk is corrupted. (Or it can't see your disk at all -- I'm
personally not very familiar with using SPDK.)

Can you share your command line with us?

>=20
> Is that because the guest OS's virtio vhost driver is not up to date en=
ough?
> =E2=80=8B
>=20
> Thanks,
> Bob
>=20

On the QEMU-devel list and many other technical lists, can you please
reply in-line instead of replying above? ("top posting")

Thank you,
--John

> 2018-04-20 1:17 GMT+08:00 John Snow <jsnow@redhat.com
> <mailto:jsnow@redhat.com>>:
>=20
>     Forwarding to qemu-block.
>=20
>     On 04/19/2018 06:13 AM, Bob Chen wrote:
>     > Hi,
>     >=20
>     > I was trying to run qemu with spdk, referring to
>     > http://www.spdk.io/doc/vhost.html#vhost_qemu_config
>     <http://www.spdk.io/doc/vhost.html#vhost_qemu_config>
>     >=20
>     > Everything went well since I had already set up hugepages, vfio, =
vhost
>     > targets, vhost-scsi device(vhost-block was also tested), etc, wit=
hout
>     > errors or warnings reported.
>     >=20
>     > But at the last step to run qemu, the process would somehow hang.=
 And its
>     > cpu busy remained 100%.
>     >=20
>     > I used `perf top -p` to monitor the process activity,
>     >=C2=A0 =C2=A018.28%=C2=A0 [kernel]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [k] vmx_vcpu_run
>     >=C2=A0 =C2=A0 3.06%=C2=A0 [kernel]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [k] vcpu_enter_guest
>     >=C2=A0 =C2=A0 3.05%=C2=A0 [kernel]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [k] system_call_after_swapgs
>     >=20
>     > Do you have any ideas about what happened here?
>     >=20
>     > Test environment: latest CentOS 7 kernel, nvme ssd, spdk v18.01.x=
,
>     > dpdk 17.11.1, qemu 2.12.0-rc2. Detail log is attached within this=
 mail.
>     >=20
>=20
>     Have you tried any other versions? (2.11.1, or 2.12-rc4?)
>=20
>     >
>     >
>     > Thanks,
>     > Bob
>     >
>=20
>=20
