Received: from eggs.gnu.org ([2001:4830:134:3::10]:47385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTxF-0004RQ-FH
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTxB-0004YX-Vu
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:21:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHTxB-0004Xt-P1
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:21:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id y15-v6so12566958wru.9
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 06:21:05 -0700 (PDT)
References: <BN6PR2201MB1251EA1F1F5E486A889A827CC6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <390ae5f6-8392-e26b-adf7-1979f32a06f0@redhat.com>
Date: Tue, 30 Oct 2018 14:21:02 +0100
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251EA1F1F5E486A889A827CC6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Question: Perfecting checkpatch.pl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 30/10/18 13:35, Aleksandar Markovic wrote:
> Perhaps checkpatch.pl should make sure the commit messages do not contain "address@hidden" and "Reviewed-off-by"?
> 
> $ git log | grep address@hidden
>      Signed-off-by: Michael S. Tsirkin <address@hidden>
>      Signed-off-by: Ronald Hecht <address@hidden>
>      Signed-off-by: Justin Chevrier <address@hidden>
>      Signed-off-by: Justin Chevrier <address@hidden>
>      Signed-off-by: Justin Chevrier <address@hidden>

Having a check for that is a good idea, but I don't think checkpatch 
would help, these incorrect emails only appear once maintainer applied 
patches, maybe the good place to check would be Peter's magic scripts, see:
https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/apply-pullreq?id=eeb001fcc1aabd8f077cd2846724120a3aa8f962#n118

Those emails also entered the tree:

hw/usb/hcd-ehci.c:4: * Copyright(c) 2008  Emutex Ltd. (address@hidden)
include/qemu/pmem.h:6: * Author: Haozhong Zhang <address@hidden>

> 
> $ git log | grep Reviewed-off-by
>      Reviewed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>      Reviewed-off-by: Anthony Liguori <aliguori@us.ibm.com>
> 
> Aleksandar
> 
