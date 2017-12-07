Received: from eggs.gnu.org ([2001:4830:134:3::10]:60382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN60w-0006Ms-M3
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eN60t-000612-Kd
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 18:55:38 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171207165355.7559-1-david@redhat.com>
	<20171207165355.7559-10-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c014dbb0-ac18-bcf3-7a8f-a47b72e584df@twiddle.net>
Date: Thu, 7 Dec 2017 15:55:32 -0800
MIME-Version: 1.0
In-Reply-To: <20171207165355.7559-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-2.12 09/10] s390x/tcg: we already
 implement the Set-Program-Parameter facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 12/07/2017 08:53 AM, David Hildenbrand wrote:
> The Set-Program-Parameter facility (also known as Load-Program-Parameter
> facility) provides the LPP instruction used to load the program
> parameter. We already implement that instruction in TCG, so add it to our
> list.
> 
> Note: Not documented in the PoP but in "The Load-Program-Parameter and
> CPU-Measurement Facilities) - SA23-2260-05 document.
> 
> While at it, make the whole list ordered (according to cpu_features_def.h).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu_models.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
