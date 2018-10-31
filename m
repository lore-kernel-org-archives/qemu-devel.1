Received: from eggs.gnu.org ([2001:4830:134:3::10]:51064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHsFU-000659-0c
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:17:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gHsFR-00064W-IC
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:17:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gHsFR-00062A-CV
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 11:17:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0323B307D85E
	for <qemu-devel@nongnu.org>; Wed, 31 Oct 2018 15:17:29 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181030123526.26415-1-kchamart@redhat.com>
Date: Wed, 31 Oct 2018 16:17:26 +0100
In-Reply-To: <20181030123526.26415-1-kchamart@redhat.com> (Kashyap Chamarthy's
	message of "Tue, 30 Oct 2018 13:35:23 +0100")
Message-ID: <87lg6eqh6h.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, ehabkost@redhat.com, imammedo@redhat.com

Kashyap Chamarthy <kchamart@redhat.com> writes:

> The first patch deprecates the QMP `cpu-add`, the second its HMP 
> equivalent, and the third documents vCPU hotplug procedure using QMP
> `device_add` et al.
>
> v2: https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03191.html

Preferably reordered so that PATCH 3 comes before 1 & 2, series
Reviewed-by: Markus Armbruster <armbru@redhat.com>
