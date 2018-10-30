Received: from eggs.gnu.org ([2001:4830:134:3::10]:41231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gHTdJ-0003xl-Lh
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1gHTd0-0002A7-15
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:00:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43240)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>) id 1gHTcw-0001zd-8O
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:00:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 17313241B24
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 13:00:08 +0000 (UTC)
Date: Tue, 30 Oct 2018 14:00:02 +0100
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20181030130002.GO22057@paraplu>
References: <20181030123526.26415-1-kchamart@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030123526.26415-1-kchamart@redhat.com>
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
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, thuth@redhat.com, libvir-list@redhat.com

[Cc: libvir-list]

On Tue, Oct 30, 2018 at 01:35:23PM +0100, Kashyap Chamarthy wrote:
> The first patch deprecates the QMP `cpu-add`, the second its HMP 
> equivalent, and the third documents vCPU hotplug procedure using QMP
> `device_add` et al.
> 
> v2: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03191.html
> 
> Kashyap Chamarthy (3):
>   Deprecate QMP `cpu-add`
>   Deprecate HMP `cpu-add`
>   docs: Document vCPU hotplug procedure
> 
>  docs/cpu-hotplug.rst | 142 +++++++++++++++++++++++++++++++++++++++++++
>  hmp-commands.hx      |   6 +-
>  hmp.c                |   2 +
>  qapi/misc.json       |   8 ++-
>  qemu-deprecated.texi |   5 ++
>  5 files changed, 160 insertions(+), 3 deletions(-)
>  create mode 100644 docs/cpu-hotplug.rst
> 
> -- 
> 2.17.1
> 

-- 
/kashyap
