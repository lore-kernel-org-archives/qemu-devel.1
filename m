Received: from eggs.gnu.org ([2001:4830:134:3::10]:42035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gNfli-0008NY-6B
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:10:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gNfld-00044d-Rs
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:10:49 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:47341)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gNflT-0003tk-Pp
	for qemu-devel@nongnu.org; Fri, 16 Nov 2018 10:10:38 -0500
Date: Fri, 16 Nov 2018 10:10:34 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181116151034.GA19881@flamenco>
References: <20181112214503.22941-1-richard.henderson@linaro.org>
	<20181114010014.GA19024@flamenco>
	<d15fa143-ab52-3de9-29f0-ff794cec6ac3@linaro.org>
	<20181115184827.GA12024@flamenco>
	<06e66024-1abb-e5b7-591c-3633b5cb3e31@linaro.org>
	<20181116011338.GB17566@flamenco>
	<97154616-dbef-a407-2e52-e09b21f3a0eb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97154616-dbef-a407-2e52-e09b21f3a0eb@linaro.org>
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

On Fri, Nov 16, 2018 at 09:10:32 +0100, Richard Henderson wrote:
> On 11/16/18 2:13 AM, Emilio G. Cota wrote:
> > This allows us to discard most TBs; in the example above,
> > we end up *not* discarding only ~70 TBs, that is we end up keeping
> > only 70/2500 = 2.8% of the TBs that we'd discard without OOL.
> 
> Thanks.
> 
> When I apply this I think I'll rename "n_ool_thunks" to "ool_generation".  We
> don't care about the absolute count, but any change.

Agreed, that's much better.

Thanks,

		E.
