Received: from eggs.gnu.org ([2001:4830:134:3::10]:49244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fC0Yy-00031N-QV
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fC0Yy-0005ZD-3k
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 06:25:12 -0400
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87in8qf2w3.fsf@dusky.pond.sub.org>
	<62dba5cf-b497-1a98-0af5-971e169a3458@redhat.com>
	<877eou2nek.fsf@dusky.pond.sub.org>
	<099d2af4-8fe3-f80c-693f-495accb26a17@redhat.com>
	<CAFEAcA_VAckXDgARe5dJdxe9N19quUD5Dn+Dseuj=itLbFmG0g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <40c06711-f9a0-3440-9a47-8230cbcb3d55@redhat.com>
Date: Fri, 27 Apr 2018 12:24:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_VAckXDgARe5dJdxe9N19quUD5Dn+Dseuj=itLbFmG0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm]  qom-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 27.04.2018 12:20, Peter Maydell wrote:
> On 27 April 2018 at 07:06, Thomas Huth <thuth@redhat.com> wrote:
>> On 26.04.2018 13:54, Markus Armbruster wrote:
>> [...]
>>> Actually, a worse offender in the "waste everybody's time via redunancy"
>>> department could be qom-test.
>>
>> Shall we change qom-test to also only test with the "none" machine in
>> the normal "make check" mode and only do the full test with all machines
>> in "make check SPEED=slow" ?
> 
> We definitely want something that tries to instantiate every
> machine, because that does catch bugs.

Yes, after having a closer look at this one, I also think that we should
*not* change it to run with "none" by default only. The 'qom-list'
command results in quite a different output depending on which machine
you run it on.

 Thomas
