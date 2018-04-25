Received: from eggs.gnu.org ([2001:4830:134:3::10]:51530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBBex-0001fw-Qd
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBBet-0008Rl-N5
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:03:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBBet-0008RN-JV
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 00:03:55 -0400
References: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524592709-6553-15-git-send-email-ian.jackson@eu.citrix.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <325c0444-c372-5436-a756-0f6ad97bdf7f@redhat.com>
Date: Wed, 25 Apr 2018 06:03:41 +0200
MIME-Version: 1.0
In-Reply-To: <1524592709-6553-15-git-send-email-ian.jackson@eu.citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 14/16] os-posix: cleanup: Replace fprintf
 with error_report in remaining call sites
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

On 24.04.2018 19:58, Ian Jackson wrote:
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Daniel P. Berrange <berrange@redhat.com>
> CC: Michael Tokarev <mjt@tls.msk.ru>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v8: Remove one remaining spurious "\n"
> v7: New patch
> ---
>  os-posix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/os-posix.c b/os-posix.c
> index 0f59566..a2ba50d 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -129,7 +129,7 @@ void os_set_proc_name(const char *s)
>          exit(1);
>      }
>  #else
> -    fprintf(stderr, "Change of process name not supported by your OS\n=
");
> +    error_report("Change of process name not supported by your OS");
>      exit(1);
>  #endif
>  }
> @@ -243,7 +243,7 @@ static void change_root(void)
>  {
>      if (chroot_dir) {
>          if (chroot(chroot_dir) < 0) {
> -            fprintf(stderr, "chroot failed\n");
> +            error_report("chroot failed");
>              exit(1);
>          }
>          if (chdir("/")) {
>=20

Maybe merge this with patch 9/16?

Anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>
