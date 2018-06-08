Received: from eggs.gnu.org ([2001:4830:134:3::10]:33931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fRIrA-0001Aa-5e
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fRIr6-0007q4-7A
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:59:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42360 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fRIr6-0007pm-3N
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:59:08 -0400
References: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <edcae62f-e3b6-6e25-60a5-843eeae89396@redhat.com>
Date: Fri, 8 Jun 2018 09:59:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180607223111.27792-1-ross.zwisler@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu PATCH 1/5] gitignore: ignore generated qapi
 job files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ross Zwisler <ross.zwisler@linux.intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 06/07/2018 05:31 PM, Ross Zwisler wrote:
> With a fully built QEMU I currently see the following with "git status":
> 
>    Untracked files:
>      (use "git add <file>..." to include in what will be committed)
> 
>    	qapi/qapi-commands-job.c
>    	qapi/qapi-commands-job.h
>    	qapi/qapi-events-job.c
>    	qapi/qapi-events-job.h
>    	qapi/qapi-types-job.c
>    	qapi/qapi-types-job.h
>    	qapi/qapi-visit-job.c
>    	qapi/qapi-visit-job.h
> 
> These are all generated files.  Ignore them.
> 
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Fixes: commit bf42508f24ee ("job: Introduce qapi/job.json")

You're the third to post this:

https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg07280.html
https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg01624.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
