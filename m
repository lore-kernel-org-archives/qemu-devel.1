Received: from eggs.gnu.org ([2001:4830:134:3::10]:46069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fVirX-0007vV-AG
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 15:33:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fVirS-00065E-7D
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 15:33:51 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180620100825.22476-1-david@redhat.com>
	<20180620100825.22476-4-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9b002cf5-a752-9b4d-1ef5-3bb0fbd62b7d@twiddle.net>
Date: Wed, 20 Jun 2018 09:33:40 -1000
MIME-Version: 1.0
In-Reply-To: <20180620100825.22476-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/7] s390x/tcg: properly implement the
 TOD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

On 06/20/2018 12:08 AM, David Hildenbrand wrote:
> +/* Converts ns to s390's clock format */
> +static inline uint64_t time2tod(uint64_t ns)
> +{
> +    return (ns << 9) / 125;
> +}
> +
> +/* Converts s390's clock format to ns */
> +static inline uint64_t tod2time(uint64_t t)
> +{
> +    return (t * 125) >> 9;
> +}

How many significant bits on input here?
Do you in fact want to be using muldiv64?


r~
