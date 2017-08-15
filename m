Received: from eggs.gnu.org ([2001:4830:134:3::10]:49265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhXNq-0000jk-PQ
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dhXNn-0003be-LG
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:39:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dhXNn-0003bM-EZ
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:39:27 -0400
References: <20170814204450.24118-1-farman@linux.vnet.ibm.com>
	<f637c206-266c-d76f-852e-4800422838bb@redhat.com>
	<20170815090302.3f315027.cohuck@redhat.com>
	<222ec8ee-0e1e-ca24-142e-505867bfee27@redhat.com>
	<86e21c68-93ee-0311-643d-dde2c8589eea@redhat.com>
	<20170815103221.2446bc3d.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <435fa5db-64a3-57f8-d71c-e88c1a11ab3a@redhat.com>
Date: Tue, 15 Aug 2017 10:39:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170815103221.2446bc3d.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.vnet.ibm.com>, borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org

On 15.08.2017 10:32, Cornelia Huck wrote:
> On Tue, 15 Aug 2017 10:26:18 +0200
> Thomas Huth <thuth@redhat.com> wrote:
[...]
>> The parameter -R disables the built-in variables, so RM can indeed not
>> work here. Sorry, I wasn't aware of that setting yet, so your patch is
>> indeed the right fix here (or we should maybe define RM in rules.mak, too).
> 
> The other users are all in tests/tcg/.
> 
> Would there be value in using the built-in variables generally? (Well,
> value that outweighs having to go through the qemu build system...)

There are some non-posix shells where "rm -f" does not work (e.g.
COMMAND.COM on Windows), and this is where $(RM) is really useful. But
since we require a posix-style built environment anyway, it's not that
important for the QEMU build system. OTOH, $(RM) is a standard Make
variable, so other people might step into this trap as well - so it's
maybe better to define it in rules.mak to avoid future confusion?

 Thomas
