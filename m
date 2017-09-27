Received: from eggs.gnu.org ([2001:4830:134:3::10]:44190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxGUR-0004Ye-2g
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dxGUN-0005nA-Vk
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:51:19 -0400
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:52789)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dxGUN-0005lZ-Pq
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 13:51:15 -0400
Received: by mail-pf0-x22c.google.com with SMTP id p87so7611273pfj.9
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 10:51:15 -0700 (PDT)
References: <20170927170027.8539-1-david@redhat.com>
	<20170927170027.8539-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a64a96b3-436f-537f-a352-428d449bba01@linaro.org>
Date: Wed, 27 Sep 2017 10:51:11 -0700
MIME-Version: 1.0
In-Reply-To: <20170927170027.8539-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC 2/3] s390x/tcg: low-address protection
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>

On 09/27/2017 10:00 AM, David Hildenbrand wrote:
> +    case PSW_ASC_HOME:
> +        return !(env->cregs[13] & _ASCE_PRIVATE_SPACE);
> +    default:
> +        /* We don't support access register mode */
> +        error_report("unsupported addressing mode");
> +        exit(1);

I think g_assert_not_reached() is sufficient for cases like this.

Oh, it's just code movement.  Nevermind, perhaps.
Modulo the outcome of discussion on patch 1,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
