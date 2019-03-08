Received: from eggs.gnu.org ([209.51.188.92]:56692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h23aj-0001Hn-FH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:42:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h23ah-0004P8-Gw
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:42:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h23ag-0004MU-LT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 19:42:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id w2so19527666wrt.11
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 16:42:20 -0800 (PST)
References: <20190307152450.20340-1-peter.maydell@linaro.org>
	<CAFEAcA-M7vo-rF=njSjdKiA85-2d4y=8B+otTdzDnuX=1h4Cnw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e655f84b-f033-539f-4c63-87b5e6260ebc@redhat.com>
Date: Fri, 8 Mar 2019 01:42:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-M7vo-rF=njSjdKiA85-2d4y=8B+otTdzDnuX=1h4Cnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/12] sphinx queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 3/7/19 5:12 PM, Peter Maydell wrote:
> On Thu, 7 Mar 2019 at 15:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> The only difference from the v3 patchset is that I've
>> changed a -d to -e in patch 10 as suggested by RTH.
>>
>> thanks
>> -- PMM
>>
>> The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65e2:
>>
>>   Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-03-06 18:52:19 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-sphinx-20190307
>>
>> for you to fetch changes up to c10e01b996df09f6cb4eceb2b7a9754bece927c9:
>>
>>   MAINTAINERS: Add entry for Sphinx documentation infrastructure (2019-03-07 14:26:47 +0000)
>>
>> ----------------------------------------------------------------
>> Enable building and installing rST docs with Sphinx
>>
>> ---------------------------------------------------------------
> 
> Applied, thanks.

I'm getting:

./configure --enable-tools --enable-doc
[...]
  GEN     qga/qapi-generated/qapi-gen
  GEN     docs/qemu-block-drivers.7
  GEN     docs/qemu-cpu-models.7
  SPHINX  docs/devel
  SPHINX  docs/interop
  CC      qapi/qapi-visit-core.o
Error: source directory and destination directory are same.
Error: source directory and destination directory are same.
Makefile:880: recipe for target 'docs/interop/index.html' failed
make: *** [docs/interop/index.html] Error 1
make: *** Waiting for unfinished jobs....
Makefile:877: recipe for target 'docs/devel/index.html' failed
make: *** [docs/devel/index.html] Error 1
The command "make -j3 && ${TEST_CMD}" exited with 2.

Is it due to the '-j3'?

See: https://travis-ci.org/philmd/qemu/jobs/503343244
