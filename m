Received: from eggs.gnu.org ([2001:4830:134:3::10]:51748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXfmq-0005TE-VN
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 00:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fXfmn-0007rd-SR
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 00:41:05 -0400
References: <20180613151942.GC19901@redhat.com>
	<87k1r24quk.fsf@dusky.pond.sub.org>
	<20180619171539.0adc90d6.cohuck@redhat.com>
	<d4e02083-c372-3ce5-d4a2-4809579fc8f2@redhat.com>
	<20180622181108.GY7451@localhost.localdomain>
	<c10c2ffa-7ee2-5106-07d1-528df939d6ad@redhat.com>
	<20180622193522.GI7451@localhost.localdomain>
	<743d495e-51cd-8c8e-293e-026b8dece74a@redhat.com>
	<87lgb3xsv8.fsf@dusky.pond.sub.org>
	<4292432f-5f26-6925-4c14-ad1370e36e5b@redhat.com>
	<20180625173056.GM7451@localhost.localdomain>
	<97504b42-9ebe-45c5-6ff3-b43102c8374a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <54dfe708-cccf-c628-753f-692c83391ec4@redhat.com>
Date: Tue, 26 Jun 2018 06:40:56 +0200
MIME-Version: 1.0
In-Reply-To: <97504b42-9ebe-45c5-6ff3-b43102c8374a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, zhang.zhanghailiang@huawei.com, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 25.06.2018 20:26, Paolo Bonzini wrote:
> On 25/06/2018 19:30, Eduardo Habkost wrote:
>>>> Attentive distros could even replace the wrapper script by a link.
>>> If they are okay with replacing the "KVM only" semantics with "KVM or
>>> TCG", which I think is generally worse.
>>
>> If we can't get agreement on what's the right default for each
>> QEMU binary, I think that's yet another reason to document that
>> upstream QEMU won't guarantee ABI compatibility if -accel is
>> omitted.
>=20
> Before that we should ask what the benefit is in changing the default
> for qemu-system-*.  Nobody is using it in practice to start QEMU with
> KVM enabled...

That's certainly not true. I've seen a couple of times already that
people ask on IRC why their guests are running so slow, and if you ask
them about their command line, it's obvious that they simply were not
aware of "-accel" / "-enable-kvm" yet.

<semi-sarcastic>
Maybe we simply should add a "--verbose" command line option that people
can use to diagnose their problems:

$ qemu-system-x86_64 --verbose
QEMU emulator version 2.12.50
Using 'tcg' accelerator. Use '-accel kvm' to speed things up.
Machine type is 'pc-i440fx-3.0'. Use 'q35' for a more modern machine.
....
</semi-sarcastic>

 Cheers,
  Thomas
