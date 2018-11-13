Received: from eggs.gnu.org ([2001:4830:134:3::10]:47673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMZYf-00057L-J2
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:20:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gMZYe-00034L-O7
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 09:20:49 -0500
References: <20181109221213.7310-1-crosa@redhat.com>
	<20181112104953.GB11580@linux.fritz.box>
	<f1c27ed2-9aba-edaf-2c49-ff565a0847ce@redhat.com>
	<20181112160025.GE11580@linux.fritz.box>
	<b51dd4e4-e814-db42-86be-698c0d87f8ef@redhat.com>
	<20181113121836.GC4830@localhost.localdomain>
	<20181113132653.GG12503@habkost.net>
	<20181113135116.GE4830@localhost.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <a596c3a8-9099-391d-f418-4600e0e614f0@redhat.com>
Date: Tue, 13 Nov 2018 09:20:11 -0500
MIME-Version: 1.0
In-Reply-To: <20181113135116.GE4830@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Caio Carrara <ccarrara@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>



On 11/13/18 8:51 AM, Kevin Wolf wrote:
> Am 13.11.2018 um 14:26 hat Eduardo Habkost geschrieben:
>> On Tue, Nov 13, 2018 at 01:18:36PM +0100, Kevin Wolf wrote:
>> [...]
>>> Anyway, one specific concern about the "simple way" I have is that we're
>>> adding a hard dependency on an external package (Avocado) that isn't
>>> usually installed anyway on developer machines. Maintainers will of
>>> course just install it. But will this reduce the amount of tests that
>>> contributors run, and increase the amount of untested patches on the
>>> mailing list?
>>>
>>> Maybe we can keep a simple in-tree runner like ./check that doesn't have
>>> any external dependencies and runs all of those tests that don't make
>>> use of Avocado utility functions etc.? And you'd use Avocado when you
>>> want to run all tests or use advanced test harness options.
>>
>> What problems you are trying to address here, exactly?
>>
>> If you don't have Avocado installed in your system, all you need
>> is Python 3, an internet connection, and the ability to type
>> "make check-acceptance" on your keyboard.
> 
> Thanks, didn't know that one. Apparently you don't only need to have
> Python 3 available on the system, but also explicitly use it for
> ./configure?
> 
>     $ LANG=C make check-acceptance
>     /home/kwolf/source/qemu/tests/Makefile.include:930: *** "venv directory for tests requires Python 3".  Stop.
> 
> While this doesn't make the tests available automatically for everyone,
> we'll get there when we finally make Python 3 the default (hopefully
> soon), which is already a lot better than what docs/devel/testing.rst
> promises:
> 
>     These tests are written using the Avocado Testing Framework (which
>     must be installed separately) [...]
> 
> Maybe time to update the docs to match the improved situation? :-)
> 
> Kevin
> 

The docs were updated when "make check-acceptance" was used.  That
sentence is still true, Avocado must be installed separately, it's just
that "check-venv", used by "check-acceptance" does just that.

It's documented as:

Running tests
-------------

You can run the acceptance tests simply by executing:

.. code::

  make check-acceptance

- Cleber.
