Received: from eggs.gnu.org ([2001:4830:134:3::10]:55593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHvA1-0001F9-60
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gHv9y-0005sD-1w
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:24:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gHv9x-0005qg-R6
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 14:24:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0F82F30820DC
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 18:24:04 +0000 (UTC)
Date: Wed, 31 Oct 2018 15:24:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181031182401.GS3902@habkost.net>
References: <20181030123526.26415-1-kchamart@redhat.com>
	<87lg6eqh6h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lg6eqh6h.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Deprecate QMP & HMP `cpu-add`;
 document vCPU hotplug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, thuth@redhat.com, imammedo@redhat.com

On Wed, Oct 31, 2018 at 04:17:26PM +0100, Markus Armbruster wrote:
> Kashyap Chamarthy <kchamart@redhat.com> writes:
> 
> > The first patch deprecates the QMP `cpu-add`, the second its HMP 
> > equivalent, and the third documents vCPU hotplug procedure using QMP
> > `device_add` et al.
> >
> > v2: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03191.html
> 
> Preferably reordered so that PATCH 3 comes before 1 & 2, series
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks, queued on machine-next.

Being only documentation updates, I consider it to be reasonable
to be included after soft freeze.

-- 
Eduardo
