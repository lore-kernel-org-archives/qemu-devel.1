Received: from eggs.gnu.org ([2001:4830:134:3::10]:35807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRChk-00038l-EO
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 02:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRChh-0003w9-7v
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 02:52:48 -0500
References: <458bba0e0865443a3d4e0f8e0dbb5bc712e098b9.1513636434.git.crobinso@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <11cf90c7-2d45-50f5-00dd-8173a4c9ae32@redhat.com>
Date: Tue, 19 Dec 2017 08:52:34 +0100
MIME-Version: 1.0
In-Reply-To: <458bba0e0865443a3d4e0f8e0dbb5bc712e098b9.1513636434.git.crobinso@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts/make-release: More .git removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>

On 18.12.2017 23:33, Cole Robinson wrote:
> As was last done in 379e21c25, we want to remove .git files for
> submodules here, which we aren't presently doing for capstone and
> keycodemapdb.
>=20
> Rather than a whitelist use 'find' to future proof this
>=20
> Signed-off-by: Cole Robinson <crobinso@redhat.com>
> ---
>  scripts/make-release | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/make-release b/scripts/make-release
> index 3917df7142..7c7bec577f 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -19,7 +19,7 @@ pushd ${destination}
>  git checkout "v${version}"
>  git submodule update --init
>  (cd roms/seabios && git describe --tags --long --dirty > .version)
> -rm -rf .git roms/*/.git dtc/.git pixman/.git
> +find . -depth -name .git -exec rm -rf '{}' \;

Good idea! That also fixes the dead pixman/.git entry :-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
