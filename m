Received: from eggs.gnu.org ([2001:4830:134:3::10]:36222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUzxN-0006TH-LS
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:09:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gUzxJ-0005gP-UE
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:09:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gUzxH-0005cr-VQ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 15:09:05 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-12-git-send-email-pbonzini@redhat.com>
	<22f8b57f-48b2-ae8d-7994-87801a8cd04e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ecc5515-8e9f-d707-cae2-69adc64e983f@redhat.com>
Date: Thu, 6 Dec 2018 21:08:57 +0100
MIME-Version: 1.0
In-Reply-To: <22f8b57f-48b2-ae8d-7994-87801a8cd04e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 11/71] vhost-user-test: reduce usage of
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 06/12/18 17:36, Thomas Huth wrote:
> Looks like it should work. Maybe you could use this patch here first:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02199.html
> 
> ... then you could likely get rid of global_qtest here completely, I think.

Note that most of the global_qtest references disappear with the qgraph
conversion.  Each qgraph object already knows which QTestState it refers
to.  However there are a couple that remain, I'll check if there's
anything to improve in the QOSGraphObject APIs to remove them.

Paolo

> Anyway:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
