Received: from eggs.gnu.org ([2001:4830:134:3::10]:35060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffSHQ-0005jZ-NJ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffSHP-0005UZ-Nv
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 11:52:48 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180713121741.19262-1-alex.bennee@linaro.org>
	<20180713121741.19262-10-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <403d4802-422d-5731-14e0-c69e67e7f45e@amsat.org>
Date: Tue, 17 Jul 2018 12:52:37 -0300
MIME-Version: 1.0
In-Reply-To: <20180713121741.19262-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 for 3.0 09/16] docker: disable
 debian-powerpc-user-cross
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org

On 07/13/2018 09:17 AM, Alex Bennée wrote:
> While we can build we can't run the unit tests due to a missing system
> call (249 - swapcontext). This could be a code generation issue as
> other architectures don't seem to have this system call.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> ---
>  tests/docker/Makefile.include | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index 09fb7db7fa..fe63aacf69 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -140,6 +140,9 @@ docker-binfmt-image-debian-powerpc-user: QEMU_TARGET = ppc-linux-user
>  docker-binfmt-image-debian-powerpc-user: EXECUTABLE = ${BUILD_DIR}/ppc-linux-user/qemu-ppc
>  docker-image-debian-powerpc-user-cross: docker-binfmt-image-debian-powerpc-user
>  DOCKER_USER_IMAGES += debian-powerpc-user
> +# Unfortunalty while we can build with this image we can't run unit
> +# tests due to missing system call: 249 which causes an abort
> +DOCKER_PARTIAL_IMAGES += debian-powerpc-user-cross
>  
>  # Expand all the pre-requistes for each docker image and test combination
>  $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES) $(DOCKER_DEPRECATED_IMAGES)), \
> 
