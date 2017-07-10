Received: from eggs.gnu.org ([2001:4830:134:3::10]:37270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUb6c-0008GV-IJ
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dUb6X-0002wU-NF
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:00:14 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56651)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dUb6X-0002w0-Ha
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:00:09 -0400
Date: Mon, 10 Jul 2017 12:00:08 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170710160008.GB1216@flamenco>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-18-git-send-email-cota@braap.org>
	<7e81eceb-2a5e-b5cf-6385-4aff70ecc1b2@twiddle.net>
	<20170709211423.GD32582@flamenco>
	<fe6e3d5b-3856-5c6b-301b-1334cf673434@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe6e3d5b-3856-5c6b-301b-1334cf673434@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 17/22] tcg: distribute profiling counters
 across TCGContext's
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

On Sun, Jul 09, 2017 at 11:44:10 -1000, Richard Henderson wrote:
> On 07/09/2017 11:14 AM, Emilio G. Cota wrote:
> >On Sun, Jul 09, 2017 at 10:45:55 -1000, Richard Henderson wrote:
> >>On 07/08/2017 09:50 PM, Emilio G. Cota wrote:
> >>>+    /* includes aborted translations because of exceptions */
> >>>+    atomic_set(&prof->tb_count1, prof->tb_count1 + 1);
> >>
> >>Again, atomic_set without atomic_read is pointless.
> >>Either you're trying to give the compiler extra information, or you aren't.
> >
> >See my comment to patch 3.
> 
> I still disagree.  It's Just Plain Confusing.

To me,
  atomic_set(&foo, foo + 1)
and
  atomic_set(&foo, atomic_read(&foo) + 1)
read differently.

The former tells me that no other thread can update the value.

The latter makes me presume that other threads *can* update the value,
which makes me wonder whether this is a bug and we should use atomic_inc(),
or perhaps we are OK with missing counts.

		Emilio
