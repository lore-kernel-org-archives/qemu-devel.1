Received: from eggs.gnu.org ([2001:4830:134:3::10]:55929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cYDJI-0001jY-SG
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:52:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1cYDJF-0004ot-28
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:52:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:58722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1cYDJE-0004oL-QH
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 09:51:56 -0500
References: <20170130145025.26475-1-david@redhat.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <94961fbd-0dbd-faa0-f05c-59f5b5163894@suse.de>
Date: Mon, 30 Jan 2017 15:51:50 +0100
MIME-Version: 1.0
In-Reply-To: <20170130145025.26475-1-david@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: use "qemu" cpu model in user
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, rth@twiddle.net, sw@weilnetz.de, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, riku.voipio@iki.fi

On 01/30/2017 03:50 PM, David Hildenbrand wrote:
> "any" does not exist, therefore resulting in a misleading error message.
>
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I think we support more instructions in user space than in kernel space, 
but for now this change is good as it definitely unbreaks user emulation.

Reviewed-by: Alexander Graf <agraf@suse.de>


Alex

> ---
>   linux-user/main.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 3004958..e588f58 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -4322,6 +4322,8 @@ int main(int argc, char **argv, char **envp)
>   # endif
>   #elif defined TARGET_SH4
>           cpu_model = TYPE_SH7785_CPU;
> +#elif defined TARGET_S390X
> +        cpu_model = "qemu";
>   #else
>           cpu_model = "any";
>   #endif
