Received: from eggs.gnu.org ([2001:4830:134:3::10]:48082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb5xs-0001fU-JU
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:42:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eb5xn-00055G-NV
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 09:42:20 -0500
References: <1516008655-31732-1-git-send-email-thuth@redhat.com>
	<CAFEAcA8X+p=oWWBTquGjceZJVEfcD8eWDxdZnRe=jVaL7t+LEA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e83d019b-2a88-f4e4-4be8-79f93731b549@redhat.com>
Date: Mon, 15 Jan 2018 15:42:09 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8X+p=oWWBTquGjceZJVEfcD8eWDxdZnRe=jVaL7t+LEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/2] Clean up the ppc default
 configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 15.01.2018 14:01, Peter Maydell wrote:
> On 15 January 2018 at 09:30, Thomas Huth <thuth@redhat.com> wrote:
>> (off-topic question: Do we still need a separate ppcemb-softmmu nowadays?
>> It seemed to be useful 10 years ago when everybody was doing KVM on
>> embedded PPC, but these days seem to be pretty much over now, so IMHO
>> just using ppc-softmmu for embedded should be enough nowadays? We could
>> save quite some compilation- and "make check"-time if we could finally get
>> rid of ppcemb-softmmu again...)
> 
> There are some specific differences guarded by TARGET_PPCEMB, like
> the way it has a different TARGET_PAGE_BITS value, and some code
> in target/ppc/kvm.c related to telling KVM about interrupts. You
> would need to make those all be runtime decisions I assume.

True ... but while we maybe could turn those into runtime checks, I now
rather think it's maybe better to go the other way round: Maybe we
should not include each and everything into ppc64-softmmu, but put the
embedded stuff only in ppcemb-softmmu and the 32-bit stuff only in
ppc-softmmu instead? That way we could, for example, also make the
output of "-cpu help" and "-device help" a little bit more user friendly...

 Thomas
