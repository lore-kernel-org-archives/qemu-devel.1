Received: from eggs.gnu.org ([2001:4830:134:3::10]:50829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6YH1-0002zw-Ls
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6YGw-0001TE-NU
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:07:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d6YGw-0001S7-GR
	for qemu-devel@nongnu.org; Fri, 05 May 2017 04:07:30 -0400
References: <20170505032340.26467-1-famz@redhat.com>
	<03beb071-ebbc-4328-3530-37b9856476cc@redhat.com>
	<20170505080513.GC21435@lemon.lan>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d75dec74-8cce-cad9-6e47-4fae5fa415ca@redhat.com>
Date: Fri, 5 May 2017 10:07:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170505080513.GC21435@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/5] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>



On 05/05/2017 10:05, Fam Zheng wrote:
>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>>
>> For patch 5, I think we should revive the "quick" qemu-iotests group
>> (maybe we can have support for skipping groups, and have a "slow" group
>> with the very few tests that take >30 seconds?) and add the quick tests
>> to "make check".
> Sounds like a good idea, but for a separate series, IMO.
> 
> The idea of the new test-block is to include all qemu-iotests tests.  I only
> added raw and qcow2 because vmdk etc. fails case 181. I could use "-x" but
> that's a bit ugly - they can wait for the fix.

I think that would still be a bit too slow for patchew?

Paolo
