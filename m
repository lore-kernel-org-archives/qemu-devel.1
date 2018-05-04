Received: from eggs.gnu.org ([2001:4830:134:3::10]:35076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fEigE-0001xT-M0
	for qemu-devel@nongnu.org; Fri, 04 May 2018 17:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fEigB-0002ce-JW
	for qemu-devel@nongnu.org; Fri, 04 May 2018 17:55:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42354 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fEigB-0002c4-Dm
	for qemu-devel@nongnu.org; Fri, 04 May 2018 17:55:51 -0400
References: <1525446790-16139-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1804abef-e853-4e95-1dc5-ed404fb47c71@redhat.com>
Date: Fri, 4 May 2018 23:55:41 +0200
MIME-Version: 1.0
In-Reply-To: <1525446790-16139-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] qemu-options: Mark -virtioconsole as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org
Cc: mst@redhat.com, berrange@redhat.com, Markus Armbruster <armbru@redhat.com>

On 04/05/2018 17:13, Thomas Huth wrote:
> The qemu-doc already states that this option is only maintained for
> backward compatibility and "-device virtconsole" should be used
> instead. So let's take the next step and mark this option officially
> as deprecated.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Addressed Markus' review feedback from v1
> 
>  qemu-doc.texi   | 5 +++++
>  qemu-options.hx | 5 +----
>  vl.c            | 2 ++
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 0ed0f19..4add403 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2931,6 +2931,11 @@ The @code{-localtime} option has been replaced by @code{-rtc base=localtime}.
>  
>  The @code{-startdate} option has been replaced by @code{-rtc base=@var{date}}.
>  
> +@subsection -virtioconsole (since 2.13.0)
> +
> +Option @option{-virtioconsole} has been replaced by
> +@option{-device virtconsole}.
> +
>  @section qemu-img command line arguments
>  
>  @subsection convert -s (since 2.0.0)
> diff --git a/qemu-options.hx b/qemu-options.hx
> index c611766..091ded6 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3675,10 +3675,7 @@ STEXI
>  @item -virtioconsole @var{c}
>  @findex -virtioconsole
>  Set virtio console.
> -
> -This option is maintained for backward compatibility.
> -
> -Please use @code{-device virtconsole} for the new way of invocation.
> +This option is deprecated, please use @option{-device virtconsole} instead.
>  ETEXI
>  
>  DEF("show-cursor", 0, QEMU_OPTION_show_cursor, \
> diff --git a/vl.c b/vl.c
> index 806eec2..519e54f 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3598,6 +3598,8 @@ int main(int argc, char **argv, char **envp)
>                  }
>                  break;
>              case QEMU_OPTION_virtiocon:
> +                warn_report("This option is deprecated, "
> +                            "use '-device virtconsole' instead");
>                  add_device_config(DEV_VIRTCON, optarg);
>                  default_virtcon = 0;
>                  if (strncmp(optarg, "mon:", 4) == 0) {
> 

Queued, thanks.

Paolo
