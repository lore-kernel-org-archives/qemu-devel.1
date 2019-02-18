Received: from eggs.gnu.org ([209.51.188.92]:59993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gvn8b-0006O3-Ao
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:55:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gvn8a-0003iq-Fy
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:55:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:63977)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gvn8Z-0003hA-5J
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 12:55:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DC9862D802
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 17:55:25 +0000 (UTC)
References: <20190212193855.13223-1-ccarrara@redhat.com>
	<20190212193855.13223-2-ccarrara@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <bc4bb11c-cb07-bfcc-3727-812312294229@redhat.com>
Date: Mon, 18 Feb 2019 12:55:24 -0500
MIME-Version: 1.0
In-Reply-To: <20190212193855.13223-2-ccarrara@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/2] tests.acceptance: adds multi vm
 capability for acceptance tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Caio Carrara <ccarrara@redhat.com>, qemu-devel@nongnu.org



On 2/12/19 2:38 PM, Caio Carrara wrote:
> This change adds the possibility to write acceptance tests with multi
> virtual machine support. It's done keeping the virtual machines objects
> stored in a test attribute (dictionary). This dictionary shouldn't be
> accessed directly but through the new method added `get_vm`. This new
> method accept a list of args (that will be added as virtual machine
> arguments) and an optional name argument. The name is the key that
> identify a single virtual machine along the test machines available. If
> a name without a machine is informed a new machine will be instantiated.
> 
> The current usage of vm in tests will not be broken by this change since
> it keeps a property called vm in the base test class. This property only
> calls the new method `get_vm` with default parameters (no args and
> 'default' as machine name).
> 
> Signed-off-by: Caio Carrara <ccarrara@redhat.com>


Reviewed-by: Cleber Rosa <crosa@redhat.com>
