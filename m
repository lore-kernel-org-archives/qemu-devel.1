Received: from eggs.gnu.org ([2001:4830:134:3::10]:39242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFdI8-0001vU-Ll
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:50:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFdI3-0008Kp-OL
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:50:32 -0500
References: <1510658424-16527-1-git-send-email-thuth@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b8ccca3c-bc60-4db2-81e2-ba3a516d6b2a@redhat.com>
Date: Fri, 17 Nov 2017 17:50:21 +0800
MIME-Version: 1.0
In-Reply-To: <1510658424-16527-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11] hw/net/vmxnet3: Fix code to
 work on big endian hosts, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry@daynix.com>, David Gibson <dgibson@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, f4bug@amsat.org



On 2017=E5=B9=B411=E6=9C=8814=E6=97=A5 19:20, Thomas Huth wrote:
> Since commit ab06ec43577177a442e8 we test the vmxnet3 device in the
> pxe-tester, too (when running "make check SPEED=3Dslow"). This now
> revealed that the code is not working there if the host is a big
> endian machine (for example ppc64 or s390x) - "make check SPEED=3Dslow"
> is now failing on such hosts.
>
> The vmxnet3 code lacks endianess conversions in a couple of places.
> Interestingly, the bitfields in the structs in vmxnet3.h already tried =
to
> take care of the*bit*  endianess of the C compilers - but the code miss=
ed
> to change the*byte*  endianess when reading or writing the correspondin=
g
> structs. So the bitfields are now wrapped into unions which allow to ch=
ange
> the byte endianess during runtime with the non-bitfield member of the u=
nion.
> With these changes, "make check SPEED=3Dslow" now properly works on big=
 endian
> hosts, too.
>
> Reported-by: David Gibson<dgibson@redhat.com>
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   v2:
>   - Introduced vmxnet3_ring_read_curr_txdesc() & vmxnet3_pci_dma_write_=
rxcd()
>     helper functions to wrap the byte-swapping code that is required in
>     multiple places (as suggested by Philippe)

Applied with typo fixed.

Thanks
