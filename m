Received: from eggs.gnu.org ([2001:4830:134:3::10]:38821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d2cng-0002Uf-UG
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1d2cnd-0004ZH-Od
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:09:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1d2cnd-0004Z3-I8
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 08:09:01 -0400
References: <1489161295-23864-1-git-send-email-Herbie.Robinson@stratus.com>
	<ca413099-649d-3e93-435a-e88685dc9fda@msgid.tls.msk.ru>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <9d048cb1-6d30-dec9-b9dd-8de89962ede2@redhat.com>
Date: Mon, 24 Apr 2017 14:08:56 +0200
MIME-Version: 1.0
In-Reply-To: <ca413099-649d-3e93-435a-e88685dc9fda@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] SGABIOS: fix wrong video attrs for int
 10h, ah==13h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>, Herbie Robinson <Herbie.Robinson@stratus.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 23/04/2017 11:03, Michael Tokarev wrote:
> 10.03.2017 18:54, Herbie Robinson wrote:
>> Fix Bug #1670509: wrong video attrs for int 10h, ah==13h
>> The subroutine set_cursor_position is trashing %bx.
>> Unfortunately, %bl contains the video attribute for write_string.
>>
>> The fix saves %bx in the function prolog and restores it in
>> the epilog. 
>>
>> Signed-off-by: Herbie Robinson <Herbie.Robinson@stratus.com>
>> ---
>> Removed incorrect code deletions from set_current_cursor.
>> Removed explanation of same from the commit message.
>>
>> BTW, I didn't see any test cases for this code, but if they exist
>> and somebody points me at them, I should be able to generate a 
>> very small qcow2 file that demonstrates the problem.
>>
>>  sgabios.S | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/sgabios.S b/sgabios.S
> 
> Now I'm not quite sure what to do with this.
> 
> It is part of sgabios, which is not qemu code but a submodule.
> 
> Maybe it's better to apply it upstream?
> Or should we apply it directly?

The original project is hosted by code.google.com, that has been closed
in 2015. I doesn't appear there is a real alive repository hosting this
project now (except some multiple clones on github).

So I think you should apply it directly (and regenerate sgabios.bin)

I cc Paolo as he has added the submodule.

Thanks,
Laurent
