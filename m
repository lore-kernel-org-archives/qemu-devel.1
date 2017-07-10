Received: from eggs.gnu.org ([2001:4830:134:3::10]:53375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUacQ-0002jE-9Y
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:29:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUacL-0007dz-Bw
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:29:02 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50601)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dUacL-0007ap-2A
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:28:57 -0400
Date: Mon, 10 Jul 2017 11:28:54 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170710152854.GA1216@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-23-git-send-email-cota@braap.org>
	<5b3531bf-5e06-f5d3-6ba0-6a0baa810cee@twiddle.net>
	<20170710035128.GA25231@flamenco>
	<4173f39f-a236-c64f-3ae4-497b4bff363c@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4173f39f-a236-c64f-3ae4-497b4bff363c@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 22/22] translate-all: do not hold tb_lock
 during code generation in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Sun, Jul 09, 2017 at 19:59:47 -1000, Richard Henderson wrote:
> On 07/09/2017 05:51 PM, Emilio G. Cota wrote:
> >On Sun, Jul 09, 2017 at 11:38:50 -1000, Richard Henderson wrote:
> >>On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> >(snip)
> >>I think it would be better to have a tb_htable_lookup_or_insert function,
> >>which performs the insert iff a matching object isn't already there,
> >>returning the entry which *is* there in either case.
> >
> >qht_insert behaves exactly like this, except that it returns a bool.
> >But we could make it return a void *.
> 
> Err.. no it doesn't.  It returns false if the *exact same object* is
> inserted twice.  That's not the same as being passed a qht_lookup_func_t to
> see if two different objects compare equal.

True, I misremembered. My original implementation worked like that though,
then I figured for our use case we could skip calling the comparison function.

		E.
