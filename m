Received: from eggs.gnu.org ([2001:4830:134:3::10]:51437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duhut-0008Os-UB
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:32:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duhur-00025E-Bc
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:32:03 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:54260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duhur-00023z-6i
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:32:01 -0400
Received: by mail-io0-x22c.google.com with SMTP id q11so4761962ioe.10
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:31:59 -0700 (PDT)
References: <20170920153016.3858-1-david@redhat.com>
	<20170920153016.3858-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <626da179-e410-e793-8c25-661c940d37d5@linaro.org>
Date: Wed, 20 Sep 2017 11:31:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170920153016.3858-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] s390x/tcg: add basic MSA features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 09/20/2017 10:30 AM, David Hildenbrand wrote:
> The STFLE bits for the MSA (extension) facilities simply indicate that
> the respective instructions can be executed. The QUERY subfunction can then
> be used to identify which features exactly are available.
> 
> Availability of subfunctions can also vary on real hardware. For now, we
> simply implement a CPU model without any available subfunctions except
> QUERY (which is always around).
> 
> As all MSA functions behave quite similarly, we can use one translation
> handler for now. Prepare the code for implementation of actual subfunctions.
> 
> At least MSA is helpful for now, as older Linux kernels require this
> facility when compiled for a z9 model. Allow to enable the facilities
> for the qemu cpu model.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/Makefile.objs   |  2 +-
>  target/s390x/cpu_models.c    |  4 +++
>  target/s390x/crypto_helper.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/helper.h        |  1 +
>  target/s390x/insn-data.def   | 13 +++++++++
>  target/s390x/translate.c     | 56 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 140 insertions(+), 1 deletion(-)
>  create mode 100644 target/s390x/crypto_helper.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
