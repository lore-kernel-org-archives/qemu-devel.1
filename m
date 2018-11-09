Received: from eggs.gnu.org ([2001:4830:134:3::10]:55557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLCoX-0005R0-Fp
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLCoQ-0004WZ-C1
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:51:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gLCoP-0004UK-3b
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 14:51:25 -0500
References: <20181109150710.31085-1-crosa@redhat.com>
	<20181109150710.31085-2-crosa@redhat.com>
	<20181109154908.GW12503@habkost.net>
	<2426066f-37b0-acb8-f5f9-02fec9b6d7fa@redhat.com>
	<20181109182501.GY12503@habkost.net>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <962bd7a4-98b4-1015-8c8a-39aaa368f1bd@redhat.com>
Date: Fri, 9 Nov 2018 14:51:11 -0500
MIME-Version: 1.0
In-Reply-To: <20181109182501.GY12503@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] configure: keep track of Python version
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



On 11/9/18 1:25 PM, Eduardo Habkost wrote:
>>
>> "Python -V" is quite different from "sys.version".  Indeed it includes
>> the "Python " prefix, but that's all, everything else is the version number.
> 
> Is this a guarantee documented somewhere?
> 

Oops, looks like I missed that comment, and failed to address it.  Now,
I must say I don't expect a documented guarantee about this will exist,
but it looks like this is an acknowledged use case:

https://bugs.python.org/issue18338

- Cleber.
