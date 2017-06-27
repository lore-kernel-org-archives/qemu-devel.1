Received: from eggs.gnu.org ([2001:4830:134:3::10]:52530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dPtlO-00077i-CT
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dPsoi-0002ae-6c
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:54:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dPsoh-0002Xu-WE
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:54:16 -0400
References: <20170620000405.3391-1-rth@twiddle.net>
	<20170623160523.vvxiayw4crjezii4@aurel32.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <f1b42947-185c-347e-c0db-79ce9b1ab6c8@redhat.com>
Date: Tue, 27 Jun 2017 17:54:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170623160523.vvxiayw4crjezii4@aurel32.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/18] target/s390x improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Cc: thuth@redhat.com, qemu-devel@nongnu.org

On 23.06.2017 18:05, Aurelien Jarno wrote:
> On 2017-06-19 17:03, Richard Henderson wrote:
>> Changes since v2:
>>   * Dropped the enforcement of PGM_OPERATION for insns for
>>     which the feature bit is set.  There's no agreement on
>>     exactly how to do this yet.
>>   * Add implementations of insns for 6 more facilities.
>>
>> I think we can get to z990 fairly quickly after this.
>> Ignoring HFP, the ones I see missing are DAT-ENH, MSA.
> 
> Thanks for this work. For the record I have started working on HFP
> sometimes ago. I'll try to finish that and submit patches in the next
> weeks.
> 

Just for the records, I am currently looking into MSA (at least
providing the functions (KM,KMC,KIMD ...) with only the query
subfunction), and I'll be looking into booting a z196 compiled linux
kernel under tcg.

-- 

Thanks,

David
