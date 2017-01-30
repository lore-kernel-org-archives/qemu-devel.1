Received: from eggs.gnu.org ([2001:4830:134:3::10]:33894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cYDag-0006UA-Iq
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cYDad-00048p-C2
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:09:58 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:55724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cYDad-00047j-5M
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:09:55 -0500
References: <20170130145025.26475-1-david@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <89891b01-8d50-98ac-c26c-2a769b22b400@weilnetz.de>
Date: Mon, 30 Jan 2017 16:09:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170130145025.26475-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: use "qemu" cpu model in user
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, rth@twiddle.net, agraf@suse.de, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, riku.voipio@iki.fi, pkg-qemu-devel@lists.alioth.debian.org

Am 30.01.2017 um 15:50 schrieb David Hildenbrand:
> "any" does not exist, therefore resulting in a misleading error message.
>
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  linux-user/main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 3004958..e588f58 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -4322,6 +4322,8 @@ int main(int argc, char **argv, char **envp)
>  # endif
>  #elif defined TARGET_SH4
>          cpu_model = TYPE_SH7785_CPU;
> +#elif defined TARGET_S390X
> +        cpu_model = "qemu";
>  #else
>          cpu_model = "any";
>  #endif


Thanks.

Reviewed-by: Stefan Weil <sw@weilnetz.de>

This fix is also needed for Debian's QEMU user emulation.
