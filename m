Received: from eggs.gnu.org ([2001:4830:134:3::10]:46242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMDhb-0001Bh-ML
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:00:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMDhN-0003Pf-Pe
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 10:00:28 -0500
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181112104953.GB11580@linux.fritz.box>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
Date: Mon, 12 Nov 2018 09:59:56 -0500
MIME-Version: 1.0
In-Reply-To: <20181112104953.GB11580@linux.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] Acceptance tests for qemu-img
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


On 11/12/18 5:49 AM, Kevin Wolf wrote:
> Am 09.11.2018 um 23:12 hat Cleber Rosa geschrieben:
>> The initial goal of this RFC is to get feedback on tests not specific
>> to the QEMU main binary, but specific to other components such as
>> qemu-img.
>>
>> For this experiment, a small issue with the zero and negative number
>> of I/O operations given to the bench command was chosen.
> 
> Any reason why this shouldn't be in qemu-iotests?
> 
> Kevin
> 

Hi Kevin,

This is indeed one of the comments I was expecting to receive.  AFAIK,
there's nothing that prevents such a *simple* test to be written as a
qemu-iotest.

Having said that, one of the things we're trying to achieve with
"tests/acceptance" is that a individual developer or maintainer, should
be able to run a subset of tests that he/she cares about.

Suppose that this developer is working on a "snapshot" related feature,
and wants to run tests that cover both "qemu-img snapshot" and then
tests interacting with a guest running on a snapshotted image.  By using
the tags mechanism, one could run:

 $ avocado run -t snapshot tests/acceptance

And run all tests related to snapshot.  This is one of the reasons for
maybe allowing the type of test proposed here to live under
"tests/acceptance".  Others include:

 * No numbering conflicts when naming tests
 * More descriptive tests names and metadata
 * No "context switch" for people also writing acceptance tests
 * The various utility APIs available in both the Test class and on
avocado.utils

BTW, since most tests Today exist outside of "tests/acceptance", that
may be also be solved in a great part by adding support in the (Avocado)
test runner about some metadata in tests such qemu-iotests.

Cheers,
- Cleber.
