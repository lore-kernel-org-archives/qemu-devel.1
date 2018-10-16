Received: from eggs.gnu.org ([2001:4830:134:3::10]:40548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCNPd-0005NE-D1
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gCNPY-0000tg-DU
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:21:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gCNPY-0000qC-3Z
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 07:21:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20181015115309.17089-1-armbru@redhat.com>
	<20181015115309.17089-28-armbru@redhat.com>
	<2fe22e4c-d7b8-f41e-493c-ffd8b7169e44@suse.com>
	<87woqiv8ii.fsf@dusky.pond.sub.org>
	<20181016065256.zhusncujzgfyr3wn@sirius.home.kraxel.org>
Date: Tue, 16 Oct 2018 13:21:09 +0200
In-Reply-To: <20181016065256.zhusncujzgfyr3wn@sirius.home.kraxel.org> (Gerd
	Hoffmann's message of "Tue, 16 Oct 2018 08:52:56 +0200")
Message-ID: <87murep26y.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 27/35] vnc: Clean up error reporting in
 vnc_init_func()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Fei Li <fli@suse.com>, qemu-devel@nongnu.org

Gerd Hoffmann <kraxel@redhat.com> writes:

>> >> +        error_propagate(errp, local_err);
>> > Shall we use error_propagate(errp, local_err, ("Failed to init VNC
>> > server: ");
>> > like vnc_display_open does?
>> 
>> I don't know.  
>> 
>> The error reporting is somewhat poor around here.  Consider:
>> 
>>     $ qemu-system-x86_64 -display vnc=:0,share=nope
>>     qemu-system-x86_64: -display vnc=:0,share=nope: Failed to start VNC server: unknown vnc share= option
>> 
>> The "Failed to start VNC server: " prefix doesn't really add value.
>
> Indeed.
>
>> Gerd, what do you think?
>
> I'd keep the messages short.

Okay, I'll delete the prefix.  Thanks!
