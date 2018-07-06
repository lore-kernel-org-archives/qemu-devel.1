Received: from eggs.gnu.org ([2001:4830:134:3::10]:34324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fbT5G-0005rx-Ua
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:55:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fbT5A-0002c3-IC
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:55:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fbT5A-0002bk-CR
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 11:55:40 -0400
References: <20180705181148.26871-1-clg@kaod.org>
	<20180705133044.634ede43@t450s.home>
	<b5322979-6114-6334-d1f5-ccc6abc049bb@redhat.com>
	<20180706015113.GC23001@xz-mi>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ae66133-86a6-72d8-cd66-f27592caffe9@redhat.com>
Date: Fri, 6 Jul 2018 17:55:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180706015113.GC23001@xz-mi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] pci: remove pci_del_option_rom()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

On 06/07/2018 03:51, Peter Xu wrote:
>=20
> A question about memory region auto destruction (which might not
> related to this patch): I see that we have object_property_add_child()
> in memory_region_do_init() to achieve the auto destruction but only if
> the "name" of memory region is specified.  Could we just do that
> unconditionally (though we might of course need to generate some of
> the names), or is there a reason not to do so?

I'm not sure actually if there are still regions without a name...

Paolo
