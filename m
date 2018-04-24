Received: from eggs.gnu.org ([2001:4830:134:3::10]:54304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fB3O5-0002Ly-HN
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:14:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fB3O4-000637-K0
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:14:01 -0400
References: <20180215192829.9944-1-eblake@redhat.com>
	<9c4fcd99-8a8c-62d3-3c0d-d26601910835@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5667b131-9105-1685-3cfc-f97c700ce9ae@redhat.com>
Date: Tue, 24 Apr 2018 15:13:46 -0400
MIME-Version: 1.0
In-Reply-To: <9c4fcd99-8a8c-62d3-3c0d-d26601910835@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] block: byte-based AIO read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org



On 04/24/2018 11:02 AM, Eric Blake wrote:
> On 02/15/2018 01:28 PM, Eric Blake wrote:
>> While we would prefer that block drivers use coroutines instead
>> of aio callbacks, it is a fairly easy exercise to prove that
>> all existing drivers with aio callbacks are merely scaling
>> from bytes into sectors and back to bytes.  So, even though I
>> am not set up to completely run (or even compile-test) this
>> full series, it seems pretty straightforward to change the
>> signature to quit playing games with pointless scaling.
>>
>> Note that except for the null-aio driver, I intentionally did
>> NOT try and change the request_alignment from the block layer's
>> default of 512 (it defaults to 1 only for drivers that use
>> coroutines).
>>
>> (And along the way, I got my docker-test-mingw@fedora working;
>> thanks to the help I got on IRC)
> 
> ping
> 

One of your replies to patch 3 suggests you were going to send a v2 --
is that not the case? Do you want deeper review of v1 first?

--js
