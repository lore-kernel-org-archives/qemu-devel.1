Received: from eggs.gnu.org ([209.51.188.92]:37504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gloFj-0008JO-OX
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:05:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gloFh-0000Xt-M8
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:05:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gloFg-0000VQ-S2
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 00:05:32 -0500
Date: Tue, 22 Jan 2019 00:05:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190122000452-mutt-send-email-mst@kernel.org>
References: <20190121181030.2112-1-philmd@redhat.com>
	<76c2912b-8c50-d15f-f153-e80fa4b1be6e@redhat.com>
	<5f27ba6f-f2e3-423f-54ee-0f6d6a0e1b48@redhat.com>
	<c52c29be-f285-2e5c-24ce-352c284e2b58@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c52c29be-f285-2e5c-24ce-352c284e2b58@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] virtio-net: Fix VirtIONet typedef
 redefinition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Wei Xu <wexu@redhat.com>

On Tue, Jan 22, 2019 at 05:28:12AM +0100, Thomas Huth wrote:
> On 2019-01-21 20:46, Philippe Mathieu-Daud=E9 wrote:
> > On 1/21/19 8:22 PM, Eric Blake wrote:
> >> On 1/21/19 12:10 PM, Philippe Mathieu-Daud=E9 wrote:
> >>> Commit 2974e916df8 introduced the VirtioNetRscChain structure which
> >>> refer to a VirtIONet, declared later, thus required VirtIONet typed=
ef
> >>> to be declarated forward.
> >>
> >> s/be declarated forward/use a forward declaration/
> >=20
> > Thanks Eric.
> >=20
> > Thomas, do you mind fixing this if you take this patch?
>=20
> No problem, just fixed it while picking up the patch.
>=20
>  Thanks,
>   Thomas
>=20


I'm not sure why it's going through that tree but sure go ahead.
Sent Reviewed-by tag.
