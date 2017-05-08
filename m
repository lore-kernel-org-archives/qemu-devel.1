Received: from eggs.gnu.org ([2001:4830:134:3::10]:38317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7lYx-000662-Pl
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:31:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7lYx-0001bP-1X
	for qemu-devel@nongnu.org; Mon, 08 May 2017 12:31:07 -0400
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-15-pbonzini@redhat.com>
	<20170504145906.GR32376@stefanha-x1.localdomain>
	<a60d65e8-fff3-dbe3-7357-38095a91e83a@redhat.com>
	<20170505102550.GA11350@stefanha-x1.localdomain>
	<1bf3079d-3af5-ffa9-c074-660b77874ff7@redhat.com>
	<20170508162121.GB22428@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e0bd9aa5-9f91-325a-0737-10911b391648@redhat.com>
Date: Mon, 8 May 2017 18:30:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170508162121.GB22428@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 14/17] block: optimize access
 to reqs_lock
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



On 08/05/2017 18:21, Stefan Hajnoczi wrote:
> If you want to use spinlocks in QEMU please document strict rules that
> ensure they will be used safely.  For example, I'd be comfortable with:
>=20
> Spinlock regions may only call functions in the same source file or
> functions explicitly documented as spinlock-safe.  Only memory accesses
> and computation may be performed; do not make system calls or invoke
> library functions.

Sounds good.  But for now I'll just drop these patches in the interest
of simplicity.

Paolo
