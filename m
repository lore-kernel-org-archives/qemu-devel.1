Received: from eggs.gnu.org ([209.51.188.92]:57972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghU6p-0000hM-4d
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 01:46:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghU6l-0004Ch-Rp
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 01:46:30 -0500
References: <1547051976-13982-1-git-send-email-thuth@redhat.com>
	<1547051976-13982-2-git-send-email-thuth@redhat.com>
	<3316bf08-36c0-c3ce-4e4f-8244276c58d3@kaod.org>
	<20190109172801.GB3998@redhat.com>
	<d72673fa-52a5-a6ff-6aa8-34f2b4b6855f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e6aa20ea-75d9-1bd9-48a7-ec8b5ad1df5f@redhat.com>
Date: Thu, 10 Jan 2019 07:46:19 +0100
MIME-Version: 1.0
In-Reply-To: <d72673fa-52a5-a6ff-6aa8-34f2b4b6855f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/2] include/hw/ppc: Fix
 compilation with clang -std=gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2019-01-09 22:20, Paolo Bonzini wrote:
> On 09/01/19 18:28, Daniel P. Berrang=C3=A9 wrote:
>>> so both files include each other, how nice ...
>> If the header files are mutually dependent it makes me wonder what the
>> point of having them split up is ?
>>
>> Feels like either they need to be merged, or they need to be split up
>> and refactored even more to remove the mutual dependancy.
>=20
> If they include each other only for the typedefs, then prehaps the
> solution is to change the coding style and allow using struct in
> function prototypes.  I'm pretty sure there are several examples of thi=
s
> already.

I'm all in favor for this!

 Thomas
