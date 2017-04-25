Received: from eggs.gnu.org ([2001:4830:134:3::10]:52739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2uvW-0001pA-SG
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d2uvS-0007X1-V6
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:30:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50666)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d2uvS-0007WI-OW
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 03:30:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E0A2DC04B951
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 07:30:16 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170424153615.18614-1-berrange@redhat.com>
Date: Tue, 25 Apr 2017 09:30:13 +0200
In-Reply-To: <20170424153615.18614-1-berrange@redhat.com> (Daniel
	P. Berrange's message of "Mon, 24 Apr 2017 16:36:15 +0100")
Message-ID: <8760htaqre.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>

"Daniel P. Berrange" <berrange@redhat.com> writes:

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

I could take this through my tree, but I suggest you stick it into your
next crypto pull request.
