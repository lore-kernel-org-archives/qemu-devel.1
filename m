Received: from eggs.gnu.org ([209.51.188.92]:57869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guabn-0002rX-Q0
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:20:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1guabl-0002q5-Mg
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:20:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1guabj-0001zC-1G
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:20:37 -0500
References: <20190215094502.32149-1-dgilbert@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f0205cae-c9f0-2ee0-8130-97adc1decbc7@redhat.com>
Date: Fri, 15 Feb 2019 11:20:18 +0100
MIME-Version: 1.0
In-Reply-To: <20190215094502.32149-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] .travis.yml: Test with
 disable-replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, alex.bennee@linaro.org

On 15/02/2019 10.45, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> We've had the build break with replication disabled, so lets
> test that case in travis.
>=20
> Suggsted-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index baa06b976a..95c554897b 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -90,7 +90,7 @@ matrix:
> =20
> =20
>      - env:
> -        - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-att=
r --disable-brlapi --disable-uuid --disable-libusb --disable-user"
> +        - CONFIG=3D"--disable-linux-aio --disable-cap-ng --disable-att=
r --disable-brlapi --disable-uuid --disable-libusb --disable-user --disab=
le-replication"

Reviewed-by: Thomas Huth <thuth@redhat.com>
