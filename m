Received: from eggs.gnu.org ([2001:4830:134:3::10]:39921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ef3in-0006wF-CS
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1ef3ii-0001Bb-ER
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:07:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1ef3ii-0001BD-7j
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:07:04 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 924131FC926
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 13:07:03 +0000 (UTC)
Date: Fri, 26 Jan 2018 14:06:55 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180126130655.bhm7iwpuijsf6ea3@eukaryote>
References: <1516958370-3955-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1516958370-3955-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add "Understanding QEMU devices"
 blog post
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Fri, Jan 26, 2018 at 10:19:30AM +0100, Thomas Huth wrote:
> Last July, Eric Blake wrote a nice summary for newcomers about what
> QEMU has to do to emulate devices for the guests. So far, we missed
> to integrate this somewhere into the QEM web site or wiki, so let's
> publish this now as a nice blog post for the users.

Good catch.  I had it bookmarked to do so, but forgot.

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  _posts/2018-01-26-understanding-qemu-devices.md | 139 ++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 _posts/2018-01-26-understanding-qemu-devices.md

The core content is very helpful; but for better readability, would be
nice to break some of the large 22-line paragraphs (as they can be
overwhelming) down into slightly readable chunks.

If you don't prefer to do it, can take a stab at it, since I asked about
it.  If you think it's not worth it, I'm fine letting it go, since this
is a strict improvement as-is.

> diff --git a/_posts/2018-01-26-understanding-qemu-devices.md b/_posts/2018-01-26-understanding-qemu-devices.md
> new file mode 100644
> index 0000000..b436ef0
> --- /dev/null
> +++ b/_posts/2018-01-26-understanding-qemu-devices.md
> @@ -0,0 +1,139 @@
> +---
> +layout: post
> +title:  "Understanding QEMU devices"
> +date:   2018-01-26 10:00:00 +0100
> +author: Eric Blake
> +categories: blog

[...]

-- 
/kashyap
