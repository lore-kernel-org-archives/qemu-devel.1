Received: from eggs.gnu.org ([2001:4830:134:3::10]:45258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gUH19-0005xZ-M1
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 15:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gUGya-0001CZ-BL
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 15:07:27 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:46849)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gUGyZ-0001C8-Vb
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 15:07:24 -0500
Date: Tue, 4 Dec 2018 15:07:20 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181204200720.GA6478@flamenco>
References: <20181124235553.17371-1-cota@braap.org>
	<20181124235553.17371-9-cota@braap.org> <87bm612lat.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bm612lat.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v6 08/13] hardfloat: implement float32/64
 addition and subtraction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>

On Tue, Dec 04, 2018 at 18:34:18 +0000, Alex Bennée wrote:
> 
> Emilio G. Cota <cota@braap.org> writes:
(snip)
> > Note that the IBM and ARM machines benefit from having
> > HARDFLOAT_2F{32,64}_USE_FP set to 0. Otherwise their performance
> > can suffer significantly:
> 
> Is this just the latency of pushing the number into a SIMD register and
> checking the flags compared to a bitmask check?

That's the case in the generated x86 assembly, so I presume
the same it's happening in the other ISAs (I didn't check
the assembly there).

(snip)
> 
> Hmm the diff is confusing but the changes look fine in the final code:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

Thanks!

		E.
