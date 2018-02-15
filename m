Received: from eggs.gnu.org ([2001:4830:134:3::10]:50006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emMKO-0004bJ-BN
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1emMKK-00013A-AL
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:24:08 -0500
Date: Thu, 15 Feb 2018 11:24:02 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180215162402.GA2308@flamenco>
References: <1518664462-2960-1-git-send-email-cota@braap.org>
	<1518664462-2960-2-git-send-email-cota@braap.org>
	<6a46ae1c-0d64-48b6-c567-5e72b1ad009c@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a46ae1c-0d64-48b6-c567-5e72b1ad009c@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH 1/3] translator: add retcode to
 translator_loop_temp_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On Thu, Feb 15, 2018 at 07:09:56 -0800, Richard Henderson wrote:
> On 02/14/2018 07:14 PM, Emilio G. Cota wrote:
> > -void translator_loop_temp_check(DisasContextBase *db);
> > +int translator_loop_temp_check(DisasContextBase *db);
> 
> bool.
> 
> Although I don't see how this is helpful.  If you want to customize the output,
> surely you just use tcg_check_temp_count directly?

The only advantage is that we get to keep the same warning on
all targets [that support the temps' check]. Admittedly
not a huge benefit; I can drop this if you want.

Thanks,

		E.
