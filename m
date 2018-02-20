Received: from eggs.gnu.org ([2001:4830:134:3::10]:35232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eo9Tq-0000Oq-O0
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:05:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eo9Tp-0007U5-Nj
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:05:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47956 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eo9Tp-0007Tu-Gl
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:05:17 -0500
References: <1519138892-12836-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b24c0bd-c90c-3835-48b0-c38be4a75983@redhat.com>
Date: Tue, 20 Feb 2018 16:05:15 +0100
MIME-Version: 1.0
In-Reply-To: <1519138892-12836-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Document --rtc-td-hack,
 --localtime and --startdate as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Daniel P Berrange <berrange@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

On 20/02/2018 16:01, Thomas Huth wrote:
> These options have been marked in a comment in qemu-options.hx as
> deprecated in 2009 already (see commit 1ed2fc1fa35fadc0d6), but we
> never informed the users about these deprecations. Let's catch up
> on that omission now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-doc.texi | 13 +++++++++++++
>  vl.c          |  5 +++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 2f19980..7494042 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2736,6 +2736,19 @@ filesystem test suite. Also it requires the CAP_DAC_READ_SEARCH capability,
>  which is not the recommended way to run QEMU. This backend should not be
>  used and it will be removed with no replacement.
>  
> +@subsection -rtc-td-hack (since 2.12.0)
> +
> +The @code{--rtc-td-hack} option has been replaced by
> +@code{--rtc driftfix=slew}.
> +
> +@subsection -localtime (since 2.12.0)
> +
> +The @code{--localtime} option has been replaced by @code{--rtc localtime}.
> +
> +@subsection -startdate (since 2.12.0)
> +
> +The @code{--startdate} option has been replaced by @code{--rtc @var{date}}.
> +
>  @section qemu-img command line arguments
>  
>  @subsection convert -s (since 2.0.0)
> diff --git a/vl.c b/vl.c
> index 0feaca7..84121bf 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3417,6 +3417,8 @@ int main(int argc, char **argv, char **envp)
>                  break;
>              case QEMU_OPTION_localtime:
>                  rtc_utc = 0;
> +                warn_report("This option is deprecated, "
> +                            "use '--rtc localtime' instead.");
>                  break;
>              case QEMU_OPTION_vga:
>                  vga_model = optarg;
> @@ -3672,6 +3674,8 @@ int main(int argc, char **argv, char **envp)
>                  };
>  
>                  qdev_prop_register_global(&slew_lost_ticks);
> +                warn_report("This option is deprecated, "
> +                            "use '--rtc driftfix=slew' instead.");
>                  break;
>              }
>              case QEMU_OPTION_acpitable:
> @@ -3876,6 +3880,7 @@ int main(int argc, char **argv, char **envp)
>                   */
>                  break;
>              case QEMU_OPTION_startdate:
> +                warn_report("This option is deprecated, use '--rtc' instead.");
>                  configure_rtc_date_offset(optarg, 1);
>                  break;
>              case QEMU_OPTION_rtc:
> 

Queued, thanks.

paolo
