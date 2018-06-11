Received: from eggs.gnu.org ([2001:4830:134:3::10]:51318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fSURl-0001fS-8d
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fSURg-0006Z8-Bi
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:33:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49244 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fSURg-0006Yw-7d
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:33:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C2F187D668
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 21:33:47 +0000 (UTC)
Date: Mon, 11 Jun 2018 23:33:42 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180611233342.36a35911@igors-macbook-pro.local>
In-Reply-To: <20180611184016.GR7451@localhost.localdomain>
References: <20180608130846.22234-1-dgilbert@redhat.com>
	<20180608130846.22234-6-dgilbert@redhat.com>
	<87y3flilan.fsf@dusky.pond.sub.org>
	<20180611184016.GR7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hmp: Add info commands for preconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Michal Privoznik <mprivozn@redhat.com>, "Daniel P.
	=?UTF-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, eblake@redhat.com, pkrempa@redhat.com

On Mon, 11 Jun 2018 15:40:16 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Jun 11, 2018 at 02:01:52PM +0200, Markus Armbruster wrote:
> > * Eduardo, why does "info numa" have no QMP equivalent?
> 
> Nobody ever asked for one, which seems to qualify as "only for
> human users".
> 
> Should we add an equivalent QMP command even if we don't expect
> anybody to use it?

we inderectly can fetch numa info via QMP, using 
  query-hotpluggable-cpus
for CPU mapping and
  query-memory-devices
for (NV|PC)-dimm devices, however there is no QMP way for getting
for numa mapping of initial RAM nor configured numa nodes
(not counting querying CLI options).

So perhaps we need info 'numa' equivalent for QMP which would give
the same amount of information as HMP in one query.

Maybe libvirt side as actual users know better if it's really needed (CCed)
