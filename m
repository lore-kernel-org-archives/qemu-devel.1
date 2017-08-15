Received: from eggs.gnu.org ([2001:4830:134:3::10]:40150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhZh1-0004wO-Cm
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:07:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dhZgw-0000dM-Kz
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:07:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dhZgw-0000aj-Eq
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:07:22 -0400
Date: Tue, 15 Aug 2017 13:07:16 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170815130716.296f031c.cohuck@redhat.com>
In-Reply-To: <CAFEAcA8=_1exzxHEOvmFV1r_oxaGi7beeCVzy=bvVx8tQTNU8w@mail.gmail.com>
References: <20170814204450.24118-1-farman@linux.vnet.ibm.com>
	<CAFEAcA8=_1exzxHEOvmFV1r_oxaGi7beeCVzy=bvVx8tQTNU8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/1] Fix "make clean" for s390
 target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 15 Aug 2017 11:00:51 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 14 August 2017 at 21:44, Eric Farman <farman@linux.vnet.ibm.com> wrote:
> > How often does one really do a "make clean" ?  Rather infrequently,
> > as I only stumbled on this today.  
> 
> FWIW, one of my standard pre-merge build tests does a
> "make clean" and then a make (mostly as a check that we
> do build from clean as well as incrementally). Not sure
> why it didn't catch this...

Probably because you don't build on s390x... I'll add it to my
workflow, though.
