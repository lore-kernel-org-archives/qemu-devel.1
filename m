Received: from eggs.gnu.org ([209.51.188.92]:42428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guCZh-0005Sa-15
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:40:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1guCZR-0000iK-D1
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:40:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1guCZR-0000Ww-6K
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 03:40:37 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D4705947B
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 08:30:34 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <871s4chvb2.fsf@dusky.pond.sub.org>
	<9e429792-cbea-c96c-ad48-7f5bdd7ef781@redhat.com>
	<87bm3f4qbt.fsf@dusky.pond.sub.org>
	<7ede9d69-a3fe-f20a-3770-dd2a4e90d1ca@redhat.com>
Date: Thu, 14 Feb 2019 09:30:31 +0100
In-Reply-To: <7ede9d69-a3fe-f20a-3770-dd2a4e90d1ca@redhat.com> (Paolo
	Bonzini's message of "Wed, 13 Feb 2019 17:19:18 +0100")
Message-ID: <87o97ebwm0.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] Seeking QEMU makefile advice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 13/02/19 17:15, Markus Armbruster wrote:
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>> 
>>> On 13/02/19 10:49, Markus Armbruster wrote:
>>>> * Define QAPI_COMMON_MODULES, QAPI_TARGET_MODULES and QAPI_MODULES in
>>>>   Makefile.obj
>>>>
>>>> * Add to util-obj-y in Makefile.obj
>>>>
>>>> * Add to obj-y in Makefile.target
>>>
>>> Why can't both be in Makefile.objs, or in qapi/Makefile.objs?
>> 
>> When I try either place, I get
>> 
>>       LINK    x86_64-softmmu/qemu-system-x86_64
>>     monitor.o: In function `qmp_query_qmp_schema':
>>     /work/armbru/qemu/monitor.c:1136: undefined reference to `qmp_schema_qlit'
>>     [more errors...]
>> 
>> Compiling with V=1 confirms qapi-introspect.o isn't in $(all-obj-y).
>
> Oh, ok.  Then I suggest placing it in qapi/Makefile.objs, and you'll
> have to add "obj-y += qapi/" in Makefile.target (I'm not sure if it's
> under "ifdef CONFIG_SOFTMMU" or outside, but you'd know that).

I think I got that to work.  Thanks for your help!
