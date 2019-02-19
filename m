Received: from eggs.gnu.org ([209.51.188.92]:44035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw4OU-0000XR-3M
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw4OT-0001uv-9r
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:21:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36830)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw4OT-0001uc-3W
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:21:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id j125so2516915wmj.1
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 04:21:01 -0800 (PST)
References: <1550565421-10944-1-git-send-email-thuth@redhat.com>
	<1550565421-10944-10-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9bacc579-482f-0296-7c1f-801fd10b63ef@redhat.com>
Date: Tue, 19 Feb 2019 13:20:58 +0100
MIME-Version: 1.0
In-Reply-To: <1550565421-10944-10-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 09/14] MAINTAINERS: Add maintainers to the
 Linux subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On 2/19/19 9:36 AM, Thomas Huth wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Add Michael, Cornelia and Paolo as maintainers of the Linux subsystem.
> 
> Remove the qemu-devel@nongnu.org entry because the list is always
> selected by the 'All patches CC here' section.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> [thuth: Add update-linux-headers.sh, too]

Good idea.

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 258ba5a..e6e08c2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -425,10 +425,12 @@ Hosts:
>  ------
>  
>  LINUX
> -L: qemu-devel@nongnu.org
> +M: Michael S. Tsirkin <mst@redhat.com>
> +M: Cornelia Huck <cohuck@redhat.com>
> +M: Paolo Bonzini <pbonzini@redhat.com>
>  S: Maintained
> -F: linux-*
>  F: linux-headers/
> +F: scripts/update-linux-headers.sh
>  
>  POSIX
>  M: Paolo Bonzini <pbonzini@redhat.com>
> 
