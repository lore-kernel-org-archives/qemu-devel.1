Received: from eggs.gnu.org ([2001:4830:134:3::10]:60598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fXgyj-0007uC-C9
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 01:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fXgyg-0006VN-6s
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 01:57:25 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180619171539.0adc90d6.cohuck@redhat.com>
	<d4e02083-c372-3ce5-d4a2-4809579fc8f2@redhat.com>
	<20180622181108.GY7451@localhost.localdomain>
	<c10c2ffa-7ee2-5106-07d1-528df939d6ad@redhat.com>
	<20180622193522.GI7451@localhost.localdomain>
	<743d495e-51cd-8c8e-293e-026b8dece74a@redhat.com>
	<87lgb3xsv8.fsf@dusky.pond.sub.org>
	<4292432f-5f26-6925-4c14-ad1370e36e5b@redhat.com>
	<20180625173056.GM7451@localhost.localdomain>
	<97504b42-9ebe-45c5-6ff3-b43102c8374a@redhat.com>
	<20180625195126.GN7451@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a931e759-879b-6f6b-3524-4b5a78fed323@redhat.com>
Date: Tue, 26 Jun 2018 07:57:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180625195126.GN7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 4/4] qemu-options: Do not show
 -enable-kvm and -enable-hax in the docs anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, zhang.zhanghailiang@huawei.com, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 25/06/2018 21:51, Eduardo Habkost wrote:
>> Before that we should ask what the benefit is in changing the default
>> for qemu-system-*.  Nobody is using it in practice to start QEMU with
>> KVM enabled...
>
> How can you be sure?  If qemu-system-* is installed with KVM
> compiled in, libvirt will probe it using
> "-machine none,accel=kvm:tcg" and run the VM using
> "-machine $MACHINE,accel=kvm".

Right, that needs to be qualified with "without libvirt".

> In either case, I'm not arguing (yet) for changing the default
> upstream.  I'm just arguing for upstream QEMU to not make any
> promises about the default.

It would be a guest ABI breakage for TCG guests, so it would only apply
to new machine types.  I don't think it's worth the complication.

BTW, another thing that needs documenting is ABI promises for HAX and
WHPX.  Both do not support -cpu in any meaningful way, at least WHPX
installs a migration blocker.

Paolo
