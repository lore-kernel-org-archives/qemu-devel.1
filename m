Received: from eggs.gnu.org ([2001:4830:134:3::10]:51091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gCpFn-0002GW-ID
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ccarrara@redhat.com>) id 1gCpFd-00070A-RN
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:04:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ccarrara@redhat.com>) id 1gCpFb-0006w6-TB
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 13:04:52 -0400
Reply-To: ccarrara@redhat.com
References: <20181017160539.12316-1-crosa@redhat.com>
From: Caio Carrara <ccarrara@redhat.com>
Message-ID: <1c3df15f-c3d5-d638-cd33-fa05bfbbd516@redhat.com>
Date: Wed, 17 Oct 2018 14:04:35 -0300
MIME-Version: 1.0
In-Reply-To: <20181017160539.12316-1-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 0/3] Bootstrap Python venv and
 acceptance/functional tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 17-10-2018 13:05, Cleber Rosa wrote:
> TL;DR
> =====
> 
> Allow acceptance tests to be run with `make check-acceptance`.
> 
> Details
> =======
> 
> This introduces a Python virtual environment that will be setup within
> the QEMU build directory, that will contain the exact environment that
> tests may require.
> 
> There's one current caveat: it requires Python 3, as it's based on the
> venv module.  This was based on some discussions and perception about
> standardizing on Python 3, but can easily be made to accommodate Python
> 2 as well.
> (...)

Reviewed-by: Caio Carrara <ccarrara@redhat.com>

-- 
Caio Carrara
Software Engineer, Virt Team
Red Hat
ccarrara@redhat.com
