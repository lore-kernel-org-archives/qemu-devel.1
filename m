Received: from eggs.gnu.org ([2001:4830:134:3::10]:44915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cjZAv-0007H4-BC
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cjZAu-0004SU-Co
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:26:17 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36627)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cjZAu-0004Qh-0q
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 17:26:16 -0500
Received: by mail-lf0-x242.google.com with SMTP id g70so5749852lfh.3
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 14:26:14 -0800 (PST)
MIME-Version: 1.0
References: <20170302194437.21823-1-brogers@suse.com>
In-Reply-To: <20170302194437.21823-1-brogers@suse.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 02 Mar 2017 22:26:01 +0000
Message-ID: <CAJ+F1CKJf+bsFvyXrr=iqq+GP9=WY9cPajjfpK0pjtvqrYrDaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: check path to avoid a failing
 qga/get-vcpus test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bruce Rogers <brogers@suse.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

On Thu, Mar 2, 2017 at 11:46 PM Bruce Rogers <brogers@suse.com> wrote:

> The qga/get-vcpus test fails in a simple chroot environment, as
> used in an openSUSE Build Service local build, so first check
> that the sysfs based path exists in order to avoid calling this
> test in an environment where it won't work right.
>
> Signed-off-by: Bruce Rogers <brogers@suse.com>
>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  tests/test-qga.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tests/test-qga.c b/tests/test-qga.c
> index 868b02a40f..9e6d19a6e1 100644
> --- a/tests/test-qga.c
> +++ b/tests/test-qga.c
> @@ -924,7 +924,9 @@ int main(int argc, char **argv)
>      g_test_add_data_func("/qga/info", &fix, test_qga_info);
>      g_test_add_data_func("/qga/network-get-interfaces", &fix,
>                           test_qga_network_get_interfaces);
> -    g_test_add_data_func("/qga/get-vcpus", &fix, test_qga_get_vcpus);
> +    if (!access("/sys/devices/system/cpu/cpu0", F_OK)) {
> +        g_test_add_data_func("/qga/get-vcpus", &fix, test_qga_get_vcpus)=
;
> +    }
>      g_test_add_data_func("/qga/get-fsinfo", &fix, test_qga_get_fsinfo);
>      g_test_add_data_func("/qga/get-memory-block-info", &fix,
>                           test_qga_get_memory_block_info);
> --
> 2.11.1
>
>
> --
Marc-Andr=C3=A9 Lureau
