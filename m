Received: from eggs.gnu.org ([209.51.188.92]:33168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glYaC-0001xS-Uk
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:21:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1glYaB-0007BT-VP
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:21:40 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1glYaB-00079K-P5
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:21:39 -0500
Received: by mail-wr1-f51.google.com with SMTP id q18so23055965wrx.9
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 04:21:37 -0800 (PST)
References: <154805723903.5550.18349469177184195707@2d3111e9616b>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3304e77c-c228-e5d7-0319-8f3325e8c0cd@redhat.com>
Date: Mon, 21 Jan 2019 13:21:34 +0100
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
To: qemu-devel@nongnu.org, jsnow@redhat.com
Cc: fam@euphon.net, peter.maydell@linaro.org

On 1/21/19 8:54 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190116010106.27626-1-jsnow@redhat.com/
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

Thanks Patchew, this error is now fixed (merged in 51c1c135608).
