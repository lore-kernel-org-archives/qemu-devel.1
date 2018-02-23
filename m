Received: from eggs.gnu.org ([2001:4830:134:3::10]:56809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1epG2W-0006gs-6L
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1epG2V-00041T-7h
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 11:17:40 -0500
Date: Fri, 23 Feb 2018 16:17:23 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180223161723.GF31076@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180223154613.2096-1-alex.bennee@linaro.org>
	<20180223154613.2096-5-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180223154613.2096-5-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 4/8] new contrib/generate_all.sh: batch
 risugen script
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, richard.henderson@linaro.org, qemu-devel@nongnu.org

On Fri, Feb 23, 2018 at 03:46:09PM +0000, Alex Benn=C3=A9e wrote:
> This is a simple script for generating all instructions in a given
> RISU file. You can split up the batch size by passing a -n N command
> line options. For example:
>=20
>   ./contrib/generate_all.sh -n 2 hp.risu testcases.armv8.2_hp
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  contrib/generate_all.sh | 96 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100755 contrib/generate_all.sh
>=20
> diff --git a/contrib/generate_all.sh b/contrib/generate_all.sh
> new file mode 100755
> index 0000000..1e6b847
> --- /dev/null
> +++ b/contrib/generate_all.sh
> @@ -0,0 +1,96 @@
> +#!/bin/bash
> +#
> +# Generate all patterns in a given RISU file
> +#
> +# Copyright (c) 2017 Linaro Limited
> +# All rights reserved. This program and the accompanying materials
> +# are made available under the terms of the Eclipse Public License v1.=
0
> +# which accompanies this distribution, and is available at
> +# http://www.eclipse.org/legal/epl-v10.html

Really ? Why this license not our standard GPLv2+, or BSD if it is wanted
to be a public-domain-ish license ?

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
