Received: from eggs.gnu.org ([2001:4830:134:3::10]:50911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dBNZP-000787-Jl
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dBNZO-0002p7-Ue
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:42:31 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35762)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dBNZO-0002oK-OV
	for qemu-devel@nongnu.org; Thu, 18 May 2017 11:42:30 -0400
Received: by mail-qt0-x241.google.com with SMTP id r58so6203284qtb.2
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 08:42:30 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1495107549-6097-1-git-send-email-thuth@redhat.com>
	<20170518132020.o6bi2eb7x2vierlc@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <103cd6bc-4240-7158-b275-9006979a48e8@twiddle.net>
Date: Thu, 18 May 2017 08:42:27 -0700
MIME-Version: 1.0
In-Reply-To: <20170518132020.o6bi2eb7x2vierlc@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/s390x: Add support for the TEST
 BLOCK instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

On 05/18/2017 06:20 AM, Aurelien Jarno wrote:
>> +DEF_HELPER_FLAGS_2(testblock, TCG_CALL_NO_WG, i32, env, i64)
> As the helper does not read any values from the global, you can even use
> TCG_CALL_NO_RWG.
> 

By throwing an exception, we imply a read of all values along the exception path.


r~
