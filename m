Received: from eggs.gnu.org ([2001:4830:134:3::10]:39841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6BL6-0002DS-MJ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6BL2-0007rn-PA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:38:16 -0400
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-10-pbonzini@redhat.com>
	<20170504073615.GF19184@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71bba48c-317f-b553-ad27-ae6ca66cb878@redhat.com>
Date: Thu, 4 May 2017 09:38:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170504073615.GF19184@lemon.lan>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/17] util: add stats64 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 04/05/2017 09:36, Fam Zheng wrote:
>> +
>> +    /* If there is a concurrent writer, wait for it.  */
>> +    while (atomic_read(&s->lock) & 1) {
>> +        g_usleep(5);
> What's the difference of g_usleep() from cpu_relax() in
> qemu_co_mutex_lock_unlock?

cpu_relax() did not exist when I wrote this patch. :)  I'll change it.

Paolo
