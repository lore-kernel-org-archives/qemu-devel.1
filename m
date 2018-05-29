Received: from eggs.gnu.org ([2001:4830:134:3::10]:35180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fNkLV-0006e9-T4
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:31:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fNkLR-0003h9-Vt
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:31:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49072 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fNkLR-0003fu-Qd
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:31:45 -0400
References: <20180525005839.11556-1-crosa@redhat.com>
	<20180525005839.11556-5-crosa@redhat.com>
	<20180525054744.GC28589@lemon.usersys.redhat.com>
	<5ebe0b6d-11b9-8c66-0e09-01706ebc57ca@redhat.com>
	<20180529190659.GL8988@localhost.localdomain>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <42eb7e54-f171-78ff-011e-e1cef8256ab7@redhat.com>
Date: Tue, 29 May 2018 15:31:44 -0400
MIME-Version: 1.0
In-Reply-To: <20180529190659.GL8988@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] scripts/qemu.py: introduce
 set_console() method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, Amador Pahim <amador@pahim.org>


On 05/29/2018 03:06 PM, Eduardo Habkost wrote:
> On Fri, May 25, 2018 at 12:57:54PM -0400, Cleber Rosa wrote:
>> On 05/25/2018 01:47 AM, Fam Zheng wrote:
> [...]
>>>> +class QEMU(unittest.TestCase):
>>>
>>> 'QEMU' is too generic, what is the intended tests to do here? It seems to be
>>> more about exercising the set_console() method.
>>>
>>
>> Yes, but again, I'm favoring simpler names when the scope is supposed to
>> be limited.  The chances of a name clash here are close to none IMO.  I
>> don't think this class would be reused elsewhere, or a class with the
>> same name would be imported here.
>>
>>> Any test should be added to tests/, not scripts/.
>>>
>>
>> One of the reasons for this file to be in this patch was to generate
>> this exact discussion.  "qemu.py" itself is not a script, but a
>> module/library.  Still it lacks the structure to have accompanying tests.
>>
>> I was hoping to get away with these tests here, so that they wouldn't be
>> thrown away, until "qemu.py", "qmp/*.py" and others are given the status
>> and structure of Python modules.
>>
>> I can definitely move these to tests/, but how about its relation to the
>> other tests living there and its activation?  Should we recognize its
>> existence and add a check-* target?
> 
> "scripts/test_qemu.py" makes it look like a script that will test
> QEMU.  While we don't rearrange the Python modules to follow a
> more Pythonic structure, probably moving it to tests/ is the best
> option we have.  Maybe tests/python?
> 
> Wherever we store the test code, running those tests on
> "make check" is a good idea.
> 
> But I wouldn't like this to delay the inclusion of this series.
> If rearranging the Python modules would make the job easier,
> including the test code only later would be a reasonable option,
> too.
> 

We already have a "probable next steps" planning (see PATCH 0), and we
can include a "Python module reorganization" to it.  So, I'm dropping
this test on v3 and we'll add it later, at a better location.

- Cleber.
