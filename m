Received: from eggs.gnu.org ([2001:4830:134:3::10]:36186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1duurq-00013o-Ac
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:21:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <JBeulich@suse.com>) id 1duurm-0008Uw-CE
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:21:46 -0400
Received: from prv-mh.provo.novell.com ([137.65.248.74]:48996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <JBeulich@suse.com>) id 1duurm-0008UF-3D
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 02:21:42 -0400
Message-Id: <59C37692020000780017DCCA@prv-mh.provo.novell.com>
Date: Thu, 21 Sep 2017 00:21:38 -0600
From: "Jan Beulich" <JBeulich@suse.com>
References: <59A9A6260200007800176A6A@prv-mh.provo.novell.com>
	<59A9A6260200007800176A6A@prv-mh.provo.novell.com>
	<alpine.DEB.2.10.1709201759580.2968@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1709201759580.2968@sstabellini-ThinkPad-X260>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [Qemu-devel] [PATCH] xen: use vMSI related #define-s from
 public interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel <xen-devel@lists.xenproject.org>, qemu-devel@nongnu.org

>>> On 21.09.17 at 03:12, <sstabellini@kernel.org> wrote:
> On Fri, 1 Sep 2017, Jan Beulich wrote:
>> --- a/hw/xen/xen_pt_msi.c
>> +++ b/hw/xen/xen_pt_msi.c
>> @@ -18,6 +18,11 @@
>> =20
>>  #define XEN_PT_AUTO_ASSIGN -1
>> =20
>> +#ifndef XEN_DOMCTL_VMSI_X86_DEST_ID_MASK
>> +#if XEN_DOMCTL_INTERFACE_VERSION >=3D 0x0000000e
>> +#error vMSI defines missing from domctl.h
>> +#endif
>=20
> All the version compatibility stuff goes to
> include/hw/xen/xen_common.h. Please move it there.

I know there's a central place, but moving there stuff that's
needed only in this file seemed rather counterproductive to
me - why would you want all files including that shared one
have to see these definitions? If there was a remote chance
that some other file may need to make use of it, I might
agree, but I don't see any such chance at all.

> We usually assume that the Xen version we are building against is
> "sane", so we don't do #error's typically.

Hmm, I can drop the #error, but to be honest I'm hesitant to do
so - I've put it there intentionally.

Jan
