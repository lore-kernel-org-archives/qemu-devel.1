Received: from eggs.gnu.org ([2001:4830:134:3::10]:58237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dukkA-00081q-Os
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dukkA-0002D9-0o
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:33:10 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:50363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dukk9-0002CI-KK
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 15:33:09 -0400
Received: by mail-wr0-x22c.google.com with SMTP id w12so2981781wrc.7
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 12:33:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87o9q5k348.fsf@secure.laptop>
References: <20170920104639.2335-1-quintela@redhat.com>
	<87o9q5k348.fsf@secure.laptop>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Sep 2017 20:32:46 +0100
Message-ID: <CAFEAcA_t3iBPr862YAv_Hp=_mESoqLJ07QFKp6QwKJ8P=tS+1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/16] Migration PULL request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 20 September 2017 at 12:42, Juan Quintela <quintela@redhat.com> wrote:
> Juan Quintela <quintela@redhat.com> wrote:
>> Hi
>>
>> To make merges easier, this includes:
>> - Peter Xu reviewed patches from Postocpy recovery (3)
>> - Alexey reviewed pages from block postcopy (4)
>
> I meaned here to include Vladimir series.  This is incomplete.
>
> Nacked myself.

It also fails to build on ppc64 and s390x (so probably
all bigendian hosts):

/home/pm215/qemu/util/bitmap.c: In function =E2=80=98bitmap_to_from_le=E2=
=80=99:
/home/pm215/qemu/util/bitmap.c:383:6: error: "__WORD_SIZE" is not
defined [-Werror=3Dundef]
 # if __WORD_SIZE =3D=3D 64
      ^

thanks
-- PMM
