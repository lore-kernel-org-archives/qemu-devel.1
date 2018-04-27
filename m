Received: from eggs.gnu.org ([2001:4830:134:3::10]:44219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fC6Mj-000694-Et
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:37:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fC6Mi-00012w-Jf
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 12:36:57 -0400
References: <1521452376-25099-1-git-send-email-thuth@redhat.com>
	<87in8qf2w3.fsf@dusky.pond.sub.org>
	<62dba5cf-b497-1a98-0af5-971e169a3458@redhat.com>
	<877eou2nek.fsf@dusky.pond.sub.org>
	<099d2af4-8fe3-f80c-693f-495accb26a17@redhat.com>
	<CAFEAcA_VAckXDgARe5dJdxe9N19quUD5Dn+Dseuj=itLbFmG0g@mail.gmail.com>
	<40c06711-f9a0-3440-9a47-8230cbcb3d55@redhat.com>
	<87muxoehnp.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <155fc4fe-f8d6-a3d9-0f50-d5384a09835a@redhat.com>
Date: Fri, 27 Apr 2018 18:36:38 +0200
MIME-Version: 1.0
In-Reply-To: <87muxoehnp.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc]  [Qemu-arm] qom-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>

On 27.04.2018 18:30, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 27.04.2018 12:20, Peter Maydell wrote:
>>> On 27 April 2018 at 07:06, Thomas Huth <thuth@redhat.com> wrote:
[...]
>>>> Shall we change qom-test to also only test with the "none" machine in
>>>> the normal "make check" mode and only do the full test with all machines
>>>> in "make check SPEED=slow" ?
>>>
>>> We definitely want something that tries to instantiate every
>>> machine, because that does catch bugs.
>>
>> Yes, after having a closer look at this one, I also think that we should
>> *not* change it to run with "none" by default only. The 'qom-list'
>> command results in quite a different output depending on which machine
>> you run it on.
> 
> Only running "none" is too naive.

For the targets that have "versioned" machine types, I think we could
skip all the older machine versions, so that we only test with
pc-i440fx-2.12 but not with pc-i440fx-2.11 and older anymore. That would
need some more or less clever algorithm to detect the latest version,
though.

 Thomas
