Received: from eggs.gnu.org ([2001:4830:134:3::10]:53507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gBeki-0002Gr-19
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 07:40:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gBekh-0000QD-4O
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 07:40:07 -0400
References: <20181013050227.17022-1-ehabkost@redhat.com>
	<219bba9b-4102-f838-a46f-11b9704ca78f@redhat.com>
	<20181013203607.GL31060@habkost.net>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0547ccec-6b85-a03f-88e3-74baa5ab4273@redhat.com>
Date: Sun, 14 Oct 2018 13:39:44 +0200
MIME-Version: 1.0
In-Reply-To: <20181013203607.GL31060@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] Require Python 3 for building QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 13.10.18 22:36, Eduardo Habkost wrote:
> On Sat, Oct 13, 2018 at 08:20:25PM +0200, Max Reitz wrote:
>> On 13.10.18 07:02, Eduardo Habkost wrote:
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>> I'd like to do this in QEMU 3.1.  I think it's time to drop
>>> support for old systems that have only Python 2.
>>>
>>> We still have a few scripts that are not required for building
>>> QEMU that still work only with Python 2 (iotests being the most
>>> relevant set).  Requiring Python 3 for building QEMU won't
>>> prevent people from using those scripts with Python 2 until they
>>> are finally ported.
>>
>> It very much does because the iotests specifically use the python path
>> qemu was configured with.
>>
>> To fix this, configure would need to write something else for into
>> tests/qemu-iotests/common.env for $PYTHON.  But what?  I don't really
>> want to introduce a new configure option for this.
> 
> What's wrong with '/usr/bin/env python2' and just using the
> python2 binary from $PATH?  Why do we need to make the Python
> interpreter path for iotests configurable?

Nothing, sounds good.  No idea why I discarded that idea.

>> So the real fix is indeed to make the iotests work with Python 3, and I
>> think that needs to be done before we can require Python 3.  Maybe it
>> even needs to be done at the same time.
> 
> I agree that this would be even better.  I just don't think the
> pending iotest porting should force all the rest of the build
> scripts to be compatible with Python 2.

True.  It just means that we have to do something about the iotests
before this patch can be merged.

Max
