Received: from eggs.gnu.org ([2001:4830:134:3::10]:44546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSRju-00024a-N5
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 14:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fSRjq-0001IJ-Eh
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 14:40:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fSRjq-0001I7-8W
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 14:40:22 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 596B687649
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 18:40:21 +0000 (UTC)
Date: Mon, 11 Jun 2018 15:40:16 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180611184016.GR7451@localhost.localdomain>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-6-dgilbert@redhat.com>
	<87y3flilan.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y3flilan.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, imammedo@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Jun 11, 2018 at 02:01:52PM +0200, Markus Armbruster wrote:
> * Eduardo, why does "info numa" have no QMP equivalent?

Nobody ever asked for one, which seems to qualify as "only for
human users".

Should we add an equivalent QMP command even if we don't expect
anybody to use it?

-- 
Eduardo
