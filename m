Received: from eggs.gnu.org ([2001:4830:134:3::10]:50667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNzoF-0005RV-R3
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dNzoB-0005sD-TH
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:57:59 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:33260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dNzoB-0005s3-Ng
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:57:55 -0400
Received: by mail-wr0-f169.google.com with SMTP id r103so18268253wrb.0
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 03:57:55 -0700 (PDT)
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-14-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8262c070-06a3-0f9f-23bc-4c497a597a0a@redhat.com>
Date: Thu, 22 Jun 2017 12:57:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170622033231.19344-14-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/21] travis: improve ccache use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 22/06/2017 05:32, Philippe Mathieu-Daudé wrote:
> diff --git a/.travis.yml b/.travis.yml
> index a7512f3ab0..96ddc16cfd 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -68,6 +68,8 @@ env:
>        # be kind with Travis free plan, restrict to at most 4 cores
>      - PARALLEL_JOBS="$(($(test ${HW_CORES} -gt ${VM_CORES} && echo ${VM_CORES} || echo ${HW_CORES}) + 1))"
>      - HOMEBREW_MAKE_JOBS="${PARALLEL_JOBS}"
> +    # ccache
> +    - CCACHE_SLOPPINESS="file_macro,time_macros"

Does this actually have any effect?  We should not be using time macros.

include_file_ctime/mtime makes sense though.

Paolo

>      # tests
>      - TEST_CMD="make -j${PARALLEL_JOBS} check"
