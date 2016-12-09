Received: from eggs.gnu.org ([2001:4830:134:3::10]:54451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dave.hansen@intel.com>) id 1cFDBC-0002Ex-S8
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 23:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dave.hansen@intel.com>) id 1cFDB9-0000EH-Qs
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 23:53:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:3553)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dave.hansen@intel.com>)
	id 1cFDB9-0000Cy-Gr
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 23:53:03 -0500
References: <1480495397-23225-1-git-send-email-liang.z.li@intel.com>
	<f67ca79c-ad34-59dd-835f-e7bc9dcaef58@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A130C01@shsmsx102.ccr.corp.intel.com>
	<0b18c636-ee67-cbb4-1ba3-81a06150db76@redhat.com>
	<0b83db29-ebad-2a70-8d61-756d33e33a48@intel.com>
	<2171e091-46ee-decd-7348-772555d3a5e3@redhat.com>
	<d3ff453c-56fa-19de-317c-1c82456f2831@intel.com>
	<20161207183817.GE28786@redhat.com>
	<b58fd9f6-d9dd-dd56-d476-dd342174dac5@intel.com>
	<20161207202824.GH28786@redhat.com>
	<F2CBF3009FA73547804AE4C663CAB28E3A14E2AD@SHSMSX104.ccr.corp.intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <060287c7-d1af-45d5-70ea-ad35d4bbeb84@intel.com>
Date: Thu, 8 Dec 2016 20:53:00 -0800
MIME-Version: 1.0
In-Reply-To: <F2CBF3009FA73547804AE4C663CAB28E3A14E2AD@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH kernel v5 0/5] Extend virtio-balloon for
 fast (de)inflating & fast live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Li, Liang Z" <liang.z.li@intel.com>, Andrea Arcangeli <aarcange@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mhocko@suse.com" <mhocko@suse.com>, "mst@redhat.com" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>

On 12/08/2016 08:45 PM, Li, Liang Z wrote:
> What's the conclusion of your discussion? It seems you want some
> statistic before deciding whether to  ripping the bitmap from the
> ABI, am I right?

I think Andrea and David feel pretty strongly that we should remove the
bitmap, unless we have some data to support keeping it.  I don't feel as
strongly about it, but I think their critique of it is pretty valid.  I
think the consensus is that the bitmap needs to go.

The only real question IMNHO is whether we should do a power-of-2 or a
length.  But, if we have 12 bits, then the argument for doing length is
pretty strong.  We don't need anywhere near 12 bits if doing power-of-2.
