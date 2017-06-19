Received: from eggs.gnu.org ([2001:4830:134:3::10]:45113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuQW-0002nL-74
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuQM-0004yF-US
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:01:00 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuQM-0004y7-J5
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:00:50 -0400
Received: by mail-wm0-x230.google.com with SMTP id u195so58178699wmd.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 04:00:50 -0700 (PDT)
References: <20170616161334.7492-1-f4bug@amsat.org>
	<20170616161334.7492-9-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170616161334.7492-9-f4bug@amsat.org>
Date: Mon, 19 Jun 2017 12:01:29 +0100
Message-ID: <871sqgutpy.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/11] travis: install more library
 dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> so more codebase is built
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Acked-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  .travis.yml | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 4889c192c2..4c0f7f444e 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -9,10 +9,12 @@ addons:
>    apt:
>      packages:
>        # Build dependencies
> +      - glusterfs-common
>        - libaio-dev
>        - libattr1-dev
>        - libbluetooth-dev
>        - libbrlapi-dev
> +      - libbz2-dev
>        - libcap-dev
>        - libcap-ng-dev
>        - libgnutls-dev
> @@ -22,6 +24,8 @@ addons:
>        - liblzo2-dev
>        - libnfs-dev
>        - libncurses5-dev
> +      - libncursesw5-dev
> +      - libnfs-dev
>        - libnss3-dev
>        - libpixman-1-dev
>        - libpng12-dev
> @@ -171,10 +175,12 @@ matrix:
>              - gcc-5
>              - g++-5
>              # Build dependencies
> +            - glusterfs-common
>              - libaio-dev
>              - libattr1-dev
>              - libbluetooth-dev
>              - libbrlapi-dev
> +            - libbz2-dev
>              - libcap-dev
>              - libcap-ng-dev
>              - libgnutls-dev
> @@ -184,6 +190,8 @@ matrix:
>              - liblzo2-dev
>              - libnfs-dev
>              - libncurses5-dev
> +            - libncursesw5-dev
> +            - libnfs-dev
>              - libnss3-dev
>              - libpixman-1-dev
>              - libpng12-dev


--
Alex Bennée
