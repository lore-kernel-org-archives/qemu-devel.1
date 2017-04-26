Received: from eggs.gnu.org ([2001:4830:134:3::10]:48659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d3NFG-0008IE-Pd
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d3NFG-0001N7-2N
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:44:38 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1493107736-6608-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f523e9f6-4e05-38a2-413a-9891033c9466@redhat.com>
Date: Wed, 26 Apr 2017 15:44:30 +0200
MIME-Version: 1.0
In-Reply-To: <1493107736-6608-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Issue a deprecation warning if the user
 specifies the "-hdachs" option.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org



On 25/04/2017 10:08, Thomas Huth wrote:
> If the user needs to specify the disk geometry, the corresponding
> parameters of the "-drive" option should be used instead. "-hdachs"
> is considered as deprecated and might be removed soon.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  vl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/vl.c b/vl.c
> index 0b4ed52..0980213 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3230,6 +3230,8 @@ int main(int argc, char **argv, char **envp)
>                          }
>                      }
>                  }
> +                error_report("'-hdachs' is deprecated. Please use '-drive"
> +                             " ...,cyls=c,heads=h,secs=s,trans=t' instead.");
>                  break;
>              case QEMU_OPTION_numa:
>                  opts = qemu_opts_parse_noisily(qemu_find_opts("numa"),
> 

Not even this, which should also be deprecated; please suggest using
"-device ide-hd" instead.

Paolo
