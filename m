Received: from eggs.gnu.org ([2001:4830:134:3::10]:55691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSkgB-000547-3F
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:26:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSkg3-0002M9-AW
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 10:26:05 -0500
References: <20181130023232.3079982-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a31b2898-e27f-2d31-6fba-7df83f8cf998@redhat.com>
Date: Fri, 30 Nov 2018 09:25:43 -0600
MIME-Version: 1.0
In-Reply-To: <20181130023232.3079982-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1? 0/3] NBD dirty bitmap cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-stable@nongnu.org

On 11/29/18 8:32 PM, Eric Blake wrote:
> I'm working on a larger series for 4.0 that will add
> 'qemu-nbd --list' to show all possible information about a
> server's exports, to make it easier to diagnose if the right
> exports and bitmaps are present.  But in the process, I found
> a few bugs that may be worth fixing in 3.1.  By itself, this
> series does not warrant -rc4 (particularly since all of the
> problems exist in the 3.0 release, so this is not a regression
> fix), but if we have -rc4 for other reasons, these would make
> incremental backup support a bit more reliable.

And CVEs might be the reason for an -rc4. I'm queuing this on my NBD 
tree, ready to send a Pull Request by early Monday if we indeed end up 
with an -rc4.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
