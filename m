Received: from eggs.gnu.org ([2001:4830:134:3::10]:55200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4qRr-0000lt-HM
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4qRq-0002zY-Lt
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 11:39:59 -0400
References: <cover.1508257445.git.jcody@redhat.com>
	<503559b438cd67b865d32d7d0577afc7ee15f32c.1508257445.git.jcody@redhat.com>
	<2de32e52-2c2a-5738-4624-d84bf7379c5f@redhat.com>
	<20171018150352.GE17962@localhost.localdomain>
	<d3682b70-64c6-1284-77c4-8df561a61098@redhat.com>
	<20171018153416.GF17962@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <07a69c86-aae3-9174-b646-dee04bf191de@redhat.com>
Date: Wed, 18 Oct 2017 17:39:40 +0200
MIME-Version: 1.0
In-Reply-To: <20171018153416.GF17962@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 03/10] qemu-iotests: automatically clean
 up bash protocol servers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org

On 18/10/2017 17:34, Jeff Cody wrote:
>> Well, I have no idea (hence the "not very constructive" part).  I'm only
>> "nacking" the sourcing of common.rc in the check script.
>>
>> The series improves the harness, but it also sets a very different
>> separation between the tests and the harness (especially WRT the tests
>> cleaning up after themselves).  The level of separation would at least
>> be clearer if check didn't include common.rc.
>>
> I can get rid of the common.rc includes prior to running the tests, but this
> series really requires including common.rc in the spot you mentioned, for
> automatically cleaning up protocol and QEMU processes.

Understood, but does it have to be common.rc?  Can it be a different
file?  That at least would still make it clear what check is doing (for
example it is not launching qemu, which is part of common.rc).

> That auto-cleanup is arguably a big improvement, as it has been relatively
> common to run across tests that leave processes running in the background.
> 
> I agree that it sets up different expectations, but that is at least partly
> intentional.  I don't really want to have to rely on individually written
> tests to clean up properly. That is ~200 chances (and growing) for a
> mistake; instead, this series moves that responsibility into a single place
> to maintain.

Understood, that's also why I'm all but nacking the entire series!

Paolo
