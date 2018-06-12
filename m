Received: from eggs.gnu.org ([2001:4830:134:3::10]:40354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSiCt-0001PS-3S
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:15:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fSiCp-0002Ye-Lm
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:15:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60618 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fSiCp-0002XK-5j
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:15:23 -0400
References: <20180612082823.25507-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c076cfe0-47ac-1c54-a157-f3797bab807d@redhat.com>
Date: Tue, 12 Jun 2018 07:15:19 -0500
MIME-Version: 1.0
In-Reply-To: <20180612082823.25507-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] travis: display config.log when configure
 fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/12/2018 03:28 AM, Daniel P. Berrang=C3=A9 wrote:
> When configure fails in CI systems we must be able to see the contents
> of the config.log file to diagnose the root cause.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   .travis.yml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 814be151f4..fc9a1fe8a8 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -69,7 +69,7 @@ before_install:
>     - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-gi=
t-seed.tar.xz | tar -xvJ
>     - git submodule update --init --recursive
>   before_script:
> -  - ./configure ${CONFIG}
> +  - ./configure ${CONFIG} || (cat config.log && exit 1)

If you want one less fork, you can spell this as:

- ./configure ${CONFIG} || { cat config.log && exit 1; }

Either way, the patch makes sense, so:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
