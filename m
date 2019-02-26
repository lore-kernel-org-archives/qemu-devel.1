Received: from eggs.gnu.org ([209.51.188.92]:53410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gydVK-0001nQ-R2
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gydVI-00060e-06
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:14:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51330)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gydV9-0005oJ-Ps
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 09:14:36 -0500
References: <87d0o24u0s.fsf@dusky.pond.sub.org>
	<b3a486f6-6b72-2950-9fdd-706c2f69c616@redhat.com>
	<871s3vnhq5.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5be5ec5d-d95f-1669-0b1a-681065bf0da5@redhat.com>
Date: Tue, 26 Feb 2019 08:14:08 -0600
MIME-Version: 1.0
In-Reply-To: <871s3vnhq5.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Maintainers, please git-am -m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Anthony PERARD <anthony.perard@citrix.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Peter Maydell <peter.maydell@linaro.org>

On 2/26/19 1:15 AM, Markus Armbruster wrote:

>>> The Message-id identifies the patch e-mail.  It makes finding the review
>>> thread easier and more reliable.  It's also a valid key on Patchew[*].
>>
>> I find the tag valuable enough in later git searches that I don't mind
>> feeding my own patches back through the mailing list to add it (patchew
>> helps with that, of course).  But for it to become mandatory, we'd need
>> to enhance scripts/checkpatch.pl to enforce it.
> 
> I'm afraid checkpatch is the wrong place.  When you submit v1 patches
> for review, there is no Message-id.  Even for respins, we don't want
> one.  It should be added when patches get applied for real, so the
> commit carries exactly one Message-id, and it refers back to the final
> version on the list.

Indeed, I wasn't thinking about how it would work. checkpatch.pl can
filter for 'PULL' being in a subject line, as that will not affect
normal submissions, but there is no guarantee that it will mesh with the
workflows of the various maintainers.

> 
> Two ideas:
> 
> * Have Patchew flag pull requests lacking Message-id

Yes, that works, as well as patching Peter's sanity-checking script to
do likewise.

> 
> * Admittedly vague: some kind of git pre merge hook magic to make
>   git-merge flag missing Message-id

I'm not sure if Peter has his sanity-checker script plugged in via git
hooks or some other way.

 https://git.linaro.org/people/peter.maydell/misc-scripts.git/

if someone wants to propose a patch to it.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
