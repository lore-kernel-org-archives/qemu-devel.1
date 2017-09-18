Received: from eggs.gnu.org ([2001:4830:134:3::10]:53643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtx8Q-0002hK-Mj
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtx8M-0003P4-M7
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:34:54 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:46976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dtx8M-0003Og-FQ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:34:50 -0400
Received: by mail-wm0-x22e.google.com with SMTP id i189so3299030wmf.1
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 07:34:50 -0700 (PDT)
Date: Mon, 18 Sep 2017 15:34:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170918143446.GB4141@stefanha-x1.localdomain>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529714885.10902.868327643224070834.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <150529714885.10902.868327643224070834.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v6 03/22] instrument: Add generic library
 loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Sep 13, 2017 at 01:05:49PM +0300, Lluís Vilanova wrote:
> +#include <dlfcn.h>

Is it possible to use glib's portable gmodule API so this works on
Windows too?
