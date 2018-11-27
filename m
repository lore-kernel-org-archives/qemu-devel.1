Received: from eggs.gnu.org ([2001:4830:134:3::10]:46989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRXpd-0002qq-ER
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gRXpX-0002mU-OH
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:30:53 -0500
References: <20181030082340.17170-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <eb8c5203-15c5-cb66-f38c-c214df0b7d84@redhat.com>
Date: Tue, 27 Nov 2018 08:30:19 +0100
MIME-Version: 1.0
In-Reply-To: <20181030082340.17170-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] fmops: fix off-by-one in AR_TABLE and
 DR_TABLE array size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: P J P <ppandit@redhat.com>, qemu-stable@nongnu.org

On 2018-10-30 09:23, Gerd Hoffmann wrote:
> Fixes: CVE-2018-???
> Cc: P J P <ppandit@redhat.com>
> Reported-by: Wangjunqing <wangjunqing@huawei.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/audio/fmopl.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/audio/fmopl.h b/hw/audio/fmopl.h
> index e7e578a48e..7199afaa3c 100644
> --- a/hw/audio/fmopl.h
> +++ b/hw/audio/fmopl.h
> @@ -72,8 +72,8 @@ typedef struct fm_opl_f {
>  	/* Rhythm sention */
>  	uint8_t rhythm;		/* Rhythm mode , key flag */
>  	/* time tables */
> -	int32_t AR_TABLE[75];	/* atttack rate tables */
> -	int32_t DR_TABLE[75];	/* decay rate tables   */
> +	int32_t AR_TABLE[76];	/* atttack rate tables */
> +	int32_t DR_TABLE[76];	/* decay rate tables   */
>  	uint32_t FN_TABLE[1024];  /* fnumber -> increment counter */
>  	/* LFO */
>  	int32_t *ams_table;
> 

CC to qemu-stable ?

 Thomas
