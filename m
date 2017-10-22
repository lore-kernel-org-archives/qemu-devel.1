Received: from eggs.gnu.org ([2001:4830:134:3::10]:48952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e6HGH-0007rm-Gr
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 10:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e6HGG-0007js-MU
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 10:29:57 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAFEAcA8WnzZpdTWjJafLDjTCOpT_=azr6T+8UAnMNyDiD2ZxAQ@mail.gmail.com>
Date: Sun, 22 Oct 2017 10:29:47 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <A2F88E43-0C42-4BD5-BF51-23C4550D780E@gmail.com>
References: <20171020175548.2566-1-programmingkidx@gmail.com>
	<f9bd98f1-d45c-6d3a-c35c-c67da67c881f@linaro.org>
	<CAFEAcA8WnzZpdTWjJafLDjTCOpT_=azr6T+8UAnMNyDiD2ZxAQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [libfdt][PATCH v2] implement strnlen for systems
 that need it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, devicetree-compiler@vger.kernel.org, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>


> On Oct 22, 2017, at 9:37 AM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On 21 October 2017 at 00:44, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> On 10/20/2017 10:55 AM, John Arbuckle wrote:
>>> +static inline size_t strnlen(const char *string, size_t max_count)
>>> +{
>>> +    size_t count;
>>> +    for (count =3D 0; count < max_count; count++) {
>>> +        if (string[count] =3D=3D '\0') {
>>> +            break;
>>> +        }
>>> +    }
>>> +    return count;
>>=20
>> Not to nitpick, but
>>=20
>>  const char *p =3D memchr(string, 0, max_count);
>>  return p ? max_count : p - string;
>=20
> Am I misreading that, or do you have the ?: arms the wrong way
> around there?
>=20
> thanks
> -- PMM

Yes. It should read:

return p ? p - string : max_count;=
