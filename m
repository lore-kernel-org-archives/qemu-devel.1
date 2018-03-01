Received: from eggs.gnu.org ([2001:4830:134:3::10]:42362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erSA9-0000Lp-6B
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:38:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erSA5-00033j-UD
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:38:37 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1erSA5-00033W-NK
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:38:33 -0500
Received: by mail-wr0-x241.google.com with SMTP id n7so7440139wrn.5
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:38:33 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-13-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aed8834b-a598-d8f8-6762-87aa0f7562a9@redhat.com>
Date: Thu, 1 Mar 2018 18:38:31 +0100
MIME-Version: 1.0
In-Reply-To: <20180301084438.13594-13-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/15] chardev: introduce
 chr_machine_done hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 01/03/2018 09:44, Peter Xu wrote:
> Introduce ChardevClass.chr_machine_done() hook so that chardevs can run
> customized procedures after machine init.
> 
> There was an existing mux user already that did similar thing but used a
> raw machine done notifier.  Generalize it into a framework, and let the
> mux chardevs provide such a class-specific hook to achieve the same
> thing.  Then we can move the mux related code to the char-mux.c file.
> 
> This notifier framework will be further leverged by other type of
> chardevs soon.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-mux.c     | 29 +++++++++++++++++++++++++++++
>  chardev/char.c         | 43 +++++++++++++++++--------------------------
>  include/chardev/char.h |  2 ++
>  3 files changed, 48 insertions(+), 26 deletions(-)

Modulo the note on muxes_realized (see patch 15/15),

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
