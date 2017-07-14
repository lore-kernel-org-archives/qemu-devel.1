Received: from eggs.gnu.org ([2001:4830:134:3::10]:57359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVwkD-0007Qc-C6
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:18:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVwkA-0004Y0-5p
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:18:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33711
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVwk9-0004XP-Vu
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:18:38 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6E9EC1d076967
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 05:18:37 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bps8cmf77-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 05:18:36 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 05:18:36 -0400
References: <20170712161830.3621-1-berrange@redhat.com>
	<CAFEAcA979j6Tw8=JAU0U1xTbxXmqj7pvo7sLvHfAv4k7OkCJYw@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 11:18:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA979j6Tw8=JAU0U1xTbxXmqj7pvo7sLvHfAv4k7OkCJYw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-IE
Content-Transfer-Encoding: 7bit
Message-Id: <f3b7d90f-57c9-543d-8d6f-efa998ea7573@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL v2 0/5] Merge sockets 2017/07/11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 07/14/2017 10:36 AM, Peter Maydell wrote:
> On 12 July 2017 at 17:18, Daniel P. Berrange <berrange@redhat.com> wrote:
>> The following changes since commit 3d0bf8dfdfebd7f2ae41b6f220444b8047d6b1ee:
>>
>>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-migration-20170710a' into staging (2017-07-10 18:13:03 +0100)
>>
>> are available in the git repository at:
>>
>>   git://github.com/berrange/qemu tags/pull-sockets-2017-07-11-2
>>
>> for you to fetch changes up to 4b1ac1b3abf0d07cd4d9f9011f12d62bff27154c:
>>
>>   tests: add functional test validating ipv4/ipv6 address flag handling (2017-07-12 16:49:00 +0100)
>>
>> ----------------------------------------------------------------
>> Merge sockets 2017/07/11 v2
>>
>> ----------------------------------------------------------------
>> Daniel P. Berrange (5):
>>   sockets: ensure we can bind to both ipv4 & ipv6 separately
>>   sockets: don't block IPv4 clients when listening on "::"
>>   sockets: ensure we don't accept IPv4 clients when IPv4 is disabled
>>   io: preserve ipv4/ipv6 flags when resolving InetSocketAddress
>>   tests: add functional test validating ipv4/ipv6 address flag handling
> 
> This failed 'make check' on s390x host:
> 
> TEST: tests/test-sockets-proto... (pid=28872)
>   /sockets/migrate/wildcard/all:                                       OK
> [...]
>   /sockets/chardev/::/ipv4onipv6on:                                    OK
>   /sockets/chardev/::/ipv4offipv6off:                                  OK
>   /sockets/net/wildcard/all:                                           **
> ERROR:/home/linux1/qemu/tests/test-sockets-proto.c:849:test_listen:
> assertion failed: (data->ipv4 == 0)
> FAIL
> GTester: last random seed: R02S575d305465be93e6120318b4f8434263
> (pid=29314)
> FAIL: tests/test-sockets-proto
> 


FWIW, I tried to reproduce on my system (Fedora 24 s390x), 
but qemu/master + this pull + configure + make check did compile the test-sockets-proto
test, but it does not execute it. Any idea why not?

Running it manually did succeed, though. (no errors) 
