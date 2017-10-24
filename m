Received: from eggs.gnu.org ([2001:4830:134:3::10]:50248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e6qe8-0003qk-IJ
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 00:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e6qe7-000649-L4
	for qemu-devel@nongnu.org; Tue, 24 Oct 2017 00:16:56 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20171022053315.GA15297@umbus>
Date: Tue, 24 Oct 2017 00:16:47 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <4CE427C5-BD1A-4911-9B10-CC1C0F80FD12@gmail.com>
References: <20171020175548.2566-1-programmingkidx@gmail.com>
	<f9bd98f1-d45c-6d3a-c35c-c67da67c881f@linaro.org>
	<20171022053315.GA15297@umbus>
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Richard Henderson <richard.henderson@linaro.org>, devicetree-compiler@vger.kernel.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


> On Oct 22, 2017, at 1:33 AM, David Gibson =
<david@gibson.dropbear.id.au> wrote:
>=20
> On Fri, Oct 20, 2017 at 04:44:58PM -0700, Richard Henderson wrote:
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
> Richard's right, that's definitely a better implementation.

I was just wondering, what if we rewrote the code to use strlen() =
instead of strnlen(). Would that be an acceptable solution?=20
