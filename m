Received: from eggs.gnu.org ([2001:4830:134:3::10]:49251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg60B-0000OE-F0
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg60A-0006RA-KP
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:40:51 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
	<1487067971-10443-24-git-send-email-armbru@redhat.com>
	<20170220201647.GL2372@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0468dc5a-8de8-4a96-bc4b-1999be862fda@redhat.com>
Date: Tue, 21 Feb 2017 09:40:42 +0100
MIME-Version: 1.0
In-Reply-To: <20170220201647.GL2372@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 23/24] util/cutils: Change qemu_strtosz*()
 from int64_t to uint64_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, "open list:Block layer core" <qemu-block@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>



On 20/02/2017 21:16, Dr. David Alan Gilbert wrote:
>>                  p.has_max_bandwidth = true;
>>                  ret = qemu_strtosz_mebi(valuestr, NULL, &valuebw);
>> -                if (ret < 0 || (size_t)valuebw != valuebw) {
>> +                if (ret < 0 || valuebw > INT64_MAX
>> +                    || (size_t)valuebw != valuebw) {
> 
> We should probably just turn all of the parameters into size_t's - although that's
> more work and there's some int64_t's in qemu_file for no good reason.

I disagree, there's no reason why 32-bit should not support a bandwidth
specification of 10 Gbps.

size_t is related to pointers, and it should only be used for those.

Paolo
