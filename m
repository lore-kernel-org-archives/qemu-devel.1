Received: from eggs.gnu.org ([2001:4830:134:3::10]:44700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePW0v-0005SA-Al
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ePW0p-0007kh-8F
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:05:37 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20171213213557.26561-1-f4bug@amsat.org>
	<20171214093907.GA14433@stefanha-x1.localdomain>
	<d4d649fc-4bb2-9b61-7e48-46a6a51e7b01@redhat.com>
	<CAMr-obuvJ4z54e0evM+J98jsdRayL-UeA_WDQVp0rx=sRoTVgw@mail.gmail.com>
Date: Thu, 14 Dec 2017 17:05:03 +0100
In-Reply-To: <CAMr-obuvJ4z54e0evM+J98jsdRayL-UeA_WDQVp0rx=sRoTVgw@mail.gmail.com>
	(Nir Soffer's message of "Thu, 14 Dec 2017 15:39:12 +0000")
Message-ID: <874lotwb0w.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/6] QTests: use Python to run
 complex tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nir Soffer <nirsof@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, =?utf-8?B?THVr?= =?utf-8?B?w6HFoQ==?= Doktor <ldoktor@redhat.com>, =?utf-8?Q?Marc-Andr?= =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Max Reitz <mreitz@redhat.com>

Nir Soffer <nirsof@gmail.com> writes:

> On Thu, Dec 14, 2017 at 1:36 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
>> On 14/12/2017 10:39, Stefan Hajnoczi wrote:
>> >>             # verify Card ID
>> >>             data = self.bus.do_cmd(ALL_SEND_CID)
>> >>             oid, pnm, psn = struct.unpack(">x2s5sxLxxx", data)
>> >>             self.assertEqual(oid, "XY") # QEMU default
>> >>             self.assertEqual(pnm, "QEMU!") # QEMU default
>> >>             self.assertEqual(psn, 0xdeadbeef) # QEMU default
>> > Device qtests are better done in C than Python.  Python is not good at
>> > binary I/O and porting this to Python 3 will be extra work later (Python
>> > 2 is set for End-of-Life in 2020, see https://pythonclock.org/).
>> >
>> > More importantly, we already have libqos in C with a guest memory
>> > allocator, PCI, and virtio support.  Fragmenting the small amount effort
>> > that goes into device testing will delay libqos reaching critical mass.
>> > Critical mass is where libqos provides all the infrastructure you need
>> > to set up a device and focus on your actual test instead of machine,
>> > bus, or device initialization.  Starting a Python device testing effort
>> > will just lead to duplication and 2 underdeveloped device testing
>> > frameworks.
>>
>> I agree that fragmentation is bad.  However, libqos is small (about 4k
>> lines of code, maybe 3k in Python).
>>
>> I also agree that any qtest written in Python should be written in
>> Python 3 from the beginning (in fact we should consider dropping Python
>> 2.x support in 2.12).  Doing so should not make binary I/O much
>> different than C.
>>
>
> Using python 3 will make it hard to develop and test qemu on RHEL/CentOS
> which do not provide python 3 yet.

s/hard/slightly inconvenient/: Python 3 is available in EPEL.  

> Doing binary io in python 2 and 3 is the same, there is no need to use
> python 3 for this. The only advantage is not having to backport code
> later from 2 to 3.
