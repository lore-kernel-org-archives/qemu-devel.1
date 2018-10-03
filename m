Received: from eggs.gnu.org ([2001:4830:134:3::10]:41275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7goP-000704-SZ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:03:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g7goG-0001PJ-8a
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:03:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g7goE-0001Nf-LM
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:03:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id 189-v6so5664226wmw.2
	for <qemu-devel@nongnu.org>; Wed, 03 Oct 2018 06:03:21 -0700 (PDT)
References: <20180907075948.26917-1-marcandre.lureau@redhat.com>
	<120d75f8-24f7-641a-9b30-4a1ebfbca34d@redhat.com>
	<CAJ+F1CKjf6APRYSJVmRCf04vVHDyLSjHxsKr+KGFL+jcLEN68Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <69790989-5568-f307-ce58-602cadd90903@redhat.com>
Date: Wed, 3 Oct 2018 15:03:19 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CKjf6APRYSJVmRCf04vVHDyLSjHxsKr+KGFL+jcLEN68Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 00/12] Various qemu command line options
 help improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Eric Blake <eblake@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 02/10/2018 12:54, Marc-André Lureau wrote:
>>>
>>> This is a compilation of patches I have to improve command line help
>>> support. The "qemu-option" patches have already been sent earlier, I
>>> modified the first to fix an issue reported by Markus. The other
>>> patches add support for -object help. A few related patches for QOM,
>>> to fix/improve some minor issues.
>>>
>>> v2: after Eric Blake review
>>> - add "qdev-monitor: print help to stdout"
>>> - add "cutils: add qemu_pstrcmp"
>>> - use consistently "arg=type - desc" help format
>> Feel free to send a pull request yourself with the minor fixes requested
>> during review.
> It would be nice to get some more review before :)

There you have it. :)

Paolo

> Andreas, as QOM maintainer, do you have time to take a look?
> 
> Anybody else interested to improve the CLI?
