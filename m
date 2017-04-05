Received: from eggs.gnu.org ([2001:4830:134:3::10]:35451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvlJw-000100-6A
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cvlJr-0004WD-C9
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:50:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cvlJr-0004Vn-5u
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 09:49:55 -0400
References: <20170405132503.32125-1-alex.bennee@linaro.org>
	<20170405132503.32125-13-alex.bennee@linaro.org>
	<001001d2ae11$386f9700$a94ec500$@ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <668f1ffc-ebc4-21cf-4355-52761c0737c3@redhat.com>
Date: Wed, 5 Apr 2017 15:49:49 +0200
MIME-Version: 1.0
In-Reply-To: <001001d2ae11$386f9700$a94ec500$@ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 12/12] replay: assert time only goes
 forward
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>, =?UTF-8?Q?'Alex_Benn=c3=a9e'?= <alex.bennee@linaro.org>, rth@twiddle.net
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mttcg@greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com



On 05/04/2017 15:33, Pavel Dovgalyuk wrote:
>> +
>> +        /* Time can only go forward */
>> +        assert(diff >= 0);
>> +
>>          if (diff > 0) {
> This "if" is useless then.
> 

It isn't, "diff == 0" can happen.

Paolo
