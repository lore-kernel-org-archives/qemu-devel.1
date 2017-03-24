Received: from eggs.gnu.org ([2001:4830:134:3::10]:55786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1crOXs-0002As-Ud
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1crOXr-0006Xn-Ni
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:42:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1crOXr-0006Xc-HD
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 08:42:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8656C7E9FA
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 12:42:19 +0000 (UTC)
References: <20170322160052.2820-1-ehabkost@redhat.com>
	<20170322191305.GO2811@thinpad.lan.raisama.net>
	<38285f0d-bcb3-e0cd-6bf7-037e81f07b0f@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <303f2a85-a209-6279-0c44-ecc5ffe2d4e3@redhat.com>
Date: Fri, 24 Mar 2017 15:42:16 +0300
MIME-Version: 1.0
In-Reply-To: <38285f0d-bcb3-e0cd-6bf7-037e81f07b0f@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] script for crash-testing -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 03/23/2017 05:43 PM, Thomas Huth wrote:
> On 22.03.2017 20:13, Eduardo Habkost wrote:
>> On Wed, Mar 22, 2017 at 01:00:49PM -0300, Eduardo Habkost wrote:
>>> This series adds scripts/device-crashtest.py, that can be used to
>>> crash-test -device with multiple machine/accel/device
>>> combinations.
>>>
>>> The script found a few crashes on some machines/devices. A dump
>>> of existing cases can be seen here:
>>>   https://gist.github.com/ehabkost/503b0af0375f0d98d3e84017e8ca54eb
>>>
>>> The script contains a whitelist that can also be useful as
>>> documentation of existing ways -device can fail or crash.
>>>
>>> Note that the script takes a few hours to run on the default mode
>>> (testing all accel/machine/device combinations), but the "-r N"
>>> option can be used to make it only test N random samples.
>
> Wow, impressive script, that must have been a lot of work 'til you've
> got it in a usable shape with that huge whitelist!
>

+1

Great work Eduardo, thanks!

>> Something I forgot to mention: I would like to run some subset of
>> these tests on "make check", but I don't know how we could choose
>> that subset. We could run, e.g., 100 random samples, but I am not
>> sure we really want to make "make check" non-deterministic.
>
> Maybe limit the tests to the devices that have a high chance to work on
> different machines? ... that means primarily PCI, ISA and USB devices, I
> guess.
>

Is hard to maintain that list, it will miss new devices and so on.
We should have a "nightly" run or something, but still, maintaining
the white list of known errors is still problematic.

Thanks,
Marcel

>  Thomas
>
