Received: from eggs.gnu.org ([2001:4830:134:3::10]:43434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d5yvg-0000io-Hg
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1d5yvc-0005GI-KP
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:23:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1d5yvc-0005FY-DH
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:23:08 -0400
References: <20170503094351.5040-1-pbonzini@redhat.com>
	<20170503094351.5040-2-pbonzini@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <dbfed08f-8beb-8b85-4d2c-fc31813426a7@redhat.com>
Date: Wed, 3 May 2017 14:23:06 -0400
MIME-Version: 1.0
In-Reply-To: <20170503094351.5040-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] MAINTAINERS: Add "R:" tag for
 self-appointed reviewers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, armbru@redhat.com, pavel.dovgaluk@ispras.ru



On 05/03/2017 05:43 AM, Paolo Bonzini wrote:
> From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
> 
> Some people are not content with the amount of mail they get, and would
> like to be CCed on patches for areas they do not maintain.  Let them
> satisfy their own appetite for qemu-devel messages.
> 
> Seriously: the purpose here is a bit different from the Linux kernel.
> While Linux uses "R" to designate non-maintainers for reviewing patches
> in a given area, in QEMU I would also like to use "R" so that people can
> delegate sending pull requests while keeping some degree of oversight.
> 

Hm? I don't follow -- you mean to say that "R" is also a designated
pull-request-sender? Did you document that anywhere?

--js

> Based on Linux commit eafbaac3093760d1fd3b2a5b9f016362dd68af36.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a1d2b3a4d3..46cf4870f9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12,6 +12,8 @@ consult qemu-devel and not any specific individual privately.
>  Descriptions of section entries:
>  
>  	M: Mail patches to: FullName <address@domain>
> +	R: Designated reviewer: FullName <address@domain>
> +	   These reviewers should be CCed on patches.
>  	L: Mailing list that is relevant to this area
>  	W: Web-page with status/info
>  	Q: Patchwork web based patch tracking system site
> 
