Received: from eggs.gnu.org ([2001:4830:134:3::10]:59434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9wOx-0001ds-Jr
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:06:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9wOu-0004rw-8u
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:06:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:23160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g9wOu-0004rI-01
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 14:06:32 -0400
References: <20181009175740.13812-1-crosa@redhat.com>
	<20181009175740.13812-2-crosa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d5b4735-ccbd-dc8e-7f64-3f85ed58183c@redhat.com>
Date: Tue, 9 Oct 2018 13:06:22 -0500
MIME-Version: 1.0
In-Reply-To: <20181009175740.13812-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/3] Bootstrap Python venv for tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <pmathieu@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 10/9/18 12:57 PM, Cleber Rosa wrote:
> A number of QEMU tests are written in Python, and may benefit
> from an untainted Python venv.
> 
> By using make rules, tests that depend on specific Python libs
> can set that rule as a requiment, along with rules that require

s/requiment/requirement/

> the presence or installation of specific libraries.
> 
> The tests/venv-requirements.txt is supposed to contain the
> Python requirements that should be added to the venv created
> by check-venv.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
