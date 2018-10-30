Received: from eggs.gnu.org ([2001:4830:134:3::10]:46226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHTtv-0001F4-Kw
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHTts-0001fK-FZ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:17:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHTts-0001ZB-5d
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:17:40 -0400
References: <BN6PR2201MB1251EA1F1F5E486A889A827CC6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e1aa7445-8eb5-f63c-ad85-7ad9c25d8ac5@redhat.com>
Date: Tue, 30 Oct 2018 14:17:23 +0100
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251EA1F1F5E486A889A827CC6CC0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
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
To: Aleksandar Markovic <amarkovic@wavecomp.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>

On 30/10/2018 13:35, Aleksandar Markovic wrote:
> Perhaps checkpatch.pl should make sure the commit messages do not contain "address@hidden" and "Reviewed-off-by"?
> 
> $ git log | grep address@hidden
>     Signed-off-by: Michael S. Tsirkin <address@hidden>
>     Signed-off-by: Ronald Hecht <address@hidden>
>     Signed-off-by: Justin Chevrier <address@hidden>
>     Signed-off-by: Justin Chevrier <address@hidden>
>     Signed-off-by: Justin Chevrier <address@hidden>
> 
> $ git log | grep Reviewed-off-by
>     Reviewed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>     Reviewed-off-by: Anthony Liguori <aliguori@us.ibm.com>

Sure, both are good ideas.  Can you write a patch for it?

Paolo
