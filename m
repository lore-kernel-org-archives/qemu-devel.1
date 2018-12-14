Received: from eggs.gnu.org ([2001:4830:134:3::10]:49243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXmg1-0007GM-UA
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:34:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXmfx-0005Vb-Mk
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:34:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gXmfx-0005V6-DV
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 07:34:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so5274867wrx.9
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 04:34:41 -0800 (PST)
References: <1544790073-23049-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <05d18c75-9611-2da5-081b-fee276c98ed4@redhat.com>
Date: Fri, 14 Dec 2018 13:34:38 +0100
MIME-Version: 1.0
In-Reply-To: <1544790073-23049-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] Remove deprecated -enable-hax option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 12/14/18 1:21 PM, Thomas Huth wrote:
> Our command line interface is really quite overcrowded, we should avoid
> duplicated options that do the same thing in just a slightly different
> way. "-accel hax" is shorter and more generic that "-enable-hax", so
> there is really no real usage for the latter option. "-enable-hax" has
> been deprecated since two releases, and nobody complained so far, so
> it's time to remove this now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  qemu-deprecated.texi |  5 -----
>  qemu-options.hx      | 11 -----------
>  vl.c                 |  5 -----
>  3 files changed, 21 deletions(-)
> 
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 5cc18b4..f3a1184 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -65,11 +65,6 @@ removed together with SDL 1.2 support.
>  The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
>  replacement since it is not needed anymore.
>  
> -@subsection -enable-hax (since 3.0.0)
> -
> -The @option{-enable-hax} option has been replaced by @option{-accel hax}.
> -Both options have been introduced in QEMU version 2.9.0.
> -
>  @subsection -drive file=json:@{...@{'driver':'file'@}@} (since 3.0)
>  
>  The 'file' driver for drives is no longer appropriate for character or host
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 5330603..c4e9690 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3381,17 +3381,6 @@ Enable KVM full virtualization support. This option is only available
>  if KVM support is enabled when compiling.
>  ETEXI
>  
> -DEF("enable-hax", 0, QEMU_OPTION_enable_hax, \
> -    "-enable-hax     enable HAX virtualization support\n", QEMU_ARCH_I386)
> -STEXI
> -@item -enable-hax
> -@findex -enable-hax
> -Enable HAX (Hardware-based Acceleration eXecution) support. This option
> -is only available if HAX support is enabled when compiling. HAX is only
> -applicable to MAC and Windows platform, and thus does not conflict with
> -KVM. This option is deprecated, use @option{-accel hax} instead.
> -ETEXI
> -
>  DEF("xen-domid", HAS_ARG, QEMU_OPTION_xen_domid,
>      "-xen-domid id   specify xen guest domain id\n", QEMU_ARCH_ALL)
>  DEF("xen-create", 0, QEMU_OPTION_xen_create,
> diff --git a/vl.c b/vl.c
> index 52881be..5093764 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3579,11 +3579,6 @@ int main(int argc, char **argv, char **envp)
>                  olist = qemu_find_opts("machine");
>                  qemu_opts_parse_noisily(olist, "accel=kvm", false);
>                  break;
> -            case QEMU_OPTION_enable_hax:
> -                warn_report("Option is deprecated, use '-accel hax' instead");
> -                olist = qemu_find_opts("machine");
> -                qemu_opts_parse_noisily(olist, "accel=hax", false);
> -                break;
>              case QEMU_OPTION_M:
>              case QEMU_OPTION_machine:
>                  olist = qemu_find_opts("machine");
> 
