Received: from eggs.gnu.org ([2001:4830:134:3::10]:41103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhZkP-0006Ot-VY
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:10:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dhZkP-0002TE-5S
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:10:57 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dhZkO-0002SU-V0
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 07:10:57 -0400
Received: by mail-wr0-x233.google.com with SMTP id k71so2138144wrc.2
	for <qemu-devel@nongnu.org>; Tue, 15 Aug 2017 04:10:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170815130716.296f031c.cohuck@redhat.com>
References: <20170814204450.24118-1-farman@linux.vnet.ibm.com>
	<CAFEAcA8=_1exzxHEOvmFV1r_oxaGi7beeCVzy=bvVx8tQTNU8w@mail.gmail.com>
	<20170815130716.296f031c.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Aug 2017 12:10:35 +0100
Message-ID: <CAFEAcA9ghHHGsz=XcrceqmP23f8HVznY7oMW+PGaM9YOpEH-UA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>

On 15 August 2017 at 12:07, Cornelia Huck <cohuck@redhat.com> wrote:
> On Tue, 15 Aug 2017 11:00:51 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On 14 August 2017 at 21:44, Eric Farman <farman@linux.vnet.ibm.com> wrote:
>> > How often does one really do a "make clean" ?  Rather infrequently,
>> > as I only stumbled on this today.
>>
>> FWIW, one of my standard pre-merge build tests does a
>> "make clean" and then a make (mostly as a check that we
>> do build from clean as well as incrementally). Not sure
>> why it didn't catch this...
>
> Probably because you don't build on s390x...

I do, but not with a 'make clean' step :-)

thanks
-- PMM
