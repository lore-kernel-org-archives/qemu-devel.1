Received: from eggs.gnu.org ([2001:4830:134:3::10]:41919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNMRf-0007o1-Lp
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:32:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gNMRa-00060C-2V
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:32:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gNMRW-0005y3-MD
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 13:32:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC0823001BC1
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 18:32:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181026105711.29605-1-cohuck@redhat.com>
Date: Thu, 15 Nov 2018 19:32:36 +0100
In-Reply-To: <20181026105711.29605-1-cohuck@redhat.com> (Cornelia Huck's
	message of "Fri, 26 Oct 2018 12:57:11 +0200")
Message-ID: <87pnv69oor.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC] MAINTAINERS: clarify some of the tags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org

Cornelia Huck <cohuck@redhat.com> writes:

> The MAINTAINERS file is a bit sparse on information about what
> the different designators are. Let's add some more information
> to give contributors a better idea about what the different
> roles are.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>
> This came out of a discussion about what being a 'reviewer' listed in
> this file actually means. A reviewer probably should already have a
> track record of doing helpful reviews before being listed in here.
>
> While at it, I also tried to add some more hints for the other entries.
> This patch is supposed to be a starting point for further discussion.
>
> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 40672c4eba..7d9dbc6724 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12,9 +12,14 @@ consult qemu-devel and not any specific individual privately.
>  Descriptions of section entries:
>  
>  	M: Mail patches to: FullName <address@domain>
> +	   Maintainers are looking after a certain area and must be CCed on
> +	   patches. They are considered the main contact point.
>  	R: Designated reviewer: FullName <address@domain>
>  	   These reviewers should be CCed on patches.
> +	   Reviewers are familiar with the subject matter and provide feedback
> +	   even though they are not maintainers.
>  	L: Mailing list that is relevant to this area
> +	   These lists should be CCed on patches.
>  	W: Web-page with status/info
>  	Q: Patchwork web based patch tracking system site
>  	T: SCM tree type and location.  Type is one of: git, hg, quilt, stgit.

Perfect is the enemy of good.  This is good.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
