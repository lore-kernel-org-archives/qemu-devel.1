Received: from eggs.gnu.org ([2001:4830:134:3::10]:41527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fait5-0005IV-Rp
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fait2-0001JI-Ju
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:36:07 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:46021)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fait2-0001JB-Ey
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:36:04 -0400
Received: by mail-qt0-x22d.google.com with SMTP id y5-v6so4665999qti.12
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 07:36:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180704120412.19020-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9f4c54dc-acf3-c6e1-7960-1f4980823241@amsat.org>
Date: Wed, 4 Jul 2018 11:35:59 -0300
MIME-Version: 1.0
In-Reply-To: <20180704120412.19020-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] pr-manager-helper: fix memory leak on event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 07/04/2018 09:04 AM, Paolo Bonzini wrote:
> Reported by Coverity.
> 

Fixes: Coverity CID 1393785 (Resource leak)

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  scsi/pr-manager-helper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
> index 519a296905..3027dde60d 100644
> --- a/scsi/pr-manager-helper.c
> +++ b/scsi/pr-manager-helper.c
> @@ -46,6 +46,7 @@ static void pr_manager_send_status_changed_event(PRManagerHelper *pr_mgr)
>      if (id) {
>          qapi_event_send_pr_manager_status_changed(id, !!pr_mgr->ioc,
>                                                    &error_abort);
> +        g_free(id);
>      }
>  }
>  
> 
