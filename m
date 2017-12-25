Received: from eggs.gnu.org ([2001:4830:134:3::10]:51679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTJFk-0007yO-DB
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 22:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eTJFh-0005z5-5e
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 22:16:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33874)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eTJFg-0005yJ-VK
	for qemu-devel@nongnu.org; Sun, 24 Dec 2017 22:16:33 -0500
Date: Mon, 25 Dec 2017 11:16:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171225031618.GB2443@xz-mi>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-12-peterx@redhat.com>
	<20171221095637.GJ10812@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171221095637.GJ10812@lemon>
Subject: Re: [Qemu-devel] [RFC v6 11/27] qmp: introduce QMPCapability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Dec 21, 2017 at 05:56:37PM +0800, Fam Zheng wrote:
> On Tue, 12/19 16:45, Peter Xu wrote:
> > diff --git a/monitor.c b/monitor.c
> > index 4b2bee773f..81fb0a42b4 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -3943,12 +3943,18 @@ void monitor_resume(Monitor *mon)
> >  
> >  static QObject *get_qmp_greeting(void)
> >  {
> > +    QList *cap_list = qlist_new();
> >      QObject *ver = NULL;
> > +    QMPCapability cap;
> >  
> >      qmp_marshal_query_version(NULL, &ver, NULL);
> >  
> > -    return qobject_from_jsonf("{'QMP': {'version': %p, 'capabilities': []}}",
> > -                              ver);
> > +    for (cap = 0; cap < QMP_CAPABILITY__MAX; cap++) {
> > +        qlist_append(cap_list, qstring_from_str(QMPCapability_str(cap)));
> 
> Did we want to not include "oob" if current monitor doesn't have use_io_thr?

Yes.  As you have already noticed, it's in next patch. :)

Thanks,

-- 
Peter Xu
