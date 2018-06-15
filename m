Received: from eggs.gnu.org ([2001:4830:134:3::10]:55213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fTje1-0008HW-CT
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fTje0-0004va-LJ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 03:59:41 -0400
MIME-Version: 1.0
In-Reply-To: <c5c1f362-d51d-df1e-c1dd-f57b64c3f1a1@amsat.org>
References: <20180614164431.29305-1-stefanha@redhat.com>
	<5768e8f3-eae5-30ef-888a-5e62692c238d@redhat.com>
	<c5c1f362-d51d-df1e-c1dd-f57b64c3f1a1@amsat.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 15 Jun 2018 08:59:34 +0100
Message-ID: <CAJSP0QU2BLvBVgtwSmNzip-7Kf=LzsrvbBjv87D9FLiswH=o0g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] compiler: add a sizeof_field() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: John Snow <jsnow@redhat.com>, xen-devel@lists.xenproject.org, qemu-s390x@nongnu.org, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

On Thu, Jun 14, 2018 at 9:33 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> On 06/14/2018 04:17 PM, John Snow wrote:
>> On 06/14/2018 12:44 PM, Stefan Hajnoczi wrote:
>>> Determining the size of a field is useful when you don't have a struct
>>> variable handy.  Open-coding this is ugly.
>>>
>>> This patch adds the sizeof_field() macro, which is similar to
>>> typeof_field().  Existing instances are updated to use the macro.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>
>> How'd you find all the existing instances?
>
> This works:
>
> $ git grep -E 'sizeof.*)0)->'

Yes, I used a similar grep command-line.

I also checked for "sizeof.*)NULL" but nothing uses that syntax.

Stefan
