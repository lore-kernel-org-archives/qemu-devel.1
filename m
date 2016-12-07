Received: from eggs.gnu.org ([2001:4830:134:3::10]:58897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cEYx7-0005VJ-Qu
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:55:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cEYx3-00081Z-2M
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:55:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cEYx2-00081H-SZ
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 04:55:48 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <2011630530.2430235.1481039230635.JavaMail.zimbra@redhat.com>
	<e8c1ed6f-fc4b-2093-60d8-5a2fb4f22e5e@redhat.com>
	<efd2e5b9-ec59-f747-6cec-0a8ceaaffa5d@redhat.com>
Date: Wed, 07 Dec 2016 10:55:44 +0100
In-Reply-To: <efd2e5b9-ec59-f747-6cec-0a8ceaaffa5d@redhat.com> (Eric Blake's
	message of "Tue, 6 Dec 2016 10:24:20 -0600")
Message-ID: <87shq0hxlr.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] ui/egl-helpers.c license and reuse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Frediano Ziglio <fziglio@redhat.com>, Qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Cole Robinson <crobinso@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 12/06/2016 10:18 AM, John Snow wrote:
>> 
>> 
>> On 12/06/2016 10:47 AM, Frediano Ziglio wrote:
>>> Hi,
>>>   I work in the SPICE team (www.spice-space.org). I'd like to reuse some code from
>>> this file for some test for our project. The license of the 2 projects are a bit
>>> different (GPL2 against LGPL2) so in theory I couldn't do it.
>>> The code is mainly doing EGL initialization.
>>> Could I obtain a dispensation to reuse to code as LGPL2 ?
>>> Alternatively where can I get similar code with compatible LGPL2 license ?
>>>
>>> Regards,
>>>   Frediano
>>>
>> 
>> "IANAL,"
>
> Ditto
>
>> 
>> Looks like the file was authored by four people with no explicit
>> license, so it defaulted to GPL2.
>> 
>> Cole Robinson, Gerd Hoffman, Gonglei, and Peter Maydell.
>> 
>> Maybe you can get explicit permission from these four.
>
> Markus Armbruster also has a one-line deletion (although how can a line
> no longer present in the file be holding up a copyright question?). It

This specific case looks as non-copyrightable to me as they get.

> depends on whether you use 'git blame' to track all contributors to the
> current state of the file, or 'git log' to track all authors to any
> changes to the file.  'git blame' may also come in handy if you only
> need to copy a subset of the file.
