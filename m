Received: from eggs.gnu.org ([2001:4830:134:3::10]:57251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2pmW-0001QH-7S
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 22:00:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d2pmT-0005Va-7C
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 22:00:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d2pmT-0005Uz-0V
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 22:00:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8A28280467
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 02:00:39 +0000 (UTC)
Date: Tue, 25 Apr 2017 10:00:36 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170425020036.GC13555@lemon.lan>
References: <20170424153615.18614-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170424153615.18614-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] crypto: move 'opaque' parameter to
 (nearly) the end of parameter list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Mon, 04/24 16:36, Daniel P. Berrange wrote:
> Previous commit moved 'opaque' to be the 2nd parameter in the list:
> 
>   commit 375092332eeaa6e47561ce47fd36144cdaf964d0
>   Author: Fam Zheng <famz@redhat.com>
>   Date:   Fri Apr 21 20:27:02 2017 +0800
> 
>     crypto: Make errp the last parameter of functions
> 
>     Move opaque to 2nd instead of the 2nd to last, so that compilers help
>     check with the conversion.
> 
> this puts it back to the 2nd to last position.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Fam Zheng <famz@redhat.com>
