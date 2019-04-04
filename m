Received: from eggs.gnu.org ([209.51.188.92]:33710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hC2pr-0003Dd-2I
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 09:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hC2po-0006yF-Uw
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 09:55:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hC2pl-0006rP-Sj
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 09:55:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id q1so3963632wrp.0
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 06:55:13 -0700 (PDT)
References: <20190404091725.20595-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <600f1565-9e14-a8a3-4692-4454dce0164b@redhat.com>
Date: Thu, 4 Apr 2019 15:55:05 +0200
MIME-Version: 1.0
In-Reply-To: <20190404091725.20595-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] configure: fix pam test warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, berrange@redhat.com

On 4/4/19 11:17 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The pam test generates a warning on Fedora 29 with -O3 compilation
> because the headers declare that the pam_conversation pointer to
> pam_start must be non-NULL.  Change it to use the same 0 initialised
> structure as we actually use in qauthz.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  configure | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index 1c563a7027..73f7ad2be0 100755
> --- a/configure
> +++ b/configure
> @@ -2946,9 +2946,9 @@ if test "$auth_pam" != "no"; then
>  int main(void) {
>     const char *service_name = "qemu";
>     const char *user = "frank";
> -   const struct pam_conv *pam_conv = NULL;
> +   const struct pam_conv pam_conv = { 0 };
>     pam_handle_t *pamh = NULL;
> -   pam_start(service_name, user, pam_conv, &pamh);
> +   pam_start(service_name, user, &pam_conv, &pamh);
>     return 0;
>  }
>  EOF
> 
