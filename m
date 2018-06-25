Received: from eggs.gnu.org ([2001:4830:134:3::10]:33750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXLKF-0001ek-6U
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:50:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fXLKB-0002YH-WB
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 02:50:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1528866321-23886-5-git-send-email-thuth@redhat.com>
	<20180613133840.GK24528@stefanha-x1.localdomain>
	<20180613134452.GU19901@redhat.com>
	<b0ebd968-797f-48e0-32c1-869c452feca9@redhat.com>
	<20180613151942.GC19901@redhat.com>
	<87k1r24quk.fsf@dusky.pond.sub.org>
	<20180619171539.0adc90d6.cohuck@redhat.com>
	<d4e02083-c372-3ce5-d4a2-4809579fc8f2@redhat.com>
	<20180622181108.GY7451@localhost.localdomain>
	<c10c2ffa-7ee2-5106-07d1-528df939d6ad@redhat.com>
	<20180622193522.GI7451@localhost.localdomain>
	<743d495e-51cd-8c8e-293e-026b8dece74a@redhat.com>
Date: Mon, 25 Jun 2018 08:50:03 +0200
In-Reply-To: <743d495e-51cd-8c8e-293e-026b8dece74a@redhat.com> (Paolo
	Bonzini's message of "Fri, 22 Jun 2018 23:22:43 +0200")
Message-ID: <87lgb3xsv8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Thomas Huth <thuth@redhat.com>, zhang.zhanghailiang@huawei.com, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 22/06/2018 21:35, Eduardo Habkost wrote:
>>>> Why is this better than using KVM by default if it's available?
>>> The answer is (as almost always): Compatibility with migration. Nobody
>>> dares to sacrifice that chicken :-(
>> We can now kill it if we announce the feature as deprecated a
>> couple of releases in advance.
>> 
>> If we declare that compatibility when the accelerator is omitted
>> is deprecated in 3.0, in QEMU 3.3 we will be free to choose a
>> different default accelerator.
>
> We can, we don't necessarily want it.
>
> The status quo is that people using KVM are invoking qemu as qemu-kvm,
> people using TCG are invoking qemu as qemu-system-*.  All distros are
> shipping a qemu-kvm or more rarely kvm binary, which is invariably a
> wrapper script except for RHEL because RHEL doesn't have a qemu-system-*
> binary at all.
>
> By the way, changing qemu-system-*'s default to e.g. RHEL's "kvm or tcg"
> would not help distros that have "-accel kvm" in their /usr/bin/qemu-kvm
> script.

It wouldn't hurt them, either.

Attentive distros could even replace the wrapper script by a link.

> All in all, it seems simpler for me to take the status quo, which is
> what non-RHEL distros do, and make it part of upstream.
>
> Paolo
