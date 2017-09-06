Received: from eggs.gnu.org ([2001:4830:134:3::10]:50777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpawd-0006kL-BW
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpawX-0001m6-PR
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:04:43 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:36372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpawX-0001la-Hr
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:04:37 -0400
Received: by mail-pf0-x22e.google.com with SMTP id e199so12942300pfh.3
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 07:04:37 -0700 (PDT)
References: <20170906094927.22376-1-cohuck@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ce37d2c8-a37d-fd71-047f-a5f8b35d1c76@linaro.org>
Date: Wed, 6 Sep 2017 07:04:33 -0700
MIME-Version: 1.0
In-Reply-To: <20170906094927.22376-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] accel: default to an actually
 available accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, kwolf@redhat.com, thuth@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

On 09/06/2017 02:49 AM, Cornelia Huck wrote:
> +    /* configure makes sure we have at least one accelerator */
> +    g_assert(false);
> +    return "";

g_assert_not_reached();

Though I do like the follow-up idea of "t:k:x:h".


r~
