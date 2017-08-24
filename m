Received: from eggs.gnu.org ([2001:4830:134:3::10]:60686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkrZd-0005VG-VM
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkrZa-0000xq-TR
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:49:26 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkrZa-0000xh-OW
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:49:22 -0400
Received: by mail-qt0-x242.google.com with SMTP id s11so2035242qtk.0
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 05:49:22 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170818142613.32394-1-ldoktor@redhat.com>
	<f8f1684a-0684-7261-57c3-63aa58892000@redhat.com>
	<87bmn8qd3z.fsf@dusky.pond.sub.org>
	<c560b757-6bb1-2ded-a25b-193e5f9318c2@amsat.org>
	<20170822190709.GJ19998@localhost.localdomain>
	<20170824121558.GB28021@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7e6005a3-205a-93d0-9baa-17d8dbdbe75a@amsat.org>
Date: Thu, 24 Aug 2017 09:49:17 -0300
MIME-Version: 1.0
In-Reply-To: <20170824121558.GB28021@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 00/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com, apahim@redhat.com, mreitz@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 08/24/2017 09:15 AM, Stefan Hajnoczi wrote:
> On Tue, Aug 22, 2017 at 04:07:09PM -0300, Eduardo Habkost wrote:
>> (CCing Cleber and Stefan)
>>
>> On Tue, Aug 22, 2017 at 07:19:45AM -0300, Philippe Mathieu-Daudé wrote:
>> [...]
>>> Can we predict how the python scripts will evolve? Only fast-testing?
>>>
>>
>> I guess it depends on how you define "fast".  Does "fast-testing"
>> include a full device-crash-test run (that could take ~30
>> minutes) or the full set of iotests?
>>
>>
>>> Is there some users hacking on qemu.py unaware they can/should use
>>> libvirt-python?
>>
>> I believe the existing users of qemu.py wouldn't want to have
>> dependencies on libvirt or other external modules (e.g. code that
>> test specific QMP commands and/or is run by "make check").
> 
> Yes, most QEMU tests interact with QEMU at a lower level than the
> libvirt API.  They may exercise new features that are not available via
> libvirt so we'd end up bypassing it anyway.

good point,

> It is easier to debug a test case that interacts directly with QEMU.
> Investigating a failed test where libvirt is involved is more
> time-consuming.

another good point.

> 
> libvirt and tools built on it, like virt-builder, are good for tests
> that need a fully-fledged operating system inside the guest.  Avocado
> Virt is aimed at higher-level tests involving guests too:
> https://avocado-virt.readthedocs.io/en/latest/WritingTests.html
> 
> Stefan
> 
