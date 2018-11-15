Received: from eggs.gnu.org ([2001:4830:134:3::10]:36054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gNKNv-0002H2-Mi
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gNKNs-0001eV-Jr
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:20:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gNKNq-0001Ph-JD
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 11:20:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CAC62D7F8
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 16:20:36 +0000 (UTC)
Received: from gondolin (dhcp-192-222.str.redhat.com [10.33.192.222])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 27B80105B1EC
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 16:20:36 +0000 (UTC)
Date: Thu, 15 Nov 2018 17:20:32 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181115172032.53945f5e.cohuck@redhat.com>
In-Reply-To: <20181026105711.29605-1-cohuck@redhat.com>
References: <20181026105711.29605-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] MAINTAINERS: clarify some of the tags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On Fri, 26 Oct 2018 12:57:11 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

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

Ping. Further discussion would be good :)

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
