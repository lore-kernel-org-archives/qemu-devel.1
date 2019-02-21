Received: from eggs.gnu.org ([209.51.188.92]:43587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gwp75-0003mG-LD
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:14:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gwp75-0007N3-0t
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:14:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gwp74-0007ML-Q2
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:14:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 40E2A59462
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 14:14:09 +0000 (UTC)
References: <20190212193855.13223-1-ccarrara@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <5347c372-464f-763c-ddf4-56484c489247@redhat.com>
Date: Thu, 21 Feb 2019 11:14:02 -0300
MIME-Version: 1.0
In-Reply-To: <20190212193855.13223-1-ccarrara@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v3 0/2] tests.acceptance: adds multi vm
 capability and basic migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Caio Carrara <ccarrara@redhat.com>, qemu-devel@nongnu.org


On 02/12/2019 05:38 PM, Caio Carrara wrote:
> This is the third attempt to add the multi vm capability to base class
> of acceptance tests.
>
> The difference from first version is that in this current version a
> simple migration test was added (done by Cleber) so the new code that is
> being added is properly used and we're not adding "new dead code".
>
> The difference from the second version is that in this current version
> the migration test being added was updated based on last reviews. It was
> added more status to consider the migration as finished and also
> assertions was added to check the migration success.

The new implementation of the migration test is very good IMHO.

>
> There are more tests and test cases that can be added, but I'm assuming
> this patch is complete enough and other series can be sent after
> covering the other cases.
>
> Caio Carrara (2):
>    tests.acceptance: adds multi vm capability for acceptance tests
>    tests.acceptance: adds simple migration test
>
>   docs/devel/testing.rst                    | 41 +++++++++++++++++-
>   tests/acceptance/avocado_qemu/__init__.py | 25 +++++++++--
>   tests/acceptance/migration.py             | 53 +++++++++++++++++++++++
>   3 files changed, 114 insertions(+), 5 deletions(-)
>   create mode 100644 tests/acceptance/migration.py
>

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
