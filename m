Received: from eggs.gnu.org ([209.51.188.92]:45470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gmHue-00071m-ED
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:45:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gmHgF-0002BZ-9y
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:30:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1gmHgF-0002B9-4I
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:30:55 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2B209C07C581
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 12:30:54 +0000 (UTC)
Received: from colo-mx.corp.redhat.com
	(colo-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E6BA6B8D6
	for <qemu-devel@nongnu.org>; Wed, 23 Jan 2019 12:30:54 +0000 (UTC)
Date: Wed, 23 Jan 2019 07:30:53 -0500 (EST)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1320922594.66364937.1548246653680.JavaMail.zimbra@redhat.com>
In-Reply-To: <d1d15efe-8653-8e47-acf5-b8839f84db19@redhat.com>
References: <20190122144103.18310-1-pagupta@redhat.com>
	<d1d15efe-8653-8e47-acf5-b8839f84db19@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] chardev: Avoid adding duplicate chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre lureau <marcandre.lureau@redhat.com>, pbonzini@redhat.com, xiaohli@redhat.com



> 
> On 1/22/19 8:41 AM, Pankaj Gupta wrote:
> > Hotplugging existing char chardev with qmp, dereferences(removes)
> > existing chardev. This patch avoids adding a chardev if a chardev
> > with same id exists.
> > 
> 
> > +++ b/chardev/char.c
> > @@ -985,6 +985,12 @@ ChardevReturn *qmp_chardev_add(const char *id,
> > ChardevBackend *backend,
> >      ChardevReturn *ret;
> >      Chardev *chr;
> >  
> > +    chr = qemu_chr_find(id);
> > +    if (chr) {
> > +        error_setg(errp, "Chardev '%s' already exist", id);
> 
> s/exist/exists/

Will correct this in v2.

Thanks,
Pankaj
