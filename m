Received: from eggs.gnu.org ([209.51.188.92]:44906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghBcp-0001SX-6l
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghBco-0003ge-8K
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:02:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghBco-0003gM-1u
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 06:02:18 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34034461F8
	for <qemu-devel@nongnu.org>; Wed,  9 Jan 2019 11:02:17 +0000 (UTC)
Date: Wed, 9 Jan 2019 11:02:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190109110208.GH3998@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190109085113.GA23677@paraplu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190109085113.GA23677@paraplu>
Subject: Re: [Qemu-devel] Should the "props" be documented for QMP
 `object-add`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com

On Wed, Jan 09, 2019 at 09:51:13AM +0100, Kashyap Chamarthy wrote:
> I notice that the following QMP command:
> 
>     {
>       "execute":"object-add",
>       "arguments":{
>         "qom-type":"tls-creds-x509",
>         "id":"objlibvirt_migrate_tls0",
>         "props":{
>           "dir":"/etc/pki/qemu",
>           "endpoint":"server",
>           "verify-peer":true
>         }
>       }
>     }
> 
> ... is the same as its command-line equivalent:
> 
>     -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes
> 
> That said, in qapi/misc.json "@object-add" doesn't document any of the
> "props".  Is it on purpose?  Maybe because it is a 1:1 mapping of the
> command-line `-object` (which _is_ documented in qemu-doc.texi).
> 
> Is it a good idea to send a patch to document the "props" in
> qapi/misc.json?  Or would it be needless duplication?

It is not practical at this time because object_add uses QOM object
properties and these are exclusively defined in code, not QAPI schema.

There's a long term todo item to use QAPI schema to define QOM objects,
which would then auto-generate the boilerplate QOM code, at which point
it all becomes self-documenting. That's basically lacking dev resources
to work on it though...


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
