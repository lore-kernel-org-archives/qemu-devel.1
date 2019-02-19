Received: from eggs.gnu.org ([209.51.188.92]:48979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvyb9-0003rp-W2
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:09:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gvyb7-0006U0-JU
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:09:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gvyb3-0006SM-G5
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 01:09:39 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
	<ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
	<BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
	<87ftsl2clg.fsf@dusky.pond.sub.org>
	<91720BD9-D5A6-4457-BC99-D2132550BEDA@oberlin.edu>
Date: Tue, 19 Feb 2019 07:09:33 +0100
In-Reply-To: <91720BD9-D5A6-4457-BC99-D2132550BEDA@oberlin.edu> (Stephen
	Checkoway's message of "Mon, 18 Feb 2019 13:31:01 -0500")
Message-ID: <87ef84z4v6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

Stephen Checkoway <stephen.checkoway@oberlin.edu> writes:

> On Feb 18, 2019, at 13:08, Markus Armbruster <armbru@redhat.com> wrote:
>
>> Stephen Checkoway <stephen.checkoway@oberlin.edu> writes:
>> 
>>> On Feb 18, 2019, at 08:43, Thomas Huth <thuth@redhat.com> wrote:
>>> 
>>>> On 18/02/2019 07.07, Stephen Checkoway wrote:
>>>>> Hi all,
>>>>> 
>>>>> I've been working on some improvements to the pflash_cfi02 block device (interleaved flash devices similar to pflash_cfi01, multi-sector erase, nonuniform sector sizes, and some bug fixes and I'm planning on implementing sector erase suspend/resume commands in the near future).
>> 
>> Any chance you could do multiple region support, too?
>
> Can you point me at the data sheet for a flash chip with multiple region support? For my purposes, I only need the features I mentioned, but if it's a simple change, I'll consider it.

I'm not familiar with CFI pflash, but I can operate a search engine.
Have a look at page 27 and 56 of

https://media.digikey.com/pdf/Data%20Sheets/Intel%20PDFs/28F160C3,320C3,640C3,800C3%20(x16).pdf

and tell us whether it's helpful.

>>>> QTestState *qts;
>>>> qts = qtest_initf(" qemu-system-arm -M musicpal,accel=qtest "
>>>>               "-drive if=pflash,file=%s,format=raw", filename);
>>> 
>>> If I do that, will it be possible for the test to override the properties set by pflash_cfi02_register? It looks like I should be able to use -global to set properties that aren't set explicitly.
>> 
>> Yes.
>> 
>> Won't work for properties set by pflash_cfi02_register(), though.  To
>> test the full range of values there, you'd have to make them
>> configurable somehow.  We currently don't have a good way to do that.
>> Please see
>> 
>>    Subject: Re: Configuring pflash devices for OVMF firmware
>>    Message-ID: <87mun8gd2x.fsf@dusky.pond.sub.org>
>>    https://lists.nongnu.org/archive/html/qemu-devel/2019-02/msg01734.html
>
> I see. That's too bad.

I think a test would be quite welcome even if it only tests what's
testable now with reasonable effort.
