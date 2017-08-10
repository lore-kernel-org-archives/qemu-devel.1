Received: from eggs.gnu.org ([2001:4830:134:3::10]:59691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfkAE-0005kl-QY
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:54:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfkAB-0005Tn-Mt
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:54:02 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:37923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dfkAB-0005TR-G2
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 05:53:59 -0400
Received: by mail-wr0-f170.google.com with SMTP id f21so980969wrf.5
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 02:53:59 -0700 (PDT)
References: <20170809215510.22802-1-pbonzini@redhat.com>
	<20170809215510.22802-2-pbonzini@redhat.com>
	<eeba95b4-23a2-51da-2c41-be5ee262c965@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f31c5090-e9df-ca82-301f-a0e21e168774@redhat.com>
Date: Thu, 10 Aug 2017 11:53:56 +0200
MIME-Version: 1.0
In-Reply-To: <eeba95b4-23a2-51da-2c41-be5ee262c965@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 01/12] qemu-iotests: remove
 dead code
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

On 10/08/2017 00:18, Eric Blake wrote:
> On 08/09/2017 04:54 PM, Paolo Bonzini wrote:
>> This includes shell function, shell variables, command line options
>> (randomize.awk does not exist) and conditions that can never be true
>> (./qemu does not exist anymore).
> 
> Can we point to a commit id where we stopped making ./qemu?  Is it still
> worth supporting a local symlink?
> 
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  tests/qemu-iotests/check         | 36 +--------------------
>>  tests/qemu-iotests/common        | 23 --------------
>>  tests/qemu-iotests/common.config | 26 ---------------
>>  tests/qemu-iotests/common.rc     | 68 ----------------------------------------
>>  4 files changed, 1 insertion(+), 152 deletions(-)
>>
>> -#
>> -# - These can be added to $HOST_CONFIG_DIR (witch default to ./config)
> 
> Good riddance to the wrong word ('which' was intended)
> 
> Other than possibly still wanting ./qemu convenience, this looks like a
> reasonable cleanup.

In my reply yesterday, I forgot to note that the other current-directory
searches go away in patch 9 anyway. :)

Paolo
