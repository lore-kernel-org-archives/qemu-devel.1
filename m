Received: from eggs.gnu.org ([2001:4830:134:3::10]:50339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLAFK-0003T8-HK
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:07:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gLAFF-0005wC-WE
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:07:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1gLAFF-0005vq-PA
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 12:06:57 -0500
References: <20181109153002.597-1-crosa@redhat.com>
	<20181109153002.597-2-crosa@redhat.com>
	<CAFEAcA8-Av_d7A0GEQGfkdC90N41or=vni480k=4dO2daXkdZQ@mail.gmail.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <88024cb3-2248-fa6b-4bc9-2926a798b15c@redhat.com>
Date: Fri, 9 Nov 2018 12:06:47 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8-Av_d7A0GEQGfkdC90N41or=vni480k=4dO2daXkdZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/2] tests/test-qht-par: test gets
 stuck intermittently on OSX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, G 3 <programmingkidx@gmail.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>



On 11/9/18 10:34 AM, Peter Maydell wrote:
> On 9 November 2018 at 15:30, Cleber Rosa <crosa@redhat.com> wrote:
>> To be fully honest, this may not be a OSX (alone) condition, but may
>> be a situation that only happens with OSX on Travis-CI, were resources
>> are quite limited.
>>
>> I have personal experience with tests that exercise parallelism or
>> depend on timing to fail on Travis.  Because I'm not 100% certain that
>> this is a situation that only happens with OSX on Travis-CI, and
>> because I'm not certain that we should be skipping tests because
>> they're running on Travis-CI, let's disable them on OSX as a whole.
> 
> Does this test still get stuck in builds after a458774ad711bceabefb ?
> That fixed an OSX-specific problem that caused hangs (notably
> in test-bdrv-drain, but it could I guess also affect other tests).
> 

It didn't get stuck here:

https://travis-ci.org/clebergnu/qemu/jobs/452663111

So I believe that was the common issue indeed.  Thanks for pointing that
out.  Also, the other patch in this series also seems to be unnecessary now.

- Cleber.

> thanks
> -- PMM
> 
