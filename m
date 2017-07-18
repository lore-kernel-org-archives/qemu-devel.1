Received: from eggs.gnu.org ([2001:4830:134:3::10]:57787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXZ62-00046v-RX
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:27:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXZ62-0000a4-2n
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 16:27:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-4-git-send-email-armbru@redhat.com>
	<e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
	<c61aee5a-a094-50c3-67c3-c39e72095710@redhat.com>
	<87y3rlrct2.fsf@dusky.pond.sub.org>
	<87lgnlcyz7.fsf@dusky.pond.sub.org>
	<c6e3d9d9-188b-6b26-3f99-a3ab5a6d6933@redhat.com>
Date: Tue, 18 Jul 2017 22:27:46 +0200
In-Reply-To: <c6e3d9d9-188b-6b26-3f99-a3ab5a6d6933@redhat.com> (Eric Blake's
	message of "Tue, 18 Jul 2017 15:08:04 -0500")
Message-ID: <87inip7anx.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] qapi: Introduce a first
 class 'null' type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/18/2017 02:43 PM, Markus Armbruster wrote:
>> @@ -536,10 +537,11 @@ can only express a choice between types represented differently in
>>  JSON.  If a branch is typed as the 'bool' built-in, the alternate
>>  accepts true and false; if it is typed as any of the various numeric
>>  built-ins, it accepts a JSON number; if it is typed as a 'str'
>> -built-in or named enum type, it accepts a JSON string; and if it is
>> -typed as a complex type (struct or union), it accepts a JSON object.
>> -Two different complex types, for instance, aren't permitted, because
>> -both are represented as a JSON object.
>> +built-in or named enum type, it accepts a JSON string; if it is typed
>> +as the 'null' built-in, it accepts JSON null, and if it is typed as a
>> +complex type (struct or union), it accepts a JSON object.  Two
>
> Grammar tweak: s/null,/null;/
>
> In a list of phrases that all have commas, it's typical to graduate the
> list separator to semicolon, so that it becomes easier to see the flow
> of 'a,b; a,b; and a,b'

Fixed, thanks!
