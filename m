Received: from eggs.gnu.org ([2001:4830:134:3::10]:41557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk6Hr-0001tm-TK
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk6Ho-0006N8-Np
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:19:55 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34946)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dk6Ho-0006MT-IS
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 06:19:52 -0400
Received: by mail-qt0-x244.google.com with SMTP id e2so3326296qta.2
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 03:19:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170818142613.32394-1-ldoktor@redhat.com>
	<f8f1684a-0684-7261-57c3-63aa58892000@redhat.com>
	<87bmn8qd3z.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c560b757-6bb1-2ded-a25b-193e5f9318c2@amsat.org>
Date: Tue, 22 Aug 2017 07:19:45 -0300
MIME-Version: 1.0
In-Reply-To: <87bmn8qd3z.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/10] qemu.py: Pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, qemu-devel@nongnu.org, famz@redhat.com, ehabkost@redhat.com, apahim@redhat.com, mreitz@redhat.com, "Daniel P. Berrange" <berrange@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 08/22/2017 04:24 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
[...]
>>
>> Looks like all ten patches have an R-B despite changes; but it looks
>> like nothing particularly major was changed anyway.
>>
>> Does this fall under Markus's jurisdiction?
>>
>> (Well, except for qtest.py which seemingly has double-extra-no
>> maintainer...!)
> 
> qemu.py is about starting and controlling QEMU, commonly for testing
> purposes.  It's related to QMP only by virtue of using QMP for control
> (well, what else could it use?); if that makes me maintainer, I'll soon
> maintain basically all tests :)
> 
> As far as I can tell, qemu.py's main user is still qemu-iotests, via
> qtest.py.  Dan factored it out to make it available for
> tests/migration/guestperf/.
> 
> Options for maintaining qemu.py and qtest.py:
> 
> * Maintain them with qemu-iotest
> 
>    Currently mainained with the block layer core, by Kevin and Max.
> 
>    - Keep it that way
> 
>    - Appoint qemu-iotest maintainer(s).
> 
> * Maintain them separately, say as "Python qtest support", appoint
>    maintainer(s)
> 
>    Dan appears to be a hot contender:
> 
>      $ scripts/get_maintainer.pl -f --git-blame scripts/qtest.py
>      Fam Zheng <famz@redhat.com> (authored lines:71/110=65%,commits:1/3=33%)
>      "Daniel P. Berrange" <berrange@redhat.com> (authored lines:39/110=35%,commits:2/3=67%)
>      Max Reitz <mreitz@redhat.com> (commits:2/3=67%)
>      Amit Shah <amit.shah@redhat.com> (commits:1/3=33%)
>      Stefan Hajnoczi <stefanha@redhat.com> (commits:1/3=33%)
>      qemu-devel@nongnu.org (open list:All patches CC here)
>      $ scripts/get_maintainer.pl -f --git-blame scripts/qemu.py
>      "Daniel P. Berrange" <berrange@redhat.com> (authored lines:217/229=95%,commits:2/4=50%)
>      Eduardo Habkost <ehabkost@redhat.com> (authored lines:12/229=5%,commits:4/4=100%)
>      Markus Armbruster <armbru@redhat.com> (commits:1/4=25%)
>      Max Reitz <mreitz@redhat.com> (commits:1/4=25%)
>      Amit Shah <amit.shah@redhat.com> (commits:1/4=25%)
>      qemu-devel@nongnu.org (open list:All patches CC here)
> 
>    Eduardo made the mistake^W^W^Wgraciously volunteered to maintain
>    scripts/qmp/qmp-shell, which is also used for testing.  Perhaps he'd
>    be willing to maintain these guys as well.
> 
> * Do nothing
> 
>    Hope "somebody" will take pity and merge patches.  A common value of
>    "somebody" would be Paolo.

:'(

* Fam is also a good candidate for scripts/qemu.py with VM testing

* trivial queue?

* Add global Python maintainers

Mostly to review/merge...

Can we predict how the python scripts will evolve? Only fast-testing?

Is there some users hacking on qemu.py unaware they can/should use 
libvirt-python?
If so, shouldn't we think about running more tests through libvirt and 
add effort there?
