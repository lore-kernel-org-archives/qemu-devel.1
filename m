Received: from eggs.gnu.org ([2001:4830:134:3::10]:36064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckns3-0007cF-JC
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ckns0-0002Ui-DN
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:19:55 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170302122429.7737-1-berrange@redhat.com>
Date: Mon, 06 Mar 2017 09:19:49 +0100
In-Reply-To: <20170302122429.7737-1-berrange@redhat.com> (Daniel P. Berrange's
	message of "Thu, 2 Mar 2017 12:24:29 +0000")
Message-ID: <87zigy3jh6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qmp: allow setting properties to empty
 string in qmp-shell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

"Daniel P. Berrange" <berrange@redhat.com> writes:

> The qmp-shell property parser currently rejects attempts to
> set string properties to the empty string eg
>
>   (QEMU) migrate-set-parameters  tls-hostname=
>   Error while parsing command line: Expected a key=value pair, got 'tls-hostname='
> command format: <command-name>  [arg-name1=arg1] ... [arg-nameN=argN]
>
> This is caused by checking the wrong condition after splitting
> the parameter on '='. The "partition" method will return "" for
> the separator field, if the seperator was not present, so that
> is the correct thing to check for malformed syntax.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

I'll take this through my tree, unless qemu-trivial beats me to the
punch.  Thanks!
