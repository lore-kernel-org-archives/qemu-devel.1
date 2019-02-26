Received: from eggs.gnu.org ([209.51.188.92]:53626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyWxw-0004Qs-Bl
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 02:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gyWxg-0008T2-Av
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 02:15:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gyWxX-0008M9-75
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 02:15:25 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <87d0o24u0s.fsf@dusky.pond.sub.org>
	<b3a486f6-6b72-2950-9fdd-706c2f69c616@redhat.com>
Date: Tue, 26 Feb 2019 08:15:14 +0100
In-Reply-To: <b3a486f6-6b72-2950-9fdd-706c2f69c616@redhat.com> (Eric Blake's
	message of "Mon, 25 Feb 2019 10:13:32 -0600")
Message-ID: <871s3vnhq5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Maintainers, please git-am -m
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Richard Henderson <richard.henderson@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Anthony PERARD <anthony.perard@citrix.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, David Gibson <david@gibson.dropbear.id.au>

Eric Blake <eblake@redhat.com> writes:

> On 2/8/19 1:30 AM, Markus Armbruster wrote:
>> Short story: please add
>>=20
>>     [am]
>>             messageid =3D true
>>=20
>> to your .gitconfig.
>>=20
>> Long story.  git-am can add a Message-id: tag.  Looks like this:
>>=20
>
>>=20
>>         Signed-off-by: Thomas Huth <thuth@redhat.com>
>>         Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>         Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>         Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>         Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> --->    Message-id: 1549268743-18502-1-git-send-email-thuth@redhat.com
>>         Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>=20
>> The Message-id identifies the patch e-mail.  It makes finding the review
>> thread easier and more reliable.  It's also a valid key on Patchew[*].
>
> I find the tag valuable enough in later git searches that I don't mind
> feeding my own patches back through the mailing list to add it (patchew
> helps with that, of course).  But for it to become mandatory, we'd need
> to enhance scripts/checkpatch.pl to enforce it.

I'm afraid checkpatch is the wrong place.  When you submit v1 patches
for review, there is no Message-id.  Even for respins, we don't want
one.  It should be added when patches get applied for real, so the
commit carries exactly one Message-id, and it refers back to the final
version on the list.

Two ideas:

* Have Patchew flag pull requests lacking Message-id

* Admittedly vague: some kind of git pre merge hook magic to make
  git-merge flag missing Message-id
