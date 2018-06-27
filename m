Received: from eggs.gnu.org ([2001:4830:134:3::10]:39985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fY68Y-00041S-A9
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fY68U-00018z-82
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 04:49:14 -0400
References: <20180622181108.GY7451@localhost.localdomain>
	<c10c2ffa-7ee2-5106-07d1-528df939d6ad@redhat.com>
	<20180622193522.GI7451@localhost.localdomain>
	<743d495e-51cd-8c8e-293e-026b8dece74a@redhat.com>
	<87lgb3xsv8.fsf@dusky.pond.sub.org>
	<4292432f-5f26-6925-4c14-ad1370e36e5b@redhat.com>
	<20180625173056.GM7451@localhost.localdomain>
	<97504b42-9ebe-45c5-6ff3-b43102c8374a@redhat.com>
	<54dfe708-cccf-c628-753f-692c83391ec4@redhat.com>
	<20180626095004.7e92fdaa.cohuck@redhat.com>
	<20180626125644.GS7451@localhost.localdomain>
	<878t71xzub.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <736ff87e-8f3c-ca43-9e79-a316df33701b@redhat.com>
Date: Wed, 27 Jun 2018 10:49:06 +0200
MIME-Version: 1.0
In-Reply-To: <878t71xzub.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, zhang.zhanghailiang@huawei.com, Ben Warren <ben@skyportsystems.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 26/06/2018 18:43, Markus Armbruster wrote:
>>> Not sure how serious you meant that, but I actually quite like the
>>> idea :)
>> Also, this mode could be enabled by default if stderr is a tty.
> It could be enabled by default, period.

I agree, summarizing the configuration to stderr on startup is a good
idea and it shouldn't be a problem for backwards compatibility.  Doing
it only if it is a tty could be a good idea though, at least initially.

Paolo
