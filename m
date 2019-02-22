Received: from eggs.gnu.org ([209.51.188.92]:52405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gxDrI-0005bK-Bc
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:39:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gxDrG-00077h-A7
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:39:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gxDrE-00073L-9r
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:39:30 -0500
References: <CAJSP0QVxaW3tezjBN9owJHsxzE9h8_qcaeRr5zHHKxKJOeFnkQ@mail.gmail.com>
	<CAJSP0QVXoZJ9MJ0qp4RM_m2fGJ8iFSyJMAU_X7mdiQvpOK59KA@mail.gmail.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<VI1PR0602MB324516419266A934FE7759C6A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB32454C17192EFA863E29CC49A47E0@VI1PR0602MB3245.eurprd06.prod.outlo>
	<VI1PR0602MB324547F72DA9EDEB1613C888A47E0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QUg=cq3tCSLidQ9BR2hxAo3K6gA6LKtpx5Rjb=_6XgJ6Q@mail.gmail.com>
	<28e6b4ed-9afd-3a79-6267-86c7385c23ce@redhat.com>
	<VI1PR0602MB324578F91F1AF9390D03022FA47F0@VI1PR0602MB3245.eurprd06.prod.outlook.com>
	<CAJSP0QWouR43wVi0guTuASP9gc24_CPucbBvtfE5_htkDkmsrQ@mail.gmail.com>
	<20190222163735.GB2616@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1f3243df-1037-235f-838f-4651df476ee3@redhat.com>
Date: Fri, 22 Feb 2019 17:39:21 +0100
MIME-Version: 1.0
In-Reply-To: <20190222163735.GB2616@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] Guest unresponsive after Virtqueue
 size exceeded error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Fernando_Casas_Sch=c3=b6ssow?= <casasfernando@outlook.com>, Richard Henderson <rth@twiddle.net>, qemu-devel <qemu-devel@nongnu.org>, Natanael Copa <ncopa@alpinelinux.org>

On 22/02/19 17:37, Dr. David Alan Gilbert wrote:
> Why does vring_avail_idx use virtio_ld*u*w_phys_cached?
> (similar for vring_avail_ring).
> There's no generically safe way to do unaligned atomic loads - don't we know
> in virtio that these are naturally aligned?

u is for unsigned. :)  We know that these are aligned and so they will
be atomic.

Paolo
