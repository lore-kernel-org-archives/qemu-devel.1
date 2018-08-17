Received: from eggs.gnu.org ([2001:4830:134:3::10]:40825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqhNh-0008SR-I6
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fqhFk-0001tH-Ki
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:05:35 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:37951)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fqhFk-0001sM-3D
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:05:32 -0400
Date: Fri, 17 Aug 2018 12:05:27 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180817160527.GA4415@flamenco>
References: <20180817051853.23792-1-cota@braap.org>
	<20180817051853.23792-10-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817051853.23792-10-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH 9/9] hmp-commands-info: add sync-profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Weil <sw@weilnetz.de>, Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri, Aug 17, 2018 at 01:18:53 -0400, Emilio G. Cota wrote:
> The command introduced here is just for developers. This means that:
> 
> - the info displayed and the output format could change in the future
> - the command is only meant to be used from HMP, not from QMP
> 
> Sample output:
(snip)
> BQL mutex  0x55a0171b7140  util/main-loop.c:236            0.00894          6425          1.39
> mutex      [           3]  util/qemu-timer.c:520           0.00342         50611          0.07
> mutex      [           2]  util/qemu-timer.c:426           0.00254         31336          0.08
> mutex      [           3] util/qemu-timer.c:234           0.00107         19275          0.06
                           ^^
I manually updated the commit message after switching to brackets
(initially didn't have them), so in case you're wondering,
the missing space is not due to a bug in the code.

Thanks,

		E.
