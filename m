Received: from eggs.gnu.org ([2001:4830:134:3::10]:49030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffUck-0005LI-Ve
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 14:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ffUch-0005KR-Mb
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 14:22:58 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:43014)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ffUch-0005Jl-7G
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 14:22:55 -0400
Received: by mail-pf0-x234.google.com with SMTP id j26-v6so899445pfi.10
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 11:22:55 -0700 (PDT)
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-7-git-send-email-jjherne@linux.ibm.com>
	<30fedbb2-24fc-7356-63b6-2544cfa7af54@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e2697b5b-4068-3429-10a2-b9cff6297c6c@linaro.org>
Date: Tue, 17 Jul 2018 11:22:50 -0700
MIME-Version: 1.0
In-Reply-To: <30fedbb2-24fc-7356-63b6-2544cfa7af54@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 06/15] s390-bios: Clean up cio.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On 07/17/2018 11:15 AM, Thomas Huth wrote:
>> -    __u32 isc:3;
>> -    __u32 ena:1;
>> -    __u32 mme:2;
>> -    __u32 mp:1;
>> -    __u32 csense:1;
>> -    __u32 mbfc:1;
>> +    __u32 isc    : 3;
>> +    __u32 ena    : 1;
>> +    __u32 mme    : 2;
>> +    __u32 mp     : 1;
>> +    __u32 csense : 1;
>> +    __u32 mbfc   : 1;
> 
> checkpatch.pl does not like these spaces, so I think it would be better
> to not make these changes (otherwise we'll have to deal with the output
> of checkpatch each time again we want to change something here).

AFAICT, this is a checkpatch bug confusing switch case labels.


r~
