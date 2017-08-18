Received: from eggs.gnu.org ([2001:4830:134:3::10]:34384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diYGO-0002aY-BU
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diYGL-0002y5-A2
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:48:00 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:35942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diYGL-0002xZ-2S
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 23:47:57 -0400
Received: by mail-pg0-x229.google.com with SMTP id i12so55701822pgr.3
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 20:47:56 -0700 (PDT)
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <41ce560e-a368-be15-ac80-388ba9b66a9d@linaro.org>
Date: Thu, 17 Aug 2017 20:47:53 -0700
MIME-Version: 1.0
In-Reply-To: <20170817092225.4264-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 01/10] target/s390x: move
 cc_name() to cc_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Aurelien Jarno <aurelien@aurel32.net>, rth@twiddle.net

On 08/17/2017 02:22 AM, David Hildenbrand wrote:
> +const char *cc_name(int cc_op)

While we're changing things up a tich, enum cc_op?

> +{
> +    static const char *cc_names[] = {

static const char * const cc_names[]

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
