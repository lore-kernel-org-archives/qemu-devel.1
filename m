Received: from eggs.gnu.org ([209.51.188.92]:43998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hAxX0-0005Wa-VN
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:03:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.weiyang@gmail.com>) id 1hAxX0-0000WK-0k
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:03:22 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:36128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.weiyang@gmail.com>)
	id 1hAxWy-0000T5-44
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 10:03:20 -0400
Received: by mail-ed1-x541.google.com with SMTP id s16so8340928edr.3
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 07:03:18 -0700 (PDT)
Date: Mon, 1 Apr 2019 14:03:14 +0000
From: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190401140314.ho2jbrnuj2xrr6ko@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190326055726.10539-1-richardw.yang@linux.intel.com>
	<20190327202421.GH2636@work-vm> <20190401031034.GA4680@richard>
	<20190401085154.GA2606@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401085154.GA2606@work-vm>
Subject: Re: [Qemu-devel] [PATCH] migration: remove not used field xfer_limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org, quintela@redhat.com

On Mon, Apr 01, 2019 at 09:51:55AM +0100, Dr. David Alan Gilbert wrote:
>* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> On Wed, Mar 27, 2019 at 08:24:21PM +0000, Dr. David Alan Gilbert wrote:
>> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
>> >> MigrationState->xfer_limit is only set to 0 in migrate_init().
>> >> 
>> >> Remove this unnecessary field.
>> >> 
>> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >
>> >Nice; I think that field has been unneeded since 1964a397063967
>> >just over 5 years ago :-)
>> >
>> 
>> Hi, David,
>> 
>> I found xfer_limit has an orphan brother, bytes_xfer.
>> 
>> Do you want me to send a separate patch or spin v2 to adopt these two
>> together?
>
>Either is fine;   since we're in 4.0 freeze at the moment, either way it
>wont get merged for a few weeks.
>

Got it, thanks :-)

>Dave

-- 
Wei Yang
Help you, Help me
