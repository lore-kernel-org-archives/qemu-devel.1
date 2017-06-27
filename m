Received: from eggs.gnu.org ([2001:4830:134:3::10]:35506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPvaf-0002CC-HO
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dPvac-0001X6-GD
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:51:57 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:51571)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dPvac-0001WN-2g
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 14:51:54 -0400
Date: Tue, 27 Jun 2017 14:51:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170627185152.GA20939@flamenco>
References: <20161202210152.6880-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161202210152.6880-1-lersek@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] scripts: add "git.orderfile" for
 ordering diff hunks by pathname patterns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, John Snow <jsnow@redhat.com>

On Fri, Dec 02, 2016 at 22:01:52 +0100, Laszlo Ersek wrote:
> When passed to git-diff (and to every other git command producing diffs
> and/or diffstats) with "-O" or "diff.orderFile", this list of patterns
> will place the more declarative / abstract hunks first, while changes to
> imperative code / details will be near the end of the patches. This saves
> on scrolling / searching and makes for easier reviewing.
> 
> We intend to advise contributors in the Wiki to run
> 
>   git config diff.orderFile scripts/git.orderfile
> 
> once, as part of their initial setup, before formatting their first (or,
> for repeat contributors, next) patches.
> 
> See the "-O" option and the "diff.orderFile" configuration variable in
> git-diff(1) and git-config(1).
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Max Reitz <mreitz@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> ---

Refloating 6+ months later, but..

Someone please merge this! :-)

		E.
