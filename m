Received: from eggs.gnu.org ([2001:4830:134:3::10]:45362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ccFLg-0003Dt-Hy
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ccFLc-0002Cu-J7
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:51:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53508)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ccFLc-0002CN-Cp
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:51:04 -0500
References: <10f23e13-dfdc-bbb1-2b31-e698d722a984@redhat.com>
	<8b4be5a0-7b07-dbc4-a899-f6b2192d5e5d@redhat.com>
	<CACXAS8CYXY=QgDCt9EYXBKzsrLwWq3HxFmXd5yXZrALZrBJDgw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <70befbdc-ab71-0261-3015-8b73dbbaf2cb@redhat.com>
Date: Fri, 10 Feb 2017 18:51:00 +0100
MIME-Version: 1.0
In-Reply-To: <CACXAS8CYXY=QgDCt9EYXBKzsrLwWq3HxFmXd5yXZrALZrBJDgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Sparc sun4v machine currently broken?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>

On 10.02.2017 18:43, Artyom Tarasenko wrote:
> On Fri, Feb 10, 2017 at 6:29 PM, Thomas Huth <thuth@redhat.com> wrote:
>> On 10.02.2017 14:49, Thomas Huth wrote:
>>>  Hi,
>>>
>>> is it just me, or could it be that the sun4v machine is currently broken?
>>> I get the following error when I try to run QEMU with this machine:
>>>
>>> qemu-system-sparc64 -nographic -M sun4v
>>> qemu: fatal: Trap 0x0010 while trap level (6) >= MAXTL (6), Error state
[...]
>>> It works for when I use an older version of QEMU (version 2.7)...
>>
>> FWIW, it's also still working when I use QEMU 2.8, so this must be a
>> recent regression...
> 
> Oh. This is surprising. Sun4v practically wasn't implemented before my
> niagara series.
> So, OpenBIOS worked because -M sun4v was like -M sun4u with some sun4v
> instructions.
> Now sun4v is closer to a real sun4v - it has sun4v MMU, so OpenBIOS is
> not compatible with it anymore.
> The proper fix would be adding sun4v support to OpenBIOS, but it may
> take some time.

Ah, ok, thanks for the explanation! I was considering to finally enable
the prom-env-test for sparc64 (since the 32-bit TCG problem was solved
at one point in time, IIRC) when I ran into this problem. So I guess I
should only enable it for the sun4u machine initially...

 Thomas
