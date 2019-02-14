Received: from eggs.gnu.org ([209.51.188.92]:60806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDWT-0003Cn-6K
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDWR-0005Mw-K9
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:41:37 -0500
References: <1549545296-18903-1-git-send-email-thuth@redhat.com>
	<1549545296-18903-3-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <df1068a1-8b57-84bc-0e7a-b3bc06ea4be4@vivier.eu>
Date: Thu, 14 Feb 2019 10:41:10 +0100
MIME-Version: 1.0
In-Reply-To: <1549545296-18903-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 2/2] qemu-options: Remove
 deprecated option -clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

On 07/02/2019 14:14, Thomas Huth wrote:
> The option is only a dummy since a long time. We've finally deprecated
> it in QEMU v3.0, so it's time to remove it now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-deprecated.texi | 5 -----
>  qemu-options.hx      | 3 ---
>  vl.c                 | 6 ------
>  3 files changed, 14 deletions(-)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 90e5860..fe90555 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -37,11 +37,6 @@ would automatically enable USB support on the machine type.
>  If using the new syntax, USB support must be explicitly
>  enabled via the ``-machine usb=on'' argument.
>  
> -@subsection -clock (since 3.0.0)
> -
> -The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
> -replacement since it is not needed anymore.
> -
>  @subsection -drive file=json:@{...@{'driver':'file'@}@} (since 3.0)
>  
>  The 'file' driver for drives is no longer appropriate for character or host
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 06ef1a7..77bd98e 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3444,9 +3444,6 @@ Load the contents of @var{file} as an option ROM.
>  This option is useful to load things like EtherBoot.
>  ETEXI
>  
> -HXCOMM Silently ignored for compatibility
> -DEF("clock", HAS_ARG, QEMU_OPTION_clock, "", QEMU_ARCH_ALL)
> -
>  DEF("rtc", HAS_ARG, QEMU_OPTION_rtc, \
>      "-rtc [base=utc|localtime|<datetime>][,clock=host|rt|vm][,driftfix=none|slew]\n" \
>      "                set the RTC base and clock, enable drift fix for clock ticks (x86 only)\n",
> diff --git a/vl.c b/vl.c
> index 9e4dba7..90ff233 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3735,12 +3735,6 @@ int main(int argc, char **argv, char **envp)
>              case QEMU_OPTION_old_param:
>                  old_param = 1;
>                  break;
> -            case QEMU_OPTION_clock:
> -                /* Clock options no longer exist.  Keep this option for
> -                 * backward compatibility.
> -                 */
> -                warn_report("This option is ignored and will be removed soon");
> -                break;
>              case QEMU_OPTION_rtc:
>                  opts = qemu_opts_parse_noisily(qemu_find_opts("rtc"), optarg,
>                                                 false);
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
