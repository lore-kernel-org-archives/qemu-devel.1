Received: from eggs.gnu.org ([2001:4830:134:3::10]:42795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4Uqp-0001WB-UV
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e4Uqn-00022Z-9U
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 12:36:20 -0400
References: <1508247148-25240-1-git-send-email-thuth@redhat.com>
	<19010e69-6abe-0888-24a9-903ca4017355@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <09194092-7fa7-e640-7208-49fa270fd497@redhat.com>
Date: Tue, 17 Oct 2017 18:36:08 +0200
MIME-Version: 1.0
In-Reply-To: <19010e69-6abe-0888-24a9-903ca4017355@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/4] Improve the CPU hot plug
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-s390x@nongnu.org, david@redhat.com, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>

On 17.10.2017 18:27, Daniel Henrique Barboza wrote:
>=20
>=20
> On 10/17/2017 11:32 AM, Thomas Huth wrote:
>> So far the CPU hot-plug qtest was only checking "cpu-add" on x86. With
>> these patches, we now test "device_add" for hot-plugging CPUs on x86,
>> and enable the test on ppc64 and s390x, too.
>=20
> Question: is there a reason other than "no one bothered" to not have a
> CPU hot
> unplug test, something around the lines of the now cpu-plug-test.c? I m=
ight
> give it a shot if there is no known roadblocks against it.

AFAIK on x86, you need some ACPI magic on the guest side to do this
(something similar to qpci_unplug_acpi_device_test() in
tests/libqos/pci-pc.c I guess). And on s390x, CPU unplug is not
supported at all. But it might work on ppc64 without guest intervention,
not sure - maybe Bharata can comment on this...

 Thomas
