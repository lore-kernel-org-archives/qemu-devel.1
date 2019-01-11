Received: from eggs.gnu.org ([209.51.188.92]:38466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ghysP-0001Mk-Ua
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:37:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1ghysO-0004VY-6m
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:37:41 -0500
References: <20190111113657.66195-1-frankja@linux.ibm.com>
	<20190111113657.66195-3-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <7d151455-f7e6-2e0f-2929-c418a2aeaf89@redhat.com>
Date: Fri, 11 Jan 2019 16:37:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190111113657.66195-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x: Return specification exception
 for unimplemented diag 308 subcodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, qemu-s390x@nongnu.org, qemu-stable@nongnu.org

On 11.01.19 12:36, Janosch Frank wrote:
> The architecture specifies specification exceptions for all
> unavailable subcodes.
> 
> The presence of subcodes is indicated by checking some query subcode.
> For example 6 will indicate that 3-6 are available. So future systems
> might call new subcodes to check for new features. This should not
> trigger a hw error, instead we return the architectured specification
> exception.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Cc: qemu-stable@nongnu.org
> ---
>  target/s390x/diag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index cfd7222ddd..c28cf1d9f1 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -132,7 +132,7 @@ out:
>          }
>          return;
>      default:
> -        hw_error("Unhandled diag308 subcode %" PRIx64, subcode);
> +        s390_program_interrupt(env, PGM_SPECIFICATION, ILEN_AUTO, ra);
>          break;
>      }
>  }
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
