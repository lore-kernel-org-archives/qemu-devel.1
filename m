Received: from eggs.gnu.org ([2001:4830:134:3::10]:46297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMGRF-0002Qs-Ca
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:56:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMGB1-0001gR-EP
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:39:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gMGAz-0001fc-GF
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:39:05 -0500
References: <20181109150710.31085-1-crosa@redhat.com>
	<20181109150710.31085-4-crosa@redhat.com>
	<20181112162337.GK12503@habkost.net>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <2e413d57-0f3b-6c63-1e03-02ff0d456268@redhat.com>
Date: Mon, 12 Nov 2018 12:38:53 -0500
MIME-Version: 1.0
In-Reply-To: <20181112162337.GK12503@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] Travis CI: make specified Python
 versions usable on jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>



On 11/12/18 11:23 AM, Eduardo Habkost wrote:
> On Fri, Nov 09, 2018 at 10:07:09AM -0500, Cleber Rosa wrote:
>> For the two Python jobs, which seem to have the goal of making sure
>> QEMU builds successfully on the 3.0-3.6 spectrum of Python 3 versions,
>> the specified version is only applicable if a Python virtual
>> environment is used.  To do that, it's necessary to define the
>> (primary?) language of the job to be Python.
>>
>> Also, Travis doesn't have a 3.0 Python installation available for the
>> chosen distro, 3.2 being the lower version available.
>>
>> Reference: https://docs.travis-ci.com/user/languages/python/#specifying-python-versions
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> 
> This doesn't depend on patches 1 and 2, right?
> 

No, it doesn't.

> The rest of the series will wait for the next release, but this
> looks like something we want to merge before QEMU 3.1.
> 

Sounds good!

- Cleber.
