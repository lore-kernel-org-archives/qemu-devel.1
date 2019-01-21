Received: from eggs.gnu.org ([209.51.188.92]:54184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1glc3w-0006YW-QY
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:04:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1glc3t-0001hC-7r
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:04:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1glc3r-0001eg-4K
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 11:04:33 -0500
References: <154805723903.5550.18349469177184195707@2d3111e9616b>
From: John Snow <jsnow@redhat.com>
Message-ID: <5233a4d3-e37c-fb50-b983-3c31b6e5a2be@redhat.com>
Date: Mon, 21 Jan 2019 10:55:41 -0500
MIME-Version: 1.0
In-Reply-To: <154805723903.5550.18349469177184195707@2d3111e9616b>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/8] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, peter.maydell@linaro.org



On 1/21/19 2:54 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190116010106.27626-1-jsnow@redhat.com/
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
>   CC      crypto/block.o
>   CC      crypto/block-qcow.o
> /tmp/qemu-test/src/block/sheepdog.c: In function 'find_vdi_name':
> /tmp/qemu-test/src/block/sheepdog.c:1239:5: error: 'strncpy' specified bound 256 equals destination size [-Werror=stringop-truncation]
>      strncpy(buf + SD_MAX_VDI_LEN, tag, SD_MAX_VDI_TAG_LEN);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> 
> The full log is available at
> http://patchew.org/logs/20190116010106.27626-1-jsnow@redhat.com/testing.docker-mingw@fedora/?type=message.
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 

Not related to this patchset.

--js
