Received: from eggs.gnu.org ([2001:4830:134:3::10]:47861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6JRV-0008Vz-Uy
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6JRV-0006Sr-8m
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:17:25 -0400
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-14-pbonzini@redhat.com>
	<20170504141234.GQ32376@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ee92fe4-38bc-dd43-3ef4-416676de1983@redhat.com>
Date: Thu, 4 May 2017 18:17:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170504141234.GQ32376@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/17] coroutine-lock: introduce
 qemu_co_mutex_lock_unlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 04/05/2017 16:12, Stefan Hajnoczi wrote:
>> This primitive lets you lock/unlock a CoMutex, guaranteeing neither
>> blocking nor cacheline bouncing if there is no qemu_co_mutex_lock
>> critical section.
> "Guaranteeing neither X nor Y" means "does not guarantee X or Y".  Did
> you mean "Guarantees not X and not Y"?

Oops, thanks---I didn't know this!  "Guaranteeing no blocking and no
cacheline bouncing if there is no concurrent critical section".

Paolo
