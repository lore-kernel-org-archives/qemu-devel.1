Received: from eggs.gnu.org ([2001:4830:134:3::10]:40401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJcnh-0001ZX-6z
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gJcnZ-0003gj-UF
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:12:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gJcnZ-0003Wo-IY
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:12:01 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96F283082E02
	for <qemu-devel@nongnu.org>; Mon,  5 Nov 2018 11:12:00 +0000 (UTC)
References: <20181030123526.26415-1-kchamart@redhat.com>
	<20181030123526.26415-2-kchamart@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9f97af69-6d3f-643f-cd1d-769edc3f4920@redhat.com>
Date: Mon, 5 Nov 2018 12:11:56 +0100
MIME-Version: 1.0
In-Reply-To: <20181030123526.26415-2-kchamart@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] Deprecate QMP `cpu-add`
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, ehabkost@redhat.com, imammedo@redhat.com

On 2018-10-30 13:35, Kashyap Chamarthy wrote:
> The intended functionality of QMP `cpu-add` is replaced with
> `device_add` (and `query-hotpluggable-cpus`).  So let's deprecate
> `cpu-add`.
> 
> A complete example of vCPU hotplug with the recommended way (using
> `device_add`) is provided as part of a seperate docs patch.
> 
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> ---
> ---

Duplicated "---" line ... but I think this should not be a problem for
the usual tools.

Reviewed-by: Thomas Huth <thuth@redhat.com>
