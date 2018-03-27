Received: from eggs.gnu.org ([2001:4830:134:3::10]:36019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f0qZ2-0004aR-MF
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f0qYx-0000d7-4f
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:31:08 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f0qYw-0000cs-U5
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:31:03 -0400
Received: by mail-wr0-x244.google.com with SMTP id 80so21756728wrb.2
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 08:31:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b635c80e-4093-0cdb-2166-6a37dbd6ee18@redhat.com>
References: <20180327143014.1767669-1-eblake@redhat.com>
	<20180327143014.1767669-7-eblake@redhat.com>
	<CAJ+F1CJvvhd-pL5S9JChsBjEHqaB=_-HdYRzd+NiH3RK28B0yw@mail.gmail.com>
	<b635c80e-4093-0cdb-2166-6a37dbd6ee18@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 27 Mar 2018 17:31:01 +0200
Message-ID: <CAJ+F1CLzHv+b7cErp3mki_xkZuPgoOZh10t+bFYzQg8XLpipLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 06/14] qmp: fix qmp_capabilities error
 regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Mar 27, 2018 at 5:16 PM, Eric Blake <eblake@redhat.com> wrote:
> On 03/27/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
>>
>> On Tue, Mar 27, 2018 at 4:30 PM, Eric Blake <eblake@redhat.com> wrote:
>>>
>>> From: Peter Xu <peterx@redhat.com>
>>>
>>> When someone sends a command before QMP handshake, the error used to be
>>> like this:
>>>
>>>   {"execute": "query-cpus"}
>>>   {"error": {"class": "CommandNotFound", "desc":
>>>              "Expecting capabilities negotiation with
>>> 'qmp_capabilities'"}}
>>>
>>> While after cf869d5317 it becomes:
>>>
>>>   {"execute": "query-cpus"}
>>>   {"error": {"class": "CommandNotFound", "desc":
>>>              "The command query-cpus has not been found"}}
>>>
>>> Fix it back to the nicer one.
>>>
>>> Fixes: cf869d5317 ("qmp: support out-of-band (oob) execution",
>>> 2018-03-19)
>>> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> Message-Id: <20180326063901.27425-2-peterx@redhat.com>
>>> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>>
>> Reviewed-by (not x2 Reported-by ;)
>>
>
> Shoot.  Want me to send a v2 pull request?

no need ;)



--=20
Marc-Andr=C3=A9 Lureau
