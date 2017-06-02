Received: from eggs.gnu.org ([2001:4830:134:3::10]:43576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGl5X-0006uv-BR
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:49:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dGl5U-0006yv-9J
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:49:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dGl5U-0006yB-2i
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:49:52 -0400
Date: Fri, 2 Jun 2017 19:49:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170602114945.GG2120@lemon.lan>
References: <20170602081120.3497-1-famz@redhat.com>
	<149640353153.4078.12133676529633625501@f98a8425f76e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <149640353153.4078.12133676529633625501@f98a8425f76e>
Subject: Re: [Qemu-devel] [PULL v2 00/22] Docker and block patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, stefanha@redhat.com

On Fri, 06/02 04:38, no-reply@patchew.org wrote:
> Checking PATCH 14/22: util: add stats64 module...
> ERROR: memory barrier without comment
> #332: FILE: util/stats64.c:102:
> +        smp_wmb();
> 
> ERROR: memory barrier without comment
> #361: FILE: util/stats64.c:131:
> +        smp_wmb();
> 
> total: 2 errors, 0 warnings, 335 lines checked

As explained by Paolo in v1, the comments are just one more line above so it's a
false positive.

Fam
