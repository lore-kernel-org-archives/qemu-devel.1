Received: from eggs.gnu.org ([209.51.188.92]:47559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghFRN-0002R8-EO
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghFRM-0000XX-Q1
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:06:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ghFRM-0000Wi-HU
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 10:06:44 -0500
References: <1547043869-10520-1-git-send-email-thuth@redhat.com>
	<20190109143122.GR3998@redhat.com>
	<21c94e77-ad1d-3ce2-72cd-fc86f6d619fc@redhat.com>
	<20190109145820.GV3998@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b4d45a4d-c7af-ee28-a87a-a0caa35acad3@redhat.com>
Date: Wed, 9 Jan 2019 16:06:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190109145820.GV3998@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] configure: Force the C standard to gnu99
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: peter.maydell@linaro.org, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, pbonzini@redhat.com

On 2019-01-09 15:58, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Jan 09, 2019 at 03:51:33PM +0100, Thomas Huth wrote:
>> On 2019-01-09 15:31, Daniel P. Berrang=C3=A9 wrote:
[...]
>>> We could consider also setting a suitable -std for CXXFLAGS too in fu=
ture
>>> though...
>>
>> Shall I send a v3 with "-std=3Dgnu++98" (which seems to be the only us=
able
>> option right now), or shall we wait until we really hit a problem with
>> the C++ code?
>=20
> I'd have a slight preference for adding a C++ suitable -std now
> just to give us a more predictable build setup.
I think that's my preference, too. I'll send a v3...

 Thomas
