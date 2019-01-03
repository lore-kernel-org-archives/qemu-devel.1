Received: from eggs.gnu.org ([208.118.235.92]:53918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gez9L-0001Wg-1D
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gez9H-0001tl-Ls
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:18:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gez9H-0001s0-Dm
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 04:18:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so32938813wrb.2
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 01:18:42 -0800 (PST)
MIME-Version: 1.0
References: <154645087925.9907.8533035759502851896@02a1dbf831e2>
	<e122954c-760c-47ac-3858-1c25e0b2f9ff@redhat.com>
In-Reply-To: <e122954c-760c-47ac-3858-1c25e0b2f9ff@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Thu, 3 Jan 2019 10:18:30 +0100
Message-ID: <CAP+75-X27ep7r5oeg9HQY6T4h0TF3YSHHdw--O5Kb-vAADtnJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] cutils: Cleanup, improve documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, David Hildenbrand <david@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Cc'ing Markus and Thomas who reviewed commit 8c06fbdf36b.

On Thu, Jan 3, 2019 at 10:04 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 1/2/19 6:41 PM, no-reply@patchew.org wrote:
> > Patchew URL: https://patchew.org/QEMU/20181226171538.21984-1-philmd@red=
hat.com/
> [...]> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> > Checking PATCH 1/3: util/cutils: Move size_to_str() from "qemu-common.h=
" to "cutils.h"...
> > WARNING: Block comments use a leading /* on a separate line
> > #42: FILE: include/qemu/cutils.h:160:
> > +/**
>
> I believe this warning is incorrect, since we use the /** marking for
> Doxygen generated documentation. The offending comment is:
>
>   /**
>    * size_to_str:
>    *
>    * Return human readable string for size @val.
>    * Use IEC binary units like KiB, MiB, and so forth.
>    *
>    * @val: The value to format.
>    *       Can be anything that uint64_t allows (no more than "16 EiB").
>    *
>    * Caller is responsible for passing it to g_free().
>    */
>    char *size_to_str(uint64_t val);
>
> Am I missing something?

I had a quick look at scripts/checkpatch.pl:

  # Block comment styles

      # Block comments use /* on a line of its own
      if ($rawline !~ m@^\+.*/\*.*\*/[ \t]*$@ &&    #inline /*...*/
          $rawline =3D~ m@^\+.*/\*\*?[ \t]*.+[ \t]*$@) { # /* or /** non-bl=
ank
          WARN("Block comments use a leading /* on a separate line\n"
. $herecurr);
      }

I am confused because the comment says it allow blank /**, which is
the case here.
