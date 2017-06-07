Received: from eggs.gnu.org ([2001:4830:134:3::10]:45009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIaad-0000gS-B5
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dIaaX-0000sz-Vc
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dIaaX-0000sB-PR
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 09:01:29 -0400
References: <1496404254-17429-1-git-send-email-peterx@redhat.com>
	<1496404254-17429-3-git-send-email-peterx@redhat.com>
	<20170602194523-mutt-send-email-mst@kernel.org>
	<20170605030725.GF4056@pxdev.xzpeter.org>
	<f68502e6-875c-0e46-f7cf-127c23513d20@redhat.com>
	<20170606234705.GG13397@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <176bbaed-3eb1-1ca5-95fc-dbf2a1168f1b@redhat.com>
Date: Wed, 7 Jun 2017 15:01:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170606234705.GG13397@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] exec: simplify
 address_space_get_iotlb_entry
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Maxime Coquelin <maxime.coquelin@redhat.com>, Jason Wang <jasowang@redhat.com>



On 07/06/2017 01:47, David Gibson wrote:
>> I would ask David.  There are PowerPC MMUs that allow fast lookup of
>> arbitrarily-sized windows (not necessarily power of two),
>
> Uh.. I'm not sure what you mean here.  You might be thinking of the
> BATs which really old (32-bit) PowerPC MMUs had - those allow
> arbitrary large block translations, but they do have to be a power of
> two.

Oh, that is what I was thinking about.  Thanks for figuring out! :)

Paolo
