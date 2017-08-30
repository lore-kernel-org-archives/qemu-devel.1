Received: from eggs.gnu.org ([2001:4830:134:3::10]:34609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn6Ut-0008Bw-Qz
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dn6Uq-0003TC-MW
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:09:47 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dn6Uq-0003Sm-Ft
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 13:09:44 -0400
Received: by mail-wm0-x236.google.com with SMTP id 187so5438750wmn.1
	for <qemu-devel@nongnu.org>; Wed, 30 Aug 2017 10:09:44 -0700 (PDT)
Date: Wed, 30 Aug 2017 18:09:41 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170830170941.GB24565@stefanha-x1.localdomain>
References: <87r2w6eq5n.fsf@gmail.com>
 <87h8x1yox3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h8x1yox3.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: David Michael <fedora.dm0@gmail.com>, qemu-devel@nongnu.org

On Mon, Aug 21, 2017 at 04:29:44PM +0200, Markus Armbruster wrote:
> What is our Python 2 -> 3 migration strategy?
> 
> Don't support Python 3 until a flag day, then flip and don't support
> Python 2?

Add support for Python 3 so that both Python 2.6+ and Python 3 are
supported.

When Python 2 is EOL it will need to be dropped and the code becomes
Python 3-only.

> Keep the source in Python 2 and support 3 via conversion with 2to3?
> 
> Port the source to Python 3 and support 2 via conversion with 3to2?
> 
> Port to Python 3, but keep it working with Python 2 with help of the six
> module?
> 
> Support both with ad hoc hackery (like this patch does)?

Yes, please see for details:
https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01758.html

Stefan
