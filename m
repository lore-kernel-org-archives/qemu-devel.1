Received: from eggs.gnu.org ([2001:4830:134:3::10]:50038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chC9p-0006s0-Ot
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:27:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1chC9k-0005f0-Sa
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:27:21 -0500
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:34779)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1chC9k-0005ew-MB
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 04:27:16 -0500
Received: by mail-wr0-x232.google.com with SMTP id o22so3617288wro.1
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 01:27:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-18-git-send-email-armbru@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6ab9e2cd-edbe-b167-8a16-bf9c00c110ac@redhat.com>
Date: Fri, 24 Feb 2017 10:27:15 +0100
MIME-Version: 1.0
In-Reply-To: <1487886317-27400-18-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/21] qapi: Drop unused non-strict qobject
 input visitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org



On 23/02/2017 22:45, Markus Armbruster wrote:
> The split between tests/test-qobject-input-visitor.c and
> tests/test-qobject-input-strict.c now makes less sense than ever.  The
> next commit will take care of that.

I'm actually adding a use for non-strict visitors (and one that makes
sense IMHO, with comments, testcases and all that :)).  See
https://www.mail-archive.com/qemu-devel@nongnu.org/msg432069.html.

For what it's worth, however, I believe that even non-strict visits
should detect unvisited list tails.

Paolo
