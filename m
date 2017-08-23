Received: from eggs.gnu.org ([2001:4830:134:3::10]:32925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dkQPH-00008k-JZ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 03:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dkQPG-0005b1-Sb
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 03:48:55 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170822131832.20191-1-pbonzini@redhat.com>
	<20170822131832.20191-11-pbonzini@redhat.com>
	<20170823044926.GB21343@lemon>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b258e891-dbaf-4512-ae2e-d9a1fc234ff2@redhat.com>
Date: Wed, 23 Aug 2017 09:48:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170823044926.GB21343@lemon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/10] scsi: add persistent reservation
 manager using qemu-pr-helper
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

On 23/08/2017 06:49, Fam Zheng wrote:
>> +
>> +    /* A simple feature negotation protocol, even though there is
>> +     * no optional feature right now.
>> +     */
>> +    if (pr_manager_helper_read(pr_mgr, &flags, sizeof(flags), errp) < 0) {
> Not returning the return value of pr_manager_helper_read()?.
> 
>> +        return -EINVAL;
>> +    }
>> +
>> +    flags = 0;
>> +    if (pr_manager_helper_write(pr_mgr, -1, &flags, sizeof(flags), errp) < 0) {
>> +        return -EINVAL;
> Same here.
> 

Sorry, I forgot to answer these.  The QIOChannel functions (and thus
pr_manager_helper_read/write) only answer -1 or QIO_CHANNEL_ERROR_BLOCK.
 I'll change read/write to return -EINVAL instead.

Paolo
