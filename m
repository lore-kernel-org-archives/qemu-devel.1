Received: from eggs.gnu.org ([2001:4830:134:3::10]:47635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQo7X-0002R7-Kc
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eQo7S-0007Fh-OJ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:37:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eQo7S-0007DY-Ip
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 00:37:42 -0500
Date: Mon, 18 Dec 2017 13:37:25 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171218053725.GM22308@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-21-peterx@redhat.com>
	<20171214131632.GI14433@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171214131632.GI14433@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 20/26] qmp: support out-of-band (oob)
 execution
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Dec 14, 2017 at 01:16:32PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 01:51:54PM +0800, Peter Xu wrote:
> >      if (qdict) {
> >          id = qdict_get(qdict, "id");
> > +        /* When OOB is enabled, the "id" field is mandatory. */
> > +        if (qmp_oob_enabled(mon) && !id) {
> > +            error_setg(&err, "Out-Of-Band capability requires that "
> > +                       "every command contains an 'id' field.");
> 
> Is this documented in docs/interop/qmp-spec.txt?

Yes it is:

@@ -102,10 +125,19 @@ The format for command execution is:
   required. Each command documents what contents will be considered
   valid when handling the json-argument
 - The "id" member is a transaction identification associated with the
-  command execution, it is optional and will be part of the response if
+  command execution.  It is required if OOB is enabled, and optional
+  if not.  The same "id" field will be part of the response if
   provided. The "id" member can be any json-value, although most
   clients merely use a json-number incremented for each successive
   command

Thanks,

-- 
Peter Xu
