Received: from eggs.gnu.org ([209.51.188.92]:47124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJJ6u-0003qi-Dq
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJJ6t-0001lA-Ac
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:42:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJJ6t-0001k3-2e
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:42:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id f7so2949773wrs.2
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 07:42:54 -0700 (PDT)
References: <20190424103747.10173-1-thuth@redhat.com>
	<20190424103747.10173-4-thuth@redhat.com>
	<167b6b7c-3fef-47e8-d30d-09abfe1e50ba@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <04383486-acc8-f07e-e6be-63cb654be25c@redhat.com>
Date: Wed, 24 Apr 2019 16:42:51 +0200
MIME-Version: 1.0
In-Reply-To: <167b6b7c-3fef-47e8-d30d-09abfe1e50ba@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/6] tests/qemu-iotests: Do not hard-code
 the path to bash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>, qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>

On 4/24/19 4:14 PM, Eric Blake wrote:
> On 4/24/19 5:37 AM, Thomas Huth wrote:
>> bash is installed in a different directory on non-Linux systems like
>> FreeBSD. Do not hard-code /bin/bash here so that the tests can run
>> there, too.
> 
> These tests were obviously copy-and-pasted from a fork point prior to
> commit 11a82d14.

:(

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qemu-iotests/239 | 2 +-
>>  tests/qemu-iotests/240 | 2 +-
>>  tests/qemu-iotests/241 | 2 +-
>>  tests/qemu-iotests/243 | 2 +-
>>  tests/qemu-iotests/244 | 2 +-
>>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> 
