Received: from eggs.gnu.org ([2001:4830:134:3::10]:37248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNM6S-0002VU-Gw
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gNM6R-0002sW-3S
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:10:56 -0500
References: <1541121763-3277-1-git-send-email-liq3ea@gmail.com>
	<CAKXe6SL=6m5u1utFoJCG65ucuBeGTiuu8rA9wEj_X-tO1jHzEA@mail.gmail.com>
	<20181113101704.GB4830@localhost.localdomain>
	<2db2eb88-bc7c-d3c0-93ca-43d6a2f79b0a@redhat.com>
	<CAKXe6S+e8zBgYU8DnU2tUqQm2C1w14pgqg55YmxwPn1UUW3E7g@mail.gmail.com>
	<9e733597-36bf-0b64-892f-1b35e67a632c@redhat.com>
	<CAKXe6S+Atz0M9NgUEuuN-2e5XDUyGMA0Ser7kipy1yfvuLguSA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ff40a572-18a1-1609-450f-b1b8e99ed3d5@redhat.com>
Date: Thu, 15 Nov 2018 19:10:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAKXe6S+Atz0M9NgUEuuN-2e5XDUyGMA0Ser7kipy1yfvuLguSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nvme: fix oob access issue(CVE-2018-16847)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: kwolf@redhat.com, keith.busch@intel.com, mreitz@redhat.com, P J P <ppandit@redhat.com>, qemu-block@nongnu.org, Qemu Developers <qemu-devel@nongnu.org>

On 15/11/2018 04:14, Li Qiang wrote:
>=20
>=20
> Paolo Bonzini <pbonzini@redhat.com <mailto:pbonzini@redhat.com>> =E4=BA=
=8E2018
> =E5=B9=B411=E6=9C=8814=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:=
44=E5=86=99=E9=81=93=EF=BC=9A
>=20
>     On 14/11/2018 02:38, Li Qiang wrote:
>     >
>     >
>     > Paolo Bonzini <pbonzini@redhat.com <mailto:pbonzini@redhat.com>
>     <mailto:pbonzini@redhat.com <mailto:pbonzini@redhat.com>>> =E4=BA=8E=
2018
>     > =E5=B9=B411=E6=9C=8814=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=
=882:27=E5=86=99=E9=81=93=EF=BC=9A
>     >
>     >=C2=A0 =C2=A0 =C2=A0On 13/11/2018 11:17, Kevin Wolf wrote:
>     >=C2=A0 =C2=A0 =C2=A0> Am 13.11.2018 um 02:45 hat Li Qiang geschrie=
ben:
>     >=C2=A0 =C2=A0 =C2=A0>> Ping.... what't the status of this patch.
>     >=C2=A0 =C2=A0 =C2=A0>>
>     >=C2=A0 =C2=A0 =C2=A0>> I see Kevin's new pr doesn't contain this p=
atch.
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> Oh, I thought you said that you wanted to fi=
x this at a higher
>     >=C2=A0 =C2=A0 =C2=A0level so
>     >=C2=A0 =C2=A0 =C2=A0> that the problem is caught before even getti=
ng into nvme
>     code? If you
>     >=C2=A0 =C2=A0 =C2=A0> don't, I can apply the patch for my next pul=
l request.
>     >
>     >=C2=A0 =C2=A0 =C2=A0As far as I know the bug doesn't exist.=C2=A0 =
Li Qiang, if you have a
>     >=C2=A0 =C2=A0 =C2=A0reproducer please send it.
>     >
>     >
>     > Hello Paolo,
>     > Though I've send the debug information and ASAN output in the mai=
l to
>     > secalert@redhat.com <mailto:secalert@redhat.com>
>     <mailto:secalert@redhat.com <mailto:secalert@redhat.com>>, I'm glad
>     provide here.
>     > This is for read, I think the write the same but as the PoC is in
>     > userspace, the mmap can only map the exact size of the MMIO,
>     > So we can only write within the area. But if we using a module we=
 can
>     > write the out of MMIO I think
>     > The nvme device's parameter should set as 'cmb_size_mb=3D2' and t=
he PCI
>     > address may differ in your system.
>=20
>     Ok, thanks.=C2=A0 I've created a reproducer using qtest (though I h=
ave to run
>     now and cannot post it properly).
>=20
>     The patch for the fix is simply:
>=20
>=20
> So do you send this or me?

Me, together with the test.

Paolo
