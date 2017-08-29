Received: from eggs.gnu.org ([2001:4830:134:3::10]:44160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmkqb-0002cc-Ge
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 14:02:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmkqY-00040F-CF
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 14:02:45 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34367)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmkqY-0003zd-7s
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 14:02:42 -0400
Received: by mail-qt0-x243.google.com with SMTP id v29so3411915qtv.1
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 11:02:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170825155732.15665-1-stefanha@redhat.com>
	<4eede1a1-5ac4-41e3-e6ef-700348fc3d37@amsat.org>
	<CAFEAcA_skx8s28zo38uTwM-TcJvX1pC6oTAxjy3q_AVN3JwHBA@mail.gmail.com>
	<4f21291d-d696-9651-e317-78ec4f08cbda@redhat.com>
	<20170829100155.GN25960@stefanha-x1.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <8dd1370a-d391-ab44-5ce4-40212f93b513@amsat.org>
Date: Tue, 29 Aug 2017 15:02:37 -0300
MIME-Version: 1.0
In-Reply-To: <20170829100155.GN25960@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] scripts: add argparse module for
 Python 2.6 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On 08/29/2017 07:01 AM, Stefan Hajnoczi wrote:
> On Fri, Aug 25, 2017 at 12:42:44PM -0500, Eric Blake wrote:
>> On 08/25/2017 11:40 AM, Peter Maydell wrote:
>>> Our choices about our dependencies are generally driven by "what
>>> are the versions available on the oldest distros which we wish
>>> to support building QEMU on", which typically is whatever the
>>> long-term-support versions of Ubuntu, SUSE, Redhat, etc are.
>>>
>>> Has somebody checked what that means for our Python version
>>> requirements?
>>
>> At least this one:
>>
>> RHEL/CentOS 6: Python-2.6.6

$ docker run --rm qemu:centos6 yum -q list python
Installed Packages
python.x86_64                     2.6.6-66.el6_8 
@CentOS/6.9

Good news, we have a docker image using Python2.6

Do you have some migration/guestperf test we can add to the testsuite?

Regards,

Phil.
