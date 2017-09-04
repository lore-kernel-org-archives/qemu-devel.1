Received: from eggs.gnu.org ([2001:4830:134:3::10]:53462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1donxF-0003PJ-KF
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:46:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1donxA-00086J-Qz
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:46:05 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:43475)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <JBeulich@suse.com>) id 1donxA-00085P-Hb
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:46:00 -0400
Message-Id: <59AD3CF302000078001770C4@prv-mh.provo.novell.com>
Date: Mon, 04 Sep 2017 03:45:55 -0600
From: "Jan Beulich" <JBeulich@suse.com>
References: <59A9A6260200007800176A6A@prv-mh.provo.novell.com>
	<59A9A6260200007800176A6A@prv-mh.provo.novell.com>
	<20170901182022.2m46ussfgiwo32c5@MacBook-Pro-de-Roger.local>
	<59AD3349020000780017704A@prv-mh.provo.novell.com>
	<20170904092331.zj2nj4nawzobjero@MacBook-Pro-de-Roger.local>
In-Reply-To: <20170904092331.zj2nj4nawzobjero@MacBook-Pro-de-Roger.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH] xen: use vMSI related
 #define-s from public interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, qemu-devel@nongnu.org

>>> On 04.09.17 at 11:23, <roger.pau@citrix.com> wrote:
> On Mon, Sep 04, 2017 at 03:04:41AM -0600, Jan Beulich wrote:
>> >>> On 01.09.17 at 20:20, <roger.pau@citrix.com> wrote:
>> > On Fri, Sep 01, 2017 at 10:25:42AM -0600, Jan Beulich wrote:
>> >> Xen and qemu having identical #define-s (with different names) is a
>> >> strong hint that these should have been part of the public interface
>> >> from the very start. Use them if they're available, falling back to
>> >> privately defined values only when using older headers.
>> >>=20
>> >> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>> >=20
>> > Reviewed-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
>>=20
>> Thanks.
>>=20
>> >> --- a/hw/xen/xen_pt_msi.c
>> >> +++ b/hw/xen/xen_pt_msi.c
>> >> @@ -18,6 +18,11 @@
>> >> =20
>> >>  #define XEN_PT_AUTO_ASSIGN -1
>> >> =20
>> >> +#ifndef XEN_DOMCTL_VMSI_X86_DEST_ID_MASK
>> >> +#if XEN_DOMCTL_INTERFACE_VERSION >=3D 0x0000000e
>> >=20
>> > XEN_DOMCTL_INTERFACE_VERSION is already 0xe (without you added
>> > defines), I guess it doesn't matter much because we only care for
>> > stable releases.
>>=20
>> Well, that's if you build qemu against master Xen. What about
>> people building against older Xen versions/headers?
>=20
> Sorry, I think I haven't explained myself clearly. What I mean is
> that if this change gets committed before the Xen side one, QEMU would
> not compile against current Xen. As said, this is only a transitory
> issue, and it's never going to be a problem in stable branches. This
> is because of the "#error" that you add.

Oh, yes, that's the case. I can't see an easy way around it, but I'm
pretty sure the qemu side of it will see some further delay anyway.

Jan
