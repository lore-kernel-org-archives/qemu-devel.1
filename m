Received: from eggs.gnu.org ([209.51.188.92]:44286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtzJC-0004eK-M3
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtzJB-0007fQ-Nt
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 13:30:58 -0500
References: <1550073299-3647-1-git-send-email-thuth@redhat.com>
	<1cbe8721-ea9e-f17f-f27d-910fece2858d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9518f0a6-2a89-ab4f-a431-d4e4741db8e5@redhat.com>
Date: Wed, 13 Feb 2019 19:30:43 +0100
MIME-Version: 1.0
In-Reply-To: <1cbe8721-ea9e-f17f-f27d-910fece2858d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] crypto: Fix LGPL information in the file
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-trivial@nongnu.org

On 2019-02-13 17:24, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/13/19 4:54 PM, Thomas Huth wrote:
>> It's either "GNU *Library* General Public License version 2" or "GNU
>> Lesser General Public License version *2.1*", but there was no "versio=
n
>> 2.0" of the "Lesser" license. So assume that version 2.1 is meant here=
.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  crypto/block-luks.c           | 2 +-
>>  crypto/block-luks.h           | 2 +-
>>  crypto/block-qcow.c           | 2 +-
>>  crypto/block-qcow.h           | 2 +-
>>  crypto/block.c                | 2 +-
>>  crypto/blockpriv.h            | 2 +-
>>  crypto/cipher-builtin.c       | 2 +-
>>  crypto/cipher-gcrypt.c        | 2 +-
>>  crypto/cipher-nettle.c        | 2 +-
>>  crypto/cipher.c               | 2 +-
>>  crypto/hash-gcrypt.c          | 2 +-
>>  crypto/hash-glib.c            | 2 +-
>>  crypto/hash-nettle.c          | 2 +-
>>  crypto/hash.c                 | 2 +-
>>  crypto/init.c                 | 2 +-
>>  crypto/ivgen-essiv.c          | 2 +-
>>  crypto/ivgen-essiv.h          | 2 +-
>>  crypto/ivgen-plain.c          | 2 +-
>>  crypto/ivgen-plain.h          | 2 +-
>>  crypto/ivgen-plain64.c        | 2 +-
>>  crypto/ivgen-plain64.h        | 2 +-
>>  crypto/ivgen.c                | 2 +-
>>  crypto/ivgenpriv.h            | 2 +-
>>  crypto/pbkdf-gcrypt.c         | 2 +-
>>  crypto/pbkdf-nettle.c         | 2 +-
>>  crypto/pbkdf-stub.c           | 2 +-
>>  crypto/pbkdf.c                | 2 +-
>>  crypto/random-gcrypt.c        | 2 +-
>>  crypto/random-gnutls.c        | 2 +-
>>  crypto/random-platform.c      | 2 +-
>>  crypto/secret.c               | 2 +-
>>  crypto/tlscreds.c             | 2 +-
>>  crypto/tlscredsanon.c         | 2 +-
>>  crypto/tlscredspriv.h         | 2 +-
>>  crypto/tlscredspsk.c          | 2 +-
>>  crypto/tlscredsx509.c         | 2 +-
>>  crypto/tlssession.c           | 2 +-
>>  crypto/xts.c                  | 2 +-
>>  include/crypto/block.h        | 2 +-
>>  include/crypto/cipher.h       | 2 +-
>>  include/crypto/hash.h         | 2 +-
>>  include/crypto/init.h         | 2 +-
>>  include/crypto/ivgen.h        | 2 +-
>>  include/crypto/pbkdf.h        | 2 +-
>>  include/crypto/random.h       | 2 +-
>>  include/crypto/secret.h       | 2 +-
>>  include/crypto/tlscreds.h     | 2 +-
>>  include/crypto/tlscredsanon.h | 2 +-
>>  include/crypto/tlscredspsk.h  | 2 +-
>>  include/crypto/tlscredsx509.h | 2 +-
>>  include/crypto/tlssession.h   | 2 +-
>>  include/crypto/xts.h          | 2 +-
>>  52 files changed, 52 insertions(+), 52 deletions(-)
>=20
> Still not convinced to use SPDX-License-Identifiers?

SPDX sounds fine to me personally, but so far nobody came up with a
proper official description if and how this can legally be done, so
until we are at that point, fixing the current statements sounds like
the best solution to me.

 Thomas
