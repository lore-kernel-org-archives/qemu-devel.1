Received: from eggs.gnu.org ([2001:4830:134:3::10]:36704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dI8dB-0005Ib-Gq
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dI8d8-00014J-By
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 03:10:21 -0400
References: <20170531120049.14111-1-n54@gmx.com>
	<26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
	<df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
	<877f0p38tr.fsf@dusky.pond.sub.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
Date: Tue, 6 Jun 2017 10:10:06 +0300
MIME-Version: 1.0
In-Reply-To: <877f0p38tr.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] ivshmem-server: ivshmem-client: Build
 when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Kamil Rytarowski <n54@gmx.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, marcandre.lureau@gmail.com, peter.maydell@redhat.com, f4bug@amsat.org

06.06.2017 09:54, Markus Armbruster wrote:

[ ./configure --disable-linux-user --disable-system --static ]

> I haven't, but here's a quick guess on what we need to squash into the
> patch:
> 
> diff --git a/Makefile b/Makefile
> index c830d7a..2ef5a78 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -469,10 +469,12 @@ ifneq ($(EXESUF),)
>  qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
>  endif
>  
> +ifdef CONFIG_IVSHMEM
>  ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>  	$(call LINK, $^)
> +endif

This effectively disables building ivshmem executables on this config
on linux, while previously they were building fine. Hmm..

/mjt
