Received: from eggs.gnu.org ([2001:4830:134:3::10]:49467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUVCp-0007Gh-1s
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUVCk-00041L-6P
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:42:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUVCj-000411-W0
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 05:42:10 -0400
References: <1499438577-7674-1-git-send-email-peter.maydell@linaro.org>
	<1499438577-7674-2-git-send-email-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37bcbe7b-a38f-b939-d182-4c2872ef15d9@redhat.com>
Date: Mon, 10 Jul 2017 11:42:03 +0200
MIME-Version: 1.0
In-Reply-To: <1499438577-7674-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/11] include/hw/boards.h: Document
 memory_region_allocate_system_memory()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>



On 07/07/2017 16:42, Peter Maydell wrote:
> + * Memory allocated via this function will be backed with the memory
> + * backend the user provided using -mem-path if appropriate

I'd change it to

using "-mem-path" or "-numa node,memdev=...".

Paolo

> ; this
> + * is typically used to cause host huge pages to be used.
> + * This function should therefore be called by a board exactly once,
> + * for the primary or largest RAM area it implements.
