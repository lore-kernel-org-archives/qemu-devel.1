Received: from eggs.gnu.org ([2001:4830:134:3::10]:59989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egxED-0005wX-8A
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egxE9-0004Ow-9P
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:35:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1egxE9-0004On-1T
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:35:21 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5188BC05FEC2
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 18:35:20 +0000 (UTC)
References: <20180131053318.13109-1-famz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <585d73f5-859a-c5d8-9f40-bf3abcccad77@redhat.com>
Date: Wed, 31 Jan 2018 13:35:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180131053318.13109-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com



On 01/31/2018 12:33 AM, Fam Zheng wrote:
> git-publish [1] is a convenient tool to send patches and has been
> popular among QEMU developers.  Recently it has been made available in
> Fedora official repo thanks to Stefan's work.
> 
> One nice feature of the tool is a per-project configuration with
> profiles, especially in which the cccmd option is a handy method to
> create the Cc list.
> 
> [1]: https://github.com/stefanha/git-publish
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  .gitpublish | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 .gitpublish
> 
> diff --git a/.gitpublish b/.gitpublish
> new file mode 100644
> index 0000000000..2099c1520f
> --- /dev/null
> +++ b/.gitpublish
> @@ -0,0 +1,57 @@
> +#
> +# Common git-publish profiles that can be used to send patches to QEMU upstream.
> +#
> +# See https://github.com/stefanha/git-publish for more information
> +#
> +[gitpublishprofile "qemu"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-rfc"]
> +base = master
> +prefix = RFC PATCH
> +to = qemu-devel@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-stable"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cc = qemu-stable@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-trivial"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-block"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cc = qemu-block@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-arm"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cc = qemu-arm@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-s390"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cc = qemu-s390@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> +
> +[gitpublishprofile "qemu-ppc"]
> +base = master
> +prefix = PATCH
> +to = qemu-devel@nongnu.org
> +cc = qemu-pcc@nongnu.org
> +cccmd = scripts/get_maintainer.pl --noroles --norolestats --nogit --nogit-fallback 2>/dev/null
> 

Awesome!!
