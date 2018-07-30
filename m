Received: from eggs.gnu.org ([2001:4830:134:3::10]:36351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fk3PC-00073a-Is
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:19:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fk3P7-0007GE-St
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:19:50 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34321)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fk3P7-0007Fv-KU
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 04:19:45 -0400
Received: by mail-wm0-x244.google.com with SMTP id l2-v6so7689306wme.1
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 01:19:45 -0700 (PDT)
References: <20180727083445.21436-1-famz@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180727083445.21436-1-famz@redhat.com>
Date: Mon, 30 Jul 2018 09:19:42 +0100
Message-ID: <87600x9lup.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/vm: Add vm-build-all/vm-clean-all in
 help text
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Fam Zheng <famz@redhat.com> writes:

> Suggested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/vm/Makefile.include | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index 5daa2a3b73..9e19f8662f 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -14,6 +14,9 @@ vm-test:
>  	@echo "  vm-build-freebsd                - Build QEMU in FreeBSD VM"
>  	@echo "  vm-build-netbsd                 - Build QEMU in NetBSD VM"
>  	@echo "  vm-build-openbsd                - Build QEMU in OpenBSD VM"
> +	@echo ""
> +	@echo "  vm-build-all                    - Build QEMU in all VMs"
> +	@echo "  vm-clean-all                    - Clean up VM images"
>
>  vm-build-all: $(addprefix vm-build-, $(IMAGES))

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
