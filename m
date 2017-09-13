Received: from eggs.gnu.org ([2001:4830:134:3::10]:60889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsC67-0001XK-0m
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:09:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsC63-00033a-Sc
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:09:14 -0400
Received: from mail-qt0-x232.google.com ([2607:f8b0:400d:c0d::232]:45813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsC63-00033O-OZ
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:09:11 -0400
Received: by mail-qt0-x232.google.com with SMTP id t46so2481268qtj.2
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:09:11 -0700 (PDT)
References: <20170913172941.5470-1-cohuck@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c26e207a-c522-3441-75cc-02c6fa287b4e@linaro.org>
Date: Wed, 13 Sep 2017 11:09:04 -0700
MIME-Version: 1.0
In-Reply-To: <20170913172941.5470-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] accel: default to an actually available
 accelerator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, pbonzini@redhat.com, thuth@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org

On 09/13/2017 10:29 AM, Cornelia Huck wrote:
> configure_accelerator() falls back to tcg if no accelerator has
> been specified. Formerly, we could be sure that tcg is always
> available; however, with --disable-tcg, this is not longer true,
> and you are not able to start qemu without explicitly specifying
> another accelerator on those builds.
> 
> Instead, choose an accelerator in the order tcg->kvm->hax.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> RFC->v2:
> - drop xen from the list of fallbacks
> - use comma-delimited list of accelerators (much easier)
> - changed one place in qemu-options.hx that had been missed

Queued to tcg-next.  Thanks,


r~
