Received: from eggs.gnu.org ([209.51.188.92]:36399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hIngT-0002GN-HZ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 01:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hIngS-00074K-O3
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 01:09:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hIngS-00073d-Fc
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 01:09:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C0864C05D3E6
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 05:09:31 +0000 (UTC)
References: <20190422210448.2488-1-ehabkost@redhat.com>
	<20190422210448.2488-4-ehabkost@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <068d46fa-424d-933d-c7d3-868c7265406d@redhat.com>
Date: Tue, 23 Apr 2019 07:09:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190422210448.2488-4-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] accel: Remove unused
 AccelClass::available field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 22/04/2019 23.04, Eduardo Habkost wrote:
> The field is not used anymore, we can remove it.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/sysemu/accel.h | 1 -
>  accel/accel.c          | 5 -----
>  2 files changed, 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
