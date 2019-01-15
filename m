Received: from eggs.gnu.org ([209.51.188.92]:37438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjWbr-00035d-OC
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:51:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjWbq-00044k-SQ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:50:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gjWbq-00041N-J1
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 16:50:58 -0500
References: <20190115100058.44712-1-sgarzare@redhat.com>
	<20190115100058.44712-5-sgarzare@redhat.com>
	<20190115135548-mutt-send-email-mst@kernel.org>
	<3db58f6f-44fc-da64-2cfb-41404a9b2319@redhat.com>
	<20190115150238-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bb11afcb-ea7a-d553-0e9d-051cf71e6b93@redhat.com>
Date: Tue, 15 Jan 2019 22:50:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190115150238-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386/pc: use PVH option rom
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, George Kennedy <george.kennedy@oracle.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Liam Merwick <liam.merwick@oracle.com>, Maran Wilson <maran.wilson@oracle.com>

On 15/01/19 21:05, Michael S. Tsirkin wrote:
> On Tue, Jan 15, 2019 at 01:12:21PM -0600, Eric Blake wrote:
>> On 1/15/19 12:57 PM, Michael S. Tsirkin wrote:
>>> On Tue, Jan 15, 2019 at 11:00:58AM +0100, Stefano Garzarella wrote:
>>>> Use pvh.bin option rom when we are booting an uncompressed
>>>> kernel using the x86/HVM direct boot ABI.
>>>>
>>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>>> Based-on: <1545422632-24444-5-git-send-email-liam.merwick@oracle.com>
>>>
>>> I don't think this is a great way to give attribution.
>>> Can you pls include the author name and the S.O.B from there as well?
>
> Good to know.
> But I still think listing the original author (e.g. Based on patches by
> Foo Bar) or such is the nice thing to do.

It's not based on patches from another author, the work is entirely
Stefano's.  It must be applied on top of those patches.

Paolo
