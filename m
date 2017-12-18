Received: from eggs.gnu.org ([2001:4830:134:3::10]:54448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0gk-0004zU-8J
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0gQ-0002r8-9B
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:02:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eR0gQ-0002pb-2D
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:02:38 -0500
Date: Mon, 18 Dec 2017 19:02:31 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171218190231.GH26755@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171218184428.15074-1-danielhb@linux.vnet.ibm.com>
	<20171218184428.15074-2-danielhb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171218184428.15074-2-danielhb@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qmp: marking qmp_cpu as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com

On Mon, Dec 18, 2017 at 04:44:28PM -0200, Daniel Henrique Barboza wrote:
> qmp_cpu is a nop that was created a while ago in commit 755f196898
> ("qapi: Convert the cpu command") for the sake of compatibility,
> due to the existence of hmp_cpu.
> 
> Today, there is no need or requirement to keep it as is. QMP is
> meant to be as stateless as possible, thus any QMP command that
> needs a specific monitor CPU setup should provide it in its
> arguments, instead of relying in the current QMP monitor state.
> 
> This patch flags qmp_cpu as deprecated in qemu-doc.texi,
> qapi-schema.json and changes qmp_cpu body to show a deprecation
> message if used.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
