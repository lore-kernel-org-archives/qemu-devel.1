Received: from eggs.gnu.org ([2001:4830:134:3::10]:41424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gNfiu-0006S2-S6
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:07:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gNfiq-0002Zf-S3
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:07:56 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57267)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gNfio-0002WS-67
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:07:51 -0500
Date: Fri, 16 Nov 2018 10:07:42 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181116150742.GA19283@flamenco>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
	<20181114010014.GA19024@flamenco>
	<d15fa143-ab52-3de9-29f0-ff794cec6ac3@linaro.org>
	<20181115184827.GA12024@flamenco>
	<06e66024-1abb-e5b7-591c-3633b5cb3e31@linaro.org>
	<20181116011338.GB17566@flamenco> <20181116051040.GA25165@flamenco>
	<00eece57-cd7d-f4da-c3ec-6bcfbf82b2f2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00eece57-cd7d-f4da-c3ec-6bcfbf82b2f2@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-4.0 00/17] tcg: Move softmmu out-of-line
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org

On Fri, Nov 16, 2018 at 09:07:50 +0100, Richard Henderson wrote:
> On 11/16/18 6:10 AM, Emilio G. Cota wrote:
> > It's possible that newer machines with larger reorder buffers
> > will be able to take better advantage of the higher instruction
> > locality, hiding the latency of having to execute more instructions.
> > I'll test on Skylake tomorrow.
> 
> I've noticed that the code we generate for calls has twice as many instructions
> as really needed for setting up the arguments.  I have a plan to fix that,
> which hopefully will solve this problem.

Ah that's great. I'll do more tests and a full review when those
changes come out, then.

Thanks,

		E.
