Received: from eggs.gnu.org ([2001:4830:134:3::10]:46352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e6MIl-0008IN-Ue
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 15:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1e6MIk-0001va-V3
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 15:52:52 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <1508699172.7314.12.camel@freebsd.org>
Date: Sun, 22 Oct 2017 15:52:43 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DBD5EDC-4F6C-4A75-ADB0-C1A52532A323@gmail.com>
References: <20171020175548.2566-1-programmingkidx@gmail.com>
	<f9bd98f1-d45c-6d3a-c35c-c67da67c881f@linaro.org>
	<20171022053315.GA15297@umbus>
	<82BA0070-FFBB-4868-AE48-D7A3671621C5@gmail.com>
	<1508699172.7314.12.camel@freebsd.org>
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
To: Ian Lepore <ian@freebsd.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <richard.henderson@linaro.org>, devicetree-compiler@vger.kernel.org, "list@suse.de:PowerPC list:PowerPC" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>


> On Oct 22, 2017, at 3:06 PM, Ian Lepore <ian@freebsd.org> wrote:
>=20
> On Sun, 2017-10-22 at 10:41 -0400, Programmingkid wrote:
>>>=20
>>> On Oct 22, 2017, at 1:33 AM, David Gibson  wrote:
>>>=20
>>> On Fri, Oct 20, 2017 at 04:44:58PM -0700, Richard Henderson wrote:
>>>>=20
>>>> On 10/20/2017 10:55 AM, John Arbuckle wrote:
>>>>>=20
>>>>> +static inline size_t strnlen(const char *string, size_t =
max_count)
>>>>> +{
>>>>> +    size_t count;
>>>>> +    for (count =3D 0; count < max_count; count++) {
>>>>> +        if (string[count] =3D=3D '\0') {
>>>>> +            break;
>>>>> +        }
>>>>> +    }
>>>>> +    return count;
>>>> Not to nitpick, but
>>>>=20
>>>>  const char *p =3D memchr(string, 0, max_count);
>>>>  return p ? max_count : p - string;
>>> Richard's right, that's definitely a better implementation.
>> His implementation is smaller, but this one is even smaller. Plus it =
uses the familiar strlen() function:
>>=20
>> size_t strnlen(const char *string, size_t max_count)
>> {
>>     return strlen(string) < max_count ? strlen(string) : max_count;
>> }
>=20
> That is not a proper implementation of strnlen(), which is not =
supposed
> to access any source-string bytes beyond max_count.
>=20
> -- Ian

http://pubs.opengroup.org/onlinepubs/9699919799/functions/strlen.html
This specification document should help anyone who wants more info.

The first implementation using the loop would never access anything =
beyond max_count. My second implementation does go beyond max_count. The =
implementation using memchr() will probably live up the requirement so I =
guess it wins.

Thank you Ian for this information.=20
