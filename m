Received: from eggs.gnu.org ([209.51.188.92]:47473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmJm8-0006lA-60
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:45:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmJm6-0007dv-DS
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:45:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eric.auger@redhat.com>)
	id 1gmJm6-0007dD-6c
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:45:06 -0500
References: <154825338186.21.2661799743092991292@ebba9967afc0>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <e15a4bfd-ce73-62c8-3338-d35a429951b8@redhat.com>
Date: Wed, 23 Jan 2019 15:44:57 +0100
MIME-Version: 1.0
In-Reply-To: <154825338186.21.2661799743092991292@ebba9967afc0>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/vfio/common: Refactor container
 initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org
Cc: fam@euphon.net, aik@ozlabs.ru, groug@kaod.org, alex.williamson@redhat.com, eric.auger.pro@gmail.com

Hi,

On 1/23/19 3:23 PM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190117210245.18364-1-eric.auger@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> time make docker-test-mingw@fedora SHOW_ENV=1 J=14
> === TEST SCRIPT END ===
> 
>   CC      job-qmp.o
>   CC      qdev-monitor.o
> /tmp/qemu-test/src/block/sheepdog.c: In function 'find_vdi_name':
> /tmp/qemu-test/src/block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals destination size [-Werror=stringop-truncation]
>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
does not seem to be related to my patch.

Thanks

Eric

> cc1: all warnings being treated as errors
> 
> 
> The full log is available at
> http://patchew.org/logs/20190117210245.18364-1-eric.auger@redhat.com/testing.docker-mingw@fedora/?type=message.
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 
