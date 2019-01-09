Received: from eggs.gnu.org ([209.51.188.92]:37877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gh9fd-00056U-Tp
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gh9fc-00039N-Vi
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:57:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1gh9fc-00038q-Pf
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:57:04 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 863B713BF66
	for <qemu-devel@nongnu.org>; Wed,  9 Jan 2019 08:51:15 +0000 (UTC)
Date: Wed, 9 Jan 2019 09:51:13 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20190109085113.GA23677@paraplu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Qemu-devel] Should the "props" be documented for QMP `object-add`?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, eblake@redhat.com

I notice that the following QMP command:

    {
      "execute":"object-add",
      "arguments":{
        "qom-type":"tls-creds-x509",
        "id":"objlibvirt_migrate_tls0",
        "props":{
          "dir":"/etc/pki/qemu",
          "endpoint":"server",
          "verify-peer":true
        }
      }
    }

... is the same as its command-line equivalent:

    -object tls-creds-x509,id=tls0,dir=/etc/pki/qemu,endpoint=server,verify-peer=yes

That said, in qapi/misc.json "@object-add" doesn't document any of the
"props".  Is it on purpose?  Maybe because it is a 1:1 mapping of the
command-line `-object` (which _is_ documented in qemu-doc.texi).

Is it a good idea to send a patch to document the "props" in
qapi/misc.json?  Or would it be needless duplication?

-- 
/kashyap
