Received: from eggs.gnu.org ([2001:4830:134:3::10]:58129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVHnO-000698-Dp
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1dVHnK-0003Uq-FU
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 09:35:14 -0400
References: <20170609152017.7286-1-eblake@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <1298d3b1-a6d6-499b-323b-b79c6e38bc7b@msgid.tls.msk.ru>
Date: Wed, 12 Jul 2017 16:35:05 +0300
MIME-Version: 1.0
In-Reply-To: <20170609152017.7286-1-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] qobject coccinelle followups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, marcandre.lureau@redhat.com, armbru@redhat.com

09.06.2017 18:20, Eric Blake wrote:
> Inspired by https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02505.html
> 
> Surprisingly, the updated script didn't find any existing longhand
> use as candidates for QDECREF() (our last such use was cleaned up
> as a side effect, in commit b72fe9e), but it DID find another straggler
> missed in commit 579cf1d1.
> 
> Eric Blake (2):
>   qobject: Update coccinelle script to catch Q{INC,DEC}REF
>   qobject: Catch another straggler for use of qdict_put_str()

Applied to -trivial, thanks!

/mjt
