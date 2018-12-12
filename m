Received: from eggs.gnu.org ([2001:4830:134:3::10]:55518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gX8yR-0001bO-N7
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:11:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gX8yN-0006Pb-Gk
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:11:07 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gX8yN-0006Ob-90
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 13:11:03 -0500
Received: by mail-wr1-x442.google.com with SMTP id b14so18638696wru.12
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:11:02 -0800 (PST)
References: <20181212102548.27626-1-alex.bennee@linaro.org>
	<87mupafxm4.fsf@dusky.pond.sub.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87mupafxm4.fsf@dusky.pond.sub.org>
Date: Wed, 12 Dec 2018 18:11:00 +0000
Message-ID: <87o99q1uq3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2] contrib: add a basic gitdm config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, maxim.kuvyrkov@linaro.org


Markus Armbruster <armbru@redhat.com> writes:

> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>
>> This is a QEMU specific version of a gitdm config for generating
>> reports on the contributor base of the project. I've added enough
>> group maps and domain aliases to ensure the current top ten is as
>> reflective as it can be. As of this commit running:
>>
>>   git log --numstat --since "Last Year" | gitdm -n -l 10
<snip>
>> diff --git a/contrib/gitdm/filetypes.txt b/contrib/gitdm/filetypes.txt
>> new file mode 100644
>> index 0000000000..e24c396b48
>> --- /dev/null
>> +++ b/contrib/gitdm/filetypes.txt
> [...]
>
> This is a verbatim copy of upstream's sample-config/filetypes.txt.  If
> you have gitdm, you should have its filetypes.txt, shouldn't you?  Can
> we think of a way to use that instead?

Without introducing an explicit dependency which seems a little
overkill. That said a lot of the entries in this file aren't used by
QEMU so I could just trim it down.
>> diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-re=
dhat
>> new file mode 100644
>> index 0000000000..252742d131
>> --- /dev/null
>> +++ b/contrib/gitdm/group-map-redhat
>> @@ -0,0 +1,7 @@
>> +#
>> +# RedHat contributors using non-corporate email
>> +#
>> +
>> +david@gibson.dropbear.id.au
>> +laurent@vivier.eu
>> +pjp@fedoraproject.org
>
> There are about a dozen commits I accidentally signed with my private
> address armbru@pond.sub.org.  Not sure we care.

For running lifetime stats maybe - it certainly won't hurt.

I really only concentrated of cleaning up the stats for the last year.
>
> Can't see anything bad, so
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Thanks.

--
Alex Benn=C3=A9e
