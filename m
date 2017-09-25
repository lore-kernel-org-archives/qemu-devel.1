Received: from eggs.gnu.org ([2001:4830:134:3::10]:47432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwQc3-00088g-Bs
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dwQc0-0005eT-IV
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:27:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dwQc0-0005cf-CV
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 06:27:40 -0400
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-11-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <05125361-7f19-20c5-0a83-c4b2ff1f12fe@redhat.com>
Date: Mon, 25 Sep 2017 12:27:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-11-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 10/27] s390x/kvm: pass ipb directly into
 handle_sigp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 18.09.2017 17:59, David Hildenbrand wrote:
> No need to pass kvm_run.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/kvm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 14f864697d..da3f7e9895 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1852,7 +1852,7 @@ static int sigp_set_architecture(S390CPU *cpu, uint32_t param,
>      return SIGP_CC_STATUS_STORED;
>  }
>  
> -static int handle_sigp(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
> +static int handle_sigp(S390CPU *cpu, uint32_t ipb, uint8_t ipa1)

Maybe order the parameters alphabetically now? I.e. first ipa, then ipb?

Anyway, feel free to add my:

Reviewed-by: Thomas Huth <thuth@redhat.com>
