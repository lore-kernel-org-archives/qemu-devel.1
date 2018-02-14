Received: from eggs.gnu.org ([2001:4830:134:3::10]:42901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1elzZ3-0007qO-Fv
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:05:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1elzYz-0005Zq-Hc
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 11:05:45 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180214152544.26925-1-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3af03376-af1b-ba46-f545-f71e80f834fd@twiddle.net>
Date: Wed, 14 Feb 2018 08:05:35 -0800
MIME-Version: 1.0
In-Reply-To: <20180214152544.26925-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tcg: add various alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>

On 02/14/2018 07:25 AM, David Hildenbrand wrote:
>  /* SET CLOCK COMPARATOR */
> -    C(0xb206, SCKC,    S,     Z,   0, m2_64, 0, 0, sckc, 0)
> +    C(0xb206, SCKC,    S,     Z,   0, a2, 0, 0, sckc, 0)

Rather than move the memory load into the op_ functions, better to add an
m2_64a (etc) functions that apply the alignment.


r~
