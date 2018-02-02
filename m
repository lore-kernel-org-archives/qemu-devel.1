Received: from eggs.gnu.org ([208.118.235.92]:56846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ehduC-0008Gx-9m
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:09:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ehdu7-0001SO-N2
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:09:36 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33656)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ehdu7-0001Rp-GG
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:09:31 -0500
Received: by mail-ua0-f194.google.com with SMTP id p12so14505320uad.0
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 08:09:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180201104639.GB5783@stefanha-x1.localdomain>
References: <20180131053318.13109-1-famz@redhat.com>
	<CAJ+F1C+v8B4STJS6v7ujGfu83oYFG6x9gcbu4D3T5VaDg382kg@mail.gmail.com>
	<20180201104639.GB5783@stefanha-x1.localdomain>
From: Fam Zheng <famz@redhat.com>
Date: Fri, 2 Feb 2018 14:33:58 +0800
Message-ID: <CAK1Eb9k0GKLed-8OVVkQtbPK5XQupi7bGKu8-S40j9=hffPejw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Add a git-publish configuration file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>

On Thu, Feb 1, 2018 at 6:46 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote=
:
> On Wed, Jan 31, 2018 at 11:06:05AM +0100, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Wed, Jan 31, 2018 at 6:33 AM, Fam Zheng <famz@redhat.com> wrote:
>> > git-publish [1] is a convenient tool to send patches and has been
>> > popular among QEMU developers.  Recently it has been made available in
>> > Fedora official repo thanks to Stefan's work.
>> >
>> > One nice feature of the tool is a per-project configuration with
>> > profiles, especially in which the cccmd option is a handy method to
>> > create the Cc list.
>> >
>> > [1]: https://github.com/stefanha/git-publish
>>
>> It would be worth to update README "Submitting patches" with an example
>
> Good idea!
>
> The workflow for a new patch series is:
>
>   $ git checkout -b my-feature
>   ...work on feature...
>   $ git publish
>
> Your patch series has been tagged as my-feature-v1 if you need to refer
> back to it in the future.
>
> Sending v2:
>
>   $ git checkout my-feature # same topic branch
>   ...work on feature...
>   $ git publish
>
> Your patch series has been tagged as my-feature-v2.

Will add a paragraph in README.

>
>> >
>> > Signed-off-by: Fam Zheng <famz@redhat.com>
>> > ---
>> >  .gitpublish | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++
>> >  1 file changed, 57 insertions(+)
>> >  create mode 100644 .gitpublish
>> >
>> > diff --git a/.gitpublish b/.gitpublish
>> > new file mode 100644
>> > index 0000000000..2099c1520f
>> > --- /dev/null
>> > +++ b/.gitpublish
>> > @@ -0,0 +1,57 @@
>> > +#
>> > +# Common git-publish profiles that can be used to send patches to QEM=
U upstream.
>> > +#
>> > +# See https://github.com/stefanha/git-publish for more information
>> > +#
>> > +[gitpublishprofile "qemu"]
>
> Please rename the "qemu" profile to "default".  This way no --profile
> needs to be given:
>
>   $ git publish
>
> The default profile settings can be overridden by command-line options
> and branch-specific settings.

Yes, good idea.

Fam
