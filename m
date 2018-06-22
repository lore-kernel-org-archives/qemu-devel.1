Received: from eggs.gnu.org ([2001:4830:134:3::10]:57680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWI46-000686-0F
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:09:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fWI40-0002pk-Cl
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:09:09 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fWI40-0002pG-6K
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 05:09:04 -0400
Received: by mail-wm0-x241.google.com with SMTP id l15-v6so5717113wmc.1
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 02:09:04 -0700 (PDT)
References: <20180622021546.18178-1-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180622021546.18178-1-f4bug@amsat.org>
Date: Fri, 22 Jun 2018 10:09:01 +0100
Message-ID: <87d0wjur0y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] travis: Do not waste time cloning
 unused submodules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Builds only require:
> - dtc
> - keycodemapdb
> - capstone
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> Some tests might require ROMs. Can they clone submodules only when requir=
ed?
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index fabfe9ec34..415d703c91 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -67,7 +67,7 @@ before_install:
>    - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew update ; fi
>    - if [ "$TRAVIS_OS_NAME" =3D=3D "osx" ]; then brew install libffi gett=
ext glib pixman ; fi
>    - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-s=
eed.tar.xz | tar -xvJ
> -  - git submodule update --init --recursive
> +  - git submodule update --init --recursive capstone dtc
> ui/keycodemapdb

Does that mean we could drop the wget hack? That's there mainly because
cloning all the submodules takes some time.

>  before_script:
>    - ./configure ${CONFIG} || { cat config.log && exit 1; }
>  script:


--
Alex Benn=C3=A9e
