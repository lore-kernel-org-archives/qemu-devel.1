Received: from eggs.gnu.org ([2001:4830:134:3::10]:55999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fL91Z-0000dN-51
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:16:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fL91T-00089t-9M
	for qemu-devel@nongnu.org; Tue, 22 May 2018 11:16:29 -0400
References: <1526990298-17924-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3213c6f-2705-fb10-2509-9669fbe1e25e@redhat.com>
Date: Tue, 22 May 2018 17:16:17 +0200
MIME-Version: 1.0
In-Reply-To: <1526990298-17924-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-options: Mark the non-functional
 -clock option as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 22/05/2018 13:58, Thomas Huth wrote:
> The function is only ignored since QEMU version 1.7.0. Let's mark
> it as deprecated, so that we can finally completely remove it soon.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-doc.texi | 5 +++++
>  vl.c          | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 0e0e0ae..057a48e 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -2922,6 +2922,11 @@ The @code{-startdate} option has been replaced by @code{-rtc base=@var{date}}.
>  Option @option{-virtioconsole} has been replaced by
>  @option{-device virtconsole}.
>  
> +@subsection -clock (since 3.0.0)
> +
> +The @code{-clock} option is ignored since QEMU version 1.7.0. There is no
> +replacement since it is not needed anymore.
> +
>  @section qemu-img command line arguments
>  
>  @subsection convert -s (since 2.0.0)
> diff --git a/vl.c b/vl.c
> index d5836c6..f7c0a46 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3829,6 +3829,7 @@ int main(int argc, char **argv, char **envp)
>                  /* Clock options no longer exist.  Keep this option for
>                   * backward compatibility.
>                   */
> +                warn_report("This option is ignored and will be removed soon");
>                  break;
>              case QEMU_OPTION_startdate:
>                  warn_report("This option is deprecated, use '-rtc base=' instead.");
> 

Queued, thanks.

Paolo
