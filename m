Received: from eggs.gnu.org ([2001:4830:134:3::10]:53824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZf2n-00061H-CE
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZf2j-0006fb-VU
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:13:13 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38232)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZf2j-0006fU-R0
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:13:09 -0400
Received: by mail-qk0-x242.google.com with SMTP id t2so10179438qkc.5
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 08:13:09 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500886370-14572-1-git-send-email-thuth@redhat.com>
	<20170724133245.48649043@gondolin>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c6bd321e-da18-d1f2-a5e1-d2fd904320ac@twiddle.net>
Date: Mon, 24 Jul 2017 08:13:06 -0700
MIME-Version: 1.0
In-Reply-To: <20170724133245.48649043@gondolin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] target/s390x: Fix broken build with
 --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>

On 07/24/2017 04:32 AM, Cornelia Huck wrote:
> On Mon, 24 Jul 2017 10:52:45 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> Our configure script was recently equipped with a new --disable-tcg
>> parameter, but this does unfortunately not work on s390x hosts yet. Fix
>> the build by moving some code around and by adding some few #ifdefs
>> in the right places.
>>
>> v3:
>> - Fixed the problem when building the s390x-linux-user target
>> - Added a g_assert_not_reached() to tcg_s390_program_interrupt()
>>    according to Richard's suggestion
> 
> If I get one more R-b by Richard for patch 3 before tomorrow, I'll
> merge that in.

Thanks, please do.


r~
