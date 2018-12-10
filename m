Received: from eggs.gnu.org ([2001:4830:134:3::10]:44903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWNZL-0004h4-K6
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWNZG-0004Qr-MI
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:34:03 -0500
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:37071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWNZG-0004PS-Ea
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 10:33:58 -0500
Received: by mail-oi1-x234.google.com with SMTP id y23so9282845oia.4
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:33:58 -0800 (PST)
References: <54990469B118604BB659B7D5A1E9A4623E80C70E@HASMSX111.ger.corp.intel.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <61892168-20ad-11fd-6b7c-ebefe9808a2d@linaro.org>
Date: Mon, 10 Dec 2018 09:33:53 -0600
MIME-Version: 1.0
In-Reply-To: <54990469B118604BB659B7D5A1E9A4623E80C70E@HASMSX111.ger.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [TCG SIMD] 128 bit SIMD support in the TCG backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Ancuta, Cristian" <cristian.ancuta@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 12/10/18 8:37 AM, Ancuta, Cristian wrote:
> Hi,
> 
> Hope this is the right place for this question.
> 
> I was wondering whether the TCG i386 backend is currently able to generate SIMD code ( vector loads/store, moves, vector arithmetic, etc ).

Yes, it is.

> Looking around on patchwork I found these patches:
> 
> https://patchwork.kernel.org/project/qemu-devel/list/?submitter=172151
> 
> They seem to implement the vector support that I'd be interested in (including support for tcg_gen_qemu_<ld/st>_v128 ) but I guess the patches didn't make it into any stable version?

They made it in with a different form.

See tcg/tcg-op-gvec.[ch] and how those are used within target/arm/.

We do not yet use the infrastructure for targets other than ARM, though Mark
Cave-Ayland has just posted a patch set that begins conversion of target/ppc/.


r~
