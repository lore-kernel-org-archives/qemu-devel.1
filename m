Received: from eggs.gnu.org ([2001:4830:134:3::10]:58574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxKo3-0001uq-5z
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:27:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxKo2-0001UL-6J
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:27:51 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dxKo1-0001U7-Vd
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 18:27:50 -0400
Received: by mail-wr0-x243.google.com with SMTP id n64so6722635wrb.2
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 15:27:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170927203225.30896-2-ehabkost@redhat.com>
References: <20170927203225.30896-1-ehabkost@redhat.com>
	<20170927203225.30896-2-ehabkost@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 27 Sep 2017 15:27:18 -0700
Message-ID: <CAKmqyKMVLuiqsN0THX-r1DrCEF6BYD7BOOjNFqVZc7eS+v=TWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/2] vl: Eliminate defconfig variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, Sep 27, 2017 at 1:32 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Both -nodefconfig and -no-user-config options do the same thing
> today, we only need one variable to keep track of them.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Acked-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

> ---
>  vl.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/vl.c b/vl.c
> index 4fd01fda91..b347a97a5b 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3093,7 +3093,6 @@ int main(int argc, char **argv, char **envp)
>      const char *qtest_log = NULL;
>      const char *pid_file = NULL;
>      const char *incoming = NULL;
> -    bool defconfig = true;
>      bool userconfig = true;
>      bool nographic = false;
>      DisplayType display_type = DT_DEFAULT;
> @@ -3194,8 +3193,6 @@ int main(int argc, char **argv, char **envp)
>              popt = lookup_opt(argc, argv, &optarg, &optind);
>              switch (popt->index) {
>              case QEMU_OPTION_nodefconfig:
> -                defconfig = false;
> -                break;
>              case QEMU_OPTION_nouserconfig:
>                  userconfig = false;
>                  break;
> @@ -3203,7 +3200,7 @@ int main(int argc, char **argv, char **envp)
>          }
>      }
>
> -    if (defconfig && userconfig) {
> +    if (userconfig) {
>          if (qemu_read_default_config_file() < 0) {
>              exit(1);
>          }
> --
> 2.13.5
>
>
