Received: from eggs.gnu.org ([2001:4830:134:3::10]:51232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9oi-0000fP-AY
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cl9oc-0005Bf-Tb
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:45:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cl9oc-0005BJ-OG
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 02:45:50 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-11-git-send-email-armbru@redhat.com>
	<dd7a93a5-87d5-83c9-b608-8511036ac394@amsat.org>
	<87efycduf0.fsf@dusky.pond.sub.org>
	<1ea524b7-bc6b-553a-d548-76faf99fccbb@redhat.com>
Date: Tue, 07 Mar 2017 08:45:46 +0100
In-Reply-To: <1ea524b7-bc6b-553a-d548-76faf99fccbb@redhat.com> (Eric Blake's
	message of "Mon, 6 Mar 2017 10:10:18 -0600")
Message-ID: <87pohtil79.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 10/28] qmp: Improve QMP dispatch error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 03/05/2017 02:01 AM, Markus Armbruster wrote:
>
>>>> @@ -41,15 +41,17 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>>>>
>>>>          if (!strcmp(arg_name, "execute")) {
>>>>              if (qobject_type(arg_obj) != QTYPE_QSTRING) {
>>>> -                error_setg(errp, "QMP input object member '%s' expects '%s'",
>>>> -                           "execute", "string");
>>>> +                error_setg(errp,
>>>> +                           "QMP input object member '%s' must be %s",
>>>> +                           "execute", "a string");
>>>
>>> let's avoid formatting like the rest of this patch.
>>>
>
>> Since substantial other work depends on this series, it needs to go in
>> sooner rather than later.  I'm therefore *dropping* this patch from the
>> series.  We can then bikeshed^Wpolish to our heart's content without
>> holding up other work.
>
> Agreed.
>
>> 
>> That said: what about this?
>
> Looks better.  Do you want R-b now, or when you re-post it as an
> official patch?

I'll gladly take it either way :)
