Received: from eggs.gnu.org ([2001:4830:134:3::10]:34738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eNUlE-0007zl-Eq
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 21:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eNUl9-0006SV-Hh
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 21:21:04 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:42377)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eNUl9-0006RF-Aq
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 21:20:59 -0500
Received: by mail-pf0-x243.google.com with SMTP id d23so8490961pfe.9
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 18:20:59 -0800 (PST)
References: <20171208160207.26494-1-david@redhat.com>
	<20171208160207.26494-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fe3b3d7e-bc65-52d0-9275-e7936ee0edb7@linaro.org>
Date: Fri, 8 Dec 2017 18:20:55 -0800
MIME-Version: 1.0
In-Reply-To: <20171208160207.26494-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.12 03/14] s390x/tcg: implement SET
 CLOCK PROGRAMMABLE FIELD
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

On 12/08/2017 08:01 AM, David Hildenbrand wrote:
> Needed for machine check handling inside Linux (when restoring registers).
> 
> Except for SIGP and machine checks, we don't make use of the register
> yet. Sufficient for now.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h      |  1 +
>  target/s390x/insn-data.def |  2 ++
>  target/s390x/misc_helper.c | 11 +++++++++++
>  target/s390x/translate.c   |  7 +++++++
>  4 files changed, 21 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
