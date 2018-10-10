Received: from eggs.gnu.org ([2001:4830:134:3::10]:50745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gACD5-0000ug-8x
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:59:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gACCz-0007Yg-EO
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:59:21 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gACCy-0007Y7-Ck
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:59:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id e187-v6so5273526wmf.0
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 03:59:16 -0700 (PDT)
References: <20181009232607.15521-1-crosa@redhat.com>
	<20181009232607.15521-7-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <30d6b2fa-c529-6eb1-f9a0-476c390c5156@redhat.com>
Date: Wed, 10 Oct 2018 12:59:12 +0200
MIME-Version: 1.0
In-Reply-To: <20181009232607.15521-7-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/7] Acceptance Tests: add variants
 definition for architectures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laszlo Ersek <lersek@redhat.com>

On 10/10/2018 01:26, Cleber Rosa wrote:
> One of the Avocado features relevant to virtualization testing is the
> ability to reuse tests in different scenarios, known as variants.
> This adds a JSON based variants file, that can be used to run most
> tests in a number of different architectures.  It can be run with:
> 
>    $ avocado run \
>      --json-variants-load=tests/acceptance/variants/arch.json \
>      --filter-by-tags='-x86_64' -- tests/acceptance/
> 
> Currently this covers 5 architectures, resulting in the execution
> of 25 different combinations.

IMHO we should add this file with all supported archs, and CANCEL a job
if there is no preferred machine in Qemu::MACHINE_TYPES.

> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  tests/acceptance/variants/arch.json | 92 +++++++++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 tests/acceptance/variants/arch.json
