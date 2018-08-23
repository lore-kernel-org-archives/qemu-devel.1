Received: from eggs.gnu.org ([2001:4830:134:3::10]:53167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fssK7-00015B-4h
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fssK3-0006pY-5o
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:19:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43854 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fssK2-0006oK-O0
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 12:18:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180823102502.28122-1-berrange@redhat.com>
	<CAFEAcA-jfnWjAA3zhUKZ2ZBJdD+JmndLgrigJnxuVFJN5e=pXg@mail.gmail.com>
Date: Thu, 23 Aug 2018 18:18:55 +0200
In-Reply-To: <CAFEAcA-jfnWjAA3zhUKZ2ZBJdD+JmndLgrigJnxuVFJN5e=pXg@mail.gmail.com>
	(Peter Maydell's message of "Thu, 23 Aug 2018 11:41:20 +0100")
Message-ID: <878t4xcaz4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts: report on author emails that are
 mangled by the mailing list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On 23 August 2018 at 11:25, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>> In some cases the Author: email address in patches submitted to the
>> list gets mangled such that it says
>>
>>     John Doe via Qemu-devel <qemu-devel@nongnu.org>
>>
>> This change is a result of workarounds for DMARC policies.
>
> I do wonder if overall we'd be better off with the other
> workaround (don't change From lines in list emails, don't
> add "[Qemu-devel]" prefix to subject lines)... It would be
> a one-off annoyance to people who filter list mail on subject
> rather than other headers, but it would get rid of this annoying
> wart where a handful of senders end up with their mail with
> a from address that our patch management tools don't handle
> very well...

Mangling e-mail headers is a bad idea.  The fact that it's commonly held
only makes it worse.

If you can hack QEMU, filtering on List-Id should not be an
insurmountable obstacle.
